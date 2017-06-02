function Create(self)
	--Timer before switching back to original actor.
	self.switchtimer = Timer();

	--How long to wait before allowing switching back.
	self.switchtime = 500;

	--The potential actor that switched to this.
	self.actor = ToActor(MovableMan:GetMOFromID(self.Mass));
end

function Update(self)
	--If the actor still exists and control is switched to this...
	if MovableMan:ValidMO(self.actor) and self:IsPlayerControlled() then
		--Get the controller.
		local controller = self:GetController();
		
		--Switch back.
		if controller:IsState(Controller.AIM_SHARP) == false and self.switchtimer:IsPastSimMS(self.switchtime) then
			self.actor:SetControllerMode(Controller.CIM_AI,-1);
			self.switchtimer:Reset();
			ActivityMan:GetActivity():SwitchToActor(self.actor,controller.Player,self.actor.Team);
		end
	end
end