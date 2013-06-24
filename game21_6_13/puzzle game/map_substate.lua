
-- Map
print("map_substate.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
-----------------------------------------------------------------------------------------
local backButton
local scrollView
local screenW, screenH = display.contentWidth, display.contentHeight

local function onBtnRelease(event)

   if event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map" ,"fade", 100 )


    elseif event.target.id == "listCharacter1" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "misstion" ,"fade", 100 )
    end
--    storyboard.gotoScene( "title_page", "fade", 100 )	    
    return true	-- indicates successful touch
end

local function createBackButton()
    local imgBnt = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        default= imgBnt,
        over= imgBnt,
        width= screenW/10, height= screenH/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW- (screenW*.845)
    backButton.y = screenH - (screenH*.7)
end

local function scrollViewList()
    local function onButtonEvent(event)
        print(event.phase)

        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
            local scrollBar = self.scrollBar
        elseif event.phase == "moved" then


            print("----///event.y:"..event.y)

            if event.markY ~= event.y and event.markX == event.x then
                print("if mark")
            else
                print("else mark")
            end

            --local dx = math.abs( event.x - event.xStart )
            local dy = math.abs( event.y - event.yStart )
            print("dy",dy)
            -- if finger drags button more than 5 pixels, pass focus to scrollView
            if  dy > 5 then
                scrollView:takeFocus( event )
                --moveScrollBar(dy)
            end

        elseif event.phase == "release" then
            print(event.target.id)
            print( "Button pushed." )
            onBtnRelease(event)

        end

        return true
    end

    scrollView = widget.newScrollView{
        width = screenW *.78,
        height = screenH * .48,
        top = screenH*.35,
        left = screenW*.12,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true

    }
    local pointListY = 0
    local maxChapter = 15
    for i = 1, maxChapter, 1 do
        local listCharacter = {}
        local imgFrmList = "img/background/sellBattle_Item/frame.png"
        listCharacter[i] = widget.newButton{
            default = imgFrmList,
            over = imgFrmList,
            width = screenW * .75 , height= screenH *.1,
            top = pointListY,
            left = 0,

            onEvent = onButtonEvent	-- event listener function
        }
        listCharacter[i].id = "listCharacter"..i
        scrollView:insert(listCharacter[i])
        pointListY = pointListY + (screenH*.11)
    end

end
function scene:createScene( event )  
    print("-- map substate --")
    local img_back = "img/background/background_1.jpg"
    local text_title = "img/text/CHAPTER_SELECT.png"
    local group = self.view
    local gdisplay = display.newGroup()
    local background = display.newImageRect( img_back, screenW, screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local titleText = display.newImageRect(text_title ,screenW/1.8, screenH/17 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.12

    scrollViewList()
    createBackButton()

    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)



    group:insert(background)

    group:insert(scrollView)
    group:insert(titleText)
    group:insert(backButton)
    group:insert(gdisplay)
    
------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "title_page" )  
    storyboard.removeScene( "team_main" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha_main" )
    storyboard.removeScene( "commu_main" )
end

function scene:enterScene( event )
    local group = self.view	
end

function scene:exitScene( event )
    local group = self.view	
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene


