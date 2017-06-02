function Create(self)
	
	self.vel = {};
	self.vel[0] = 15.00;
	self.vel[1] = 45.00;
	self.Sharpness = 0;
	self.c = self:GetController();
	
end


function Update(self)

	if self.c:IsState(14) then
		self.Sharpness = 1;
	else
		self.Sharpness = 0;
	end

	if self.c:IsState(3) then
		self.Vel.X = self.vel[math.ceil(self.Sharpness)];
	elseif self.c:IsState(4) then
		self.Vel.X = -self.vel[math.ceil(self.Sharpness)];
	else
		self.Vel.X = 0;
	end
	
	if self.c:IsState(5) then
		self.Vel.Y = -self.vel[math.ceil(self.Sharpness)];
	elseif self.c:IsState(6) then
		self.Vel.Y = self.vel[math.ceil(self.Sharpness)];
	else
		self.Vel.Y = 0;
	end
	
	local a = CreateMOPixel("Cannon Target Designator Glow");
	a.Pos = self.Pos;
	MovableMan:AddMO(a);
	
end

function Destroy(self)
end