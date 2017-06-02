
function Create(self)
	self.Life = Timer()
	self.Fire = CreateAEmitter("Wehrmacht.rte/Ground Flames")
	self.dummyFire = CreateAEmitter("Wehrmacht.rte/Dummy Flames")
	self.Spawn = false
	
	for actor in MovableMan.Actors do
		if SceneMan:ShortestDistance(self.Pos,actor.Pos,true).Magnitude < 50 then
			self.Parent = actor;
			self.Team = self.Parent.Team;
		end
	end
end

function Update(self)

	for actor in MovableMan.Actors do
	    if self.Life:IsPastSimMS(10) and SceneMan:ShortestDistance(self.Pos,actor.Pos,true).Magnitude < 20 then
			if not(actor.Team == self.Team) then
				self.Fire.Pos = actor.Pos;
				if math.random(0,100) < 25 and not(self.Life:IsPastSimMS(500)) then
					actor.Health = actor.Health - (1 / actor.Mass)
					if math.random(0,100) < 3 then
						MovableMan:AddParticle(self.Fire);
					end
				end
			end
	    end
	end
	
	if self.Vel.Magnitude < 3 then
		self.Spawn = true
		self.ToDelete = true
	end
end

function Destroy(self)
	if math.random(0,100) < 2 then
		if self.Spawn == true then
			self.Fire.Pos = self.Pos;
			MovableMan:AddParticle(self.dummyFire);
		end
	end
end