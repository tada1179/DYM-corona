module(..., package.seeall)
--------------------------------------------------
function new( imageSet, slideBackground, top, bottom ,page,USERID,USERLV)

    local widget = require "widget"
    local alertMSN = require("alertMassage")
    local storyboard = require( "storyboard" )
    storyboard.purgeOnSceneChange = true
    local screenW, screenH = display.contentWidth, display.contentHeight
    local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
    ---------------------------------------------------------

    local btnreset
    local btnback
    local imgNum = nil
    local images = nil
    local touchListener, nextImage, prevImage, cancelMove, initImage
    local background

    local image_reset = "img/background/button/as_team_reset.png"
    local image_background = "img/background/background_2.png"
    local pad = 20
    local top = top or 0
    local bottom = bottom or 0
    imgNum = page or 1

    local g = display.newGroup()
    local USERID = USERID
    local USERLV = USERLV
    if slideBackground then

        background = display.newImage(slideBackground, 0, 0, true)
    else
        background = display.newImageRect(image_background, screenW, screenH, true)
        background:setReferencePoint( display.TopLeftReferencePoint )
        background.x, background.y = 0, 0
    end

    g:insert(background) --front background

    images = {}
    for i = 1,#imageSet do
        local p = require(imageSet[i]).newTEAM(USERID)
        p:setReferencePoint(display.CenterReferencePoint)

        local h = viewableScreenH-(top+bottom)
        if p.width > viewableScreenW or p.height > h then
            if p.width/viewableScreenW > p.height/h then
                p.xScale = viewableScreenW/p.width
                p.yScale = viewableScreenW/p.width
            else
                p.xScale = h/p.height
                p.yScale = h/p.height
            end

        end
        g:insert(p)

        if (i > imgNum) then
            p.x = screenW*1.5 + pad -- all images offscreen except the first one
        elseif (i < imgNum) then
            p.x = (screenW*0.5 + pad)*-1 -- all images offscreen except the first one
        else
            p.x = screenW*.5
        end
        p.y = h*.6
        images[i] = p


    end

    local navBar = display.newGroup()
    g:insert(navBar)


    local navBarGraphic = display.newImageRect("img/background/team/as_slide_page_00.png", screenW*.25, screenH*.03, false)
    navBar:insert(navBarGraphic)
    navBarGraphic.x = viewableScreenW*.75
    navBarGraphic.y = viewableScreenH*.75

    local poinlock =  viewableScreenW*.648 -- number 2  vsw*.75
    local myCircle = {}
    local lockteam
    local numlock = 0
    local MSNunlock = {}

    for i = 1,5,1 do
        local teamNumber = math.floor(USERLV/10) + 1
        if i <= teamNumber then
           if i ~= page then
               myCircle[i] = display.newCircle(poinlock, viewableScreenH*.75, 15)
               myCircle[i] :setFillColor(128,128,128)
               myCircle[i] .alpha = .8
               navBar:insert(myCircle[i] )
           else
               myCircle[i] = display.newCircle(poinlock, viewableScreenH*.75, 15)
               myCircle[i] :setFillColor(128,128,128)
               myCircle[i] .alpha = .1
               navBar:insert(myCircle[i] )
           end

        else
            numlock = numlock + 1
            myCircle[i]  = display.newCircle(poinlock, viewableScreenH*.75, 15)
            myCircle[i] :setFillColor(128,128,128)
            myCircle[i] .alpha = .8
            myCircle[i] .id = "lock"
            navBar:insert(myCircle[i])

            lockteam = display.newImageRect("img/background/team/locker_closed.png", screenW*.06, screenH*.03, false)
            lockteam.x = poinlock
            lockteam.y = viewableScreenH*.753
            navBar:insert(lockteam)
        end

        poinlock = poinlock + (viewableScreenW*.051)
    end
    navBar.y = math.floor(navBar.height-viewableScreenW*.635)
    navBar.x = math.floor(navBar.width-viewableScreenH*.5)
    function onbtnreset(event)
        if event.target.id == "back" then

            display.remove(lockteam)
            lockteam = nil
            display.remove(navBarGraphic)
            navBarGraphic = nil
            display.remove(background)
            background = nil
            display.remove(btnreset)
            btnreset = nil
            display.remove(btnback)
            btnback = nil
            display.remove(lockteam)
            lockteam = nil
            display.remove(myCircle)
            myCircle = nil


            for i= navBar.numChildren,1,-1 do
                local child = navBar[i]
                child.parent:remove( child )
                child = nil
            end
            display.remove(navBar)
            navBar = nil

            for i= g.numChildren,1,-1 do
                local child = g[i]
                child.parent:remove( child )
                child = nil
            end
            display.remove(g)
            g = nil

            --storyboard.removeScene( "team_main" ,"fade", 100 )
            storyboard.gotoScene( "unit_main" ,"fade", 100 )
        else
            local team_id = event.target.id
            alertMSN.resetCharacter(1,1,team_id,1,event)-- resetCharacter(id,holddteam_no,team_id,USERID)
        end
        return true
    end

    btnreset = widget.newButton{
        defaultFile= image_reset,
        overFile= image_reset,
        width = screenW /9, height= screenH/21,
        onRelease = onbtnreset	-- event listener function
    }
    btnreset.id= 1
    btnreset:setReferencePoint( display.TopLeftReferencePoint )
    btnreset.x = viewableScreenW*.7
    btnreset.y = viewableScreenH*.3
    g:insert(btnreset)
    local image_back = "img/background/button/Button_BACK.png"
    btnback = widget.newButton{
        defaultFile= image_back,
        overFile= image_back,
        width = screenW/9, height = screenH/21,
        onRelease = onbtnreset	-- event listener function
    }
    btnback.id= "back"
    btnback:setReferencePoint( display.TopLeftReferencePoint )
    btnback.x = viewableScreenW*.15
    btnback.y = viewableScreenH*.3
    g:insert(btnback)

    g.x = 0
--    g.y = top+viewableScreenH*.05
    g.y = 0

    function touchListener (self, touch)
        local phase = touch.phase

        if ( phase == "began" ) then
            -- Subsequent touch events will target button even if they are outside the stageBounds of button
            display.getCurrentStage():setFocus( self )
            self.isFocus = true

            startPos = touch.x
            prevPos = touch.x


        elseif( self.isFocus ) then
            local pointA = touch.y > display.contentHeight/3
            local pointB = touch.y < display.contentHeight/1.25
            if ( phase == "moved" and pointA and pointB ) then

                if tween then transition.cancel(tween) end

                local delta = touch.x - prevPos
                prevPos = touch.x

                images[imgNum].x = images[imgNum].x + delta

                if (images[imgNum-1]) then
                    images[imgNum-1].x = images[imgNum-1].x + delta
                end

                if (images[imgNum+1]) then
                    images[imgNum+1].x = images[imgNum+1].x + delta
                end

            elseif ( phase == "ended" or phase == "cancelled"  ) then
                if pointA and pointB then
                    dragDistance = touch.x - startPos

                    if (dragDistance < -40 and imgNum < #images) then
                        nextImage()
                    elseif (dragDistance > 40 and imgNum > 1) then
                        prevImage()
                    else
                        cancelMove()
                    end

                    if ( phase == "cancelled" ) then
                        cancelMove()
                    end

                    if imgNum == 5 then
                        myCircle[imgNum].alpha = 0.1
                        myCircle[imgNum-1].alpha = 0.8

                    elseif imgNum == 1 then
                        myCircle[imgNum+1].alpha = 0.8
                        myCircle[imgNum].alpha = 0.1

                    else
                        myCircle[imgNum+1].alpha = 0.8
                        myCircle[imgNum].alpha = 0.1
                        myCircle[imgNum-1].alpha = 0.8

                   end
                   if myCircle[imgNum].id == "lock" then
                       if MSNunlock[imgNum] then
                           MSNunlock[imgNum].alpha = 0

                       end
                       MSNunlock[imgNum] = alertMSN.teamLock(imgNum)
                       if MSNunlock[imgNum+1] then
                           MSNunlock[imgNum+1].alpha = 0
                       end

                       if MSNunlock[imgNum-1] then
                           MSNunlock[imgNum-1].alpha = 0
                       end

                   else
                       if MSNunlock[imgNum+1] then
                           MSNunlock[imgNum+1].alpha = 0
                       end

                       if MSNunlock[imgNum-1] then
                           MSNunlock[imgNum-1].alpha = 0
                       end
                   end


                    btnreset.id= imgNum

                    -- Allow touch events to be sent normally to the objects they "hit"
                    display.getCurrentStage():setFocus( nil )
                    self.isFocus = false

                end
            end
        end

        return true

    end

    function cancelTween()
        if prevTween then
            transition.cancel(prevTween)
        end
        prevTween = tween
    end

    function nextImage()
        tween = transition.to( images[imgNum], {time=100, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
        tween = transition.to( images[imgNum+1], {time=100, x=screenW*.5, transition=easing.outExpo } )
        imgNum = imgNum + 1
        initImage(imgNum)
    end

    function prevImage()
        tween = transition.to( images[imgNum], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
        tween = transition.to( images[imgNum-1], {time=400, x=screenW*.5, transition=easing.outExpo } )
        imgNum = imgNum - 1
        initImage(imgNum)
    end

    function cancelMove()
        tween = transition.to( images[imgNum], {time=400, x=screenW*.5, transition=easing.outExpo } )
        tween = transition.to( images[imgNum-1], {time=400, x=(screenW*.5 + pad)*-1, transition=easing.outExpo } )
        tween = transition.to( images[imgNum+1], {time=400, x=screenW*1.5+pad, transition=easing.outExpo } )
    end

    function initImage(num)
        if (num < #images) then
            images[num+1].x = screenW*1.5 + pad
        end
        if (num > 1) then
            images[num-1].x = (screenW*.5 + pad)*-1
        end
    end


    background.touch = touchListener
    background:addEventListener( "touch", background )

    ------------------------
    -- Define public methods

    function g:jumpToImage(num)
        local i
        for i = 1, #images do
            if i < num then
                images[i].x = -screenW*.5;
            elseif i > num then
                images[i].x = screenW*1.5 + pad
            else
                images[i].x = screenW*.5 - pad
            end
        end
        imgNum = num
        initImage(imgNum)
    end
    ------------------------------------
    storyboard.removeAll ()
    storyboard.purgeAll()
    ------------------------------------
    function g:cleanUp()

        background:removeEventListener("touch", touchListener)
        background:removeSelf()
        background = nil

        navBar:removeSelf()
        navBar = nil

        imgNum:removeSelf()
        imgNum = nil

        images:removeSelf()
        images = nil

        tween:removeSelf()
        tween = nil

    end
    return g
end

