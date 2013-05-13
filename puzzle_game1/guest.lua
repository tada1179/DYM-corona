
-----------------------------------------------------------------------------------------
--
-- map_substate.lua
--
-- ##ref
--
-- Map
print("guest.lua")
-----------------------------------------------------------------------------------------


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")



--------- icon event -------------
local backButton
local scrollView
local function onBtnRelease(event)
   if event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map_substate" ,"fade", 100 )


    elseif event.target.id == "listCharacter1" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_select" ,"fade", 100 )
    end
    --    storyboard.gotoScene( "title_page", "fade", 100 )
    return true	-- indicates successful touch
end

local function createBackButton()
    backButton = widget.newButton{
        default="img/background/button/Button_BACK.png",
        over="img/background/button/Button_BACK.png",
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
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
        width = display.contentWidth *.6,
        height = display.contentHeight * .45,
        top = display.contentHeight *.35,
        left = display.contentWidth *.3,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true,
        horizontalScrollDisabled = true ,--slide
        verticalScrollDisabled = false ,--up
    }
    for i = 1, 7, 1 do
        local listCharacter = {}
        listCharacter[i] = widget.newButton{
            default="img/background/character/BLOCK_NEW_LAYOUT_2.png",
            --over="img/background/character/BLOCK_NEW_LAYOUT_2.png",
            width=display.contentWidth * .9 ,
            height=(display.contentHeight *.14),
            top = (i*90)-(display.contentHeight/8),
            left = (display.contentWidth*.8) - display.contentWidth ,
            onEvent = onButtonEvent	-- event listener function
        }
        listCharacter[i].id = "listCharacter"..i
        scrollView:insert(listCharacter[i])
    end

end

function scene:createScene( event )
    print("--------------createScene----------------")
    local group = self.view
    local gdisplay = display.newGroup()
    local background = display.newImageRect( "img/background/background_1.png", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local background2 = display.newImageRect( "img/background/background_2.png", display.contentWidth, display.contentHeight )
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0

    local titleText = display.newImageRect( "img/text/GUEST_SELECT.png", display.contentWidth/2.65, display.contentHeight/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    scrollViewList()
    createBackButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)




    group:insert(background)

    group:insert(scrollView)
    group:insert(backButton)
    group:insert(titleText)
    group:insert(background2)
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


