module(..., package.seeall)

local widget = require "widget"
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
--------------------------------------------------
function new( imageSet, slideBackground, top, bottom ,page,USERID,USERLV,option)
    print("00000000")
    local map_id = 1
    local mission_id = 1
    local mission_name = "test test"
    if option ~=1 then
        map_id = option.map_id
        mission_id = option.mission_id
        mission_name = option.mission_name
    end

    ---------------------------------------------------------
    local imgNum = nil
    local images = nil
    local touchListener, nextImage, prevImage, cancelMove, initImage
    local background

    local image_background = "img/universal/ast_bg01.png"
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
        --        background:setReferencePoint( display.TopLeftReferencePoint )
        background.anchorX = 0
        background.anchorY = 0
        background.x, background.y = 0, 0
    end

    g:insert(background) --front background

    local image_background = "img/middle_frame/frm_m_end.png"
    local picture = display.newImage(image_background)
    g:insert(picture)
    picture.anchorX = 0.5
    picture.anchorY = 0.42
    picture.x = screenW*.5
    picture.y = screenH*.5

    images = {}

    for i = 1,#imageSet do
        local p = require(imageSet[i]).newTEAM(USERID)
        --        p:setReferencePoint(display.TopLeftReferencePoint)
        --        p:setReferencePoint(display.CenterReferencePoint)

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

        --        p.x = screenW*.1
        --        p.y = h*.1
        p.y = h*.6
        images[i] = p
    end

    local function menuMode(event)
        if "ended" == event.phase   then
            print("close")
            local option = {
                effect = "zoomInOutFade",
                time = 100,
                params = {
                    mission_id = mission_id,
                    mission_name = mission_name,
                    map_id = map_id,
                    team_no = imgNum,
                }

            }
            display.remove(g)
            g = nil

            if event.target.id == "close" then

                storyboard.gotoScene("mainMap",option)
            elseif event.target.id == "start" then
                storyboard.gotoScene("mission",option)
            end

--            storyboard.gotoScene("mission",option)

--            storyboard.gotoScene("mainMenu")
--            require( "info").customizeTMODE(0,"close")
        end
        return true
    end
    local navBar = display.newGroup()
    local imgStart = "img/small_frame/btt_start.png"
    local startButton = widget.newButton
        {
            left = screenW*.5,
            top = screenH*.72,
            id = "startButton",
            defaultFile = imgStart,
            overFile = imgStart,
            onEvent = menuMode
        }
    startButton.id = "start"
    startButton.anchorX = 1
    g:insert(startButton)


    local close = widget.newButton
        {
            left = screenW*.9,
            top = screenH*.22,
            defaultFile = "img/universal/btt_cancel.png",
            overFile = "img/universal/btt_cancel.png",
            onEvent = menuMode
        }
    close.font = native.newFont("CooperBlackMS",50)
    close.id = "close"
    close.anchorX = 1
    close.anchorY = 1
    g:insert(close)

    local imgBar = "img/middle_frame/ast_scorebar.png"
    local tabNameMission = display.newImage(imgBar )
    --    navBarGraphic:setReferencePoint( display.TopLeftReferencePoint )
    tabNameMission.anchorX = 0.5
    tabNameMission.anchorY = 0
    tabNameMission.y = screenH *.27
    tabNameMission.x = screenW*.5
    g:insert(tabNameMission)

--    local nameMission = "HELLO WORLD"
    local textNameMission = display.newText(mission_name, 0, 0, native.systemFont, 25 )
    textNameMission.anchorX = 0.5
    textNameMission.anchorY = 0
    textNameMission.y =  screenH*.27
    textNameMission.x =  screenW*.5
    g:insert(textNameMission)

    local imgBar = "img/ally_frame/ast_pinpage_s.png"
    local navBarGraphic = display.newImage(imgBar )
    --    navBarGraphic:setReferencePoint( display.TopLeftReferencePoint )
    navBarGraphic.anchorX = 0.5
    navBarGraphic.anchorY = 0
    navBarGraphic.y = screenH *.55
    navBarGraphic.x = screenW*.4
    navBar:insert(navBarGraphic)

    local poinlock =  screenW*.33 -- number 2  vsw*.75
    local myCircle = {}
    local lockteam
    local sizeMyCircle = 12
    local numlock = 0
    local MSNunlock = {}
    local img_close = "img/clear_frame/ast_pinpage.png"
    for i = 1,3,1 do
        myCircle[i] = display.newImage(img_close)
        myCircle[i].x = poinlock
        myCircle[i].y = screenH*.558
        myCircle[i].anchorX = 0
        myCircle[i].anchorY = 0

        navBar:insert(myCircle[i] )
        if i ~= imgNum then
            myCircle[i] .alpha = .1
        else
            myCircle[i] .alpha = .8
        end

        poinlock = poinlock + screenW*.057
    end

    navBar.anchorX = 1
    navBar.anchorY = 0

    navBar.y = screenH*.12
    navBar.x = screenW*.1

    g:insert(navBar)

    function touchListener (self, touch)
        local phase = touch.phase

        if ( phase == "began" ) then
            -- Subsequent touch events will target button even if they are outside the stageBounds of button
            display.getCurrentStage():setFocus( self )
            self.isFocus = true

            startPos = touch.x
            prevPos = touch.x
            print("touch")

        elseif( self.isFocus ) then
            local pointA = touch.y > display.contentHeight/4
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

                    for i = 1,3,1 do
                        if i ~= imgNum then
                            myCircle[i] .alpha = .1
                        else
                            myCircle[i] .alpha = .8
                        end
                    end

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

