function Create(self)
	self.Life = Timer()
end

function Update(self)
	if self.Life:IsPastSimMS(20) then
		if SceneMan:FindAltitude(self.Pos, 500, 3) < 490 then
			self:GibThis()
		end
	end
end