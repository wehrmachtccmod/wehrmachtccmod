function Create(self)
    self.healTimer = Timer();
    self.healInterval = 300;
    self.healnum = 0;
end

function Update(self)
    if self.healTimer:IsPastSimMS(self.healInterval) then
	for actor in MovableMan.Actors do
	    if actor.Health < 100 then
		local avgx = actor.Pos.X - self.Pos.X;
		local avgy = actor.Pos.Y - self.Pos.Y;
		local dist = math.sqrt(avgx ^ 2 + avgy ^ 2);
		if dist < 70 then
		    actor.Health = actor.Health + 1;
		    if self.healnum == 8 then
		    	local part = CreateMOSParticle("Particle Heal Effect");
		    	part.Pos = actor.AboveHUDPos + Vector(0,4);
		    	MovableMan:AddParticle(part);
		    end
		end
	    end
	end
	self.healTimer:Reset();
	self.healnum = self.healnum + 1;
	if self.healnum > 8 then
	    self.healnum = 0;
	end
    end
end