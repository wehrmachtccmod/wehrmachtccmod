function Create(self)
	self.flip = false;
	self.setpos = Vector(self.Pos.X, self.Pos.Y - 22);
	self.firevel = 15; -- Shell firing speed
	self.fire = Timer();
	self.reload = true;
	self.hiss = true;
	self.sound = Timer();
end

function Update(self)
	
	local ctrl = self:GetController();
	local turnspeed = 0.01 -- Turret aim speed
	local maxturn = 0 -- sets max aim level 0 is flat level; neg number is down, pos number is up. Number is between 1.57 to -1.57; straight up to straight down.
	
	self.Pos = self.setpos;
	
	if self:IsPlayerControlled() then
	
		-- Turn Sound
		local turnsound = CreateAEmitter("Cannon Turn", "Wehrmacht.rte");
		turnsound.Pos = self.Pos;
	
		-- Move Turret
		if ctrl:IsState(Controller.MOVE_LEFT) then
			if self.HFlipped == false then
				if self.RotAngle + turnspeed > 1.57 then
					self.HFlipped = true;
					self.flip = true;
					self.RotAngle = self.RotAngle * -1;
				else
					self.RotAngle = self.RotAngle + turnspeed;
				end
			else
				if self.RotAngle + 0.01 < maxturn then
					self.RotAngle = self.RotAngle + turnspeed;
				end
			end
			
			if self.sound:IsPastSimMS(250) then
				MovableMan:AddParticle(turnsound);
				self.sound:Reset();
			end
		elseif ctrl:IsState(Controller.MOVE_RIGHT) then
			if self.HFlipped == false then
				if self.RotAngle - turnspeed > maxturn then
					self.RotAngle = self.RotAngle - turnspeed;
				end
			else
				if self.RotAngle - 0.01 < -1.57 then
					self.HFlipped = false;
					self.flip = false;
					self.RotAngle = self.RotAngle * -1;
				else
					self.RotAngle = self.RotAngle - turnspeed;
				end
			end
			
			if self.sound:IsPastSimMS(250) then
				MovableMan:AddParticle(turnsound);
				self.sound:Reset();
			end
		end
		
		-- Fire Shots
		if self.fire:IsPastSimMS(1600) then
		
			-- Hiss Sound
			if self.hiss == true then
				local hisssound = CreateAEmitter("Cannon Hiss", "Wehrmacht.rte");
				hisssound.Pos = self.Pos;
				MovableMan:AddParticle(hisssound);
				self.hiss = false;
			end
			
		
			if self.fire:IsPastSimMS(2000) then
			
				-- Reload Sound
				if self.reload == true then
					local reloadsound = CreateAEmitter("Cannon Reload", "Wehrmacht.rte");
					reloadsound.Pos = self.Pos;
					MovableMan:AddParticle(reloadsound);
					self.reload = false;
				end
			
				if ctrl:IsState(Controller.WEAPON_FIRE) and self.fire:IsPastSimMS(2600) then
				
					-- Round
					local round = CreateAEmitter("Fixed Artillery Shell Launch", "Wehrmacht.rte");
					if self.HFlipped == false then
						local bvx = math.cos(self.RotAngle) * self.firevel;
						local bvy = math.sin(self.RotAngle) * self.firevel * -1;
						round.Vel = Vector(bvx, bvy);
						local cbx = self.Pos.X + (math.cos(self.RotAngle) * 60);
						local cby = self.Pos.Y + (math.sin(self.RotAngle) * 60 * -1);
						round.Pos = Vector(cbx, cby);
						round.RotAngle = self.RotAngle;
					else
						local bvx = math.cos(self.RotAngle) * self.firevel * -1;
						local bvy = math.sin(self.RotAngle) * self.firevel;
						round.Vel = Vector(bvx, bvy);
						local cbx = self.Pos.X - (math.cos(self.RotAngle) * 60);
						local cby = self.Pos.Y - (math.sin(self.RotAngle) * 60 * -1);
						round.Pos = Vector(cbx, cby);
						round.RotAngle = self.RotAngle + math.pi;
					end
					MovableMan:AddParticle(round);
					
					-- Shell
					local shell = CreateAEmitter("Cannon Casing", "Base.rte");
					shell.Pos = Vector(self.Pos.X, self.Pos.Y + 22);
					shell.AngularVel = 0.1;
					MovableMan:AddParticle(shell);
					
					-- Fire Sound
					local firesound = CreateAEmitter("Cannon Fire", "Wehrmacht.rte");
					firesound.Pos = self.Pos;
					MovableMan:AddParticle(firesound);
					
					self.fire:Reset();
					self.reload = true;
					self.hiss = true;
				end
			end
		end
	end
end