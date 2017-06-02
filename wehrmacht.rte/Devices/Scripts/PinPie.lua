function AutoCannonPin(actor)
	actor.userGun = nil;
	for i = 1,MovableMan:GetMOIDCount()-1 do
		actor.userGun = MovableMan:GetMOFromID(i);
		if actor.userGun.RootID == actor.ID and actor.userGun.ClassName == "HDFirearm" then
			actor.userGun.Sharpness = 2;
			break;
		end
	end
	actor.userGun = nil;
end