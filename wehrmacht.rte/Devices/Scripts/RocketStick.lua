function Create(self)
    self.LTimer = Timer();
	self.hurtTimer = Timer();
	self.hurtInterval = 2000;
	
	if math.random(0,100) < 85 then
		self:GibThis();
	else
		print("Dud!");
	end
end



function Update(self)


	if self.LTimer:IsPastSimMS(5) then
		for actor in MovableMan.Actors do
			if (math.abs(actor.Pos.X - self.Pos.X) < 18) and (math.abs(actor.Pos.Y - self.Pos.Y) < 18) and (actor.PinStrength <= 50) and (actor.Mass <= 750) then
				print("Try not to make any sudden movements.")
				actor.PinStrength = 9000000;
				actor.Pos = self.Pos;
				actor.Vel = self.Vel;
				actor.PinStrength = 0;
				if self.hurtTimer:IsPastSimMS(self.hurtInterval) then
					actor.Health = actor.Health - 1;
					self.hurtTimer:Reset();
				end
			end	
		end
	end
end

function Destroy(self)
	--self:GibThis();
end