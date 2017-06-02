function Create(self)
    local curdist = 25;
end

function Update(self)
    self.parent = nil;

    for actor in MovableMan.Actors do
	dist = math.sqrt((self.Pos.X - part.Pos.X) ^ 2 + (self.Pos.Y - part.Pos.Y) ^ 2);
	if dist < curdist then
	    curdist = dist;
	    self.parent = actor;
	end
	if MovableMan:IsActor(self.parent) and dist(self.parent) < 100 then
	    self.Team = self.parent.Team;
	    self.IsControllable = true;
	else
	    self.Team = -1;
	    self.IsControllable = false;
	end
    end
end