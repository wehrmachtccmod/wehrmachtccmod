
function Create(self)
	if math.random(0,100) < 80 then
		self.ToDelete = true
	end
end

function Update(self)
	if self.Vel.Magnitude < 5 then
		self.ToDelete = true
	end
end