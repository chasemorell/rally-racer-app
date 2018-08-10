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
    carIcon= {}

    bgWater = display.newImage("bg5.jpg")
    bgWater.width = 800*1
    bgWater.height = 532*.7
    bgWater.x = 240-20
    bgWater.y = 160










    --bg.x = 240
    sceneGroup:insert(bgWater)


    carIcon[1] = display.newImage("car1.png")
    carIcon[1].name = "     The Classic"
    carIcon[1].id = "1"

    carIcon[2] = display.newImage("car7.png")
    carIcon[2].name = "   The Rally Racer"
    carIcon[2].id = "7"

    carIcon[3] = display.newImage("car6.png")
    carIcon[3].name = "    The Sports Car"
    carIcon[3].id = "6"

    carIcon[4] = display.newImage("car5.png")
    carIcon[4].name = "    The Supercar"
    carIcon[4].id = "5"

    carIcon[5] = display.newImage("car4.png")
    carIcon[5].name = "          XCAR"
    carIcon[5].id = "4"

    if(userData.isCar6Unlocked == true)then
    carIcon[6] = display.newImage("car3.png")
    carIcon[6].name = "         Orlando"
    carIcon[6].id = "3"
end


       SelectedTrack = 1

    circle = display.newCircle( 240,160,20)
    circle:setFillColor( 1,1,1 )
    circle.alpha = 0 
    sceneGroup:insert(circle)

    carWidth = carIcon[1].width * .3
    carHeight = carIcon[1].height * .3
    for i = 1,#carIcon do

      
        carIcon[i].nameText = display.newText( carIcon[i].name, (480/2) + ((i-1)*240) , 280 , 200, 30, 12 )
        carIcon[i].nameText.align = "right"
        carIcon[i].nameText.x =  (480/2) + ((i-1)*240) + 40
        carIcon[i].x = (480/2) + ((i-1)*240)
        carIcon[i].y = 160
        if(SelectedTrack == i)then
            carIcon[i].width = carWidth
            carIcon[i].height = carHeight
        else
            carIcon[i].width = carWidth
            carIcon[i].height =carHeight
            carIcon[i].alpha = .5
            carIcon[i].nameText.alpha = 0

        end
          sceneGroup:insert(carIcon[i])
          sceneGroup:insert(carIcon[i].nameText)
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
        x = 240+ 150,
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
        x = 240-150,
        y = 160,
        onEvent = leftTouch,
    }
)

         goButton = widget.newButton(
    {
        width = 90,
        height = 90,
        defaultFile = "okButton.png",
        overFile = "okButton2.png",
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
        transition.to(carIcon[SelectedTrack],{rotation = 360})
       -- composer.gotoScene("menu")
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
      

        for i  = 1,#carIcon do 
          --  carIcon[i].x = carIcon[i].x + (direction*240)
           -- carIcon[i].nameText.x = carIcon[i].nameText.x + (direction*240)
            if(SelectedTrack == i)then
                transition.to( carIcon[i],{rotation = 45,width = carWidth,height = carHeight,alpha = 1, x = carIcon[i].x + (direction*240), time = tTime*2, transition = easing.outExpo} )
                transition.to( carIcon[i].nameText,{alpha = 1, x = carIcon[i].nameText.x + (direction*240), time = tTime , transition = easing.outExpo})

        else
                transition.to( carIcon[i],{rotation = 0,width = carWidth,height = carHeight,alpha = transparency, x = carIcon[i].x + (direction*240) , time = tTime*2, transition = easing.outExpo})
                transition.to( carIcon[i].nameText,{alpha = 0, x = carIcon[i].nameText.x + (direction*240), time = tTime, transition = easing.outExpo,onComplete = function()
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
        elseif(SelectedTrack == #carIcon)then
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
          --  globalTrack = SelectedTrack
            --ads.show( "interstitial" )
            transition.to(bgWater,{alpha = 0,onComplete = function()
                circle.alpha = 1
                --circle:setFillColor( "green" )
                transition.to(circle,{xScale = 20,yScale = 20,time = 1000,transition = easing.outExpo,onComplete = function()
                        --circle:removeSelf()
                        writeData("car",carIcon[SelectedTrack].id,"w")
                        composer.gotoScene("menu",{effect = "fade",time = 200})
                    end})
            end})
            goButton.alpha = 0 
            backButton.alpha = 0
            leftArrow.alpha = 0
            rightArrow.alpha = 0
            for i = 1,#carIcon do 
                if(i ~= SelectedTrack)then
                    carIcon[i].alpha = 0
                end

            end
            transition.to(carIcon[SelectedTrack],{rotation = 360,transition = easing.outExpo,time = 1000})

        --composer.gotoScene("tutorial",{effect = "fade",time = 200})
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
        composer.removeScene( "garage", false )
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