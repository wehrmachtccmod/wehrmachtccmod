function Create(self)
	self.RotAngle = 0;
	for actor in MovableMan.Actors do
		local dist = SceneMan:ShortestDistance(actor.Pos, self.Pos, true).Magnitude;
		if dist < 100 and actor.PresetName == "Lwf.gPz Saucer D3" then
			self.parent = ToActor(actor);
		end
	end		
end
function Update(self)
	self.HFlipped = true;
	if self:IsAttached() and MovableMan:IsActor(self.parent) then
		local a = self.parent.RotAngle;
		if self.RotAngle < ((4*(math.pi/3))+a) and self.RotAngle > (math.pi+a) then
			self.RotAngle = (4*(math.pi/3))+a;
			self:Deactivate();
		elseif self.RotAngle > a and self.RotAngle < (math.pi+a) then
			self.RotAngle = a;
			self:Deactivate();
		end
	end
end