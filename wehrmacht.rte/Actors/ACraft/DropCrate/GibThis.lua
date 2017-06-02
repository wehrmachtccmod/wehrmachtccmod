function Create(self)
   self.LTimer = Timer();
end

function Update(self)
	if self.LTimer:IsPastSimMS(10000) then
		self:GibThis();
	end
end