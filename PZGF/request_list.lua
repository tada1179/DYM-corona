print("request_list.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")

---------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
--local scrollView
local maxlistFriend
local user_id
local gdisplay
local titleText
--------------------------------------

local function BackRelease(event)

    display.remove(titleText)
    titleText= nil
    display:remove(gdisplay)
    gdisplay = nil
    menu_barLight.SEtouchButtonBack()
    if event.target.id == "back" then -- back button
        storyboard.gotoScene( "commu_main" ,"fade", 100 )
    end
end

local function createBackButton()
    backButton = widget.newButton{
        defaultFile="img/background/button/Button_BACK.png",
        overFile="img/background/button/Button_BACK.png",
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = BackRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
    gdisplay:insert(backButton)
end

function scene:createScene( event )
    gdisplay = display.newGroup()
    local image_text = "img/text/REQUEST_LIST_TXT.png"
    user_id = menu_barLight.user_id()
    local group = self.view

    gdisplay:insert(background)

    titleText = display.newImageRect( image_text, display.contentWidth/3.4, display.contentHeight/32 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1
    gdisplay:insert(titleText)

    createBackButton()

    local scroll =  require("request_list_scroll")
    gdisplay:insert(scroll.new{ user_id = user_id })
    scroll.loatCharacter()
    gdisplay:insert(menu_barLight.newMenubutton())
    group:insert(gdisplay)

    menu_barLight.checkMemory()

end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "commu_main" )
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
    display.remove(backButton)
    backButton = nil

    display.remove(titleText)
    titleText= nil
    display:remove(gdisplay)
    gdisplay = nil
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
