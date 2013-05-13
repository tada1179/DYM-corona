print("gacha.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local json = require("json")
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local image_btnback = "img/background/button/Button_BACK.png"
local image_background = "img/background/background_1.png"
local image_background2 = "img/background/background_2.png"
local image_txtshopmoney =  "img/text/TICKET_SHOP.png"

local backButton


local function onBtnRelease(event)
    -- print("onBtnRelease event id",event.id)
    if event.target.id == "battle" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map", "fade", 100 )
        --storyboard.gotoScene( "game-scene", "fade", 100 ) --game-scene
    elseif  event.target.id == "team" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_main", "fade", 100 )
    elseif  event.target.id == "shop" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_main", "fade", 100 )
    elseif  event.target.id == "gacha" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "gacha", "fade", 100 )
    elseif  event.target.id == "commu" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "commu_main", "fade", 100 )


    elseif event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map" ,"fade", 100 )
    end
    --    storyboard.gotoScene( "title_page", "fade", 100 )
    return true	-- indicates successful touch
end



local function createBackButton()
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
    print("scene: createScene")
    local group = self.view
    local gdisplay = display.newGroup()
--    local background = display.newImageRect("img/background/pageBackground_JPG/ticket_shop.jpg",display.contentWidth,display.contentHeight)
    local background = display.newImageRect(image_background,display.contentWidth,display.contentHeight)
    background:setReferencePoint( display.TopLeftReferencePoint  )
    background.x,background.y = 0 , 0

    local background2 = display.newImageRect(image_background2,display.contentWidth,display.contentHeight)
    background2:setReferencePoint( display.TopLeftReferencePoint  )
    background2.x,background2.y = 0 , 0


    local titleText = display.newImageRect(image_txtshopmoney, display.contentWidth/3.25, display.contentHeight/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    createBackButton()

    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)


    group:insert(background)
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
