function Create(self)
	local curdist = 25;
	local shovel = nil;
	local dist = 0;
	local part = nil;

	for i=1,MovableMan:GetMOIDCount() - 1 do
		part = MovableMan:GetMOFromID(i);
		if part.PresetName == "Heavy MG" then
			part = ToHDFirearm(part);
			if MovableMan:IsActor(ToMovableObject(MovableMan:GetMOFromID(part.RootID))) == true then
				dist = math.sqrt((self.Pos.X - part.Pos.X) ^ 2 + (self.Pos.Y - part.Pos.Y) ^ 2);
				if dist < curdist then
					curdist = dist;
					shovel = part;
				end
			end
		end
	end

	if shovel ~= nil then
		for actor in MovableMan.Actors do
			if shovel.RootID == actor.ID then
				for i=1,MovableMan:GetMOIDCount() - 1 do
					part = MovableMan:GetMOFromID(i);
					if part.RootID == actor.RootID then
						self:SetWhichMOToNotHit(part,-1);
					end
				end
			end
		end
	end
end