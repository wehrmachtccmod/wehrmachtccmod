function Create(self)
   self.Ctrl = self:GetController()
end

-- limit aim to the first quadrant (up-right)
function Update(self)
   if self.Ctrl.AnalogAim.AbsRadAngle > 0.2 then
      self.Ctrl.AnalogAim = Vector(1,0):RadRotate(0.2)
   elseif self.Ctrl.AnalogAim.AbsRadAngle > 1.5 then
      self.Ctrl.AnalogAim = Vector(1,0):RadRotate(1.5)
   end
end

-- limit aim to the second quadrant (up-left)
function Update(self)
   if self.Ctrl.AnalogAim.AbsRadAngle < 1.6 then
      self.Ctrl.AnalogAim = Vector(1,0):RadRotate(1.6)
   elseif self.Ctrl.AnalogAim.AbsRadAngle > 3 then
      self.Ctrl.AnalogAim = Vector(1,0):RadRotate(3)
   end
end