function Create(self)
   self.Turret = {};
   self.Turret.Team = self.Team;
   self.Turret[1] = CreateACrab("Light Bomber Defence Turret C");
   MovableMan:AddParticle(self.Turret[1]);
   self.Turret[1].Offset = Vector(0,-13);
   self.Turret[1].IsControllable = true;
   local activate = true
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

	self.AngularVel = self.AngularVel * 0.90;
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