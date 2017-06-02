function Create(self)
	self.lifeTimer = Timer();
	print("Rocket spawn!");
	self.rocket = CreateACRocket("V-1 Flying Bomb");
	self.rocket.Team = self.Team
	self.rocketPos = self.Pos;
	self.firevel = 10;
end

function Update(self)
	self.rocket.Pos = self.rocketPos;
	if self.HFlipped == false then
		local bvx = math.cos(self.RotAngle) * self.firevel;
		local bvy = math.sin(self.RotAngle) * self.firevel * -1;
		self.rocket.Vel = Vector(bvx, bvy);
		local cbx = self.Pos.X + (math.cos(self.RotAngle) * 60);
		local cby = self.Pos.Y + (math.sin(self.RotAngle) * 60 * -1);
		self.rocket.Pos = Vector(cbx, cby);
		self.rocket.RotAngle = self.RotAngle;
	else
		local bvx = math.cos(self.RotAngle) * self.firevel * -1;
		local bvy = math.sin(self.RotAngle) * self.firevel;
		self.rocket.Vel = Vector(bvx, bvy);
		local cbx = self.Pos.X - (math.cos(self.RotAngle) * 60);
		local cby = self.Pos.Y - (math.sin(self.RotAngle) * 60 * -1);
		self.rocket.Pos = Vector(cbx, cby);
		self.rocket.RotAngle = self.RotAngle + math.pi;
	end
	MovableMan:AddActor(self.rocket);
	ActivityMan:GetActivity():SwitchToActor(self.rocket);
	self.ToDelete = true;
	--end
end

function Destrot(self)
	--ActivityMan:GetActivity():SwitchToActor(ToActor(self.rocket),(self.rocket:GetController()).Player,self.rocket.Team);
end