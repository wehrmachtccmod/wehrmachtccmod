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

    --How far the train can rotate before crashing (radians)
    self.maxrot = 0.8;

   self.Turret = {};
  
   self.Turret[1] = CreateACrab("Train Gun Large");
   MovableMan:AddParticle(self.Turret[1]);
   self.Turret[1].Offset = Vector(36,-38);
   self.Turret[1].IsControllable = true;
   self.Turret[1].HFlipped = true;
   self.Turret[2] = CreateACrab("Train Gun Large");
   MovableMan:AddParticle(self.Turret[2]);
   self.Turret[2].Offset = Vector(-32,-38);
   self.Turret[1].Team = self.Team;
   self.Turret[2].Team = self.Team;
   
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
	--if self.Vel.X ~= 50 then
	--    self.Vel.X = (self.Vel.X * 9 + self.curspeed) / 10;
	--end

	--This keeps the train rotated in the right direction.
	if self.RotAngle ~= 0 then
	    self.AngularVel = (self.AngularVel * 74 - math.deg(self.RotAngle)) / 75;
	end

	--Crash the train if it's rotated too far.
	if self.RotAngle <= -self.maxrot or self.RotAngle >= self.maxrot then
	    self.crashed = true;
	    self.crashtimer:Reset();
	end
	
	--If the train is dead, crash it.
	if self.Health <= 10 then
	    self.crashed = true;
	    self.crashtimer:Reset();
	end

	--Every 5 seconds, check if the train has any sway.  If not, apply some.
	--if self.swaytimer:IsPastSimMS(5000) then
	--    self.swaytimer:Reset();
	--    self.AngularVel = self.sway;
	--end
    elseif self.crashtimer:IsPastSimMS(500) == true then
	--Explode five seconds after crashing.
	self:GibThis();
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