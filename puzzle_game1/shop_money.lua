print("shop_money")

-----------------------------------------------------------------------------------------
--
-- shop_main.lua
--
-- ##ref
--
-- Map
-----------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")

local image_background = "img/background/background_1.png"
--local image_background = "img/background/shop/shopmoney.jpg"
local image_background2 = "img/background/background_2.png"
local image_text = "img/text/SHOP_MONEY.png"
local image_btnback = "img/background/button/Button_BACK.png"

local screenW, screenH = display.contentWidth, display.contentHeight

local backButton
local rowmenu = 5

local btnmenu = {}
local idMenu = {"ticket","stamina","slot","weapon","armour"}
local imageMenu = {
    "img/background/shop/ticket_shop.png",
    "img/background/shop/stamina_recivery.png",
    "img/background/shop/slot_extension.png",
    "img/background/shop/weapon_shop_money.png",
    "img/background/shop/armour_shop_money.png"
 }

local function onBtnRelease(event)
    if event.target.id == "back" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_main" ,"fade", 100 )

    elseif event.target.id == "ticket" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "ticket_shop" ,"fade", 100 )

    elseif event.target.id == "stamina" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_main" ,"fade", 100 )

    elseif event.target.id == "slot" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_main" ,"fade", 100 )

    elseif event.target.id == "weapon" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_main" ,"fade", 100 )

    elseif event.target.id == "armour" then
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

    -- menu button
    for i = 1, rowmenu ,1 do
        btnmenu[i] = widget.newButton{
            default= imageMenu[i],
            over= imageMenu[i],
            width=screenW*.56, height=screenH*.086,
            onRelease = onBtnRelease	-- event listener function
        }
        btnmenu[i].id = idMenu[i]
        btnmenu[i]:setReferencePoint( display.CenterReferencePoint )
        btnmenu[i].x = screenW*.5
        btnmenu[i].y = i*(screenH*.09)+(screenH*.313)
    end


    --
end

function scene:createScene( event )
    print("--------------shop_coin----------------")
    local group = self.view
    local gdisplay = display.newGroup()
    local background = display.newImageRect( image_background, display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local background2 = display.newImageRect( image_background2, display.contentWidth, display.contentHeight )
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0

    local titleText = display.newImageRect(image_text,screenW*.3, screenH*.025 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.5
    titleText.y = screenH /3.15

    createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background)
    group:insert(titleText)
    group:insert(backButton)

    for i =1,rowmenu,1    do
        group:insert(btnmenu[i])
    end

    group:insert(background2)
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

