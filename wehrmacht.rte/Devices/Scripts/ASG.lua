function Create(self)
	self.Life = Timer()
end

function Destroy(self)
end

function Update(self)
	if self.Life:IsPastSimMS(100) then
	    for actor in MovableMan.Actors do
		if (actor.Pos.X >= self.Pos.X - 86) and (actor.Pos.X <= self.Pos.X + 86) and (actor.Pos.Y >= self.Pos.Y - 87) and (actor.Pos.Y <= self.Pos.Y + 87) then
		    self:GibThis() ;
		end
	end
end
