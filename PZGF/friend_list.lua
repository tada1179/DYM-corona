print("friend_list.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"

-------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight


local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
    return true
end

function scene:createScene( event )
    local group = self.view
    local gdisplay = display.newGroup()
    local includeFUN = require("includeFunction")
    local user_id = includeFUN.USERIDPhone()
    local image_text = "img/text/FRIEND_SELECT.png"

    local titleText = display.newImageRect( image_text, screenW/3.4, screenH/32 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH /3.1


    local function BackRelease(event)
        if event.target.id == "back" then -- back button
            storyboard.gotoScene( "commu_main" ,"fade", 100 )
        end
        return true	-- indicates successful touch
    end
    local img_btnback = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
        defaultFile= img_btnback,
        overFile= img_btnback,
        width= screenW/10, height= screenH/21,
        onRelease = BackRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW - (screenW *.845)
    backButton.y = screenH - (screenH *.7)

    local scroll = require("friend_list_scroll")
    local listscroll = scroll.new{ user_id = user_id }
    scroll.loatCharacter()

    gdisplay:insert(background)
    gdisplay:insert(titleText)
    gdisplay:insert(listscroll)
    gdisplay:insert(backButton)

    local menu_barLight = require ("menu_barLight")
    gdisplay:insert(menu_barLight.newMenubutton())


    group:insert(gdisplay)

    storyboard.removeAll ()
    storyboard.purgeAll()
    checkMemory()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "game-setting" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view

    group:removeSelf()
    group = nil

    storyboard.removeAll ()
    storyboard.purgeAll()
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
