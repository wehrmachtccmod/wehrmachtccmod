function Create(self)
 self.parentgun = nil;
 self.parentactor = nil;
-------------------------
 self.weaponname = "8cm GrW-34";
-------------------------
 local curdist = 30;
 for i = 1,MovableMan:GetMOIDCount()-1 do
  target = MovableMan:GetMOFromID(i);
  if target.PresetName == self.mainweaponname and target.ClassName == "HDFirearm" and SceneMan:ShortestDistance(self.Pos,target.Pos,true).Magnitude < curdist then
   self.parentgun = ToHDFirearm(target);
   break;
  end
 end
 if self.parentgun == nil then
  self.ToDelete = true;
  self.LifeTime = 0;
  self.canturnoff = false;
 end
end

function Update(self)
 self.ToDelete = false;
 self.ToSettle = false;
 self.PinStrength = 10000;

 if self.parentgun ~= nil and self.parentgun.ID ~= 255 then
  self.parent = nil;
  self.actor = MovableMan:GetMOFromID(self.parentgun.RootID);
 end
 if MovableMan:IsActor(self.actor) then
  self.parent = ToActor(self.actor);
  self.Team = self.parent.Team;
 end
 if self.parent:IsPlayerControlled() and self.parentgun ~= nil and self.parentgun.ID ~= 255 then
  if self.parent:IsState(WEAPON_FIRE) then
  self.parent:GetController():SetState(10, true)
 end
end
end