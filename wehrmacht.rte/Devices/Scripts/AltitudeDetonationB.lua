function Create(self)
	self.Life = Timer()
end

function Update(self)
	if self.Life:IsPastSimMS(500) then
		if SceneMan:FindAltitude(self.Pos, 110, 3) < 70 then
			self:GibThis()
		end
	end
end