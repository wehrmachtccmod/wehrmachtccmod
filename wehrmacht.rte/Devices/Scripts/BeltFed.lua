function Create(self)

end

function Update(self)
	if self.Magazine then
		self.Magazine.Frame = 11 - math.ceil((self.Magazine.RoundCount/self.Magazine.Capacity) * 11)
	end
end