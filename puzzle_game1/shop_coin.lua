
-----------------------------------------------------------------------------------------
--
-- shop_main.lua
--
-- ##ref
--
-- Map
-----------------------------------------------------------------------------------------
print("shop_coin")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")

--local image_background = "img/background/background_1.png"
local image_background = "img/background/shop/shopcoin.jpg"
local image_background2 = "img/background/background_2.png"
local image_text = "img/text/SHOP.png"
local image_textcoin = "img/text/COIN.png"
local image_btnback = "img/background/button/Button_BACK.png"
local screenW, screenH = display.contentWidth, display.contentHeight

local backButton

local function onBtnRelease(event)
    if event.target.id == "back" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_main" ,"fade", 100 )
    end
    return true
end
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end

local function createButton()
    backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)

end

function scene:createScene( event )
    print("--------------shop_coin----------------")
    local group = self.view
    local gdisplay = display.newGroup()
    local background = display.newImageRect( image_background, display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local titleText = display.newImageRect(image_text, display.contentWidth*.15, display.contentHeight/33 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    local titleTextcoin = display.newImageRect(image_textcoin, screenW*.095, screenH*.021 )
    titleTextcoin:setReferencePoint( display.CenterReferencePoint )
    titleTextcoin.x = screenW*.75
    titleTextcoin.y = screenH* .32

    createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background)
    group:insert(titleText)
    group:insert(titleTextcoin)
    group:insert(backButton)
    group:insert(gdisplay)
    checkMemory()
    ------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "team_main" )
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
