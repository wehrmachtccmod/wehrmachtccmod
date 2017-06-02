function Create(self)

	self.lifeTimer = Timer();
	self.emitTimerA = Timer();
	self.emitTimerB = Timer();
    self.LTimer = Timer();

end

function Update(self)

	if MovableMan:IsParticle(self) and self.lifeTimer:IsPastSimMS(math.random(550,1600)) then
		self:GibThis();
	else
		--self.ToDelete = false;
		--self.ToSettle = false;
	local Effect
	local Offset = self.Vel*(20*TimerMan.DeltaTimeSecs)	-- the effect will be created the next frame so move it one frame backwards towards the barrel
	
	for i = 1, math.floor(self.Vel.Magnitude*0.045) do
		Effect = CreateMOSParticle("Tiny Smoke Trail " .. math.random(3), "Coalition.rte")
		if Effect then
			Effect.Pos = self.Pos - Offset * i/8 + Vector(RangeRand(-2,2),RangeRand(-2,2))
			Effect.Vel = (self.Vel + Vector(RangeRand(-10,30),RangeRand(-10,10))) / 20
			MovableMan:AddParticle(Effect)
		end
	end
end
end