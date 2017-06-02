function Create(self)

	--Credit to Coops for his S.A.W weapons script which defined recoil for all guns in one document, and to Mehman for his recoil formulas. 
	self.name = self.PresetName
	self.recoil = 0;
	self.ff = false;
	self.f0 = ToMagazine(self.Magazine).RoundCount;
	self.f1 = ToMagazine(self.Magazine).RoundCount;
	self.recoilRecover = false
	
	self.recoilAngle = SceneMan:ShortestDistance(self.Pos, self.MuzzlePos, false).AbsRadAngle
	
end

function Update(self)

	for parent in MovableMan.Actors do
		if parent.ID == self.RootID then
			self.parent = ToAHuman(parent)
			break
		else
			self.parent = nil
		end
	end

		if self.PresetName == "Flechette Gun" then
			self.weaponRecoil = 0.55
			self.weaponMuzPosY = 2.5
		elseif self.PresetName == "Gewehr 43" then
			self.weaponRecoil = 0.30
			self.weaponMuzPosY = 2
		elseif self.PresetName == "Kar-98k" or self.PresetName == "Kar-98 Sharpshooter" then
			self.weaponRecoil = 0.50
			self.weaponMuzPosY = 3
		elseif self.PresetName == "Sauer M30" then
			self.weaponRecoil = 0.50
			self.weaponMuzPosY = 2
		elseif self.PresetName == "M1912" or self.PresetName == "Steyr M1912 Offhand" then
			self.weaponRecoil = 0.75
			self.weaponMuzPosY = 3
		elseif self.PresetName == "Spz-Kr" or self.PresetName == "Spz-Kr Offhand" then
			self.weaponRecoil = 0.015
			self.weaponMuzPosY = 1
		elseif self.PresetName == "VSG 1-5" then
			self.weaponRecoil = 0.090
			self.weaponMuzPosY = 3
		elseif self.PresetName == "StG44" or self.PresetName == "STG 44 Scoped" then
			self.weaponRecoil = 0.065
			self.weaponMuzPosY = 2
		elseif self.PresetName == "MG-42" then
			self.weaponRecoil = 0.015
			self.weaponMuzPosY = 2
		end

		if self.Magazine ~= nil and not self:IsReloading() then
			if self.ff then
				self.f0 = ToMagazine(self.Magazine).RoundCount
				self.ff = false
			else
				self.f1 = ToMagazine(self.Magazine).RoundCount
				self.ff = true
			end
	   
			if self:IsActivated() and self.f1 ~= self.f0 then
				self.recoil = self.recoil + ((self.weaponRecoil + self.recoil/2)/((self.parent.Mass - self.Mass)/2))*30
			end
		end
		if self.HFlipped then
			self.RotAngle = self.RotAngle - self.recoil
		else
			self.RotAngle = self.RotAngle + self.recoil
		end
		self.muzPos = Vector()
		self.muzPos.X = self.Pos.X
		self.muzPos.Y = self.Pos.Y - self.weaponMuzPosY
		self.recoilAngle = SceneMan:ShortestDistance(self.muzPos, self.MuzzlePos, false).AbsRadAngle
		if self.recoil > 0 then
			self.recoil = self.recoil - self.recoil/30
			if self.recoil < 0.05 then
				self.recoilRecover = false
			end
			if self.recoil < 0.0005 and not self:IsActivated() then
				self.recoil = 0
			end
			if not self.parent:IsPlayerControlled() then
				if self.recoil > math.random(0.45,0.85) then
					self.recoilRecover = true
				end
				if self.recoilRecover then
					self:Deactivate()
				end
			end
		else
			self.recoil = 0
		end
		
	
end

function Destroy(self)


end