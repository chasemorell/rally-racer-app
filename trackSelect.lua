local composer = require( "composer" )

local scene = composer.newScene()
local widget = require "widget"
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local moveLock = false
-- create()
function scene:create( event )

    local sceneGroup = self.view
    trackIcon = {}

    bgWater = display.newImage("bg5.jpg")
    bgWater.width = 800*1
    bgWater.height = 532*.7
    bgWater.x = 240-20
    bgWater.y = 160

    bg = display.newImage("bg6.png")
    bg.width = 500
    bg.height = 300
    bg.x = 350
    bg.y = 160

    bg2 = display.newImage("bg6.png")
    bg2.width = 500
    bg2.height = 300
    bg2.x = 350 + (bg.width)
    bg2.y = 160

    bg2.alpha = 0
    bg.alpha = 0



    if(bg.width < display.actualContentWidth )then
        bg.width = display.actualContentWidth ; bg.height = display.actualContentHeight -20
        bg2.width = display.actualContentWidth ; bg2.height = display.actualContentHeight -20
    end




    --bg.x = 240
    bg.y = 160
    sceneGroup:insert(bgWater)
    sceneGroup:insert(bg)
    sceneGroup:insert(bg2)

    trackIcon[1] = display.newImage("track1Icon.png")
    trackIcon[1].name = "Bayside Circuit"
    trackIcon[2] = display.newImage("track2Icon.png")
    trackIcon[2].name = "Hairpin Circuit"
    trackIcon[3] = display.newImage("track3Icon.png")
    trackIcon[3].name = "Endurance Circuit"

       SelectedTrack = 1

    for i = 1,#trackIcon do 

        trackIcon[i].nameText = display.newText( trackIcon[i].name, (480/2) + ((i-1)*240), 280 , 200, 30, 12 )
        trackIcon[i].nameText.align = "right"
        trackIcon[i].nameText.x =  (480/2) + ((i-1)*240) + 40
        trackIcon[i].x = (480/2) + ((i-1)*240)
        trackIcon[i].y = 160
        if(SelectedTrack == i)then
            trackIcon[i].width = 200
            trackIcon[i].height = 200
        else
            trackIcon[i].width = 200--100
            trackIcon[i].height = 200--100
            trackIcon[i].alpha = .5
            trackIcon[i].nameText.alpha = 0

        end
          sceneGroup:insert(trackIcon[i])
          sceneGroup:insert(trackIcon[i].nameText)
    end

local correction = 0     
if(display.actualContentWidth == 480)then
    correction = 30
elseif(display.actualContentWidth > 692)then
    correction = -70
end

        rightArrow = widget.newButton(
    {
        width = 75,
        height = 75,
        defaultFile = "arrowLeft.png",
        overFile = "arrow2.png",
        x = 240+ 130,
        y = 160,
        onEvent = rightTouch,
    }
)

         leftArrow = widget.newButton(
    {
        width = 75,
        height = 75,
        defaultFile = "arrow.png",
        overFile = "arrowLeft2.png",
        x = 240-130,
        y = 160,
        onEvent = leftTouch,
    }
)

         goButton = widget.newButton(
    {
        width = 90,
        height = 90,
        defaultFile = "goButton.png",
        overFile = "goButton2.png",
        x = display.actualContentWidth - 80 + correction,
        y = display.actualContentHeight - 40,
        onEvent = goTouch,
    }
)

         backButton = widget.newButton(
    {
        width = 90,
        height = 90,
        defaultFile = "backButton.png",
        overFile = "backButton2.png",
        x = 10 + correction,
        y = display.actualContentHeight - 40,
        onEvent = backTouch,
    }
)


         leftArrow.alpha =  0
        --goButton = display.newImage("goButton.png")
        --goButton.width = 90
        --goButton.height = 90
       -- goButton.x = display.actualContentWidth - 80
       -- goButton.y = display.actualContentHeight - 40

        sceneGroup:insert(goButton)
        sceneGroup:insert(leftArrow)
        sceneGroup:insert(rightArrow)
        sceneGroup:insert(backButton)

   

end

function mTouch(event)
    if(event.phase == "began")then
        composer.gotoScene("trackSelect")
    end
end

function changeIcon(direction)
    local transparency = .2
    local tTime = 300
   -- if(event.phase == "ended")then
    if(moveLock == false)then
        moveLock = true
        SelectedTrack = SelectedTrack - direction
        --bg.x = bg.x + (direction*240)
        transition.to( bg, {x = bg.x + (direction*240),time = tTime, transition = easing.outExpo} )
        transition.to( bg2, {x = bg2.x + (direction*240),time = tTime, transition = easing.outExpo} )

        for i  = 1,#trackIcon do 
          --  trackIcon[i].x = trackIcon[i].x + (direction*240)
           -- trackIcon[i].nameText.x = trackIcon[i].nameText.x + (direction*240)
            if(SelectedTrack == i)then
                transition.to( trackIcon[i],{width = 200,height = 200,alpha = 1, x = trackIcon[i].x + (direction*240), time = tTime, transition = easing.outExpo} )
                transition.to( trackIcon[i].nameText,{alpha = 1, x = trackIcon[i].nameText.x + (direction*240), time = tTime , transition = easing.outExpo})

        else
                transition.to( trackIcon[i],{width = 200,height = 200,alpha = transparency, x = trackIcon[i].x + (direction*240) , time = tTime, transition = easing.outExpo})
                transition.to( trackIcon[i].nameText,{alpha = 0, x = trackIcon[i].nameText.x + (direction*240), time = tTime, transition = easing.outExpo,onComplete = function()
                        moveLock = false
                end} )
        end

        end
        print(SelectedTrack)
        if(SelectedTrack == 1)then
            print("left")
            leftArrow.alpha = 0
            rightArrow.alpha = 1
            return
        elseif(SelectedTrack == #trackIcon)then
            leftArrow.alpha = 1
            rightArrow.alpha = 0
        else
            leftArrow.alpha = 1
            rightArrow.alpha = 1
        end
    end
   -- end
end

 function rightTouch(event)
    if(event.phase == "ended")then
        changeIcon(-1)
    end
end

 function leftTouch(event)
    if(event.phase == "ended")then
        changeIcon(1)
    end
end

 function goTouch(event)
    if(event.phase == "ended")then
            globalTrack = SelectedTrack
          --  ads.show( "interstitial" )

        composer.gotoScene("tutorial",{effect = "fade",time = 200})
    end
end

 function backTouch( event )
    if(event.phase == "ended")then
          --  globalTrack = SelectedTrack

        composer.gotoScene("menu",{effect = "fade",time = 200})
    end
    -- body
end
-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        composer.removeHidden()
                   -- ads.show( "interstitial" )

        print("entered")

        timer.performWithDelay( 100, function()
                   --rightArrow:addEventListener( "touch", rightTouch )
                   --leftArrow:addEventListener( "touch", leftTouch )
                --   goButton:addEventListener( "touch", goTouch )
        end )
    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        goButton:removeEventListener( "touch", goTouch )
      --  menubg:removeEventListener( "touch", mTouch )
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )
            goButton:removeEventListener( "touch", goTouch )

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