function Create(self)
end

function Update(self)

	self.AIMode = 0;
	if not(self:IsPlayerControlled()) then
		self:GetController():SetState(Controller.WEAPON_FIRE,false);
		self:GetController():SetState(Controller.AIM_DOWN,false);
		self:GetController():SetState(Controller.AIM_UP,false);
		self:GetController():SetState(Controller.MOVE_RIGHT,false);
		self:GetController():SetState(Controller.MOVE_LEFT,false);
	end
   
	for actor in MovableMan.Actors do
		dist = math.sqrt((self.Pos.X - actor.Pos.X) ^ 2 + (self.Pos.Y - actor.Pos.Y) ^ 2);
		if dist < 60 then
			actor.HitsMOs = false;
		else
			actor.HitsMOs = true;
		end
	end
end