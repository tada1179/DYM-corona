local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
-----------------------------------------------------------------------------------------

local screenW, screenH = display.contentWidth, display.contentHeight
local gdisplay = display.newGroup()

local btnshopcoin
local btnshopmoney
local background
local stamshop
local titleText
-----------------------------------
local function onBtnshop(event)

    display.remove(btnshopcoin)
    btnshopcoin = nil

    display.remove(btnshopmoney)
    btnshopmoney = nil

    display.remove(background)
    background = nil

    display.remove(stamshop)
    stamshop = nil

    display.remove(titleText)
    titleText= nil

    for i= gdisplay.numChildren,1,-1 do
        local child = gdisplay[i]
        child.parent:remove( child )
        child = nil
    end
    if event.target.id == "back" then
        storyboard.gotoScene( "map" ,"fade", 100 )

    elseif event.target.id == "shopcoin" then
        storyboard.gotoScene( "shop_coin" ,"fade", 100 )

    elseif event.target.id == "shopmoney" then
        storyboard.gotoScene( "shop_money" ,"fade", 100 )
    end
    return true
end
local function createButton()

    local image_shopcoin = "img/background/shop/SHOP_MONEY.png"
    local image_shopmoney = "img/background/shop/SHOP_COIN.png"

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
    gdisplay:insert(btnshopcoin)

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
    gdisplay:insert(btnshopmoney)
end

function scene:createScene( event )  
    print("--------------shop_main----------------")
    local image_background = "img/background/background_1.jpg"
    local image_text = "img/text/SELL_ITEM.png"
    local image_stam = "img/background/shop/STAM.png"
    local group = self.view

    background = display.newImageRect( image_background, screenW, screenH )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    stamshop = display.newImageRect( image_stam, screenW*.05, screenH*.6 )
    stamshop.x = screenW *.5
    stamshop.y = screenH*.65

    titleText = display.newImageRect(image_text, screenW*.25, screenH*.03 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH /3.1

    gdisplay:insert(background)
    gdisplay:insert(titleText)
    gdisplay:insert(stamshop)
    createButton()

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
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )
    local group = self.view

    display.remove(btnshopcoin)
    btnshopcoin = nil

    display.remove(btnshopmoney)
    btnshopmoney = nil

    display.remove(background)
    background = nil

    display.remove(stamshop)
    stamshop = nil

    display.remove(titleText)
    titleText= nil

    display.remove(gdisplay)
    gdisplay = nil
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
