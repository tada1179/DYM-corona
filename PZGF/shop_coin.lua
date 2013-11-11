print("shop_coin")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
-----------------------------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight

local gdisplay
local titleText
local titleTextcoin
local backButton
----------------------------------------

local function onBtnRelease(event)
    display.remove(titleText)
    titleText = nil

    display.remove(titleTextcoin)
    titleTextcoin= nil

    display.remove(backButton)
    backButton= nil

    for i= gdisplay.numChildren,1,-1 do
        local child = gdisplay[i]
        child.parent:remove( child )
        child = nil
    end
    menu_barLight.SEtouchButtonBack()
    if event.target.id == "back" then
        storyboard.gotoScene( "shop_main" ,"fade", 100 )

    end
    return true
end

function scene:createScene( event )
    gdisplay = display.newGroup()
    local image_background = "img/background/shop/shopcoin.jpg"
    local image_text = "img/text/SHOP.png"
    local image_textcoin = "img/text/COIN.png"

    local group = self.view

    titleText = display.newImageRect(image_text, screenW *.15, screenH/33 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.1

    titleTextcoin = display.newImageRect(image_textcoin, screenW*.095, screenH*.021 )
    titleTextcoin:setReferencePoint( display.CenterReferencePoint )
    titleTextcoin.x = screenW*.75
    titleTextcoin.y = screenH* .32

    local image_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        defaultFile= image_btnback,
        overFile= image_btnback,
        width= screenW/10, height= screenH/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW- (screenW*.845)
    backButton.y = screenH - (screenH *.7)



    gdisplay:insert(background)
    gdisplay:insert(titleText)
    gdisplay:insert(titleTextcoin)
    gdisplay:insert(backButton)
    gdisplay:insert(menu_barLight.newMenubutton())
    group:insert(gdisplay)
    ------------- other scene ---------------
    storyboard.removeAll ()
    storyboard.purgeAll()

end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "shop_main" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view

    display.remove(titleText)
    titleText = nil

    display.remove(titleTextcoin)
    titleTextcoin= nil

    display.remove(backButton)
    backButton= nil

    for i= gdisplay.numChildren,1,-1 do
        local child = gdisplay[i]
        child.parent:remove( child )
        child = nil
    end

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
