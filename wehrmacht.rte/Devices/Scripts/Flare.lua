function Create(self)
	self.LifeTimer = Timer()
end

function Destroy(self)
end

function Update(self)
    --First checks whether an actor or an item is within the box and then gibs them.
	for actor in MovableMan.Actors do
	    if self.LifeTimer:IsPastSimMS(100) and (actor.Pos.X >= self.Pos.X - 20) and (actor.Pos.X <= self.Pos.X + 20) and (actor.Pos.Y >= self.Pos.Y - 21) and (actor.Pos.Y <= self.Pos.Y + 21) then
		self:GibThis() ;
	    end
	end
end
