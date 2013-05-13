--
-- Created by IntelliJ IDEA.
-- User: APPLE
-- Date: 5/3/13
-- Time: 2:07 PM
-- To change this template use File | Settings | File Templates.
--
print("item_setting")

local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"
local itemView = require("itemView")
local menu_barLight = require ("menu_barLight")

local image_text = "img/text/ITEM_SETTING.png"
local image_background1 = "img/background/background_1.png"
local image_background2 = "img/background/background_2.png"
local image_btnback = "img/background/button/Button_BACK.png"

local backButton

local function onBtnRelease(event)
    if event.target.id == "back" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "unit_main" ,"fade", 100 )
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
    local group = self.view
    local gdisplay = display.newGroup()
    local groupGameLayer = display.newGroup()

    local background1 = display.newImageRect(image_background1,display.contentWidth,display.contentHeight)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0

    local background2 = display.newImageRect(image_background2,display.contentWidth,display.contentHeight)--contentWidth contentHeight
    background2:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background2.x,background2.y = 0,0

    local titleText = display.newImageRect(image_text,display.contentWidth/3,display.contentHeight/35)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = display.contentWidth/2
    titleText.y = display.contentHeight/3.15
    createButton()

    local mySlides = {
        "item1",
        "team2",
        "team3",
        "team4",
        "team5",
    }

    itemView = itemView.new(mySlides )
    groupGameLayer:insert(itemView)

    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background1)
    group:insert(groupGameLayer)

    group:insert(titleText)
    group:insert(backButton)
    group:insert(background2)
    group:insert(gdisplay)
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

