function Create(self)
    --The Y coordinate at which to hover.
    self.hoverY = self.Pos.Y - 20;

    --The maximum speed of the train.
    self.maxspeed = 7;

    --The current speed of the train.
    self.curspeed = self.maxspeed;

    --If the train has crashed or not.
    self.crashed = false;

    --The time since the train has crashed.
    self.crashtimer = Timer();

    --This detects when to add some swaying motion to make movement seem more natural.
    self.swaytimer = Timer();

    --How much to sway (radians).
    self.sway = 0.25;

    --The area in which the train should stop.
    self.stoparea = SceneMan.Scene:GetArea("Train Stop Area");

    --Whether the train has come to a stop at a destination.
    self.stopped = false;

    --How long the train has been stopped for.
    self.stoptimer = Timer();

    --How far the train can rotate before crashing (radians)
    self.maxrot = 1.8;
	
	-- Add Turrets
	self.turrets = nil
	
   self.Turret = {};
   --self.Turret.Team = self.Team;
  
   self.Turret[1] = CreateACrab("Train Gun Small");
   MovableMan:AddParticle(self.Turret[1]);
   self.Turret[1].Offset = Vector(-11,-34);
   self.Turret[1].Team = self.Team;
	
end

function Update(self)
    --If the train hasn't crashed...
    if self.crashed == false then
	--The following lines level out the train (until it has crashed).
	--This makes it hover.
	self.Vel.Y = self.Vel.Y - ((self.Pos.Y - self.hoverY)) / 35;

	--This makes sure it's hovering around the right spot.
	self.Pos.Y = ((self.Pos.Y * 9) + self.hoverY) / 10;

	--This keeps the train at a constant speed.
	if self.Vel.X ~= 50 then
	    self.Vel.X = (self.Vel.X * 9 + self.curspeed) / 10;
	end

	--This keeps the train rotated in the right direction.
	if self.RotAngle ~= 0 then
	    self.AngularVel = (self.AngularVel * 74 - math.deg(self.RotAngle)) / 75;
	end

	--Crash the train if it's rotated too far.
	if self.RotAngle <= -self.maxrot or self.RotAngle >= self.maxrot then
	    self.crashed = true;
	    self.crashtimer:Reset();
	end

	--Slow down and stop if at a stop area.
	if self.stoparea ~= nil then
	    --Find the area to stop in.
	    stopbox = self.stoparea:GetBoxInside(self.Pos);
	    if stopbox ~= nil then
		--If we're not at a complete stop yet, slow down with a nice pattern.
		if self.stopped == false then
		    if self.Pos.X < stopbox.Center.X then
			--Math to make a nice slowing gradient.
			self.curspeed = ((stopbox.Center.X - self.Pos.X) / (stopbox.Width / 2)) * self.maxspeed;
			--Reset the stop timer; we haven't stopped yet.
			self.stoptimer:Reset();
			--If the train is in approximately the right position, flag that it is stopped.
			if (self.Pos.X > stopbox.Center.X - 5) and (self.Pos.X < stopbox.Center.X + 5) then
			    self.curspeed = 0;
			    self.stopped = true;
			end
		    end
		--Otherwise, after 7.5 seconds, go.
		elseif self.stoptimer:IsPastSimMS(7500) then
		    --If the train is not past the center, give it a nudge so it can start going.
		    if self.Pos.X - stopbox.Center.X <= 0 then
			self.Pos.X = self.Pos.X + 2;
		    end
		    --Increase the speed in an increasing gradient as it leaves.
		    self.curspeed = ((self.Pos.X - stopbox.Center.X) / (stopbox.Width / 2)) * self.maxspeed;
		    --If the train is behind the center, it will go backward.  To avoid this, we reverse the speed if it is negative.
		    if self.curspeed < 0 then
			self.curspeed = self.curspeed * -1 + 2;
		    end
		    --Once we're close enough to the maximum speed, flag that the train is no longer stopped and cap off the speed to what it should be.
		    if self.curspeed >= self.maxspeed - 3 then
			self.curspeed = self.maxspeed;
			self.stopped = false;
		    end
		end
	    end
	end
	
	--If the train is dead, crash it.
	if self.Health <= 100 then
	    self.crashed = true;
	    self.crashtimer:Reset();
	end

	--Every 5 seconds, check if the train has any sway.  If not, apply some.
	--if self.swaytimer:IsPastSimMS(1000) then
	--    self.swaytimer:Reset();
	--    self.AngularVel = self.sway;
	--end
    elseif self.crashtimer:IsPastSimMS(5000) == true then
	--Explode five seconds after crashing.
	self:GibThis();
    end
	
	if self.Turret == nil then
		MovableMan:AddParticle(self.Turret[1]);
	end
	
	for i = 1, #self.Turret do
      if MovableMan:IsParticle(self.Turret[i]) == true then
         --basic turret position upkeep (so it doesn't fall at 999999m/s)
         self.Turret[i].Vel.X = 0;
         self.Turret[i].Vel.Y = 0;
         --update turret position
         self.Turret[i].RotAngle = self.RotAngle;
         self.Turret[i].Pos = self.Pos + self:RotateOffset(self.Turret[i].Offset)
      end
   end
	
end
	
function Destroy(self)
  for i = 1, #self.Turret do
      if MovableMan:IsParticle(self.Turret[i]) == true then
         if self.Health < 1 then
            self.Turret[i]:GibThis()
         else
            self.Turret[i].ToDelete = true
         end
      end
   end
end