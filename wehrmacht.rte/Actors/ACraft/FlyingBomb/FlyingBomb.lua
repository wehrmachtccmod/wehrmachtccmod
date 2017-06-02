function Create(self)
	self.lifeTimer = Timer();
end

function Update(self)
	
	local ctrl = self:GetController();
	local turnspeed = 0.05
	
	--if self:IsPlayerControlled then	
		if ctrl:IsState(Controller.MOVE_LEFT) then
			if self.HFlipped == false then
				self.RotAngle = self.RotAngle + turnspeed;
			else
				self.RotAngle = self.RotAngle - turnspeed;
			end
		end

		if ctrl:IsState(Controller.MOVE_RIGHT) then
			if self.HFlipped == false then
				self.RotAngle = self.RotAngle - turnspeed;
			else
				self.RotAngle = self.RotAngle + turnspeed;
			end
		end
	--end
end