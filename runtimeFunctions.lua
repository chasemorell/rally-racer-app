local json = require( "json" )
composer = require "composer"

local function angleBetween( srcX, srcY, dstX, dstY )
	local angle = ( math.deg( math.atan2( dstY-srcY, dstX-srcX ) )+90 )
	return angle % 360
end

function onCarCollision(event)
	if(event.phase == "began")then
		graphicCar.isFixedRotation = true
		--print("COLLIDED")
			masterLockOn = true
	timer.performWithDelay( 50, function()
		isFixedRotation = false
		masterLockOn = false
	end)

end
end

function exitGame(trackNumber)

	lInit = false
		rInit = false
		turnSpeed = 0
		isTurning = false

	paused = true
	turnRightButton:removeEventListener( "touch", rTouch )
    turnLeftButton:removeEventListener( "touch", lTouch )
    Runtime:removeEventListener("enterFrame",enterFrame)
    Runtime:removeEventListener( "key", onKeyEvent ) 
    Runtime:removeEventListener( "touch", touch )
    Runtime:removeEventListener( "touch", screenTouch )

    --delte tiles
    for i = 1,100 do 
    	if track[trackNumber][i].track then track[trackNumber][i].track:removeSelf() end
    	if track[trackNumber][i].leftBody then track[trackNumber][i].leftBody:removeSelf() end
     	if track[trackNumber][i].rightBody then track[trackNumber][i].rightBody:removeSelf() end
    end

	--camera:destroy()   
	camera:cancel() 
	graphicCar:removeSelf()
    carShadow:removeSelf()
    aiCar:removeSelf()
    graphicCar = nil
    --remove controls
    turnRightButton:removeSelf()
    turnLeftButton:removeSelf()

    lever:removeSelf()
    dot:removeSelf()
    wheel:removeSelf()

    track[globalTrack][sensorTile].sensorTop:removeEventListener( "collision" ) 
	track[globalTrack][sensorTile].sensorBottom:removeEventListener( "collision")

    lapText:removeSelf()
    pauseButton:removeSelf()

end

function onKeyEvent(event)
	if(event.phase == "down")then
		if(event.keyName == "a")then
				goForward = true
				isTurning = true
				lInit = true
		end
		if(event.keyName == "c")then

			exitGame(globalTrack)
			
				composer:gotoScene("menu")
		end
		if(event.keyName == "d")then
				goForward = true
				isTurning = true
				rInit = true
		end
		if(event.keyName == "s")then
			print("stop")
				goForward = not goForward
		end
		if(event.keyName == "r")then
			loadSave.saveTable(coordinateLog, "coordinateLog5.json")
			coordinateLog = nil 
			coordinateLog = {}
		end
	end

	if(event.phase == "up")then
		lInit = false
		rInit = false
		turnSpeed = 0
		isTurning = false
	end
end

function enterFrame(event)

	if(paused == false)then
	time = time + (1*.0166)
	--print("TIME = "..time)
    aiIndex = aiIndex + 1 

	if(userActualLap >= (track[globalTrack].lapCount+1) and aiCarHasFinished == false and gameOver == false)then
		print("User wins")
		whoWon = "user"
		goForward = false
		gameOver = true
		timer.performWithDelay( 500,function()
			exitGame(globalTrack)
		end)

		timer.performWithDelay( 1000, function()

			composer.gotoScene("afterGame",{effect = "fade"})
		end)

		return
	end

	if(userActualLap >= (track[globalTrack].lapCount+1) and aiCarHasFinished == true and gameOver == false)then
		--print("User wins")
		--whoWon = "user"
		gameOver = true
		timer.performWithDelay( 500,function()
			exitGame(globalTrack)
		end)

		timer.performWithDelay( 1000, function()

			composer.gotoScene("afterGame",{effect = "fade"})
		end)


		return
	end

	if(aiCoor[aiIndex] == nil )then
		if(aiCarHasFinished == false)then
			aiCarHasFinished = true
			if(userActualLap < (track[globalTrack].lapCount+1) and gameOver == false)then
				-- gameOver = true
				print("Ai Car wins")
				whoWon = "ai"
				--aiIndex = 4
				aiCarEngineOn = false
				timer.performWithDelay( 1000, function()
					--exitGame(globalTrack)

					--composer.gotoScene("afterGame",{effect = "fade"})
				end)
			else
				print("User wins")
			end

			print("aiCar Has finished the race")
		end
	else
		if(aiCarEngineOn)then
			aiCar.rotation = aiCoor[aiIndex].rotation--(angleBetween(aiCar.x,aiCar.y,aiCoor[aiIndex].x,aiCoor[aiIndex].y))+180
			aitouchJoint:setTarget(aiCoor[aiIndex].x,aiCoor[aiIndex].y) --Development Only
		end
		if(aiCoor[aiIndex].y ~= aiCoor[2].y)then

			goForward = true

			if(isNowGreenLight == false and lights)then
				isNowGreenLight = true
				lights:setFrame(3)

				timer.performWithDelay( 1000, function()
					transition.to( lights, {y = -100, onComplete = function ()
						lights:removeSelf()
						lights = nil
					end} )
				end)

			end

		end

	end

	if(aiIndex < 70)then
		aiCar.rotation = -180
	end
end


	--aiCar.x = aiCoor[aiIndex].x
	--aiCar.y = aiCoor[aiIndex].y
	--aiCar:setLinearVelocity( (aiCoor[aiIndex].x/100), (aiCoor[aiIndex].y/100) )
	--Development Only ---------
	if(graphicCar)then
	--cIndex = cIndex + 1 
	--coordinateLog[cIndex] = {}
	--coordinateLog[cIndex].x = graphicCar.x
	--coordinateLog[cIndex].y = graphicCar.y
	--coordinateLog[cIndex].rotation = graphicCar.rotation
end

	if(masterLockOn == false and paused == false)then

		graphicCar.rotation = orbital.rotation - 90
		graphicCar.linearDamping = 2
		if (lInit == true) then
			if(turnSpeed > -2)then
				turnSpeed = turnSpeed - .2
				--speed = speed - .1
			end
		end

		if (rInit == true) then
			if(turnSpeed < 2)then
				turnSpeed = turnSpeed + .2
				--speed = speed - .1
			end
		end

		orbital.rotation = orbital.rotation + turnSpeed
		theta = math.rad(orbital.rotation)
		Ox = 0 + 20*math.cos(theta)
		Oy = 0 - 20*math.sin(theta)

		deltaX =  Ox 
		deltaY =  Oy

		angle = math.atan(deltaX/deltaY)
		if((deltaX/deltaY) == 0)then
		end
		angle = math.deg( angle )
		car.rotation = angle
		
			tDeltaY = -Oy 
			tDeltaX = Ox 

			if(goForward == true)then
			--	graphicCar:setLinearVelocity( (tDeltaX*speed), (tDeltaY*speed) )
				if(graphicCar)then
				graphicCar:applyForce( (tDeltaX/(speed*3)), (tDeltaY/(speed*3)), graphicCar.x, graphicCar.y )
			end

			end

				local aitheta = math.rad(aiCar.rotation)
				aiOx = 0 + 20*math.cos(aitheta)
				aiOy = 0 - 20*math.sin(aitheta)
--isEmitterEnabled = true
		if(isEmitterEnabled == "true")then

				aiTrail3[trailIndex] = display.newCircle( (aiCar.x - 0) - (aiOx ), (aiCar.y -  0) - (aiOy ),4)
				aiTrail3[trailIndex].anchorX = 1.3
				aiTrail3[trailIndex].anchorY = 4
				aiTrail3[trailIndex].x =  (aiCar.x - 0) ---+ (aiOx )
				aiTrail3[trailIndex].y =  (aiCar.y -  0) 

				aiTrail3[trailIndex].rotation = aiCar.rotation 
				aiTrail3[trailIndex].alpha = .2
				aiTrail3[trailIndex]:setFillColor( .5,.5,.5 )
				 aiTime =  math.random(500,1000)

				transition.to(aiTrail3[trailIndex],{alpha = 0,time = aiTime,xScale = math.random(3,5),yScale = math.random(3,5), onComplete = function(event)
						--self.removeSelf()
					end})

				function onTime(event)
					if(aiTrail3[event.source.params.index])then
						aiTrail3[event.source.params.index]:removeSelf()
						aiTrail3[event.source.params.index] = nil
					end
				end

				 tm[trailIndex] = timer.performWithDelay( aiTime, onTime )
				 tm[trailIndex].params = { index = trailIndex}

				camera:add(aiTrail3[trailIndex],1)
				trailIndex = trailIndex + 1

				carTrail3[trailIndex] = display.newCircle( (graphicCar.x - 0) - (aiOx ), (graphicCar.y -  0) - (aiOy ),4) --4
				carTrail3[trailIndex].anchorX = 1.3
				carTrail3[trailIndex].anchorY = 1.5
				carTrail3[trailIndex].x =  (graphicCar.x - tDeltaX) ---+ (aiOx )
				carTrail3[trailIndex].y =  (graphicCar.y - tDeltaY) 

				carTrail3[trailIndex].rotation = graphicCar.rotation 
				carTrail3[trailIndex].alpha = .2 --.2
				carTrail3[trailIndex]:setFillColor( .5,.5,.5 )

				local trailScale = math.random( 3,5 )
				transition.to(carTrail3[trailIndex],{alpha = 0,time = aiTime,xScale = trailScale,yScale = trailScale}) --3,5
				camera:add(carTrail3[trailIndex],1)
				

				function onTimeC(event)
					if carTrail3[event.source.params.index] then
						carTrail3[event.source.params.index]:removeSelf()
						carTrail3[event.source.params.index] = nil
					end
				end

				 tm2[trailIndex] = timer.performWithDelay( aiTime, onTimeC )
				 tm2[trailIndex].params = { index = trailIndex}

end




		if(aiIndex > 2)then
		  if(aiCoor[aiIndex] ~= nil)then
			if(aiCoor[aiIndex].rotation ~= aiCoor[aiIndex-1].rotation and isEmitterEnabled == "true")then
				aiSkidAlpha = aiSkidAlpha + skidChange
				--print("drifting")
				
				aiTrail[trailIndex] = display.newCircle( aiCar.x - aiOx, aiCar.y - aiOy,4)
				aiTrail[trailIndex].anchorX = -.5
				aiTrail[trailIndex].anchorY = 1
				aiTrail[trailIndex].x =  (aiCar.x - 0) --+ (aiOx )
				aiTrail[trailIndex].y =  (aiCar.y -  0) --+ (aiOy )

				aiTrail2[trailIndex] = display.newCircle( (aiCar.x - 0) - (aiOx ), (aiCar.y -  0) - (aiOy ),4)
				aiTrail2[trailIndex].anchorX = 1.3
				aiTrail2[trailIndex].anchorY = 1.3
				aiTrail2[trailIndex].x =  (aiCar.x - 0) ---+ (aiOx )
				aiTrail2[trailIndex].y =  (aiCar.y -  0) --+ (aiOy )

				aiTrail[trailIndex].rotation = aiCar.rotation 
				aiTrail[trailIndex].alpha = aiSkidAlpha
				aiTrail[trailIndex]:setFillColor( math.random( .5,.7 ),math.random( .5,.7 ),math.random( .5,.7 ) )
				transition.to(aiTrail[trailIndex],{alpha = 0,time = 10000})
				camera:add(aiTrail[trailIndex],2)

				aiTrail2[trailIndex].rotation = aiCar.rotation
				aiTrail2[trailIndex].alpha = aiSkidAlpha
				aiTrail2[trailIndex]:setFillColor( math.random( .5,.7 ),math.random( .5,.7 ),math.random( .5,.7 ) )
				transition.to(aiTrail2[trailIndex],{alpha = 0,time = 10000})
				camera:add(aiTrail2[trailIndex],2)

				function onTime2(event)
					if aiTrail2[event.source.params.index] then
						aiTrail2[event.source.params.index]:removeSelf()
						aiTrail2[event.source.params.index] = nil
						aiTrail[event.source.params.index]:removeSelf()
						aiTrail[event.source.params.index] = nil
					end
				end

				 tm3[trailIndex] = timer.performWithDelay( 10000, onTime2 )
				 tm3[trailIndex].params = { index = trailIndex}

			else
				aiSkidAlpha = 0
				--print("straight")
			end
		  end
		end

		if(isTurning == true and isEmitterEnabled == "true")then
			--print(tostring(isEmitterEnabled) .."This is if the emitter is enabled")

			 skidAlpha = skidAlpha + skidChange
			carTrail[trailIndex] = display.newCircle( graphicCar.x - tDeltaX, graphicCar.y - tDeltaY,4)
			carTrail[trailIndex].anchorX = -.5
			carTrail[trailIndex].anchorY = 1
			carTrail[trailIndex].x =  (graphicCar.x - 0) - (tDeltaX )
			carTrail[trailIndex].y =  (graphicCar.y -  0) - (tDeltaY )

			carTrail2[trailIndex] = display.newCircle( (graphicCar.x - 0) - (tDeltaX ), (graphicCar.y -  0) - (tDeltaY ),4)
			carTrail2[trailIndex].anchorX = 1.3
			carTrail2[trailIndex].anchorY = 1.3
			carTrail2[trailIndex].x =  (graphicCar.x - 0) - (tDeltaX )
			carTrail2[trailIndex].y =  (graphicCar.y -  0) - (tDeltaY )

			carTrail[trailIndex].rotation = graphicCar.rotation 
			carTrail[trailIndex].alpha = skidAlpha
			carTrail[trailIndex]:setFillColor( math.random( .5,.7 ),math.random( .5,.7 ),math.random( .5,.7 ) )
			transition.to(carTrail[trailIndex],{alpha = 0,time = 10000})
			camera:add(carTrail[trailIndex],2)

			carTrail2[trailIndex].rotation = graphicCar.rotation
			carTrail2[trailIndex].alpha = skidAlpha
			carTrail2[trailIndex]:setFillColor( math.random( .5,.7 ),math.random( .5,.7 ),math.random( .5,.7 ) )
			transition.to(carTrail2[trailIndex],{alpha = 0,time = 10000})
			camera:add(carTrail2[trailIndex],2)

			function onTime3(event)
				if carTrail2[event.source.params.index] then
					carTrail2[event.source.params.index]:removeSelf()
					carTrail2[event.source.params.index] = nil
					carTrail[event.source.params.index]:removeSelf()
					carTrail[event.source.params.index] = nil
				end
			end

				 tm4[trailIndex] = timer.performWithDelay( 10000, onTime3 )
				 tm4[trailIndex].params = { index = trailIndex}
		else
			skidAlpha = 0
		end

		end

	if(paused == false)then
	carShadow.rotation = graphicCar.rotation
	carShadow.x = graphicCar.x + 5
	carShadow.y = graphicCar.y + 5

	trailIndex = trailIndex + 1
end

end

function touch(event)
	maxTurnSpeed = 3
	--HERE GO 
	--goForward = true
	--print(math.abs(event.x-jX))
	if(math.abs(event.x-jX) < 120 )then
		lever.x = event.x
		wheel.rotation = event.x-jX
	end
if(math.abs(lever.x-jX) > 30)then
		isTurning = true

	if(lever.x - jX)<0 then
		 compensation = 30
	else
		 compensation = -30
	end
	turnSpeed = ((lever.x - jX)+compensation)/20
	if(turnSpeed < -maxTurnSpeed)then
		turnSpeed  = -maxTurnSpeed
	end

	if(turnSpeed > maxTurnSpeed)then
		turnSpeed = maxTurnSpeed
	end
	--print("turnSpeed = "..turnSpeed)
	--lever.x = event.x
else
		isTurning = false

	turnSpeed = 0
end

	if(event.phase == "ended")then
		turnSpeed = 0
		--lever.x = 160
		--transition.to( wheel, {rotation = 0} )
		wheel.rotation = 0
		lever.x = jX 
		--transition.to(lever,{x = jX})
		if(lever.alpha == 0)then
		--goForward = false 
		end
	end
end

function rTouch(event)
	print("NO!!!!!!")
	if(event.phase == "began")then

		goForward = true
		isTurning = true
		--turnSpeed = 1
		rInit = true
	end
	if(event.phase == "ended")then
		--goForward = false
		turnSpeed = 0
		rInit = false
		isTurning = false
		speed = maxSpeed
	end
end

function screenTouch(event)
--[[
	if(event.phase == "began")then
		if(event.x<240)then
			lInit = true
			isTurning = true
			goForward = true
		else
			goForward = true
			isTurning = true
			--turnSpeed = 1
			rInit = true
		end
		--turnSpeed = -1

	end

	if(event.phase == "ended")then
		lInit = false
		rInit = false
		--goForward = false
		turnSpeed = 0
		isTurning = false
		speed = maxSpeed
	end ]]--
end


function lTouch(event)
	if(event.phase == "began")then
		lInit = true
		isTurning = true
		goForward = true
		--turnSpeed = -1
		isTurning = true

	end

	if(event.phase == "ended")then
		lInit = false
		--goForward = false
		turnSpeed = 0
		isTurning = false
				isTurning = false

		speed = maxSpeed
	end
end
