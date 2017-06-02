function Create(self)
	self.LTimer = Timer()
	self.DTimer = Timer()
end

function Update(self)
	if self.LTimer:IsPastSimMS(200) then
		for actor in MovableMan.Actors do
			if (actor.Pos - self.Pos).Magnitude < 80 and actor.team then
				self:GibThis();
			else
				self.LTimer:Reset();
			end
		end
	end
	
	if self.DTimer:IsPastSimMS(800) then
		self:GibThis();
	end
end