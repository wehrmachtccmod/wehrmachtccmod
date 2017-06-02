function Create(self)

local curdist = 70 -- Change this distance based on your own gun
  for actor in MovableMan.Actors do
      local avgx = actor.Pos.X - self.Pos.X;
      local avgy = actor.Pos.Y - self.Pos.Y;
      local dist = math.sqrt(avgx ^ 2 + avgy ^ 2);
      if dist < curdist then
         curdist = dist;
         self.parent = actor;
    self.parent:GetController():SetState(10, true)
      end
end
end

function Update(self)
self.parent:GetController():SetState(10, true)
end