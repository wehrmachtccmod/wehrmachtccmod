
function WehrmachtShotgunRifleShot(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Shotgun Rifle Shot");
		gun:Reload();
	end
end

function WehrmachtShotgunDoubleBarrel(actor)
	local gun = ToAHuman(actor).EquippedItem;
	if gun ~= nil then
		local gun = ToHDFirearm(gun);
		gun:SetNextMagazineName("Magazine Shotgun Double Barrel");
		gun:Reload();
	end
end