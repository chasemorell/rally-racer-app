local composer = require( "composer" )

local scene = composer.newScene()
require "saveData"
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()

function continueTouch(event)
    if(event.phase == "ended")then
        composer.gotoScene( "menu" )
end
end
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
   tutorial = display.newImage("tutorial2.png")
   tutorial.width =  4032/8
   tutorial.height= 3024/8
   tutorial.x = 240
   tutorial.y = 160
    sceneGroup:insert(tutorial)
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    isEmitterEnabled = readData("effects")
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        timer.performWithDelay( 2000, function()
            composer.gotoScene( "game", {effect = "fade"})
        end )
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