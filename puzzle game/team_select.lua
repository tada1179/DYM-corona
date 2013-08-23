local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
local widget = require ("widget")
local menu_barLight = require ("menu_barLight")
--local item1 = require ("item1")
---------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local pageTeam = nil
local pageItem = 1
local groupGameLayer = display.newGroup()

local myItem
local user_id
local USERLV

local startbuttle
local backButton
local background
local titleText
local mySlides = {}
--------------------
local user_id
local map_id
local mission_id
local chapter_id
local friend_id
--------------------------------------------------------

local function onbtnstartBattleBack(event)

    display.remove(titleText)
    titleText = nil
    display.remove(background)
    background = nil

    display.remove(backButton)
    backButton = nil

    display.remove(startbuttle)
    startbuttle = nil

    display.remove(mySlides)
    mySlides = nil
    display.remove(mySlides)
    mySlides = nil

    for i= groupGameLayer.numChildren,1,-1 do
        local child = groupGameLayer[i]
        child.parent:remove( child )
        child = nil
    end
    display.remove(groupGameLayer)
    groupGameLayer = nil


    if event.target.id == "back" then
        local option = {
            effect = "fade",
            time = 100,
            params =
            {

                mission_id = mission_id,
                chapter_id = chapter_id,
                map_id = map_id,
                user_id = user_id

            }
        }
         storyboard.gotoScene( "guest" ,option )

    elseif event.target.id == "startBattle" then
--       local option = require("character_scene").getTeamgetItem()
       local option = {
           effect = "fade",
           time = 100,
           params = {
               mission = "CODE KWANTA",
               battle = "1/5",

               -- 1 : ON
               -- 2 : OFF
               BGM = 1,
               SFX = 1,
               SKL = 1,
               BTN = 1,
               checkOption = 1,

               friend_id = friend_id,
               mission_id = mission_id,
               chapter_id = chapter_id,
               map_id = map_id,
               user_id = user_id

           }
       }
        storyboard.gotoScene( "puzzle" ,option )
--        storyboard.gotoScene( "map","fade", 100 )
    end
    return true
end

local function createBackButton(event)

    local image_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        overAlpha = .2,
        overScale = 1.1,
        width=screenW/10, height=screenH/21,
        onRelease = onbtnstartBattleBack	-- event listener function
    }
    backButton.id = "back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW *.15
    backButton.y = screenH *.3
    groupGameLayer:insert(backButton)

    local image_btnbuttle = "img/background/button/START_BATTLE.png"
    startbuttle = widget.newButton{
        default= image_btnbuttle,
        over= image_btnbuttle,
        width= screenW*.25, height= screenH*.05,
        onRelease = onbtnstartBattleBack
    }
    startbuttle.id = "startBattle"
    startbuttle:setReferencePoint( display.TopLeftReferencePoint )
    startbuttle.x = screenW *.6
    startbuttle.y = screenH *.3
    groupGameLayer:insert(startbuttle)
end

function scene:createScene( event )

    local image_text = "img/text/TEAM_SELECT.png"
    local group = self.view

    local params = event.params
    if params then
        if params.team_id == nil then
            pageTeam = 1
        end
        if params.item_id == nil then
            pageItem = 1
        end
    else
        if pageTeam == nil then
            pageTeam = 1
        end
        if pageItem == nil then
            pageItem = 1
        end
    end
    user_id = params.user_id
    chapter_id =  params.chapter_id
    map_id =  params.map_id
    mission_id = params.mission_id
    friend_id = params.friend_id

    background = display.newImageRect("img_back", system.DocumentsDirectory,screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    groupGameLayer:insert(background)

    titleText = display.newImageRect(image_text, screenW*.32, screenH*.028 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW *.43
    titleText.y = screenH /3.1
    groupGameLayer:insert(titleText)

    -- myItem = item1.newitem(user_id)

    USERLV = menu_barLight.userLevel()
    local teamNumber = math.floor(USERLV/10) + 1
    if teamNumber > 5 then
        teamNumber = 5
    end

    for i = 1,teamNumber,1 do
        mySlides[i] = "teamSelect"..i
    end

    groupGameLayer:insert( require("teamselectView").new(mySlides,nil, nil, nil ,pageTeam,pageItem,user_id,params))
    --createBackButton(event)
    groupGameLayer:insert(menu_barLight.newMenubutton())

    group:insert(groupGameLayer)
    -----------------------------------------
    menu_barLight.checkMemory()

    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view

    display.remove(groupGameLayer)
    groupGameLayer = nil

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



