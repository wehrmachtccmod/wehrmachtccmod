function Create(self)
end

function Update(self)
	self.PrevAngle = self.aimAngle;

	for actor in MovableMan.Actors do
		dist = math.sqrt((self.Pos.X - actor.Pos.X) ^ 2 + (self.Pos.Y - actor.Pos.Y) ^ 2);
		if dist < 40 then
			actor.HitsMOs = false;
		else
			actor.HitsMOs = true;
		end
	end

	if self:GetController():IsState(Controller.AIM_UP) then
		self:SetAimAngle(self.PrevAngle + 1)
	end
	if self:GetController():IsState(Controller.AIM_DOWN) then
		self:SetAimAngle(self.PrevAngle - 1)
	end

end