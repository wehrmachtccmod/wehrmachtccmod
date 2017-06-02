function Create(self)
   --thanks so much to whitty for his awesome lua, which i'm hopeless at

   self.Turret = {};
   self.Turret.Team = self.Team;
  
   self.Turret[1] = CreateACrab("Saucer Defence Turret A");
   MovableMan:AddParticle(self.Turret[1]);
   self.Turret[1].Offset = Vector(60,-17);
   self.Turret[1].IsControllable = true;
   self.Turret[2] = CreateACrab("Saucer Defence Turret B");
   MovableMan:AddParticle(self.Turret[2]);
   self.Turret[2].Offset = Vector(-60,-17);
   self.Turret[2].IsControllable = true;
   
   self.activate = false	--true
   
	for i = 1, MovableMan:GetMOIDCount()-1 do
		if MovableMan:GetRootMOID(i) == self.ID then
			local MoObj = MovableMan:GetMOFromID(i)
			if MoObj.PresetName == "Saucer Engine Center" then
				self.Engine = ToAEmitter(MoObj)
			end
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

function WehrmachtEngineDeactivate(self)
	for i = 1, MovableMan:GetMOIDCount()-1 do
		if MovableMan:GetRootMOID(i) == self.ID then
			local MoObj = MovableMan:GetMOFromID(i)
			if MoObj.PresetName == "Saucer Engine Center"  and MoObj.Class == "AEmitter" then
				self.activate = false
				print("Deactivated " .. self.Engine.PresetName)
				self.Engine = ToAEmitter(MoObj)
				self.Engine:EnableEmission(false)
			end
		end
	end
end

function WehrmachtEngineActivate(self)
	for i = 1, MovableMan:GetMOIDCount()-1 do
		if MovableMan:GetRootMOID(i) == self.ID then
			local MoObj = MovableMan:GetMOFromID(i)
			if MoObj.PresetName == "Saucer Engine Center" then
				self.activate = true
				print("Reactivated " .. self.Engine.PresetName)
				self.Engine = ToAEmitter(MoObj)
				self.Engine:EnableEmission(true)
			end
		end
	end
end

function Update(self)

	if self.Engine then
		if self.activate == false then
			self.Engine = ToAEmitter(MoObj)
			self.Engine:EnableEmission(false)
		elseif self.activate == true then
			self.Engine = ToAEmitter(MoObj)
			self.Engine:EnableEmission(true)
		end
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