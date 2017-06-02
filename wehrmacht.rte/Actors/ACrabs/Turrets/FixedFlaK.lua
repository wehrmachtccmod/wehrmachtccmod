function Create(self)
	self.sound = Timer();
end

function Update(self)
	
	local ctrl = self:GetController();
	local turnspeed = 0.05 -- Turret aim speed
	local maxturn = 0 -- sets max aim level 0 is flat level; neg number is down, pos number is up. Number is between 1.57 to -1.57; straight up to straight down.
	
	if self:IsPlayerControlled() then
	
		-- Turn Sound
		local turnsound = CreateAEmitter("Cannon Turn", "Wehrmacht.rte");
		turnsound.Pos = self.Pos;
	
		-- Move Turret
		if ctrl:IsState(Controller.MOVE_LEFT) then
			if self.HFlipped == false then
				if self.RotAngle + turnspeed > 1.57 then
					self.HFlipped = true;
					self.flip = true;
					self.RotAngle = self.RotAngle * -1;
				else
					self.RotAngle = self.RotAngle + turnspeed;
				end
			else
				if self.RotAngle + 0.01 < maxturn then
					self.RotAngle = self.RotAngle + turnspeed;
				end
			end
			
			if self.sound:IsPastSimMS(250) then
				MovableMan:AddParticle(turnsound);
				self.sound:Reset();
			end
		elseif ctrl:IsState(Controller.MOVE_RIGHT) then
			if self.HFlipped == false then
				if self.RotAngle - turnspeed > maxturn then
					self.RotAngle = self.RotAngle - turnspeed;
				end
			else
				if self.RotAngle - 0.01 < -1.57 then
					self.HFlipped = false;
					self.flip = false;
					self.RotAngle = self.RotAngle * -1;
				else
					self.RotAngle = self.RotAngle - turnspeed;
				end
			end
			
			if self.sound:IsPastSimMS(250) then
				MovableMan:AddParticle(turnsound);
				self.sound:Reset();
			end
		end
	end
end