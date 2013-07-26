print("gacha.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local json = require("json")
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local image_btnback = "img/background/button/Button_BACK.png"
local image_background = "img/background/background_1.jpg"
local image_background2 = "img/background/background_2.png"
local image_txtshopmoney =  "img/text/TICKET_SHOP.png"

--------------------------------------
local background
local titleText
local gdisplay = display.newGroup()
--------------------------------------
local function onBtnRelease(event)
    -- print("onBtnRelease event id",event.id)
    if event.target.id == "battle" then
        storyboard.gotoScene( "map", "fade", 100 )

        --storyboard.gotoScene( "game-scene", "fade", 100 ) --game-scene
    elseif  event.target.id == "team" then
        storyboard.gotoScene( "team_main", "fade", 100 )

    elseif  event.target.id == "shop" then
        storyboard.gotoScene( "shop_main", "fade", 100 )

    elseif  event.target.id == "gacha" then
        storyboard.gotoScene( "gacha", "fade", 100 )

    elseif  event.target.id == "commu" then
        storyboard.gotoScene( "commu_main", "fade", 100 )

    elseif event.target.id == "back" then -- back button
        storyboard.gotoScene( "map" ,"fade", 100 )

    end
    --    storyboard.gotoScene( "title_page", "fade", 100 )
    return true	-- indicates successful touch
end



local function createBackButton()
--    backButton = widget.newButton{
--        default= image_btnback,
--        over= image_btnback,
--        width=display.contentWidth/10, height=display.contentHeight/21,
--        onRelease = onBtnRelease	-- event listener function
--    }
--    backButton.id="back"
--    backButton:setReferencePoint( display.TopLeftReferencePoint )
--    backButton.x = display.contentWidth - (display.contentWidth *.845)
--    backButton.y = display.contentHeight - (display.contentHeight *.7)
end

function scene:createScene( event )
    print("--: gacha :--")
    local group = self.view

--    local background = display.newImageRect("img/background/pageBackground_JPG/ticket_shop.jpg",display.contentWidth,display.contentHeight)
    background = display.newImageRect(image_background,display.contentWidth,display.contentHeight)
    background:setReferencePoint( display.TopLeftReferencePoint  )
    background.x,background.y = 0 , 0

    titleText = display.newImageRect(image_txtshopmoney, display.contentWidth/3.25, display.contentHeight/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    --createBackButton()

    gdisplay:insert(background)
--    group:insert(backButton)
    gdisplay:insert(titleText)
    gdisplay:insert(menu_barLight.newMenubutton())
    group:insert(gdisplay)


    ------------- other scene ---------------
    storyboard.removeAll ()
    storyboard.purgeAll()
    menu_barLight.checkMemory()
end

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view

end

function scene:destroyScene( event )
    local group = self.view
    display.remove(background)
    background = nil
    display.remove(titleText)
    titleText = nil
    display.remove(gdisplay)
    gdisplay  = nil
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
