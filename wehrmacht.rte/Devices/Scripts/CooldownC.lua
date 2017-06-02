
-- Thanks to Asklar for the meter and Coops for a few things.

-- This script would not work without the help of akblabla

function Create(self)
	self.ShootTimer = Timer()
	self.Clicked = false
	self.coolDown = false
	self.Shot = 1
	self.MaxShot = 100
	self.Overheat = false
end

function Update(self)

	self.actor = MovableMan:GetMOFromID(self.RootID);
	if MovableMan:IsActor(self.actor) then
		self.parent = ToActor(self.actor);
		self.Work = true;
	else
		self.Work = false;
	end
	
	
	if self.Work == true then

		self.Meter = CreateAEmitter("Meter Laser")
		self.Meter.Pos = self.parent.AboveHUDPos + Vector(0,27)
		self.Meter.Frame = 16 - math.ceil((self.Shot/self.MaxShot) * 16)
		MovableMan:AddParticle(self.Meter)
	
		if self:IsActivated() then
			if self.ShootTimer:IsPastSimMS(60000/self.RateOfFire) and self.Clicked then
				if self.Overheat == false then
					self.ShootTimer:Reset()
					self.Shot = self.Shot + 50
				end
				self.coolDown = false
				self.Clicked = false
			else
				self.coolDown = true
			end
		else
			self.Clicked = true
		end	
		
		if self.Shot >= self.MaxShot then
			self:Deactivate()
			self.Shot = self.MaxShot
			self.Overheat = true
		end
		
		if self.Overheat == true then
			local Effect = CreateAEmitter("Wehrmacht.rte/Overheat Laser")
			Effect.Pos = self.Pos + Vector(math.random(-7,-3),-3):RadRotate(self.parent:GetAimAngle(true))
			MovableMan:AddParticle(Effect)
			if self.Shot > 1 then
				self:Deactivate()
				self.coolDown = true
			else
				self.Overheat = false
			end
		end
	
		if self.Shot <= 1 then
			self.coolDown = false
		end
		
		if (self.coolDown == true and self.Shot > 1) and not(self.Overheat) then
			self.Shot = self.Shot - 1
		elseif (self.coolDown == true and self.Shot > 1) and self.Overheat == true then
			self.Shot = self.Shot - 0.45
		end
	end
end