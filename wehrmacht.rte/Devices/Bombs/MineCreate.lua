function Create(self)

	self.alliedTeam = -1;
	self.Life = Timer()
end

function Update(self)

	if self.ID ~= self.RootID then
		local actor = MovableMan:GetMOFromID(self.RootID);
		if MovableMan:IsActor(actor) then
			self.alliedTeam = ToActor(actor).Team;
		end
	end
end

function Destroy(self)
	local mine = CreateAEmitter("S-mine Active");
	mine.Pos.X = self.Pos.X;
	mine.Pos.Y = self.Pos.Y + 10;
	mine.Vel = self.Vel;
	mine.RotAngle = 0;
	mine.Sharpness = self.alliedTeam;
	MovableMan:AddParticle(mine);
end