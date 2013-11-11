
-- Seem seem map_substate 24/6/13 17.03
print("..................chapter_select.lua")
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
--local scrollImage = require ("scrollImage")
-----------------------------------------------------------------------------------------
local backButton
local scrollView
local screenW, screenH = display.contentWidth, display.contentHeight

local topBoundary = display.screenOriginY
local bottomBoundary = display.screenOriginY
--local scrollImageFN = scrollImage.new{ top=topBoundary, bottom=bottomBoundary }

local function onBtnRelease(event)

    if event.target.id == "back" then -- back button
        menu_barLight.SEtouchButtonBack()
        storyboard.gotoScene( "map" ,"fade", 100 )


    elseif event.target.id == "listCharacter1" then
        menu_barLight.SEtouchButton()
        storyboard.gotoScene( "misstion" ,"fade", 100 )
    end

    display.remove( scrollView )
    display.remove( backButton )
    scrollView = nil

    return true	-- indicates successful touch
end

local function createBackButton()
    local imgBnt = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        defaultFile= imgBnt,
        overFile= imgBnt,
        width= screenW/10, height= screenH/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW- (screenW*.845)
    backButton.y = screenH - (screenH*.7)
end

local function scrollViewList()
    local eventScroll
    local pointListY
    local poinNext

    local function onButtonEvent(event,self)
--     function scrollView:touch(event)

      -- print("onButtonEvent self y",self.y)

        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y

            --scrollView:takeFocus( event )
        elseif event.phase == "moved" then

            --local dx = math.abs( event.x - event.xStart )
            local dy = math.abs( event.y - event.yStart )  print("dy",dy)
            local dyY =  event.y - event.yStart   print("dyY",dyY)

            -- if finger drags button more than 5 pixels, pass focus to scrollView
            if  dy > 5 then
                --
                if dyY == dy then -- down
                    eventScroll = "down"
                    poinNext =  dyY

                else  --up
                    eventScroll = "up"
                    poinNext =  dyY

                end
                scrollView:takeFocus( event,self )
            end
            --scrollListener(event)
        elseif event.phase == "release" then
            --onBtnRelease(event)

        end

        return true
    end
    local scroll_item
    local scroll_line

     local function scrollImage(self)
        local img_scrollLine = "img/background/frame/SCROLL_LINE.png"
        local img_scrollitem = "img/background/frame/SCROLLER.png"
        scroll_line = display.newImageRect( img_scrollLine, screenW*.2, screenH*.62)
        scroll_line:setReferencePoint( display.TopLeftReferencePoint )
        scroll_line.x, scroll_line.y = screenW*.8, screenH*.29

        scroll_item = display.newImageRect( img_scrollitem, screenW*.11, screenH*.1)
        scroll_item:setReferencePoint( display.TopLeftReferencePoint )
        scroll_item.x, scroll_item.y = screenW*.851, screenH*.36
        self.top = screenH*.35
        self.bottom = pointListY
        return true

    end

    function scrollListener( event )

        local phase = event.phase
        local direction = event.direction
        if "began" == phase then
            print( "Began" )

        elseif "moved" == phase then
            print( "Moved ")
        elseif "ended" == phase then
            print( "Ended" )
        end

        if event.type == "movingToBottomLimit" then
            scroll_item.y =  ( (screenH*.62) + (screenH*.122))

        elseif event.type == "contentTouch" and "moved" == phase and eventScroll == "up" then
            print("eventScroll up")
            if scroll_item.y  >=  screenH*.36 then
                scroll_item.y =  scroll_item.y + (scrollView.height*.01)
            end
            if scroll_item.y  >=  ( (screenH*.62) + (screenH*.122)) then
                scroll_item.y =(screenH*.62) + (screenH*.122)
            end
        elseif event.type == "contentTouch" and "moved" == phase and eventScroll == "down" then
            print("eventScroll down")
            if scroll_item.y  >=  screenH*.36 + pointListY*.01 then
                scroll_item.y =  scroll_item.y - (scrollView.height*.01)
            end
            if  scroll_item.y  >=  ( (screenH*.62) + (screenH*.122)) then
                scroll_item.y =(screenH*.62) + (screenH*.122)
            end
        elseif event.type == "beganScroll" and "moved" == phase  then
            scroll_item.y =  screenH*.36
        elseif event.type == "movingToTopLimit" then
            scroll_item.y =  screenH*.36
        end

       return true
    end

    scrollView = widget.newScrollView{
        width = screenW *.78,
        height = screenH * .48,
        top = screenH*.35,
        left = screenW*.12,
        scrollWidth = screenW,
        scrollHeight = 0,
        bottom = 0,
        topPadding = 0,
        bottomPadding = 0,
        leftPadding = 0,
        rightPadding = 0,
        friction = .972, -- how fast the scroll view moves.  default is .972
        backgroundColor = {39,0,226,255},
        hideBackground = true, -- if true it wont show the background color.
        horizontalScrollDisabled = true,
        verticalScrollDisabled = true,
       listener = scrollListener,

    }

    print("-* start",scrollView.height)
    pointListY = 0
    local maxChapter = 17
    for i = 1, maxChapter, 1 do
        local listCharacter = {}
        local imgFrmList = "img/background/sellBattle_Item/frame.png"
        listCharacter[i] = widget.newButton{
            defaultFile = imgFrmList,
            overFile = imgFrmList,
            width = screenW * .75 , height= screenH *.1,
            top = pointListY,
            left = 0,
            onEvent = onButtonEvent	-- event listener function
        }

        listCharacter[i].id = "listCharacter"..i
        scrollView:insert(listCharacter[i])
        pointListY = pointListY + (screenH*.11)

    end

    scrollImage(scrollView)

end
function scene:createScene( event )
--    local img_back = "img/background/background_1.jpg"
    local text_title = "img/text/CHAPTER_SELECT.png"
    local group = self.view
    local gdisplay = display.newGroup()

    local titleText = display.newImageRect(text_title ,screenW/1.8, screenH/17 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.12

    --scrollViewList()
    createBackButton()

    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)
    group:insert(background)

    group:insert(scrollView)
    group:insert(titleText)
    group:insert(backButton)
    group:insert(gdisplay)

    ------------- other scene ---------------
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "map" )
    storyboard.purgeScene( "misstion" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )
end

function scene:destroyScene( event )
    local group = self.view

    scrollView:removeSelf()
    scrollView= nil

    backButton:removeSelf()
    backButton= nil

    menu_barLight:removeSelf()
    menu_barLight= nil
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene


