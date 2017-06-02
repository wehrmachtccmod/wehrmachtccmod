
function Create(self)
	self.coolDown = false
	self.Shot = 1
	self.MaxShot = 100
	self.actor = MovableMan:GetMOFromID(self.RootID);
	if MovableMan:IsActor(self.actor) then
		self.parent = ToActor(self.actor);
		self.Work = true;
	else
		self.Work = false;
	end
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

		self.Meter = CreateAEmitter("Meter")
		self.Meter.Pos = self.parent.AboveHUDPos + Vector(0,27)
		self.Meter.Frame = 16 - math.ceil((self.Shot/self.MaxShot) * 16)
		MovableMan:AddParticle(self.Meter)

		if self:IsActivated() then
		self.Shot = self.Shot + 2
			self.Clicked = false
		else
			self.coolDown = true
		end	
		
		if self.Shot >= self.MaxShot then
			self:Deactivate()
		end
	
		if self.Shot <= 1 then
			self.coolDown = false
		end
		
		if (self.coolDown == true and self.Shot > 1) then
			self.Shot = self.Shot - 1
			
		end
	end
end