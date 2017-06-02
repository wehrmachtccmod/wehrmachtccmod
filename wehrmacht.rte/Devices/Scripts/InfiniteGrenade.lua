function Create(self)
   self.spawnedbomb = false;
   self.autoswitch = false;

end

function Update(self)

   if self.spawnedbomb == false and self:IsActivated() == true then
   self.spawnedbomb = true;
   self.grabobject = SceneMan:CastMORay(self.Pos,Vector(-self.Vel.X,-self.Vel.Y):SetMagnitude(50),self.ID,0,true,0);
    if self.grabobject ~= 255 then
   self.target2 = MovableMan:GetMOFromID(self.grabobject);
   self.target = MovableMan:GetMOFromID(self.target2.RootID);
     if MovableMan:IsActor(self.target) then
   ToActor(self.target):AddInventoryItem(CreateTDExplosive(self.PresetName));

      if self.autoswitch == true and self.target.ClassName == "AHuman" then
   ToActor(self.target):GetController():SetState(Controller.WEAPON_CHANGE_PREV,true);
      end

     end
    end
   end

end