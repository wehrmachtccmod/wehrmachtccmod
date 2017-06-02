function Create(self)
--The timer that will detonate the revolver shot once 1.6 seconds have passed.
    self.LTimer = Timer();
	self.DTimer = Timer();
end

function Update(self)
	if self.LTimer:IsPastSimMS(50) then
		for actor in MovableMan.Actors do
			if (actor.Pos - self.Pos).Magnitude < 80 then
				self:GibThis();
			else
				self.LTimer:Reset();
			end
		end
	end
	
	if self.DTimer:IsPastSimMS(300) then
		self:GibThis();
	end
end