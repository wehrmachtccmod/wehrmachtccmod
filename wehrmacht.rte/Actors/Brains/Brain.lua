function Create(self)
	self.BrainMan = CreateAHuman("Wehrmacht.rte/Adolf Hitler");
	self.BrainCase = CreateActor("Wehrmacht.rte/Brain Decoy");
	self.BrainCase.Pos = self.Pos;
	self.BrainMan.Pos = self.Pos;
	
	MovableMan:AddActor(self.BrainCase);
	print("Brain case decoy created");
	
	self.Life = Timer();
end

function Update(self)

	self.Frame = 2;
	
	for actor in MovableMan.Actors do
		if actor.PresetName == "Brain Decoy" and SceneMan:ShortestDistance(self.Pos,actor.Pos,true).Magnitude < 200 then
			self.Case = ToActor(actor);
		end
	end
	
	if self.Life:IsPastSimMS(10) and not(self.Case) then
	
		self.BrainMan.Pos = self.Pos;
		MovableMan:AddActor(self.BrainMan);
		self.Man = ToActor(self.BrainMan);
			
		self.Pos = self.Man.Pos;
		self.Health = self.Man.Health;
			
		print("Brain man spawned");
		self.spawnbrain = false;
		
		if self.Man.Health <= 0 or not(self.Man) then
		
			self.ToDelete = true;
			print("Brain man killed")
		end
	end
end
