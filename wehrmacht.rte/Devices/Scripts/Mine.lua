function Create(self)
	self.LifeTimer = Timer()
end

function Destroy(self)
end

function Update(self)
    --First checks whether an actor or an item is within the box and then gibs them.
	for actor in MovableMan.Actors do
	    if self.LifeTimer:IsPastSimMS(250) and (actor.Pos.X >= self.Pos.X - 36) and (actor.Pos.X <= self.Pos.X + 36) and (actor.Pos.Y >= self.Pos.Y - 37) and (actor.Pos.Y <= self.Pos.Y + 37) then
		self:GibThis() ;
	    end
	end
end
