module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local character_scene = require("character_scene")
local menu_barLight = require("menu_barLight")
local loadImageSprite = require ("downloadData").loadImageSprite_Victory_Warning2()

local teamInfo = require("team")
local myImageteam = graphics.newImageSheet( "team.png",system.DocumentsDirectory, teamInfo:getSheet() )
--------------------------------------------------

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight

local imgNum = nil
local images = nil
local touchListener, nextImage, prevImage, cancelMove, initImage

local imageNumberText, imageNumberTextShadow


function new( imageSet, slideBackground, top, bottom ,pageTeam,pageItem,user_id,params)
    character_scene.startBattle(pageTeam,pageItem)
    local pad = 20
    local top = top or 0
    local bottom = bottom or 0
    local image_background = "img/background/background_2_1.png"
    imgNum = pageTeam or 1

    local backButton
    local startbuttle
    local background


    local g = display.newGroup()
    local USERID = user_id

    if slideBackground then

        background = display.newImage(slideBackground, 0, 0, true)
        background:setReferencePoint( display.TopLeftReferencePoint )

    else
--        background = display.newRect( 0, 0, screenW, screenH*.6 )
--        background:setFillColor(255, 255, 255)

        background = display.newImageRect(image_background, screenW, screenH*.6)
        background:setReferencePoint( display.TopLeftReferencePoint )
        background.x, background.y = 0, 0
    end
    g:insert(background) --front background


    --imgNum = 3
    images = {}
    for i = 1,#imageSet do

        local p = require(imageSet[i]).newTEAM(params.friend_id)
       -- print("imageSet", imageSet[i])
        p:setReferencePoint(display.CenterReferencePoint)
--        p:setReferencePoint(display.TopLeftReferencePoint)

        local h = viewableScreenH-(top+bottom)
        if p.width > viewableScreenW or p.height > h then
            if p.width/viewableScreenW > p.height/h then
                p.xScale = viewableScreenW/p.width
                p.yScale = viewableScreenW/p.width
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

        p.y = h*.45

        images[i] = p
    end

    local navBar = display.newGroup()

    local img_bar = "as_slide_icn_base"
    local img_Show = "as_slide_icn_show"

    local navBarGraphic = display.newImageRect(myImageteam , teamInfo:getFrameIndex(img_bar), screenW*.1, screenH*.015, false)
    navBar:insert(navBarGraphic)
    navBarGraphic:setReferencePoint( display.TopLeftReferencePoint )
    navBarGraphic.x = viewableScreenW*.76
    navBarGraphic.y = viewableScreenH*.6


    local navBarShow = display.newImageRect(myImageteam , teamInfo:getFrameIndex(img_Show), screenW*.018, screenH*.015, false)
    navBar:insert(navBarShow)
    navBarShow:setReferencePoint( display.TopLeftReferencePoint )
    navBarShow.x = viewableScreenW*.76
    navBarShow.y = viewableScreenH*.6

    navBar.y = math.floor(navBar.height*0.5)
    g:insert(navBar)
    local function onbtnstartBattleBack(event)
        native.setActivityIndicator( true )

        if event.target.id == "back" then
            display.remove(startbuttle)
            startbuttle = nil

            display.remove(backButton)
            backButton = nil

            display.remove(navBarShow)
            navBarShow = nil
            display.remove(navBarGraphic)
            navBarGraphic = nil

            display.remove(navBar)
            navBar = nil

            for i= g.numChildren,1,-1 do
                local child = g[i]
                child.parent:remove( child )
                child = nil
            end
            display.remove(g)
            g = nil

            local option = {
                effect = "fade",
                time = 100,
                params = {
                    user_id = params.user_id,
                    map_id = params.map_id,
                    chapter_id = params.chapter_id,
                    mission_id = params.mission_id,
                }
            }
            menu_barLight.SEtouchButtonBack()
            storyboard.gotoScene( "guest" ,option )
            native.setActivityIndicator( false )

        elseif event.target.id == "startBattle" then
            menu_barLight.SEtouchStartBattle()
            local grrop = display.newGroup()
               local option = {
                params = {
                    user_id = params.user_id,
                    map_id = params.map_id,
                    chapter_id = params.chapter_id,
                    mission_id = params.mission_id,
                    mission_stamina = params.mission_stamina,
                    friend_id = params.friend_id,
                    friendPoint = params.friendPoint,
                    team = imgNum
                }
            }

            require( "loadPuzzle" ).newload(option)
            local cheackLoad = require( "loadPuzzle" ).cheack()
            local stopSpin = function()
                if cheackLoad ==10 then
                    display.remove(startbuttle)
                    startbuttle = nil

                    display.remove(backButton)
                    backButton = nil

                    display.remove(navBarShow)
                    navBarShow = nil
                    display.remove(navBarGraphic)
                    navBarGraphic = nil

                    display.remove(navBar)
                    navBar = nil

                    display.remove(g)
                    g = nil

                    --menu_barLight.SEEndMovePuzzle()
                    require("menu").removeDisplay()


                    storyboard.gotoScene( "puzzleCode" ,option )
                    native.setActivityIndicator( false )
                end



            end
            timer.performWithDelay(1000,stopSpin)



        end

    end
    local image_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        defaultFile= image_btnback,
        overFile= image_btnback,
        overAlpha = .2,
        overScale = 1.1,
        width=screenW/10, height=screenH/21,
        onRelease = onbtnstartBattleBack	-- event listener function
    }
    backButton.id = "back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW *.15
    backButton.y = screenH *.3
    navBar:insert(backButton)


    local image_btnbuttle = "img/background/button/START_BATTLE.png"
    startbuttle = widget.newButton{
        defaultFile= image_btnbuttle,
        overFile= image_btnbuttle,
        width= screenW*.25, height= screenH*.05,
        onRelease = onbtnstartBattleBack
    }
    startbuttle.id = "startBattle"
    startbuttle:setReferencePoint( display.TopLeftReferencePoint )
    startbuttle.x = screenW *.6
    startbuttle.y = screenH *.3
    navBar:insert(startbuttle)

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

           -- transition.to( navBar,  { time=200, alpha=math.abs(navBar.alpha-1) } )

        elseif( self.isFocus ) then
            local pointA = touch.y > display.contentHeight/3
            local pointB = touch.y < display.contentHeight/1.6
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
                local item_no = option.params.item_no
                imgNum = option.params.team_no

                if pointA and pointB then
                    dragDistance = touch.x - startPos

                    if (dragDistance < -40 and imgNum < #images) then
                        nextImage()
                        menu_barLight.SEtouchMoveTeam()
                    elseif (dragDistance > 40 and imgNum > 1) then
                        prevImage()
                        menu_barLight.SEtouchMoveTeam()
                    else
                        cancelMove()
                    end

                    if ( phase == "cancelled" ) then
                        cancelMove()
                    end

                    navBarShow.x = viewableScreenW*(.74 +(imgNum*.02))
                    character_scene.startBattle(imgNum,item_no)
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

