function Create(self)
end

function Destroy(self)
end

function Update(self)
    --First checks whether an actor or an item is within the box and then gibs them.
	for actor in MovableMan.Actors do
	    if (actor.Pos.X >= self.Pos.X - 76) and (actor.Pos.X <= self.Pos.X + 76) and (actor.Pos.Y >= self.Pos.Y - 77) and (actor.Pos.Y <= self.Pos.Y + 77) then
		self:GibThis() ;
	    end
	end
end
