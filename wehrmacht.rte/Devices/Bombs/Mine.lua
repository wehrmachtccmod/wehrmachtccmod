function Create(self)
end

function Destroy(self)
end

function Update(self)
	for actor in MovableMan.Actors do
	    if (actor.Pos.X >= self.Pos.X - 36) and (actor.Pos.X <= self.Pos.X + 36) and (actor.Pos.Y >= self.Pos.Y - 37) and (actor.Pos.Y <= self.Pos.Y + 37) then
			if not(ToActor(actor).Team == self.Sharpness) then
				self:GibThis() ;
			end
	    end
	end
end
