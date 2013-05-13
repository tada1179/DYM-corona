
-----------------------------------------------------------------------------------------
--
-- commu_main.lua
--
-- ##ref
--
-- Map
print("commu_main")
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")

local screenW, screenH = display.contentWidth, display.contentHeight
local image_background = "img/background/background_1.png"
--local image_background2 = "img/background/community/TEMPLATE.jpg"
local image_background2 = "img/background/background_2.png"

local image_text = "img/text/COMMUNITY.png"
local image_friend = "img/background/community/FRIEND_LIST.png"
local image_player = "img/background/community/PLAYERS_ID.png"
local image_request = "img/background/community/REQUEST_LIST.png"

local backButton

local btnfriend
local btnplayer
local btnrequest

local function onBtnRelease(event)
 if  event.target.id == "friend" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "friend_list", "fade", 100 )

    elseif  event.target.id == "player" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "player_list", "fade", 100 )

    elseif  event.target.id == "request" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "request_list", "fade", 100 )
    end

    return true	-- indicates successful touch
end

local function BackRelease(event)
    if event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "guest" ,"fade", 100 )
    end
    return true	-- indicates successful touch
end

local function createBackButton()
    backButton = widget.newButton{
        default="img/background/button/Button_BACK.png",
        over="img/background/button/Button_BACK.png",
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = BackRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
end

local function list_community()

    local sizemenuH = display.contentHeight *.08
    local sizemenuW = display.contentWidth *.4

    btnfriend = widget.newButton{
        default = image_friend,
        over = image_friend,
        width= sizemenuW ,
        height= sizemenuH,
        onRelease = onBtnRelease
    }
    btnfriend.id="friend"
    btnfriend:setReferencePoint( display.CenterReferencePoint )
    btnfriend.x = display.contentWidth *.5
    btnfriend.y =  display.contentHeight *.41

    btnplayer = widget.newButton{
        default = image_player,
        over = image_player,
        width= sizemenuW ,
        height= sizemenuH,
        onRelease = onBtnRelease
    }
    btnplayer.id="player"
    btnplayer:setReferencePoint( display.CenterReferencePoint )
    btnplayer.x = display.contentWidth *.5
    btnplayer.y =  display.contentHeight *.5

    btnrequest = widget.newButton{
        default = image_request,
        over = image_request,
        width= sizemenuW ,
        height= sizemenuH,
        onRelease = onBtnRelease
    }
    btnrequest.id="request"
    btnrequest:setReferencePoint( display.CenterReferencePoint )
    btnrequest.x = display.contentWidth *.5
    btnrequest.y =  display.contentHeight *.59
end


function scene:createScene( event )  
    print("--------------commu_main createScene ----------------")
    local group = self.view
    local gdisplay = display.newGroup()
    local background = display.newImageRect( image_background, screenW, screenH )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local background2 = display.newImageRect( image_background2, screenW, screenH )
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0

    local titleText = display.newImageRect( image_text, display.contentWidth/3.5, display.contentHeight/33 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    createBackButton()
    list_community()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)


    group:insert(background)
    group:insert(background2)
    group:insert(titleText)
    group:insert(btnfriend)
    group:insert(btnplayer)
    group:insert(btnrequest)

    group:insert(backButton)
    group:insert(gdisplay)

------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha_main" )
    storyboard.removeScene( "team_main" )
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
