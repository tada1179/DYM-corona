
--
print("****** //// itemSelectView")

module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local character_scene = require("character_scene")

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local imgNum = nil
local images = nil
local touchListener, nextImage, prevImage, cancelMove, initImage
local imageNumberText, imageNumberTextShadow

function new( imageSet, slideBackground, top, bottom ,pageItem,pageTeam,user_id)
    print("2222itemview pageItem,pageTeam:",pageItem,pageTeam)
    character_scene.startBattle(pageTeam,pageItem)

    local chaUser_id = user_id;
    print("------------- chaUser_id",chaUser_id)
    local pad = 20
    local top = top or 0
    local bottom = bottom or 0
    local background
    local image_background = "img/background/background_2_2.png"
    imgNum = pageItem or 1
    local g = display.newGroup()


    if slideBackground then

        background = display.newImage(slideBackground, 0, 0, true)
    else

--        background = display.newRect( 0, screenH*.62, screenW, screenH*.3 )
--        background:setFillColor(0, 0, 255)

        background = display.newImageRect(image_background, screenW, screenH, true)
        background:setReferencePoint( display.TopLeftReferencePoint )
        background.x, background.y = 0, screenH*.62
    end
    g:insert(background) --front background

    images = {}
    for i = 1,#imageSet do

        local p = require(imageSet[i]).newitem(chaUser_id)
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

        if (i > 1) then
            p.x = screenW*1.5 + pad -- all images offscreen except the first one
        else
            p.x = screenW*.5
        end

        p.y = h*.7

        images[i] = p
    end

    local navBar = display.newGroup()
    g:insert(navBar)

    --imgNum = 1
    local navBarGraphic = display.newImageRect("img/background/team/as_slide_icn_base.png", screenW*.1, screenH*.015, false)
    navBar:insert(navBarGraphic)
    navBarGraphic.x = viewableScreenW*.80
    navBarGraphic.y = viewableScreenH*.8

    local navBarShow = display.newImageRect("img/background/team/as_slide_icn_show.png", screenW*.018, screenH*.015, false)
    navBar:insert(navBarShow)
    navBarShow.x = viewableScreenW*.76
    navBarShow.y = viewableScreenH*.8
    navBar.y = math.floor(navBar.height*0.5)
    g.x = 0
    g.y = top + display.screenOriginY




    function touchListener (self, touch)
        local phase = touch.phase
        if ( phase == "began" ) then
            -- Subsequent touch events will target button even if they are outside the stageBounds of button
            display.getCurrentStage():setFocus( self )
            self.isFocus = true

            startPos = touch.x
            prevPos = touch.x

            transition.to( navBar,  { time=200, alpha=math.abs(navBar.alpha-1) } )

        elseif( self.isFocus ) then
            local pointA = touch.y > display.contentHeight/1.6
            local pointB = touch.y < display.contentHeight/0.5
            if ( phase == "moved" and pointA and pointB ) then

                transition.to(navBar,  { time=400, alpha=1 } )

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

                local option = character_scene.getTeamgetItem()
                local team_no = option.params.team_no
                imgNum = option.params.item_no
                print("vvvv 2222 team_no",team_no,"item_no",imgNum)

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
                    navBarShow.x = viewableScreenW*(.74 +(imgNum*.02))
                    character_scene.startBattle(team_no,imgNum)

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

    function g:cleanUp()
        background:removeEventListener("touch", touchListener)
    end


    --g:insert(background) --front background
    return g
end


