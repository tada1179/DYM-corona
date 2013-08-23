-- teamView.lua

print("itemView.lua")
module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()

local backButton
local btnreset
local btnsell
local btnchoose
local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local imgNum = nil
local images = nil
local touchListener, nextImage, prevImage, cancelMove, initImage
local background
local imageNumberText, imageNumberTextShadow

function new( imageSet, slideBackground, top, bottom )
    local image_reset = "img/background/button/as_team_reset.png"
    local image_sell = "img/background/button/SELL.png"
    local image_txtItem = "img/text/Item_Itembox.png"
    local image_background = "img/background/background_2.png"
    local image_slide = "img/background/team/as_slide_icn_show.png"
    local image_slidebase = "img/background/team/as_slide_icn_base.png"

    print("screenOffsetW:"..screenOffsetW,"screenH:"..screenH)

    local txtITEM = "100"
    local txtITEM_Box = "205"
    local sizeFont = 20
    local typeFont = native.systemFontBold

    local pad = 20
    local top = top or 0
    local bottom = bottom or 0

    local g = display.newGroup()

    if slideBackground then

        background = display.newImage(slideBackground, 0, 0, true)
    else
        background = display.newImageRect(image_background, screenW, screenH, true)
        background:setReferencePoint( display.TopLeftReferencePoint )
        background.x, background.y = 0, 0
    end

    --createBackButton()
    g:insert(background) --front background

    images = {}
    for i = 1,#imageSet do

        local p = require(imageSet[i]).newitem()
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
            print("p.xScale:"..p.xScale)
            print("p.yScale:"..p.yScale)
        end
        g:insert(p)

        if (i > 1) then
            p.x = screenW*1.5 + pad -- all images offscreen except the first one
        else
            p.x = screenW*.5
        end

        p.y = h*.45

        images[i] = p
    end

    --local defaultString = "1 of " .. #images

    local navBar = display.newGroup()
    g:insert(navBar)

    imgNum = 1
    print("imgNum:"..imgNum)

    local backcharacter = display.newRect(screenW*.1, screenH*.725, screenW*.8, screenH*.07)
    backcharacter.alpha = 0.8
    backcharacter:setFillColor(130 , 130, 130)
    navBar:insert(backcharacter)

    local txtItem = display.newImageRect(image_txtItem, screenW*.16, screenH*.05)
    navBar:insert(txtItem)
    txtItem.x = viewableScreenW*.25
    txtItem.y = viewableScreenH*.76

    local textITEM = display.newText(txtITEM, screenW*.45, screenH*.73, typeFont, sizeFont)
    textITEM:setTextColor(255, 100, 255)
    navBar:insert(textITEM)

    local textITEM_Box = display.newText(txtITEM_Box, screenW*.45, screenH*.76, typeFont, sizeFont)
    textITEM_Box:setTextColor(0, 255, 0)
    navBar:insert(textITEM_Box)

    function onbtnreset(event)
        local option = {
            effect = "slideRight",
            time = 100,
            params = {
                holditem = imgNum
            }
        }
        print("imgNum:"..imgNum,"event: "..event.target.id)
        if event.target.id == "SELL" then
            storyboard.gotoScene( "sell_item", "fade", 100 )
        elseif event.target.id == "choose"..imgNum then
            storyboard.gotoScene( "battle_item", option )

        end

        -- storyboard.gotoScene( "team_item", "fade", 100 )
    end

    g.x = 0
    g.y = top + display.screenOriginY
--    -- ** btnchoose BUTTON
--    btnchoose = widget.newButton{
--        default= image_choose,
--        over= image_choose,
--        width=screenW*.25, height=screenH*.05,
--        onRelease = onbtnreset	-- event listener function
--    }
--    btnchoose.id= "choose"..imgNum
--    btnchoose:setReferencePoint( display.TopLeftReferencePoint )
--    btnchoose.x = viewableScreenW*.6
--    btnchoose.y = viewableScreenH*.57
--    g:insert(btnchoose)

    -- ** RESET BUTTON
    btnreset = widget.newButton{
        default= image_reset,
        over= image_reset,
        width=display.contentWidth/9, height=display.contentHeight/21,
        onRelease = onbtnreset	-- event listener function
    }
    btnreset.id= 1
    btnreset:setReferencePoint( display.TopLeftReferencePoint )
    btnreset.x = viewableScreenW*.7
    btnreset.y = viewableScreenH*.3
    g:insert(btnreset)

    -- ** SELL BUTTON
    btnsell = widget.newButton{
        default= image_sell,
        over= image_sell,
        width=screenW*.3, height=screenH*.06,
        onRelease = onbtnreset	-- event listener function
    }
    btnsell.id="SELL"
    btnsell:setReferencePoint( display.TopLeftReferencePoint )
    btnsell.x = viewableScreenW*.6
    btnsell.y = viewableScreenH*.73
    g:insert(btnsell)

    function touchListener (self, touch)
        local phase = touch.phase
        print("slides", phase)
        if ( phase == "began" ) then
            -- Subsequent touch events will target button even if they are outside the stageBounds of button
            display.getCurrentStage():setFocus( self )
            self.isFocus = true

            startPos = touch.x
            prevPos = touch.x

            transition.to( navBar,  { time=200, alpha=math.abs(navBar.alpha-1) } )

        elseif( self.isFocus ) then
            local pointA = touch.y > display.contentHeight/3
            local pointB = touch.y < display.contentHeight/1.25
            if ( phase == "moved" and pointA and pointB ) then
                print("touch:"..touch.y,"contentHeight/3:"..display.contentHeight/3)
                print("touch:"..touch.y,"contentHeight/1.5:"..display.contentHeight/1.25)

                if touch.y > display.contentHeight/3 and touch.y < display.contentHeight/1.25 then
                    print("OK OK touch y:"..touch.y)
                else
                    print("NO touch y:"..touch.y)
                end

                transition.to(navBar,  { time=400, alpha=1 } )

                if tween then transition.cancel(tween) end

                print(imgNum)

                --                local navBarShow = display.newImageRect("img/background/team/as_slide_icn_show.png", screenW*.018, screenH*.015, false)
                --                navBar:insert(navBarShow)

                --                navBarShow.y = viewableScreenH*.35

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
                    print("dragDistance: " .. dragDistance)

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
                    btnreset.id="reset"..imgNum
                    btnchoose.id="choose"..imgNum
                    -- Allow touch events to be sent normally to the objects they "hit"
                    display.getCurrentStage():setFocus( nil )
                    self.isFocus = false

                end
            end
        end

        return true

    end

    function setSlideNumber()

        print("setSlideNumber", imgNum .. " of " .. #images)
        imageNumberText.text = imgNum .. " of " .. #images
        imageNumberTextShadow.text = imgNum .. " of " .. #images
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
        --setSlideNumber()
    end


    background.touch = touchListener
    background:addEventListener( "touch", background )

    ------------------------
    -- Define public methods

    function g:jumpToImage(num)
        local i
        print("jumpToImage")
        print("#images", #images)
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
        print("slides cleanUp")
        background:removeEventListener("touch", touchListener)
    end

    storyboard.removeScene( "sell_item" )
    --g:insert(background) --front background
    return g
end


