function Create(self)
--The timer that will detonate the revolver shot once 1.6 seconds have passed.
    self.LTimer = Timer();
end

function Update(self)
	if self.LTimer:IsPastSimMS(100) then
		self:GibThis();
	end
end