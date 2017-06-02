function Create(self)

	--laser:
	self.Range = 1500;
	--self.LaserKey = 39;
	self.t = Timer();


end

function Update(self)

	local mo = SceneMan:ShortestDistance(self.Pos, self.MuzzlePos, true);
	local p = Vector();
	local ray = SceneMan:CastObstacleRay(self.MuzzlePos+mo, Vector(self.Range*mo.Normalized.X,self.Range*mo.Normalized.Y), Vector(), p, self.ID, 0, 0);

	if ray > 0 then
		local k = CreateMOPixel("Aimer Glow");
		k.Pos = p;
		k.Vel = Vector(0,0);
		MovableMan:AddMO(k);
		local k2 = CreateMOPixel("Aimer Glow");
		k2.Pos = p;
		k2.Vel = Vector(0,0);
		MovableMan:AddMO(k2);
	end
end