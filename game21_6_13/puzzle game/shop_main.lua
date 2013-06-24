print("shop_main")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
-----------------------------------------------------------------------------------------

local screenW, screenH = display.contentWidth, display.contentHeight


-- BUTTON
local backButton
local btnshopcoin
local btnshopmoney

local function onBtnshop(event)
    if event.target.id == "back" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map" ,"fade", 100 )

    elseif event.target.id == "shopcoin" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_coin" ,"fade", 100 )

    elseif event.target.id == "shopmoney" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_money" ,"fade", 100 )
    end
    return true
end
local function createButton()

    local image_shopcoin = "img/background/shop/SHOP_MONEY.png"
    local image_shopmoney = "img/background/shop/SHOP_COIN.png"
    local image_btnback = "img/background/button/Button_BACK.png"

    backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnshop	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)

    -- shop coin
    btnshopcoin = widget.newButton{
        default= image_shopcoin,
        over= image_shopcoin,
        width= screenW*.378, height= screenH*.075,
        onRelease = onBtnshop	-- event listener function
    }
    btnshopcoin.id="shopmoney"
    btnshopcoin:setReferencePoint( display.TopLeftReferencePoint )
    btnshopcoin.x = screenW *.215
    btnshopcoin.y = screenH *.5


    -- shop money
    btnshopmoney = widget.newButton{
        default= image_shopmoney,
        over= image_shopmoney,
        width= screenW*.375, height= screenH*.09,
        onRelease = onBtnshop	-- event listener function
    }
    btnshopmoney.id="shopcoin"
    btnshopmoney:setReferencePoint( display.TopLeftReferencePoint )
    btnshopmoney.x = screenW *.385
    btnshopmoney.y = screenH *.405

end

function scene:createScene( event )  
    print("--------------shop_main----------------")
    local image_background = "img/background/background_1.jpg"
    local image_text = "img/text/SELL_ITEM.png"
    local image_stam = "img/background/shop/STAM.png"

    local group = self.view
    local gdisplay = display.newGroup()

    local background = display.newImageRect( image_background, screenW, screenH )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local stamshop = display.newImageRect( image_stam, screenW*.05, screenH*.6 )
    stamshop.x = screenW *.5
    stamshop.y = display.contentHeight*.65

    local titleText = display.newImageRect(image_text, screenW*.25, screenH*.03 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH /3.1

    createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background)
    group:insert(titleText)
    group:insert(backButton)
    group:insert(stamshop)

    group:insert(btnshopcoin)
    group:insert(btnshopmoney)
    group:insert(gdisplay)
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
