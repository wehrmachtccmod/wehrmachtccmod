function Create(self)
--The timer that will measure out the missile's events.
    self.LTimer = Timer();

--The missile's target, currently set to nothing.

    self.target = nil;

--Find out who shot the weapon by finding the closest actor within 50 pixels.
    local curdist = 140;
    for actor in MovableMan.Actors do
	local avgx = actor.Pos.X - self.Pos.X;
	local avgy = actor.Pos.Y - self.Pos.Y;
	local dist = math.sqrt(avgx ^ 2 + avgy ^ 2);
	if dist < curdist then
	    curdist = dist;
	    self.parent = actor;
	end
    end

--If the missile has no firer, make it go after anyone.  Otherwise, set its team to that of the firer.
    if MovableMan:IsActor(self.parent) then
	self.Team = self.parent.Team;
    else
	self.Team = -1;
    end
end

function Update(self)
    if self.LTimer:IsPastSimMS(100) then
	--Get a target.  Go for the closest actor within 500 pixels.
	if MovableMan:IsActor(self.target) == false then
	    local curdist = 500;
	    for actor in MovableMan.Actors do
		local avgx = actor.Pos.X - self.Pos.X;
		local avgy = actor.Pos.Y - self.Pos.Y;
		local dist = math.sqrt(avgx ^ 2 + avgy ^ 2);
		if dist < curdist and actor.Team ~= self.Team then
		    curdist = dist;
		    self.target = actor;
		end
	    end
	end

	--If the target still exists...
	if MovableMan:IsActor(self.target) then
	    --The direction from the center of the missile to the target.
	    local targetdir = math.atan2(-(self.target.Pos.Y-self.Pos.Y),(self.target.Pos.X-self.Pos.X));

	    --Gradually angle the missile toward its target.
	    if targetdir ~= self.RotAngle then
		self.RotAngle = targetdir;
	    end

	    --Make sure the missile's thruster is firing.
	    if self:IsEmitting() == false then
	        self:EnableEmission(true);
	    end
	else
	    --If there's no target, shut off the thrusters.
	    if self:IsEmitting() == true then
	        self:EnableEmission(false);
	    end
	end

	if self.LTimer:IsPastSimMS(5000) then
	    --If the missile has run out of time, self destruct!
	    self:GibThis();
	end
    end
end