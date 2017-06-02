function WehrmachtArtilleryRoundA(actor)
	print("Partial success!");
	local gun = ToActor(actor).EquippedItem;
	if gun ~= nil then
		print("Even more success!")
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Artillery A");
		gun:Reload();
		print("Complete success! :D");
	end
end

function WehrmachtArtilleryRoundB(actor)
	local gun = ToACrab(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Artillery B");
		gun:Reload();
	end
end

function WehrmachtArtilleryRoundC(actor)
	local gun = ToACrab(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Artillery C");
		gun:Reload();
	end
end