function Create(self)
	self.reloadTimer = Timer();
	self.loadedShell = false;
	self.reloadCycle = false;
	self.Stage = 1
	if self:IsFull() == true and self.Magazine ~= nil then
		self.MaxRoundCount = self.Magazine.RoundCount;
	end
	self.reloadDelay = 200;
	
end

function Update(self)
	
	if self.reloadCycle == true and self.reloadTimer:IsPastSimMS(self.reloadDelay) and self:IsFull() == false then
		local actor = MovableMan:GetMOFromID(self.RootID);
		if MovableMan:IsActor(actor) then
			ToActor(actor):GetController():SetState(Controller.WEAPON_RELOAD,true);
		end
		self.reloadCycle = false;
	end
	if self.Magazine then
		if self.loadedShell == false then
			self.ammoCounter = self.Magazine.RoundCount;
		else
			self.loadedShell = false;
			self.Magazine.RoundCount = self.ammoCounter + 1;
		end
	else
		self.reloadTimer:Reset();
		self.reloadCycle = true;
		self.Stage = self.Stage + 1
		self.loadedShell = true;
	end
	if self:IsActivated() then
		self.reloadCycle = false;
		self.Stage = 1			
	end
	if self:IsFull() == true and self.Magazine ~= nil then
		self.MaxRoundCount = self.Magazine.RoundCount;
	end
	if self.Magazine ~= nil and not(self.Stage > 1) then
	end
end