function Create(self)
	self.baseROF = 250
	self.modROF = 0
end

function Update(self)
	if self:IsActivated() then
		if self.modROF < 550 then
			self.modROF = self.modROF + 3;
		end
	else
		self.modROF = 0;
	end
	self.RateOfFire = (self.baseROF + self.modROF);
end