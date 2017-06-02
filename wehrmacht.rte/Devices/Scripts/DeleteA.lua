function Create(self)
end

function Update(self)

	for actor in MovableMan.Actors do
	    if (actor.Pos.X >= self.Pos.X - 10) and (actor.Pos.X <= self.Pos.X + 10) and (actor.Pos.Y >= self.Pos.Y - 11) and (actor.Pos.Y <= self.Pos.Y + 11) then
			self:GibThis();
		end
	end
	if self.Velocity.Magnitude < 100 then
		self:GibThis();
	end
end
