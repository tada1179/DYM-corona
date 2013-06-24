--
-- Created by IntelliJ IDEA.
-- User: APPLE
-- Date: 5/13/13
-- Time: 3:58 PM
-- To change this template use File | Settings | File Templates.
--
 print("character_show.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")

--local image_background = "img/background/background_1.png"
local image_background = "img/background/character/7.CHARACTER-NAME.jpg"
local image_background2 = "img/background/background_2.png"
local image_text = "img/text/CHARACTER_NAME.png"
local image_character = "img/character/tgr_chfb-v201.png"

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight


local function onBtnRelease(event)
    if event.target.id == "back" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_item" ,"fade", 100 )

        -- back image profile
    elseif event.target.id == "imageprofile" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_item" ,"fade", 100 )
    end
    return true
end
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end



function scene:createScene( event )
    print("--------------characterprofile----------------")
    local group = self.view
    checkMemory()
    local gdisplay = display.newGroup()
    function touchListener (self, touch)
        local phase = touch.phase
        print("slides", phase)
        display.getCurrentStage():setFocus( self )
        self.isFocus = true
        storyboard.gotoScene( "characterprofile" ,"zoomOutInFade", 500 )

    end

    -- local background = display.newImageRect( "img/background/character/characterNmae.jpg", display.contentWidth, display.contentHeight )
    local background = display.newImageRect(image_background, display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    background.touch = touchListener
    background:addEventListener( "touch", background )

    local background2 = display.newImageRect(image_background2, display.contentWidth, display.contentHeight )
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0

    local titleText = display.newImageRect(image_text, display.contentWidth/2.35, display.contentHeight/33 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

--    local charaterImage = display.newImage(image_character,screenW*.1,screenH*.25 )
    --charaterImage:translate( screenW *., screenH *.5 )

    local charaterImage = display.newImageRect(image_character,screenW*.5,screenH*.4 )
    charaterImage:setReferencePoint( display.CenterReferencePoint )
    charaterImage.x = display.contentWidth *.5
    charaterImage.y = display.contentHeight *.65
    charaterImage.touch = touchListener
    charaterImage:addEventListener( "touch", charaterImage )

    --createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background)
    group:insert(charaterImage)
    group:insert(titleText)
    group:insert(background2)
    group:insert(gdisplay)


    ------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
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

