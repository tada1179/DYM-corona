
print("team_main.lua")
display.setStatusBar( display.HiddenStatusBar )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local teamView = require("teamView")
local widget = require "widget"
local menu_barLight = require ("menu_barLight")


local screenW, screenH = display.contentWidth, display.contentHeight
local image_background = "img/background/background_1.png"
--local image_background = "img/background/team/TEMPLATE.jpg"
local image_background2 = "img/background/background_2.png"
local image_btnback = "img/background/button/Button_BACK.png"
local image_text = "img/text/TEAM_SETTING.png"
local backButton


local function BackRelease(event)
    if event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "guest" ,"fade", 100 )
    end
    return true	-- indicates successful touch
end

local function createBackButton()
    backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = BackRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
end

local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
function scene:createScene( event )

    local group = self.view
    local groupGameLayer = display.newGroup()
    local gdisplay = display.newGroup()

    local background = display.newImageRect(image_background, screenW, screenH, true)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local background2 = display.newImageRect(image_background2, screenW, screenH, true)
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0

    local titleText = display.newImageRect(image_text, display.contentWidth/3, display.contentHeight/35 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    group:insert(background)


    createBackButton()

    local mySlides = {
        "team1",
        "team2",
        "team3",
        "team4",
        "team5",
    }

    teamView = teamView.new(mySlides )
    groupGameLayer:insert(teamView)

    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)


    group:insert(groupGameLayer)
    group:insert(backButton)
    group:insert(titleText)
    group:insert(background2)
    group:insert(gdisplay)
    ----------------------

    storyboard.removeScene( "map" )
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha" )
    storyboard.removeScene( "commu_main" )
    checkMemory()
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



