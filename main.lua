
--SETUP ------------------------------------------------------------ SETUP
perspective = require("perspective")
camera = perspective.createView()
loadSave = require "loadsave"
physics = require("physics")
composer = require "composer"
 json = require( "json" )

require "saveData"
ads = require("ads")
ads.init( "vungle", "57ad238495dac4b56f00002a" )

--ads.init( "vungle", "57ad1d0dc59fb5a068000048" )

display.setStatusBar( display.HiddenStatusBar )

if(readData("car",false) == 0)then
	print("no car is saved")
	writeData("car","1","w")
	userData = {}
	 

	userData.isCar1Unlocked = true
	userData.isCar2Unlocked = false
	userData.isCar3Unlocked = false
	userData.isCar4Unlocked = false
	userData.isCar5Unlocked = false
	userData.highscore1 = 100000
	userData.highscore2 = 100000
	userData.highscore3 = 100000
	userData.isCar6Unlocked = false
	jUserData = json.encode( userData)
	writeData("userData",jUserData,"w","json") 


else
	print("a car is saved")
	--userData = readData("userData",false)
	 local path = system.pathForFile( "userData.json", system.DocumentsDirectory ) --2
     local contents = ""
     userData = {}
    local file = io.open( path, "r" )
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        userData = json.decode(contents);
        io.close( file )
    end
    print(userData.highscore3)
end



if(readData("effects",false) == 0)then
	print("no effect setting is saved")
	writeData("effects","true","w")
	writeData("effects","true","w")



else
	print("an effect is saved")
	--userData = readData("userData",false)
	 local path = system.pathForFile( "effects.txt", system.DocumentsDirectory ) --2

    local file = io.open( path, "r" )
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
      isEmitterEnabled =  contents
      print(isEmitterEnabled)
        io.close( file )
    end
end



 gameNetwork = require( "gameNetwork" )
gameNetwork.init( "gamecenter" )

display.setDefault( "isAnchorClamped", false )
physics.start()  -- Do this before any other physics call(s)
system.activate( "multitouch" )
require "generateTrack"
 --isEmitterEnabled = true

track = {}
track[1] = {}
track[2] = {}
track[3] = {}
for i = 1,100 do 
	track[1][i] = {}
    track[2][i] = {}
    track[3][i] = {}


end

-- ls = left shoulder 
-- sh = straight horizontal 
-- g  = grass
-- rs = right shoulder 
-- sv = straight vertical 
-- rb = right bottom

--y, x
track[1].lapCount = 6 --6
track[1][21].index = "ls"
track[1][22].index = "sh"
track[1][32].index = "b1"
track[1][23].index = "rs"
track[1][31].index = "ad" --sv
track[1][41].index = "sv2"
track[1][43].index = "rb2"
track[1][33].index = "sF"
track[1][42].index = "ls"
track[1][52].index = "rb"
track[1][51].index = "lb"
track[1][20].index = "g"
track[1][30].index = "g"
track[1][40].index = "g"
track[1][50].index = "g"
track[1][53].index = "g"
track[1][54].index = "w2"
track[1][44].index = "w2"
track[1][34].index = "w1"
track[1][24].index = "w2"
track[1][10].index = "g"
track[1][11].index = "g"
track[1][12].index = "g"
track[1][13].index = "g"
track[1][14].index = "w2"
track[1][15].index = "g"
track[1][60].index = "g"
track[1][61].index = "g"
track[1][62].index = "g"
track[1][63].index = "g"
track[1][64].index = "g"

track[2].lapCount = 5
track[2][21].index = "ls"
track[2][22].index = "rs"
track[2][32].index = "lb"
track[2][33].index = "rb"
track[2][23].index = "ls"
track[2][24].index = "rs"
track[2][31].index = "sv"
track[2][41].index = "lb"
track[2][42].index = "sh3"
track[2][43].index = "rs"
track[2][53].index = "lb"
track[2][54].index = "rb"
track[2][44].index = "sF"
track[2][34].index = "sv"
track[2][10].index = "g"
track[2][20].index = "g"
track[2][30].index = "g"
track[2][40].index = "g"
track[2][50].index = "g"
track[2][60].index = "g"
track[2][61].index = "g"
track[2][62].index = "g"
track[2][63].index = "g"
track[2][64].index = "g"
track[2][65].index = "g"
track[2][15].index = "g"
track[2][25].index = "g"
track[2][35].index = "g"
track[2][45].index = "g"
track[2][55].index = "g"
track[2][65].index = "g"
track[2][11].index = "g"
track[2][12].index = "g"
track[2][13].index = "g"
track[2][14].index = "g"
track[2][15].index = "g"
track[2][16].index = "g"
track[2][17].index = "g"
track[2][52].index = "b1"
track[2][51].index = "g"


track[3].lapCount = 2
track[3][10].index = "g"
track[3][20].index = "g"
track[3][30].index = "g"
track[3][40].index = "g"
track[3][50].index = "g"
track[3][60].index = "g"
track[3][70].index = "g"
track[3][80].index = "g"
track[3][90].index = "g"
track[3][10].index = "g"
track[3][11].index = "g"
track[3][12].index = "g"
track[3][13].index = "g"
track[3][14].index = "g"
track[3][15].index = "g"
track[3][16].index = "g"
track[3][17].index = "g"


track[3][64].index = "sF"
-- ls = left shoulder 
-- sh = straight horizontal 
-- g  = grass
-- rs = right shoulder 
-- sv = straight vertical 
-- rb = right bottom
track[3][21].index = "ls"
track[3][31].index = "lb"
track[3][41].index = "ls"
track[3][51].index = "sv"
track[3][61].index = "lb"
track[3][71].index = "ls"
track[3][81].index = "lb"

track[3][22].index = "sh"
track[3][32].index = "sh2"
track[3][42].index = "sh"
track[3][52].index = "ls"
track[3][62].index = "rb"
track[3][72].index = "sh"
track[3][82].index = "sh3"

track[3][23].index = "sh2"
track[3][33].index = "sh"
track[3][43].index = "sh3"
track[3][53].index = "sh2"
track[3][63].index = "b1"
track[3][73].index = "sh"
track[3][83].index = "sh2"

track[3][24].index = "sh"
track[3][34].index = "rs"
track[3][44].index = "rb"
track[3][54].index = "rs"
track[3][74].index = "rb"
track[3][84].index = "sh"

track[3][25].index = "rs"
track[3][35].index = "sv"
track[3][45].index = "sv"
track[3][55].index = "sv"
track[3][65].index = "sv"
track[3][75].index = "sv"
track[3][85].index = "rb"

track[3][16].index = "w2"
track[3][26].index = "w2"
track[3][36].index = "w2"
track[3][46].index = "w1"
track[3][56].index = "w2"
track[3][66].index = "w2"
track[3][76].index = "w1"
track[3][86].index = "w2"
track[3][96].index = "w2"

track[3][91].index = "g"
track[3][92].index = "g"
track[3][93].index = "g"
track[3][94].index = "g"
track[3][95].index = "g"
track[3][97].index = "g"
track[3][98].index = "g"
track[3][99].index = "g"


composer.gotoScene( "menu"  )

--[[
--CREATE CAR ------------------------------------------------------------ CREATE CAR
car = display.newRect(200,240,50,120)
car.alpha = 0
graphicCar = display.newImage("car1.png")
graphicCar.width = 340/13
graphicCar.height = 676/13
carShadow = display.newImage("carShadow.png")
carShadow.width = 340/13
carShadow.height = 676/13
carShadow.alpha = .3
physics.addBody( graphicCar, "dynamic" ,{bounce = 0})
aiCar = display.newImage("car2.png")
aiCar.width = 340/13
aiCar.height = 676/13
aiCar.rotation = 90
aiCar.x = 590 
aiCar.y = 630
physics.addBody( aiCar, "dynamic")
 aitouchJoint = physics.newJoint( "touch", aiCar, aiCar.x, aiCar.y )
 aitouchJoint.dampingRatio = 0

local path = system.pathForFile( "coordinateLog2.json", system.ResourceDirectory )
local contents = ""
    local aiCoor = {}
    local file = io.open( path, "r" )
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        aiCoor = json.decode(contents);
        io.close( file )
    end
--aiCoor = loadSave.loadTable("coordinateLog2.json")



jheight = 400
jX = 300
orbital = display.newRect( jX, jheight, 10, 10 )
orbital.anchorY = 2.0

-- VARIABLES ---------------------------------------------------------- VARIABLES
masterLockOn = false
cIndex = 1
aiIndex = 1
previousAngle = 0
rate = 3.5
Ox = 1
Oy = 2
goForward = false
turnSpeed = 0
orbital.alpha = 0 
maxTurnSpeed = 3
speed = 19
maxSpeed = 19

--SETUP COORDINATE LOGGER ---------------------------------------------- COORDINATE LOGGER
coordinateLog = {}






--GENERATE track[1]
local function angleBetween( srcX, srcY, dstX, dstY )
	local angle = ( math.deg( math.atan2( dstY-srcY, dstX-srcX ) )+90 )
	return angle % 360
end

function onCarCollision(event)
	if(event.phase == "began")then
		graphicCar.isFixedRotation = true
		print("COLLIDED")
			masterLockOn = true
	timer.performWithDelay( 50, function()
		isFixedRotation = false
		masterLockOn = false
	end)

end
end
graphicCar:addEventListener( "collision", onCarCollision )

function renderTrack(tTL)
	tileSize = 300
	for i = 1,#track[1] do 
		if(track[tTL][i].index)then

			track[tTL][i].track = display.newImage("tile_"..track[1][i].index..".png")
			track[tTL][i].track.width = tileSize
			track[tTL][i].track.height = tileSize
			local xCoordinate = tonumber(string.sub( tostring(i), 2, 2))
			local yCoordinate = tonumber(string.sub( tostring(i), 1, 1))

			if(track[tTL][i].index == "sF")then
				print("FINISH LINE")
				graphicCar.x = (xCoordinate-1)*(tileSize-(tileSize*.016)) - 50
				graphicCar.y = (yCoordinate-1)*(tileSize -(tileSize*.016)) + 50
				orbital.rotation = -90

			end

			print("track "..i.." coordinates are "..xCoordinate.." and "..yCoordinate)
			track[tTL][i].track.x = (xCoordinate-1)*(tileSize-(tileSize*.016))
			track[tTL][i].track.y = (yCoordinate-1)*(tileSize -(tileSize*.016))
			camera:add(track[tTL][i].track,2)
			addPhysicsToTile(tTL,i,track[tTL][i].index)
		end			

	end
end
renderTrack(1)

--physics.setDrawMode( "hybrid" )



--STEUP CAMERA
camera:add(car,1)
camera:add(carShadow,1)
camera:add(graphicCar, 1)
camera:add(aiCar,1)

camera:setFocus(graphicCar) -- Set the focus to the player
camera:track()

--camera:setParallax(1, 1, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3) -- Here we set parallax for each layer in descending order


--joystick = display.newRect( jX,jheight,20,20)

turnRightButton = display.newRect( display.actualContentWidth - 90,260,40,40)
turnLeftButton = display.newRect( 20,260,40,40)
turnRightButton.alpha = .5
turnLeftButton.alpha = .5

lever = display.newRect( jX,jheight,20,20)
dot = display.newRect( jX,jheight,160,2)
lever.alpha = 0
dot.alpha = 0



physics.start()
physics.setGravity( 0, 0 )

function touch(event)
	goForward = true
	lever.x = event.x
	turnSpeed = (lever.x - jX)/20
	if(turnSpeed < -maxTurnSpeed)then
		turnSpeed  = -maxTurnSpeed
	end

	if(turnSpeed > maxTurnSpeed)then
		turnSpeed = maxTurnSpeed
	end
	print("turnSpeed = "..turnSpeed)
	lever.x = event.x

	if(event.phase == "ended")then
		turnSpeed = 0
		--lever.x = 160
		transition.to(lever,{x = jX})
		goForward = false 
	end
end

function rTouch(event)
	if(event.phase == "began")then

		goForward = true
		--turnSpeed = 1
		rInit = true
	end
	if(event.phase == "ended")then
		--goForward = false
		turnSpeed = 0
		rInit = false
		speed = maxSpeed
	end
end

function lTouch(event)
	if(event.phase == "began")then
		lInit = true
		goForward = true
		--turnSpeed = -1

	end

	if(event.phase == "ended")then
		lInit = false
		--goForward = false
		turnSpeed = 0
		speed = maxSpeed
	end
end

function enterFrame(event)

	aiIndex = aiIndex + 1


	carShadow.rotation = graphicCar.rotation
	carShadow.x = graphicCar.x + 5
	carShadow.y = graphicCar.y + 5

	--print(aiCoor[aiIndex].x)

	if(aiCoor[aiIndex] == nil)then
		aiIndex = 80
	end
	aiCar.rotation = (angleBetween(aiCar.x,aiCar.y,aiCoor[aiIndex].x,aiCoor[aiIndex].y))+180

	if(aiIndex < 70)then
		aiCar.rotation = -180
	end
	aitouchJoint:setTarget(aiCoor[aiIndex].x,aiCoor[aiIndex].y)
	--aiCar.x = aiCoor[aiIndex].x
	--aiCar.y = aiCoor[aiIndex].y
	aiCar:setLinearVelocity( (aiCoor[aiIndex].x/100), (aiCoor[aiIndex].y/100) )
	--Development Only ---------
	--cIndex = cIndex + 1 
	--coordinateLog[cIndex] = {}
	--coordinateLog[cIndex].x = graphicCar.x
	--coordinateLog[cIndex].y = graphicCar.y



	if(masterLockOn == false)then

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

				--graphicCar.angularVelocity = (turnSpeed*(speed))
				--print("o X = "..Ox.." , o Y = "..Oy)

				--print(car.x)
				deltaX =  Ox 
				deltaY =  Oy

				angle = math.atan(deltaX/deltaY)
				if((deltaX/deltaY) == 0)then
					print("LOL")
				end
				angle = math.deg( angle )
				car.rotation = angle
		
			tDeltaY = -Oy 
			tDeltaX = Ox 
			-- print("DELTA X = "..tDeltaX.." , DELTA Y = "..tDeltaY)

			if(math.abs(tDeltaY)>math.abs(tDeltaX))then 
			--	tDeltaX = tDeltaX/1.8
			end

			if(math.abs(tDeltaY)<math.abs(tDeltaX))then 
			--	tDeltaY = tDeltaY/1.8
			end


			if(goForward == true)then
				graphicCar:setLinearVelocity( (tDeltaX*speed), (tDeltaY*speed) )

			end
		end
end

function onKeyEvent(event)
	--print("key pressed")
	--print(event.phase)
	if(event.phase == "down")then
		
		if(event.keyName == "a")then
			--print("left")
				goForward = true
				--turnSpeed = 1
				lInit = true
		end
		if(event.keyName == "d")then
			--print("right")
				goForward = true
				--turnSpeed = 1
				rInit = true
		end

		if(event.keyName == "s")then
			print("stop")
				goForward = not goForward
				--turnSpeed = 1
				--rInit = true
		end
		if(event.keyName == "r")then
			loadSave.saveTable(coordinateLog, "coordinateLog2.json")
			coordinateLog = nil 
			coordinateLog = {}
		end
	end

	if(event.phase == "up")then
		lInit = false
		rInit = false
		turnSpeed = 0
	end

end
--Runtime:addEventListener( "touch", touch )
turnRightButton:addEventListener( "touch", rTouch )
turnLeftButton:addEventListener( "touch", lTouch )
Runtime:addEventListener("enterFrame",enterFrame)
Runtime:addEventListener( "key", onKeyEvent ) --]]
