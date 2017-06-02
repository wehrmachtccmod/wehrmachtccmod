function Create(self)
	self.baseROF = 500
	self.modROF = 0
end

function Update(self)
	if self:IsActivated() then
		if self.modROF < 900 then
			self.modROF = self.modROF + 4;
		end
	else
		self.modROF = 0;
	end
	self.RateOfFire = (self.baseROF + self.modROF);
end