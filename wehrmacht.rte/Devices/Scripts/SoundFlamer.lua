
function Create(self)
	self.Timer = Timer();
	self.soundmake = false;
end

function Update(self)


	if self:IsActivated() then
		self.Timer:Reset();
		if self.Timer:IsPastSimMS(1000) == false then
			if self.soundmake == true then
				self.Sound = CreateAEmitter("Flamer Charge");
				self.Sound.Pos = self.Pos;
				self.Sound.Vel = self.Vel;
				MovableMan:AddParticle(self.Sound);
				self.soundmake = false;
			end
		end
	else
	self.Timer:Reset();
	self.soundmake = true;
	end	
end