local composer = require( "composer" )
ads = require("ads")
require "saveData"
local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

widget = require("widget")

print(display.actualContentWidth .. " SJHFJSKDHFKLJDSHJKFDS WIDTH ")
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()

function carButtonTouch(event)
    if(event.phase == "ended")then
        composer.gotoScene("garage",{effect = "fade",time = 200})
    end
end

function leaderBoardButtonTouch(event)
    if(event.phase == "ended")then
          gameNetwork.show( "leaderboards",
    {
        
    }
)
    end
end

function settingsListener(event)
    if ( event.action == "clicked" ) then
        local i = event.index
        if ( i == 1 ) then
            print(storedEffectBoolean)
            areEffectsEnabled = true
            print(areEffectsEnabled)
            writeData("effects",tostring(areEffectsEnabled),"w")

        elseif ( i == 2 ) then
            -- Open URL if "Learn More" (second button) was clicked
        end
    end
end

function settingsCurrentlyEnabledListener(event)
    if ( event.action == "clicked" ) then
        local i = event.index
        if ( i == 1 ) then
            print(storedEffectBoolean)
            areEffectsEnabled = false
            print(areEffectsEnabled)
            writeData("effects",tostring(areEffectsEnabled),"w")

        elseif ( i == 2 ) then
            -- Open URL if "Learn More" (second button) was clicked
        end
    end
end

function settingstouch(event)
    if(event.phase == "ended")then
        --composer.gotoScene( "settings" )
        print("settings touch")
        storedEffectBoolean = readData("effects")
        print(storedEffectBoolean)
        if(storedEffectBoolean == "true")then
                    print("showing alert to opt to disable graphics")
                    native.showAlert( "Settings", "Advanced Graphics are currently enabled" , {"Disable","Cancel"}, settingsCurrentlyEnabledListener )
        elseif(storedEffectBoolean == "false")then
                    native.showAlert( "Settings", "Advanced Graphics are currently disabled" , {"Enable","Cancel"},  settingsListener )

        end

    end
end


function scene:create( event )

    local sceneGroup = self.view
    menubg = display.newImage("bgV2.png") --menubg
    menubg.x = 240

    menuCars = display.newImage( "menuCars.png")
    menuCars.x = -100
    print(display.actualContentHeight)
    if(display.actualContentHeight == 320 and display.actualContentWidth == 480)then menubg.y = (display.actualContentHeight/2) else menubg.y = (display.actualContentHeight/2) - (display.actualContentHeight/4.5) end
    if(display.actualContentHeight == 320 and display.actualContentWidth == 480)then menuCars.y = (display.actualContentHeight/2) else menuCars.y = (display.actualContentHeight/2) - (display.actualContentHeight/4.5) end

    menubg.width = menubg.width /2
    menubg.height = menubg.height/2

    menuCars.width = menuCars.width /2
    menuCars.height = menuCars.height/2

    if(menubg.width < display.actualContentWidth or menubg.height < display.actualContentHeight)then
        menubg.width = display.actualContentWidth
        menubg.height = display.actualContentHeight
        menubg.y = 160

       -- menuCars.width = display.actualContentWidth
       -- menuCars.height = display.actualContentHeight
        menuCars.y = 140
        menuCars.x = menuCars.x - 50
    end

    logo = display.newImage("logo 2.png")
    logo.anchorX = .6
    logo.width = 150 * 1.5
    logo.height = 100 * 1.5
    logo.x = (display.actualContentWidth/4) + (display.actualContentWidth/2)
    logo.y = display.actualContentHeight - 250

    singleRaceButton = widget.newButton( {
        defaultFile = "start.png",
        overFile = "start2.png",
        onEvent = mTouch,
        } )

    carButton = widget.newButton( {
        defaultFile = "carButton.png",
        overFile = "carButton2.png",
        onEvent = carButtonTouch,
        } )

    leaderBoardButton = widget.newButton( {
        defaultFile = "leaderboardButton.png",
        overFile = "leader2.png",
        onEvent = leaderBoardButtonTouch,
        } )

      carButton.width = 700/9
    carButton.height = 700/9
    carButton.x = ((display.actualContentWidth/4) + (display.actualContentWidth/2)) - 110
    carButton.y = display.actualContentHeight - 150

     leaderBoardButton.width = 700/12
    leaderBoardButton.height = 700/12
    leaderBoardButton.x = ((display.actualContentWidth/4) + (display.actualContentWidth/2)) - 110
    leaderBoardButton.y = display.actualContentHeight - 90


    --display.newImage("start.png")
    singleRaceButton.width = 700/6
    singleRaceButton.height = 700/6
    singleRaceButton.x = ((display.actualContentWidth/4) + (display.actualContentWidth/2)) - 20
    singleRaceButton.y = display.actualContentHeight - 120

    tournamentButton = display.newImage("tournamentButton.png")
    tournamentButton.width = 700/3
    tournamentButton.height = 100/3
    tournamentButton.x = ((display.actualContentWidth/4) + (display.actualContentWidth/2)) + 20
    tournamentButton.y = display.actualContentHeight - 130
    tournamentButton.alpha = 0

    garageButton = display.newImage("garage.png")
    garageButton.width = 700/3
    garageButton.height = 100/3
    garageButton.x = ((display.actualContentWidth/4) + (display.actualContentWidth/2)) + 20
    garageButton.y = display.actualContentHeight - 80
    garageButton.alpha = 0

    credit = display.newImage("credits.png")
    credit.width = 400 * .7
    credit.height = 50 *.7
    credit.x = 350
    credit.y = 290

    settingsButton = display.newImage("settingsButton.png")
    settingsButton.width = 30
    settingsButton.height = 30
    settingsButton.x = ((display.actualContentWidth/4) + (display.actualContentWidth/2)) + 40
    settingsButton.y = display.actualContentHeight - 50
    settingsButton:addEventListener( "touch", settingstouch )


    sceneGroup:insert(menubg)
    sceneGroup:insert(menuCars)
    sceneGroup:insert(logo)
    sceneGroup:insert(singleRaceButton)
    sceneGroup:insert(tournamentButton)
    sceneGroup:insert(garageButton)
    sceneGroup:insert(credit)
    sceneGroup:insert(carButton)
    sceneGroup:insert(leaderBoardButton)
    sceneGroup:insert(settingsButton)
end

function mTouch(event)
    if(event.phase == "ended")then
        --native.showAlert( "Test", "It is working" ,{"Ok"} )
        composer.gotoScene("trackSelect",{effect = "fade",time = 200})
    end
end

-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        if(circle)then
            circle:removeSelf()
            circle = nil
        end
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        ---composer.removeHidden()

        ads.show( "interstitial" )

        menuCars.x = -100
        timer.performWithDelay( 500, function()
            transition.to( menuCars,{x = 200,transition = easing.outExpo, time = 2500 } )   
        end )
        singleRaceButton:addEventListener( "touch", mTouch )


         local function adListener( event )
    if ( event.type == "adStart" and event.isError ) then
        print("could not display a video")
        --Cached video ad not available for display
    end
end

    print("ads available")

   -- isEmitterEnabled = readData("effects")

        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

        menubg:removeEventListener( "touch", mTouch )
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
                singleRaceButton:removeEventListener( "touch", mTouch )

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