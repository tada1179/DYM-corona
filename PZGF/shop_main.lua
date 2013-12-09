local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
-----------------------------------------------------------------------------------------

local screenW, screenH = display.contentWidth, display.contentHeight
local gdisplay

local btnshopcoin
local btnshopmoney
local stamshop
local titleText
-----------------------------------
local function onBtnshop(event)

    display.remove(btnshopcoin)
    btnshopcoin = nil

    display.remove(btnshopmoney)
    btnshopmoney = nil


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
        menu_barLight.SEtouchButtonBack()
        storyboard.gotoScene( "map" ,"fade", 100 )

    elseif event.target.id == "shopcoin" then
        menu_barLight.SEtouchButton()
        storyboard.gotoScene( "shop_coin" ,"fade", 100 )

    elseif event.target.id == "shopmoney" then
        menu_barLight.SEtouchButton()
        storyboard.gotoScene( "shop_money" ,"fade", 100 )
    end
    return true
end
local function createButton()

    local image_shopcoin = "img/background/shop/SHOP_MONEY.png"
    local image_shopmoney = "img/background/shop/SHOP_COIN.png"

    -- shop coin
    btnshopcoin = widget.newButton{
        defaultFile= image_shopcoin,
        overFile= image_shopcoin,
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
        defaultFile= image_shopmoney,
        overFile= image_shopmoney,
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
    gdisplay = display.newGroup()
  --  local image_background = "img/background/background_1.jpg"
    local image_text = "img/text/SELL_ITEM.png"
    local image_stam = "img/background/shop/STAM.png"
    local group = self.view

    stamshop = display.newImageRect( image_stam, screenW*.05, screenH*.6 )
    stamshop:setReferencePoint( display.TopLeftReferencePoint )
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
    storyboard.purgeScene( "map" )
    storyboard.purgeScene( "shop_coin" )
    storyboard.purgeScene( "shop_money" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
