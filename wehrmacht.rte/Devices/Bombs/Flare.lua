function Update(self)
if SceneMan:FindAltitude(self.Pos, 10, 2) > 5 then
for k,v in pairs(AEmitters) do
if type(v) == "userdata" then
v.target = self
v.targetMO = self
v.Target = self
v.targ = self
v.Sharpness = self.ID
v.armDist = 50 -- edv missiles need this to prevent console spam, as this is nill without this due to this script
end
end
for k,v in pairs(MOPixels) do
if type(v) == "userdata" then
v.target = self
v.targetMO = self
v.Target = self
v.targ = self
v.Sharpness = self.ID
v.armDist = 50
end
end
else
self.Lifetime = 1
end
end