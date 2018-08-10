-- ls = left shoulder 
-- sh = straight horizontal 
-- g  = grass
-- rs = right shoulder 
-- sv = straight vertical 
-- rb = right bottom
physics = require "physics"

local function listener( event )

end

Runtime:addEventListener( "accelerometer", listener )


function addPhysicsToTile(level,tile,Ttype)
	local xC = tonumber(string.sub( tostring(tile), 2, 2))
	local yC = tonumber(string.sub( tostring(tile), 1, 1))
	xC = (xC-1)*(tileSize-(tileSize*.016))
	yC = (yC-1)*(tileSize -(tileSize*.016))

	if Ttype == "sv"  or Ttype == "sv2" or Ttype == "ad" then
		local more = 30
		track[level][tile].leftBody = display.newRect( xC - (95+(more/2)),yC,30+more,299 )
		track[level][tile].rightBody = display.newRect( xC + (95+(more/2)),yC,30+more,299 )
		camera:add(track[level][tile].leftBody,2)
		camera:add(track[level][tile].rightBody,2)

		physics.addBody( track[level][tile].leftBody, "static")
		physics.addBody( track[level][tile].rightBody, "static")

		track[level][tile].leftBody.alpha = 0
		track[level][tile].rightBody.alpha = 0
	elseif  Ttype == "sF" then
		local more = 30

		local function topSensorCollision(self,event)
			local whatCar = event.other.id
			if(event.phase == "began")then

				if(whatCar == "user")then
					userTopLap = userTopLap + 1
				end
				print(""..event.other.id.." car touched the top Sensor ")
			end
		end

		local function bottomSensorCollision(self,event)
			--this one is on the finish line
			local whatCar = event.other.id

			if(event.phase == "began")then
				if(whatCar == "user")then
					userBottomLap = userBottomLap + 1
					print("userBottomLap = "..tostring(userBottomLap)..", userTopLap = "..tostring(userTopLap))
					if(userBottomLap == (userTopLap + 1))then
						userActualLap = userActualLap + 1
						lapText.text = "Lap "..tostring(userActualLap).." of "..tostring(track[globalTrack].lapCount)
						if(userActualLap == track[globalTrack].lapCount)then
							lapText.text = "Final Lap!"
						end
						print("LAP VERIFIED. LAP COUNT: "..tostring(userActualLap))
					else 
						print("CHEATING DETECTED")
						userBottomLap = userActualLap
						userTopLap = userActualLap - 1
					end
				end
			--aa	print(""..event.other.id.." car touched the finish line")
			end
		end

		track[level][tile].leftBody = display.newRect( xC - (95+(more/2)),yC,30+more,299 )
		track[level][tile].rightBody = display.newRect( xC + (95+(more/2)),yC,30+more,299 )
		camera:add(track[level][tile].leftBody,2)
		camera:add(track[level][tile].rightBody,2)

		track[level][tile].sensorTop = display.newRect( xC, yC - 100, 200,20)

		camera:add(track[level][tile].sensorTop,2)

		track[level][tile].sensorBottom = display.newRect( xC, yC + 100 - 100, 200,20)
		camera:add(track[level][tile].sensorBottom,2)

		physics.addBody( track[level][tile].leftBody, "static")
		physics.addBody( track[level][tile].rightBody, "static")
		physics.addBody( track[level][tile].sensorTop, "static")
		physics.addBody( track[level][tile].sensorBottom, "static")

		track[level][tile].sensorTop.isSensor = true
		track[level][tile].sensorBottom.isSensor = true

		track[level][tile].leftBody.alpha = 0
		track[level][tile].rightBody.alpha = 0

		track[level][tile].sensorBottom.alpha = 0
		track[level][tile].sensorTop.alpha = 0

		track[level][tile].sensorTop.collision = topSensorCollision
		track[level][tile].sensorBottom.collision = bottomSensorCollision

		track[level][tile].sensorTop:addEventListener( "collision" ) 
		track[level][tile].sensorBottom:addEventListener( "collision")
		sensorTile = tile

	elseif Ttype == "sh" or Ttype == "sh2" or Ttype == "sh3" then
		local more = 30
		track[level][tile].leftBody = display.newRect( xC,yC - (95+(more/2)),299,30+more )
		track[level][tile].rightBody = display.newRect( xC,yC + (95+(more/2)),299,30+more)
		camera:add(track[level][tile].leftBody,2)
		camera:add(track[level][tile].rightBody,2)

		physics.addBody( track[level][tile].leftBody, "static")
		physics.addBody( track[level][tile].rightBody, "static")

		track[level][tile].leftBody.alpha = 0
		track[level][tile].rightBody.alpha = 0
	elseif Ttype == "ls" then
		track[level][tile].leftBody = display.newCircle(  xC - 40, yC - 90, 50 )
		camera:add(track[level][tile].leftBody,2)

		physics.addBody( track[level][tile].leftBody, "static", {radius = 70})

		track[level][tile].leftBody.alpha = 0
	elseif Ttype == "lb" then
		track[level][tile].leftBody = display.newCircle(  xC - 64, yC + 40, 50 )
		camera:add(track[level][tile].leftBody,2)

		physics.addBody( track[level][tile].leftBody, "static", {radius = 60})

		track[level][tile].leftBody.alpha = 0
	elseif Ttype == "rb" or Ttype == "rb2s" then
		track[level][tile].leftBody = display.newCircle(  xC + 85, yC + 40, 50 )
		camera:add(track[level][tile].leftBody,2)

		physics.addBody( track[level][tile].leftBody, "static", {radius = 60})

		track[level][tile].leftBody.alpha = 0
	elseif Ttype == "rs" then
		track[level][tile].leftBody = display.newCircle(  xC + 50, yC - 80, 50 )		
		camera:add(track[level][tile].leftBody,2)

		physics.addBody( track[level][tile].leftBody, "static", {radius = 60})

		track[level][tile].leftBody.alpha = 0

	elseif Ttype == "b1" then
		track[level][tile].leftBody = display.newCircle(  xC , yC , 50 )
		camera:add(track[level][tile].leftBody,2)

		physics.addBody( track[level][tile].leftBody, "static", {radius = 150})

		track[level][tile].leftBody.alpha = 0
	elseif Ttype == "g" or Ttype == "w1" or Ttype == "w2" then
		track[level][tile].leftBody = display.newRect( xC,yC,299,299 )
		camera:add(track[level][tile].leftBody,2)

		physics.addBody( track[level][tile].leftBody, "static")

		track[level][tile].leftBody.alpha = 0
	
	end
end