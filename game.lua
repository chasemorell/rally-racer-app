local composer = require( "composer" )
require "runtimeFunctions"
require "saveData"
local scene = composer.newScene()
local json = require( "json" )
physics.start()
physics.setGravity( 0, 0 )
widget = require "widget"

function createCars()
    car = display.newRect(200,240,50,120)
    car.alpha = 0

    whatCar = readData("car",false)
    graphicCar = display.newImage("car"..whatCar..".png")
    graphicCar.width = 340/13
    graphicCar.height = 676/13
    graphicCar.x = 100
    graphicCar.y = 100
    graphicCar:addEventListener( "collision", onCarCollision )
    graphicCar.id = "user"

     carTrail = nil
    carTrail2 = nil
    carTrail3 = nil
    aiTrail = nil
    tm = nil
    tm2 = nil
    tm3 = nil
    tm4 = nil
    aiTrail2 = nil
    aiTrail3 = nil

    carTrail = {}
    carTrail2 = {}
    carTrail3 = {}
    aiTrail = {}
    tm = {}
    tm2 = {}
    tm3 = {}
    tm4 = {}
    aiTrail2 = {}
    aiTrail3 = {}
    skidAlpha = 0
    skidChange = .03
    aiSkidAlpha = 0
    trailIndex = 1



   local  aiOption = {}
    aiOption[1] = "1"
    aiOption[2] = "7"
    aiOption[3] = "6"
    aiOption[4] = "5"
    aiOption[5] = "4"
    aiOption[6] = "2"

     aiPickedOption = tonumber(whatCar)
        aiPickedOption = math.random(1,6)
    

  --  emitterRight = display.newCircle( graphicCar.x,graphicCar.y + 20, 10 )
   -- physics.addBody( emitterRight, "static")
   -- weldJoint = physics.newJoint( "weld", graphicCar, emitterRight, emitterRight.x, emitterRight.y )

    --local distanceJoint = physics.newJoint( "distance", graphicCar, emitterRight, , anchorA_y, anchorB_x, anchorB_y )


    carShadow = display.newImage("carShadow.png")
    carShadow.width = 340/13
    carShadow.height = 676/13
    carShadow.alpha = .3


    physics.addBody( graphicCar, "dynamic" ,{bounce = 0})
    graphicCar.isBullet = true

    aiCar = display.newImage("car"..aiOption[aiPickedOption]..".png")
    aiCar.width = 340/13
    aiCar.height = 676/13
    aiCar.rotation = 0
    aiCar.x = aiCoor[2].x
    aiCar.y = aiCoor[2].y

    aiCar.id = "ai"

    physics.addBody( aiCar, "dynamic")

    aitouchJoint = physics.newJoint( "touch", aiCar, aiCar.x, aiCar.y )
    aitouchJoint.dampingRatio = 0
end

function createTrack(tTL)
    tileSize = 300
    for i = 1,#track[tTL] do 
        if(track[tTL][i].index)then

            track[tTL][i].track = display.newImage("tile_"..track[tTL][i].index.."-min.png")
            track[tTL][i].track.width = tileSize
            track[tTL][i].track.height = tileSize
            local xCoordinate = tonumber(string.sub( tostring(i), 2, 2))
            local yCoordinate = tonumber(string.sub( tostring(i), 1, 1))

            if(track[tTL][i].index == "sF")then
                print("FINISH LINE")
                if(globalTrack == 3)then
                    graphicCar.x = (xCoordinate-1)*(tileSize-(tileSize*.016)) + 50 
                    graphicCar.y = (yCoordinate-1)*(tileSize -(tileSize*.016)) + 180
                else
                    graphicCar.x = (xCoordinate-1)*(tileSize-(tileSize*.016)) - 50 
                    graphicCar.y = (yCoordinate-1)*(tileSize -(tileSize*.016)) + 180
                end

                orbital.rotation = -90
                aiCar.x = aiCoor[2].x
                aiCar.y = aiCoor[2].y
                -- aiCar.x = (xCoordinate-1)*(tileSize-(tileSize*.016)) + 50  --590
                -- aiCar.y = (yCoordinate-1)*(tileSize -(tileSize*.016)) + 180

            end

            print("track "..i.." coordinates are "..xCoordinate.." and "..yCoordinate)
            track[tTL][i].track.x = (xCoordinate-1)*(tileSize-(tileSize*.016))
            track[tTL][i].track.y = (yCoordinate-1)*(tileSize -(tileSize*.016))
            camera:add(track[tTL][i].track,3)
            addPhysicsToTile(tTL,i,track[tTL][i].index)
        end         
    end
end

function setupParams()
    jheight = 280
    jX = 350
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
    gameOver = false
    turnSpeed = 0
    orbital.alpha = 0 
    maxTurnSpeed = 3
    speed = 19
    maxSpeed = 19
    isTurning = false
    paused = false
    userBottomLap = 0
    userTopLap = 0
    userActualLap = 0
    time = 0
    aiCarEngineOn = true

    aiCarHasFinished = false
    isNowGreenLight = false
    --SETUP COORDINATE LOGGER ---------------------------------------------- COORDINATE LOGGER
    coordinateLog = {}

    turnRightButton = display.newRect( display.actualContentWidth - 100,260,100,100)
    turnLeftButton = display.newRect( 10,260,100,100)
    turnRightButton.alpha = 0
    turnLeftButton.alpha = 0

    lever = display.newCircle( jX,jheight,10)
    dot = display.newRect( jX,jheight,160,5)
    lever.alpha = .5
    dot.alpha = 0
    wheel = display.newImage("wheel.png")
    wheel.width = 100
    wheel.height = 100
    wheel.anchorX = .5
    wheel.anchorY = .5
    wheel.x = jX
    wheel.y = jheight



    local path = system.pathForFile( "coordinateLog"..tostring(globalTrack+2)..".json", system.ResourceDirectory ) --2
    local contents = ""
     aiCoor = {}
    local file = io.open( path, "r" )
    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        aiCoor = json.decode(contents);
        io.close( file )
    end

end

function pauseButtonTouch(event)
    if(event.phase == "ended")then
       physics.pause()
       darken = display.newRect( 240,160,1000,1000 )
       darken:setFillColor( black )
       darken.alpha = 0
       transition.to( darken, {alpha = .4,time = 300} )
       paused = true
       playButton = display.newImage("playButton.png")
       playButton.width = 150
       playButton.height = 150
       playButton.x = 240
       playButton.y = 160
       playButton:addEventListener( "touch", function(event)
        if(event.phase == "ended")then
            paused = false
            physics.start( )
            playButton:removeSelf( )
            playButton = nil
            darken:removeSelf()
        end
       end )
    end
end

function setupOverlay()
    print("overlay")

   
end

function scene:create( event )

    local sceneGroup = self.view

    -- Code here runs when the scene is first created but has not yet appeared on screen

end

function createLights()
    local options =
    {
        -- Required parameters
        width = 400,
        height = 640,
        numFrames = 3,
 
    }

    local lightsSheet = graphics.newImageSheet( "lights.png", options )

    local sequenceData =
    {
        name="cycle",
        frames= { 1, 2, 3},
        time = 1000,
        loopCount = 0        -- Optional ; default is 0
    }
 
    lights = display.newSprite( lightsSheet, sequenceData )
    lights:scale(.2,.2)
    lights.y = -100
    lights.x = 100
    transition.to(lights,{ y = 100})
    --lights:play()
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
            isEmitterEnabled = readData("effects")

        camera = perspective.createView()
        setupParams()
        createCars()
        createLights()

        camera:add(car,1)
        camera:add(carShadow,1)
        camera:add(graphicCar, 1)
        camera:add(aiCar,1)

        createTrack(globalTrack) 
        setupOverlay()-- track # as argument

        camera:setFocus(graphicCar) 
        camera:track()
        Pcorrection = 0
        if(display.actualContentWidth > 692)then
            Pcorrection = -70
        end
        pauseButton = widget.newButton( {
            width = 75,
            height = 75,
            defaultFile = "pauseButton.png",
            overFile = "arrow2.png",
            x = display.actualContentWidth-  75 + Pcorrection,
            y = 20,
            onEvent = pauseButtonTouch,
        } )


       lapText =  display.newText( "Start you engines", display.contentCenterX - 100, 0 , 200,50,12 )
       lapText.anchorX = 0
       lapText.anchorY = 0 
       lapText.x = 10
    elseif ( phase == "did" ) then
        composer.removeHidden()

   --   physics.setDrawMode( "hybrid" )
        --turnRightButton:addEventListener( "touch", rTouch )
        --turnLeftButton:addEventListener( "touch", lTouch )
        Runtime:addEventListener("enterFrame",enterFrame)
        Runtime:addEventListener( "key", onKeyEvent ) 
        Runtime:addEventListener( "touch", touch )
        Runtime:addEventListener("touch",screenTouch)
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene