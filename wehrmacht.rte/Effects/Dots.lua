function Create(self)
	self.force = 36;
	self.upLimit = 1.4;
	self.grav = SceneMan.GlobalAcc.Y * TimerMan.DeltaTimeSecs;
	self.loopskip = 5;
	self.switched = false;
	
	self.parent = MovableMan:GetMOFromID(self.RootID);
	
	self.viewactor = CreateActor("Target View Actor");
	self.viewactor.Team = -1;
	self.viewactor.Mass = self.ID;
	MovableMan:AddActor(self.viewactor);
end

function Update(self)

	self.parent = MovableMan:GetMOFromID(self.RootID);
	
	--local isused = false;
	--if MovableMan:IsActor(self.parent) then
	--	for player = 0,ActivityMan:GetActivity().PlayerCount do
	--		actor = ActivityMan:GetActivity():GetControlledActor(player);
	--		if actor then
	--			if actor.ID == self.parent.ID then
	--				isused = true;
	--			end
	--		end
	--	end
	--end

	--local controller = self.parent:GetController();

	if MovableMan:IsActor(self.parent) then
		--if self.parent:IsPlayerControlled() == true then
			local i = 0;
			local pos = Vector(self.Pos.X,self.Pos.Y);
			local lastpos = Vector(pos.X,pos.Y);
			local projvel = Vector(self.force * math.cos(-self.parent:GetAimAngle(true)),self.force * math.sin(-self.parent:GetAimAngle(true)));
			local hitground = false;
			while hitground == false and i < 500 do
				projvel.Y = projvel.Y + (self.grav);
				pos = pos + projvel / 3;
				if pos.X > SceneMan.SceneWidth then
					pos.X = pos.X % SceneMan.SceneWidth;
				end
				
				if pos.X < 0 then
					pos.X = pos.X + SceneMan.SceneWidth;
				end

				if i % self.loopskip == 0 then
					local dot = CreateMOPixel("Target Dots Glow");
					dot.Pos = pos; 
					MovableMan:AddParticle(dot);
					lastpos = Vector(pos.X,pos.Y);
				end

				if SceneMan:GetTerrMatter(pos.X,pos.Y) ~= 0 then
					hitground = true;
					local hitpos = SceneMan:MovePointToGround(pos,0,0);
					local target = CreateMOPixel("Target Aimer Glow");
					target.Pos = hitpos;
					MovableMan:AddParticle(target);
--					self.viewactor.Pos = hitpos;
--					if isused == true and controller:IsState(Controller.AIM_SHARP) then
--						local player = controller.Player;
--						ActivityMan:GetActivity():SwitchToActor(self.viewactor,controller.Player,-1);
--						self.parent:SetControllerMode(Controller.CIM_PLAYER,player);
--						self.switched = true;
--					end
				--end
				--end
				i = i + 1;
			end
		end
	end

--	if self.switched == true and self.viewactor:IsPlayerControlled() == false then
--		self.switched = false;
--		local actor = nil;
--		
--		if isused == false then
--			self.parent:SetControllerMode(Controller.CIM_AI,-1);
--		end
--	end
end

function Destroy(self)
	self.viewactor.ToDelete = true;
end