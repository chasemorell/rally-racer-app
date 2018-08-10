local composer = require( "composer" )

local scene = composer.newScene()

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
    continue = display.newImage("continue.png")
    continue.width =  700/3
    continue.height = 100/3
    continue.x = ((display.actualContentWidth/4) + (display.actualContentWidth/2)) + 20
    continue.y = display.actualContentHeight - 40

    finishBg = display.newImage("finishBg.png")
    finishBg.x = 240
    finishBg.y = 160
    finishBg.width = finishBg.width * .7
    finishBg.height = finishBg.height * .7

    if(whoWon == "user")then
        placeText = display.newImage("first.png")
        

    else
        placeText = display.newImage("second.png")
    end

    placeText.x = 240
    placeText.y = 160
    placeText.width = finishBg.width * .1
    placeText.height = finishBg.height * .1


    transition.to( placeText, {width = 1024*.4, height = 768*.4, transition = easing.outExpo,time = 4000} )

    sceneGroup:insert(finishBg)
    sceneGroup:insert(continue)
    sceneGroup:insert(placeText)
    continue:addEventListener( "touch", continueTouch)
end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then

        print("globalTrack = "..globalTrack.. " Time = "..time)
        if(globalTrack == 1)then
            benchmark = userData.highscore1
        elseif(globalTrack == 2)then
            benchmark = userData.highscore2

        elseif(globalTrack == 3)then
            benchmark = userData.highscore3

        end

        if(time < benchmark)then
            timeText = display.newText( "Time: "..math.round(time).." seconds (New Highscore!)", display.contentCenterX, display.contentCenterY + 150, 200, 100, 20 )

            print("new highscore")
            if(globalTrack == 1)then
                userData.highscore1 = time
            elseif(globalTrack == 2)then
                userData.highscore2 = time

            elseif(globalTrack == 3)then
                userData.highscore3 = time

             end
             userDataForJson = json.encode( userData  )
            writeData("userData",userDataForJson,"w","json")
        else 
            timeText = display.newText( "Time: "..math.round(time).." seconds", display.contentCenterX, display.contentCenterY + 150, 200, 100, 20 )

         end  


             if(globalTrack == 1)then
                gameNetwork.request( "setHighScore",
                {
                    localPlayerScore = { category="Bayside_Circuit", value=time },
                --    listener = requestCallback
                }
                )            
            elseif(globalTrack == 2)then
                gameNetwork.request( "setHighScore",
                {
                    localPlayerScore = { category="Hairpin_Circuit", value=time },
                --    listener = requestCallback
                }
                )  
            elseif(globalTrack == 3)then
                gameNetwork.request( "setHighScore",
                {
                    localPlayerScore = { category="Endurance_Circuit", value=time },
                --    listener = requestCallback
                }
                )  
             end
    timeText.anchorX = .5
    timeText.x = display.contentCenterX

        
     ads.show( "interstitial" )


    sceneGroup:insert(timeText)


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