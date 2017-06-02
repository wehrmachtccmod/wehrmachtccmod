function Destroy(self)
	local terrcheck = Vector(0,0);
   if SceneMan:CastStrengthRay(self.Pos,Vector(0,50),0,terrcheck,0,0,true) then
	local turretstand = CreateAEmitter("Turret Stand");
	turretstand.Pos = terrcheck + Vector(0,-7);
	MovableMan:AddParticle(turretstand);
	end
end