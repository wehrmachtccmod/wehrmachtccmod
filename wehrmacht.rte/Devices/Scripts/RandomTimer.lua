function Create(self)
	self.LTimer = Timer()
end

function Update(self)
	if self.LTimer:IsPastSimMS(math.random(800,1200)) then
		self:GibThis();
	end
end