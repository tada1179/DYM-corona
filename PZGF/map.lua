local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu")

----------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local user_id

local timers = {}
local transitionStash = {}
local dataTable = {}
local map = nil
local chapter = 0
local img_MAP = "img/background/MAP_olySize.png"
local img_Ribbon = "img/background/Ribbon.png"

local groupScene
------------------------------------
local function onMapRelease(event)
    menu_barLight.SEtouchButton()
    if timers.gameTimerUpdate then
        timer.cancel(timers.gameTimerUpdate)
        timers.gameTimerUpdate = nil
    end
    if transitionStash.clearCharacter then
        transition.cancel(transitionStash.clearCharacter )
        transitionStash.clearCharacter = nil
    end

    local map_id
    local option = {
        effect = "fade",
        time = 100,
        params =
        {
          map_id = 0,
            user_id = user_id

        }
    }
    if event.target.id == "water" and chapter >= 2 then
        option.params.map_id = 2
       storyboard.gotoScene( "map_substate", option ) --game-scene

    elseif  event.target.id == "forest" and chapter >= 1 then
        option.params.map_id = 1
        storyboard.gotoScene( "map_substate", option ) --game-scene

    elseif  event.target.id == "mountain" and chapter >= 3 then
        option.params.map_id = 3
        storyboard.gotoScene( "map_substate", option ) --game-scene

    elseif  event.target.id == "bunus" and chapter >= 7 then
        option.params.map_id = 4
        storyboard.gotoScene( "map_substate", option ) --game-scene
    end
end
local function loadmap()

    local count = 1
    local max = 1
     local maxChapter = 0
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )
    for max in db:urows ("SELECT * FROM MapSubstates ;") do maxChapter = max end
    for x in db:nrows("SELECT * FROM MapSubstates;") do
        dataTable[count] = {}
        dataTable[count].chapter_mission_run = x.chapter_mission_run
        dataTable[count].chapter_name = x.chapter_name
        dataTable[count].chapter_id   = tonumber(x.chapter_id)
        dataTable[count].mission_id   = x.mission_id
        dataTable[count].ID_status    = x.ID_status
        dataTable[count].map_id       = tonumber(x.map_id)
        if dataTable[count].ID_status == "new" then
            map = dataTable[count].map_id
            chapter = dataTable[count].chapter_id
        end
        count = count + 1
    end

    db:close()

end
function scene:createScene( event)
    groupScene = display.newGroup()
    local group = self.view

    user_id = menu_barLight.user_id()
    loadmap()
    menu_barLight.CountStamina()
   groupScene:insert(background)

    local backgroundmap = display.newImageRect("img/background/MAP_Chinese-ornament-frame.png",screenW,screenH)
    backgroundmap:setReferencePoint( display.TopLeftReferencePoint )
    backgroundmap.x, backgroundmap.y = 0, 0
    --    local backgroundmap = display.newImage(img_MAP)
--    backgroundmap:setReferencePoint( display.BottomCenterReferencePoint )
--    backgroundmap.x, backgroundmap.y = screenW*.5, screenH + screenH*.008

    local btnMapWater = widget.newButton{
            defaultFile="img/map/water_dark.png",
            overFile="img/map/water_glow.png",
            width=screenW*.26, height=screenH*.187,
            onRelease = onMapRelease	-- event listener function
    }
    btnMapWater.id="water"  --2
    btnMapWater:setReferencePoint( display.CenterReferencePoint )
    btnMapWater.x = screenW - (screenW*.63)
    btnMapWater.y =  screenH - (screenH*.322)

    local btnMapForest = widget.newButton{
            defaultFile="img/map/forest_dark.png",
            overFile="img/map/forest_glow.png",
            width=screenW*.375, height=screenH*.233,
            onRelease = onMapRelease	-- event listener function
    }
    btnMapForest.id="forest"  --1
    btnMapForest:setReferencePoint( display.CenterReferencePoint )
    btnMapForest.x = screenW - (screenW*.43)
    btnMapForest.y = screenH - (screenH*.273)

    local btnMapMountain = widget.newButton{
            defaultFile="img/map/mountain_dark.png",
            overFile="img/map/mountain_glow.png",
            width=screenW*.43, height=screenH*.18,
            onRelease = onMapRelease	-- event listener function
    }
    btnMapMountain.id="mountain"  --3
    btnMapMountain:setReferencePoint( display.CenterReferencePoint )
    btnMapMountain.x = screenW - (screenW*.46)
    btnMapMountain.y = screenH - (screenH*.458)

    local btnMapBonus = widget.newButton{
        defaultFile="img/map/bunus.png",
        overFile="img/map/bunusImg_glow.png",
        width=screenW*.14, height=screenH*.19,
        onRelease = onMapRelease	-- event listener function
    }
    btnMapBonus.id="bunus"  --4
    btnMapBonus:setReferencePoint( display.CenterReferencePoint )
    btnMapBonus.x = screenW*.38
    btnMapBonus.y = screenH*.385

    local Ribbon = display.newImage(img_Ribbon)
    Ribbon:setReferencePoint( display.CenterReferencePoint )
    if map == 1 then --forest
        Ribbon.x = btnMapForest.x + screenW*.05
        Ribbon.y = btnMapForest.y - screenH * .01
    elseif map == 2 then --water
        Ribbon.x = btnMapWater.x  + screenW*.01
        Ribbon.y = btnMapWater.y + screenH * .02
    elseif map == 3 then
        Ribbon.x = btnMapMountain.x  + screenW*.02
        Ribbon.y = btnMapMountain.y + screenH * .02
    else  --bonus
        Ribbon.x = btnMapBonus.x
        Ribbon.y = btnMapBonus.y + screenH*.05
    end

    local timerText2 = function()
        transitionStash.clearCharacter = transition.to(Ribbon, { time=1000, alpha=.5} )
    end
    local timerText = function()
        transitionStash.clearCharacter = transition.to(Ribbon, { time=1000,alpha=1,onComplete = timerText2} )
    end

    timers.gameTimerUpdate = timer.performWithDelay(1000, timerText, 0)

    groupScene:insert(backgroundmap)
    groupScene:insert(btnMapMountain)
    groupScene:insert(btnMapForest)
    groupScene:insert(btnMapWater)
    groupScene:insert(btnMapBonus)
    groupScene:insert(Ribbon)
    group:insert(groupScene)

    local slot = menu_barLight.slot()
    local HoldcharacterAll = menu_barLight.HoldcharacterAll()
    if slot >= HoldcharacterAll then
        storyboard.gotoScene( "map" ,"fade", 100 )
    else
        require ("alertMassage").NoHaveSlot("map")
    end
------------- other scene ---------------
--    storyboard.removeAll ()
--    storyboard.purgeAll()
    menu_barLight.checkMemory()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "map_substate" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    storyboard.removeAll ()
    storyboard.purgeAll()
-----------------
end

function scene:destroyScene( event )
    local group = self.view


end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
    

--    
