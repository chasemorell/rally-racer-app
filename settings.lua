local composer = require( "composer" )

local scene = composer.newScene()

function backTouch(event)
    if(event.phase == "ended")then
        composer.gotoScene( "menu", {effect = "fade"} )
end
end

function onSwitchPress(event)
    isEmitterEnabled = not event.target.isOn
    print(tostring(isEmitterEnabled))

    writeData("effects",tostring(isEmitterEnabled),"w")
end

-- create()
function scene:create( event )
    correction = 0
if(display.actualContentWidth == 480)then
    correction = 30
end
    local sceneGroup = self.view
    backButton = widget.newButton(
    {
        width = 90,
        height = 90,
        defaultFile = "backButton.png",
        overFile = "backButton2.png",
        x = 10 + correction ,
        y = display.actualContentHeight - 40,
        onEvent = backTouch,
    }
)


    print(isEmitterEnabled)
    if (isEmitterEnabled == true)then  
             effectsSwitch = widget.newSwitch(
        {
        left = 150,
        top = 200,
        style = "onOff",
        id = "RadioButton1",
        initialSwitchState = true,

        onPress = onSwitchPress
        }
        )

    else 
         effectsSwitch = widget.newSwitch(
        {
        left = display.actualContentWidth/2,
        top = 200,
        style = "onOff",
        id = "RadioButton1",
        initialSwitchState = false,

        onPress = onSwitchPress
        }
        )
    end


function textListener(event)
     if ( event.phase == "began" ) then
        -- User begins editing "defaultField"

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
      if(event.target.text == "universal" or event.target.text == "Universal" or event.target.text == "UNIVERSAL")then
            print("Unlocked secret car")
            userData.isCar6Unlocked = true
            jUserData = json.encode( userData)
            writeData("userData",jUserData,"w","json")
       else
            print("sorry, try again")
        end
        print( event.target.text )

    elseif ( event.phase == "editing" ) then
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end
end



helperText = display.newText( "Advanced Graphics ", display.actualContentWidth/2, 235, 300,50,20)

if(isEmitterEnabled == "true")then
    print("true")
    effectsSwitch:setState( { isOn=true, isAnimated=true, onComplete=changeComplete } )

else

end

sceneGroup:insert(backButton)
sceneGroup:insert(effectsSwitch)
sceneGroup:insert(helperText)
    -- Code here runs when the scene is first created but has not yet appeared on screen

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        defaultField = native.newTextField( display.actualContentWidth/2, 30, 180, 30 )
defaultField:addEventListener( "userInput", textListener )
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        defaultField:removeSelf()
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