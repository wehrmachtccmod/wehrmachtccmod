
function WehrmachtEngineDeactivate(actor)
   if not self.searchedForEngines then
      self.searchedForEngines = true
      local MoObj
      for i = 1, MovableMan:GetMOIDCount()-1 do
         if MovableMan:GetRootMOID(i) == self.ID then   -- an obj without a parent has ID == RootID
             MoObj = MovableMan:GetMOFromID(i)
             if MoObj.PresetName == "Saucer Engine Center" then
                  self.Engine = ToAEmitter(MoObj)
				  ToAEmitter(self.Engine):Deactivate()
             end
             
             if self.Engine then
                  print("Deactivated " .. self.Engine.PresetName)
                  break
             end
         end
      end
   end
    
   if self.Engine then
      if self.Engine:IsAttached() then
         self.Engine:TriggerBurst()
      else
         self.Engine = nil
      end
   end
end

function WehrmachtEngineActivate(actor)
   if not self.searchedForEngines then
      self.searchedForEngines = true
      local MoObj
      for i = 1, MovableMan:GetMOIDCount()-1 do
         if MovableMan:GetRootMOID(i) == self.ID then   -- an obj without a parent has ID == RootID
             MoObj = MovableMan:GetMOFromID(i)
             if MoObj.PresetName == "Saucer Engine Center" then
                  self.Engine = ToAEmitter(MoObj)
				  ToAEmitter(self.Engine):Activate()
             end
             
             if self.Engine then
                  print("Reactivated " .. self.Engine.PresetName)
                  break
             end
         end
      end
   end
    
   if self.Engine then
      if self.Engine:IsAttached() then
         self.Engine:TriggerBurst()
      else
         self.Engine = nil
      end
   end
end
