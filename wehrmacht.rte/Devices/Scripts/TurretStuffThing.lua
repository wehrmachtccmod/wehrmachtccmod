function Create(self)
end

function Update(self)
	for device in MovableMan.devices do
		--See if a dropship is within 70 pixel range of the docking unit and if it has the AI mode set to "Stay".
		if (device.ClassName == "HDFirearm") and (math.abs(device.Pos.X - self.Pos.X) < 45) and (math.abs(device.Pos.Y - self.Pos.Y) < 45) then
			
			
			--[[ WARNING, AUTOSCUTTLE WILL KICK IN ONCE THE DS NOTICES ITS NOT MOVING ANYWHERE.
			--Pin the ship and place it nicely in the docking unit.
			device.Vel = Vector(0,0)
			device.Pos = Vector(self.Pos.X + 0, self.Pos.Y + 0)  --replace offsets with values that place the dropship in a nice position
			--]]
			--TEMPORARY SOLUTION. GRAVITATE AT DOCK WITHIN 60 PIXELS.
			local diff = math.sqrt(math.pow((device.Pos.X-self.Pos.X),2) + math.pow((device.Pos.Y - (self.Pos.Y)),2))
			if diff < 1 then
				diff = 1
				end
			if diff < 2 then
				local diffx = device.Pos.X - self.Pos.X
				local diffy = device.Pos.Y - (self.Pos.Y + 0)
				local ang = math.atan2(diffy,diffx)
				device.Vel.Y = device.Vel.Y - (2 / diff * math.sin(ang))
				device.Vel.X = device.Vel.X - (1 / diff * math.cos(ang))
			end
		end
	end
end

function Destroy(self)
end