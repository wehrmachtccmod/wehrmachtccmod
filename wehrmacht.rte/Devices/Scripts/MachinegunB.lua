function Create(self)
  self.BipodOffset = Vector(0, 7) --Where the Bipod is on the gun
  self.PinDepth = 4 --How deep the bipod is stuck into the ground
  self.BipodStanceOffset = Vector(13, -4) --Where the actor is relative to the gun when the gun is pinned
  
  --Don't fiddle with these
  self.OriginalName = self.PresetName
  self.Recoil = 0
  self.RecoilRot = 0
  self.ShootTimer = Timer()
  self.SharpRange = self.SharpLength
  self.PinnedPos = self.Pos + self:RotateOffset(self.BipodOffset)
  self.PinnedFlipped = self.HFlipped
  self.PickedUp = false
  self.AgeCheck = 0
  self.Clicked = false
end

function Update(self)

	if self.Magazine then
		self.Magazine.Frame = 11 - math.ceil((self.Magazine.RoundCount/self.Magazine.Capacity) * 11)
	end

  if self.AgeCheck + 100 < self.Age then
    self.PresetName = self.OriginalName
  end
  self.AgeCheck = self.Age
  local negatore = 1
	if self.HFlipped then
		negatore = -1;
	end
  if self.RotAngle < 0 then
     self.RotAngle = self.RotAngle + math.pi * 2
  else
    if self.RotAngle > math.pi * 2 then
       self.RotAngle = self.RotAngle - math.pi * 2
    end
  end
	local Pinstrength = 0
	--If Pinned check current strength of the terrain the gun is pinned on
	if self.PresetName == self.OriginalName .. " (Pinned)" then
    local strikePoint = Vector(0,0);
    local lastPoint = Vector(0,0);
    Pinstrength = SceneMan:CastStrengthSumRay(self.PinnedPos, self.PinnedPos + Vector(-1, self.PinDepth) , 0, 0) + SceneMan:CastStrengthSumRay(self.PinnedPos, self.PinnedPos + Vector(0, self.PinDepth) , 0, 0) + SceneMan:CastStrengthSumRay(self.PinnedPos, self.PinnedPos + Vector(1, self.PinDepth) , 0, 0);
    if Pinstrength < 10*self.PinDepth+self.Recoil*10*self.PinDepth  then
      self.PresetName = self.OriginalName
    end
	end
	
	self.Recoil = self.Recoil * 0.99
	self.RecoilRot = self.RecoilRot * 0.95
	local RecoilReduction = 0.1
	local user = nil
	for parent in MovableMan.Actors do
		if parent.ID == self.RootID then
			user = ToAHuman(parent)
			break
		end
	end
	if user ~= nil then
    local aim = ToAHuman(user):GetAimAngle(false)
    ToAHuman(user):SetAimAngle(aim + self.Recoil*0.0015*negatore)
    --Taking the user into account
    local ArmCount = 0
    local ArmLength = 0
    if user.FGArm ~= nil then
      RecoilReduction = RecoilReduction + user.FGArm.Mass
      ArmCount = ArmCount + 1
      ArmLength = user.FGArm.Diameter
    end
    if user.BGArm ~= nil then
      RecoilReduction = RecoilReduction + user.BGArm.Mass
      ArmCount = ArmCount + 1
      ArmLength = math.max(user.BGArm.Diameter , ArmLength)
    end
    ArmLength = ArmLength + user.Diameter
    local strikePoint = Vector(0,0);
    local lastPoint = Vector(0,0);
    local dist = SceneMan:CastObstacleRay(self.Pos + self:RotateOffset(self.BipodOffset), Vector(0, user.Height * 0.5) , strikePoint, lastPoint, user.ID, -1, 0);
    if dist < 0 then
      dist = user.Height * 0.5
    end
    
    if self.PickedUp == false then
      if self.HFlipped ~= self.PinnedFlipped then
        self.PresetName = self.OriginalName
      end
    end
    if self.PresetName == self.OriginalName .. " (Pinned)" then
      local pinnedNegatore = 1
      if user.HFlipped ~= self.PinnedFlipped then
        self:Deactivate()
        user:GetController():SetState(Controller.AIM_SHARP, false)
        pinnedNegatore = -1
      end
      self.HFlipped = self.PinnedFlipped
      if SceneMan:ShortestDistance(self.Pos + self:RotateOffset(self.BipodOffset), self.PinnedPos, SceneMan.SceneWrapsX).Magnitude > self.Diameter*2 then
        self.PresetName = self.OriginalName
      else
        if self.RotAngle > math.pi*0.25 and self.RotAngle < math.pi then
          self.RotAngle = math.pi*0.25
        else
          if self.RotAngle > math.pi*0.25 and self.RotAngle < math.pi*1.75 then
            self.RotAngle = math.pi*1.75
          end
        end
        self.RotAngle = self.RotAngle * pinnedNegatore + self.RecoilRot * negatore * 0.1
        self.Pos = self.PinnedPos - self:RotateOffset(self.BipodOffset)
        self.Vel = Vector(0, 0)
        user.Pos = self.Pos - self:RotateOffset(self.BipodStanceOffset)
        user.Vel = Vector(0, 0)
        altitude = user:GetAltitude(user.Height,0)
        if altitude >= user.Height*0.5 then
          if self.PickedUp == false then
            self.PresetName = self.OriginalName
          else
            user:GetController():SetState(Controller.WEAPON_DROP,true)
          end
        end
      end
    end
    if self.Sharpness == 2 then
      if self.PresetName == self.OriginalName then
        self.PresetName = self.OriginalName .. " (Pinned)"
        local strikePoint = Vector(0,0);
        local lastPoint = Vector(0,0);
        local dist = SceneMan:CastObstacleRay(self.Pos + self:RotateOffset(self.BipodOffset), Vector(0, self.PinDepth) , strikePoint, lastPoint, user.ID, -1, 0);
        if dist >= 0 then
          self.PinnedPos = self.Pos + self:RotateOffset(self.BipodOffset) + Vector(0, dist)
        end
        self.PinnedFlipped = self.HFlipped
      else
        self.PresetName = self.OriginalName
      end
      self.Sharpness = 1
    end
    self.PickedUp = true
  else
    self.PickedUp = false
    self.RecoilRot = 0
    if self.PresetName == self.OriginalName .. " (Pinned)" then
      self.HFlipped = self.PinnedFlipped
      self.Pos = self.PinnedPos - self:RotateOffset(self.BipodOffset)
    end
  end
end

function Destroy(self)

end