function Create(self)
	self.user = nil;
	self.gotgun = false;
	self.gun = nil;
	self.gungethit = false;
	self.DelayTimer = Timer();

	self.delaytime = 250;
	self.operatingdist = 30;

end

function Update(self)

   if not(MovableMan:IsDevice(self.gun)) then
      for item in MovableMan.Items do
         local itemavgx = item.Pos.X - self.Pos.X;
         local itemavgy = item.Pos.Y - (self.Pos.Y-15);
         local itemdist = math.sqrt(itemavgx ^ 2 + itemavgy ^ 2);
         if itemdist < 20 and item.ClassName == "HDFirearm" then
	self.gun = ToHDFirearm(item);
	self.gotgun = true;
     if self.gun.GetsHitByMOs == true then
	self.gungethit = true;
	end
    end
end
end

   if self.gotgun == true and MovableMan:IsDevice(self.gun) then
	self.gun.Pos = self.Pos + Vector(0,-15);
	self.gun.Vel = self.Vel;
	self.gun.ToDelete = false;
	self.gun.AngularVel = 0;
	self.gun.GetsHitByMOs = false;
    if not(MovableMan:IsActor(self.user)) and self.DelayTimer:IsPastSimMS(self.delaytime) then
      for actor in MovableMan.Actors do
         local actoravgx = actor.Pos.X - self.Pos.X;
         local actoravgy = actor.Pos.Y - self.Pos.Y;
         local actordist = math.sqrt(actoravgx ^ 2 + actoravgy ^ 2);
         if actor:GetController():IsState(Controller.PIE_MENU_ACTIVE) and actordist < (self.gun.Radius+actor.Radius) then
	self.user = actor;
	self.DelayTimer:Reset();
	self.user:AddInventoryItem(CreateHeldDevice("Turret Stand Operator" , "Wehrmacht.rte"));
	self.user:GetController():SetState(Controller.WEAPON_CHANGE_PREV,true);
	end
    end
end
end

   if self.gotgun == true and MovableMan:IsDevice(self.gun) then
    if MovableMan:IsActor(self.user) then
     if self.user.Pos.X > self.Pos.X then
	self.gun.HFlipped = true;
	self.gun.RotAngle = (self.user:GetAimAngle(false))*-1;
	else
	self.gun.HFlipped = false;
	self.gun.RotAngle = self.user:GetAimAngle(false);
	end
     if self.user:GetController():IsState(Controller.WEAPON_FIRE) then
	self.gun:Activate();
	else
	self.gun:Deactivate();
	end
	local avgx = self.user.Pos.X-self.Pos.X;
	local avgy = self.user.Pos.Y-self.Pos.Y;
	local dist = math.sqrt(avgx ^ 2 + avgy ^ 2);
     if self.user:GetController():IsState(Controller.PIE_MENU_ACTIVE) and (self.user:GetController():IsState(Controller.HOLD_LEFT) or self.user:GetController():IsState(Controller.HOLD_RIGHT)) then
	self.gun.ToDelete = true;
	self.gun.LifeTime = 0;
	self.user:AddInventoryItem(CreateHDFirearm(self.gun.PresetName));
	self.user:GetController():SetState(Controller.WEAPON_CHANGE_PREV,true);
	self.user = nil;
	self.DelayTimer:Reset();
	end
     if (self.user:GetController():IsState(Controller.PIE_MENU_ACTIVE) and self.DelayTimer:IsPastSimMS(self.delaytime) and not(self.user:GetController():IsState(Controller.BODY_CROUCH))) or dist > (self.gun.Radius+self.user.Radius) then
	self.user:GetController():SetState(Controller.WEAPON_CHANGE_PREV,true);
	self.user = nil;
	self.DelayTimer:Reset();
	end
	self.Frame = 1;
	else
	self.Frame = 0;
    end
end
   

end

function Destroy(self)
   if MovableMan:IsDevice(self.gun) and self.gungethit == true then
	self.gun.GetsHitByMOs = true;
	self.gun:Deactivate();
	end

end