function Create(self)
   --thanks so much to whitty for his awesome lua, which im hopeless at
   --working variables
   self.Turret = {};
   self.Turret.Team = 0;
   --self.DetectTimer[1] = Timer();
   --self.Turret[1].IsControllable = false;
   --create the turrets.
   self.Turret[1] = CreateACrab("MG-42 Turret FB");
   MovableMan:AddParticle(self.Turret[1]);
   self.Turret[1].Offset = Vector(4,17);
   self.Turret[1].IsControllable = true;
   self.Turret[2] = CreateACrab("AAM Turret FB");
   MovableMan:AddParticle(self.Turret[2]);
   self.Turret[2].Offset = Vector(-35,20);
   self.Turret[3] = CreateACrab("AAM Turret FB");
   MovableMan:AddParticle(self.Turret[3]);
   self.Turret[3].Offset = Vector(44,20);
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

function Update(self)

	--keeps it nice and leveled
	if self.AngularVel > 0.45 and self.RotAngle > 0.45 then
		self.AngularVel = 0.45;
	elseif self.AngularVel < -0.45 and self.RotAngle < -0.45 then
		self.AngularVel = -0.1;
	end


   --update turret spatial properties
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