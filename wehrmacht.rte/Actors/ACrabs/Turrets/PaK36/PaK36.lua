package.loaded.Constants = nil; require("Constants")
require("Actors/AI/HumanBehaviors")
require("Actors/AI/CrabBehaviors")
require("Actors/AI/TurretBehaviors")

function Create(self)
	---------------- AI variables start ----------------
	self.Ctrl = self:GetController()
	
	self.lateralMoveState = Actor.LAT_STILL
	self.deviceState = ACrab.STILL
	self.lastAIMode = Actor.AIMODE_NONE
	self.SentryFacing = self.HFlipped
	self.fire = false
	
	self.ReloadTimer = Timer()
	self.TargetLostTimer = Timer()
	
	self.PlayerInterferedTimer = Timer()
	self.PlayerInterferedTimer:SetSimTimeLimitMS(500)
	
	self.AlarmTimer = Timer()
	self.AlarmTimer:SetSimTimeLimitMS(500)
	
	-- check if this team is controlled by a human
	local Activ = ActivityMan:GetActivity()
	for player = Activity.PLAYER_1, Activity.MAXPLAYERCOUNT - 1 do
		if Activ:PlayerActive(player) and Activ:PlayerHuman(player) then
			if self.Team == Activ:GetTeamOfPlayer(player) then
				self.isPlayerOwned = true
				break
			end
		end
	end
	
	function self:CreatePatrolBehavior()
		self.NextBehavior = coroutine.create(TurretBehaviors.Patrol)
		self.NextCleanup = nil
		self.NextBehaviorName = "Patrol"
	end
	
	function self:CreateSentryBehavior()
		if not self.FirearmIsReady and not self.ThrowableIsReady then
			return
		end
		
		self.NextBehavior = coroutine.create(CrabBehaviors.Sentry)
		self.NextCleanup = nil
		self.NextBehaviorName = "Sentry"
	end
	
	function self:CreateAttackBehavior()
		if self.FirearmIsReady then
			self.NextBehavior = coroutine.create(CrabBehaviors.ShootTarget)
			self.NextBehaviorName = "ShootTarget"
		else
			if self.FirearmIsEmpty then
				self:ReloadFirearm()
			end
			
			return
		end
		
		self.NextCleanup = function(self)
			self.fire = false
			self.Target = nil
			self.deviceState = ACrab.STILL
		end
	end
	
	function self:CreateSuppressBehavior()
		if self.FirearmIsReady then
			self.NextBehavior = coroutine.create(CrabBehaviors.ShootArea)
			self.NextBehaviorName = "ShootArea"
		else
			if self.FirearmIsEmpty then
				self:ReloadFirearm()
			end
			
			return
		end
		
		self.NextCleanup = function(self)
			self.fire = false
			self.UnseenTarget = nil
			self.deviceState = ACrab.STILL
		end
	end
	
	---------------- AI variables end ----------------
end

function UpdateAI(self)
	if self.PlayerInterferedTimer:IsPastSimTimeLimit() then
		self.Behavior = nil	-- remove the current behavior
		if self.BehaviorCleanup then
			self.BehaviorCleanup(self)	-- clean up after the current behavior
			self.BehaviorCleanup = nil
		end
		
		self.Target = nil
		self.fire = false
		self.lastAIMode = Actor.AIMODE_NONE
	end
	
	self.PlayerInterferedTimer:Reset()
	
	if self.Target and not MovableMan:IsActor(self.Target) then
		self.Target = nil
	end
	
	if self.UnseenTarget and not MovableMan:IsActor(self.UnseenTarget) then
		self.UnseenTarget = nil
	end
	
	-- switch to the next behavior, if avaliable
	if self.NextBehavior then
		if self.BehaviorCleanup then
			self.BehaviorCleanup(self)
		end
		
		self.Behavior = self.NextBehavior
		self.BehaviorCleanup = self.NextCleanup
		self.BehaviorName = self.NextBehaviorName
		self.NextBehavior = nil
	end
	
	-- check if the AI mode has changed or if we need a new behavior
	if self.AIMode ~= self.lastAIMode or not self.Behavior then
		self.Behavior = nil
		if self.BehaviorCleanup then
			self.BehaviorCleanup(self)	-- stop the current behavior
			self.BehaviorCleanup = nil
		end
		
		-- select a new behavior based on AI mode
		if self.AIMode == Actor.AIMODE_PATROL then
			self:CreatePatrolBehavior()
		else
			if self.AIMode ~= self.lastAIMode and self.AIMode == Actor.AIMODE_SENTRY then
				self.SentryFacing = self.HFlipped	-- store the direction in which we should be looking
			end
			
			self:CreateSentryBehavior()
		end
		
		self.lastAIMode = self.AIMode
	end
	
	-- look for targets
	local FoundMO, HitPoint = CrabBehaviors.LookForTargets(self)
	if FoundMO then
		if self.Target and MovableMan:IsActor(self.Target) and FoundMO.ID == self.Target.ID then	-- found the same target
			self.TargetOffset = SceneMan:ShortestDistance(self.Target.Pos, HitPoint, false)
			self.TargetLostTimer:Reset()
			self.ReloadTimer:Reset()
		elseif MovableMan:IsActor(FoundMO) then
			if FoundMO.Team == self.Team then	-- found an ally
				if self.Target then
					if SceneMan:ShortestDistance(self.Pos, FoundMO.Pos, false).Magnitude < SceneMan:ShortestDistance(self.Pos, self.Target.Pos, false).Magnitude then
						self.Target = nil	-- stop shooting
					end
				elseif FoundMO.ClassName ~= "ADoor" and
					SceneMan:ShortestDistance(self.Pos, FoundMO.Pos, false).Magnitude < self.Diameter + FoundMO.Diameter
				then
					self.BlockingActor = ToActor(FoundMO)	-- this actor is blocking our path
				end
			else
				if FoundMO.ClassName == "AHuman" then
					FoundMO = ToAHuman(FoundMO)
				elseif FoundMO.ClassName == "ACrab" then
					FoundMO = ToACrab(FoundMO)
				elseif FoundMO.ClassName == "ACRocket" then
					FoundMO = ToACRocket(FoundMO)
				elseif FoundMO.ClassName == "ACDropShip" then
					FoundMO = ToACDropShip(FoundMO)
				elseif FoundMO.ClassName == "ADoor" then
					FoundMO = ToADoor(FoundMO)
				elseif FoundMO.ClassName == "Actor" then
					FoundMO = ToActor(FoundMO)
				else
					FoundMO = nil
				end
				
				if FoundMO then
					self.ReloadTimer:Reset()
					self.TargetLostTimer:Reset()
					
					if self.Target then
						-- check if this MO sould be targeted instead
						if HumanBehaviors.CalculateThreatLevel(self, FoundMO) > HumanBehaviors.CalculateThreatLevel(self, self.Target) + 0.2 then
							self.OldTargetPos = self.Target.Pos
							self.Target = FoundMO
							self.TargetOffset = SceneMan:ShortestDistance(self.Target.Pos, HitPoint, false)	-- this is the distance vector from the target center to the point we hit with our ray
							self:CreateAttackBehavior()
						end
					else
						self.OldTargetPos = nil
						self.Target = FoundMO
						self.TargetOffset = SceneMan:ShortestDistance(self.Target.Pos, HitPoint, false)	-- this is the distance vector from the target center to the point we hit with our ray
						self:CreateAttackBehavior()
					end
				end
			end
		end
	else	-- no target found this frame
		if self.Target and self.TargetLostTimer:IsPastSimTimeLimit() then
			self.OldTargetPos = self.Target.Pos
			self.Target = nil	-- the target has been out of sight for too long, ignore it
		end
		
		if self.ReloadTimer:IsPastSimMS(8000) then	-- check if we need to reload
			self.ReloadTimer:Reset()
			if ToACrab(self).FirearmNeedsReload then
				self:ReloadFirearm()
			end
		end
	end
	
	-- run the selected behavior and delete it if it returns true
	if self.Behavior then
		local msg, done = coroutine.resume(self.Behavior, self)
		if not msg then
			ConsoleMan:PrintString(self.PresetName .. " behavior " .. self.BehaviorName .. " error:\n" .. done)	-- print the error message
			done = true
		end
		
		if done then
			self.Behavior = nil
			if self.BehaviorCleanup then
				self.BehaviorCleanup(self)
				self.BehaviorCleanup = nil
			end
		end
	end
	
	-- react to relevant AlarmEvents
	if not self.Target and not self.UnseenTarget then
		if self.AlarmTimer:IsPastSimTimeLimit() and HumanBehaviors.ProcessAlarmEvent(self) then
			self.AlarmTimer:Reset()
		elseif self.AlarmPos then	-- if alarmed, look at the alarming point until AlarmTimer has expired
			self.deviceState = ACrab.AIMING
			self.Ctrl.AnalogAim = SceneMan:ShortestDistance(self.EyePos, self.AlarmPos, false)
		end
	end
	
	-- controller states
	if self.fire then
		self.Ctrl:SetState(Controller.WEAPON_FIRE, true)
	end
	
	if self.deviceState == ACrab.AIMING then
		self.Ctrl:SetState(Controller.AIM_SHARP, true)
	end
end
