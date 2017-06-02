function Create(self)
	self.magazine = ToMagazine(self.Magazine)
	self.magazineframe = 1
end

function Update(self)
	if self.magazine ~= false and self.magazine.RoundCount > 0 then
		self.magazineframe = ((self.magazine.RoundCount / 7) + 1);
		if self.magazineframe > 11 then
			self.magazineframe = 11
		end
		ToMOSprite(self.magazine).Frame = self.magazineframe
	end
end