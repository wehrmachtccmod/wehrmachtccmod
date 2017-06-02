function Create(self)
	self.simFrame = 1;
	self.Pos.X = self.Pos.X + math.random(-100,100);
end

function Update(self)
	if self.simFrame < 9 then
		self.simFrame = self.simFrame + 0.5;
	else
		self.simFrame = 1;
	end
	
	self.Frame = math.abs(self.simFrame);
end