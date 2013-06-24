
print("team_select.lua")
display.setStatusBar( display.HiddenStatusBar )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()
local teamselectView = require("teamselectView")
local itemSelectView = require("itemSelectView")
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local character_scene = require ("character_scene")
local item1 = require ("item1")
local includeFN = require ("includeFunction")
---------------------------------------------------------

local screenW, screenH = display.contentWidth, display.contentHeight
local backButton
local startbuttle
local pageTeam = nil
local pageItem = 1

local function onbtnstartBattle(event)
    print("touch ID:"..event.target.id)
    if event.target.id == "back" then
        storyboard.gotoScene( previous_scene_name ,"fade", 100 )

    elseif event.target.id == "startBattle" then
        local option = character_scene.getTeamgetItem()
        print("startBattle team:",option.params.team_no,"Item;",option.params.item_no)
        storyboard.gotoScene( "game-scene" ,option )
        storyboard.removeScene( "team_select" )

    end
    return true
end

local function createBackButton(event)
    local image_btnback = "img/background/button/Button_BACK.png"
    local image_btnbuttle = "img/background/button/START_BATTLE.png"
    local params = event.params
    if params then
        print("params")
       if params.team_id == nil then
           pageTeam = 1
       end
       if params.item_id == nil then
           pageItem = 1
       end
    else
        print("else")
        if pageTeam == nil then
            pageTeam = 1
        end
        if pageItem == nil then
            pageItem = 1
        end
    end

    print("pageTeam",pageTeam,"pageItem",pageItem)


    backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onbtnstartBattle	-- event listener function
    }
    backButton.id = "back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)

    startbuttle = widget.newButton{
        default= image_btnbuttle,
        over= image_btnbuttle,
        width= screenW*.25, height= screenH*.05,
        onRelease = onbtnstartBattle
    }
    startbuttle.id = "startBattle"
    startbuttle:setReferencePoint( display.TopLeftReferencePoint )
    startbuttle.x = screenW *.6
    startbuttle.y = screenH - (screenH *.7)
end


function scene:createScene( event )
    local image_text = "img/text/TEAM_SELECT.png"
    local image_background = "img/background/background_1.jpg"
    local group = self.view
    local groupGameLayer = display.newGroup()
    local gdisplay = display.newGroup()
    local myItem
    local mySlides
   local user_id = includeFN.USERIDPhone()

    local background = display.newImageRect(image_background, screenW, screenH, true)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local titleText = display.newImageRect(image_text, display.contentWidth*.32, display.contentHeight*.028 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth *.43
    titleText.y = display.contentHeight /3.1
    group:insert(background)

    createBackButton(event)
    myItem = item1.newitem(user_id)

    mySlides = {
        "teamSelect1",
        "teamSelect2",
        "teamSelect3",
        "teamSelect4",
        "teamSelect5",
    }
    teamselectView = teamselectView.new(mySlides,nil, nil, nil ,pageTeam,pageItem)
    groupGameLayer:insert(teamselectView)
    groupGameLayer:insert(myItem)



    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(groupGameLayer)
    group:insert(backButton)
    group:insert(startbuttle)
    group:insert(titleText)
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



