function Create(self)

end

function Update(self)
	if self.Magazine then
		self.Frame = 4 - math.ceil((self.Magazine.RoundCount/self.Magazine.Capacity) * 4)
	end
end