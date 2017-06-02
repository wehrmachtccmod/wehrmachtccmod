
-- Thanks to Asklar for the meter and Coops for a few things.

-- This script would not work without the help of akblabla

function Create(self)
	self.coolDown = false
	self.Shot = 1
	self.MaxShot = 100
	self.Overheat = false
end

function Update(self)

	if self.Magazine then
		self.Magazine.Frame = 11 - math.ceil((self.Magazine.RoundCount/self.Magazine.Capacity) * 11)
	end

	self.actor = MovableMan:GetMOFromID(self.RootID);
	if MovableMan:IsActor(self.actor) then
		self.parent = ToActor(self.actor);
		self.Work = true;
	else
		self.Work = false;
	end
	
	
	if self.Work == true then

		self.Meter = CreateAEmitter("Meter Plasma")
		self.Meter.Pos = self.parent.AboveHUDPos + Vector(0,27)
		self.Meter.Frame = 16 - math.ceil((self.Shot/self.MaxShot) * 16)
		MovableMan:AddParticle(self.Meter)
	
		if self:IsActivated() and self.Magazine then
			if self.Overheat == false then
				self.Shot = self.Shot + 1
				self.coolDown = false
			else
				self:Deactivate()
			end
		else
			self.coolDown = true;
		end	
		
		if self.Shot >= self.MaxShot then
			self:Deactivate()
			self.Shot = self.MaxShot
			self.Overheat = true
		end
		
		if self.Overheat == true then
			local Effect = CreateAEmitter("Wehrmacht.rte/Overheat B")
			Effect.Pos = self.Pos + Vector(math.random(4,12),0):RadRotate(self.parent:GetAimAngle(true))
			MovableMan:AddParticle(Effect)
			if self.Shot > 1 then
				self:Deactivate()
				self.coolDown = true
			else
				self.Overheat = false
			end
		end
	
		
		if (self.coolDown == true and self.Shot > 1) and not(self.Overheat) then
			self.Shot = self.Shot - 2
		elseif (self.coolDown == true and self.Shot > 1) and self.Overheat == true then
			self.Shot = self.Shot - 1
		end
	end
end
