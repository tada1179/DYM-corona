local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
local widget = require ("widget")
local menu_barLight = require ("menu_barLight")
local loadImageSprite = require ("downloadData").loadImageSprite_Victory_Warning3()
--local item1 = require ("item1")
---------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local pageTeam = nil
local pageItem = 1


local myItem
local user_id
local USERLV

local startbuttle
local backButton
local titleText
local mySlides = {}
--------------------
local user_id
local map_id
local mission_id
local mission_stamina
local chapter_id
local friend_id
local friendPoint
--------------------------------------------------------

function scene:createScene( event )
    local groupGameLayer = display.newGroup()
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
    mission_stamina = params.mission_stamina
    friend_id = params.friend_id
    friendPoint = params.friendPoint

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

--    storyboard.removeAll ()
--    storyboard.purgeAll()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "guest" )
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



