local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
----------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
storyboard.isDebug = true
local groupView = display.newGroup()

local background
local btnMapWater
local btnMapForest
local btnMapMountain
local user_id
------------------------------------
local function onMapRelease(event)

    menu_barLight = nil
--    display.remove(background)
--    background = nil
--    display.remove(btnMapWater)
--    btnMapWater = nil
--    display.remove(btnMapForest)
--    btnMapForest = nil
--    display.remove(btnMapMountain)
--    btnMapMountain = nil

    for i=groupView.numChildren,1,-1 do
        local child = groupView[i]
        child.parent:remove( child )
        child = nil
    end
    display.remove(groupView)
    groupView = nil

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
    if event.target.id == "water" then
        option.params.map_id = 1
       storyboard.gotoScene( "map_substate", option ) --game-scene

    elseif  event.target.id == "forest" then
        option.params.map_id = 2
        storyboard.gotoScene( "map_substate", option ) --game-scene

    elseif  event.target.id == "mountain" then
        option.params.map_id = 3
        storyboard.gotoScene( "map_substate", option ) --game-scene
    end
end

function scene:createScene( event)
    local group = self.view
    user_id = menu_barLight.user_id()
    local sizemenu = screenH*.1
    background = display.newImageRect("img_map", system.DocumentsDirectory,screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    btnMapWater = widget.newButton{
            default="img/map/water_dark.png",
            over="img/map/water_glow.png",
            width=screenW*.26, height=screenH*.187,
            onRelease = onMapRelease	-- event listener function
    }
    btnMapWater.id="water"
    btnMapWater:setReferencePoint( display.CenterReferencePoint )
    btnMapWater.x = screenW - (screenW*.63)
    btnMapWater.y =  screenH - (screenH*.323)

    btnMapForest = widget.newButton{
            default="img/map/forest_dark.png",
            over="img/map/forest_glow.png",
            width=screenW*.375, height=screenH*.233,
            onRelease = onMapRelease	-- event listener function
    }
    btnMapForest.id="forest"
    btnMapForest:setReferencePoint( display.CenterReferencePoint )
    btnMapForest.x = screenW - (screenW*.43)
    btnMapForest.y = screenH - (screenH*.273)

    btnMapMountain = widget.newButton{
            default="img/map/mountain_dark.png",
            over="img/map/mountain_glow.png",
            width=screenW*.43, height=screenH*.18,
            onRelease = onMapRelease	-- event listener function
    }
    btnMapMountain.id="mountain"
    btnMapMountain:setReferencePoint( display.CenterReferencePoint )
    btnMapMountain.x = screenW - (screenW*.46)
    btnMapMountain.y = screenH - (screenH*.458)

    groupView:insert(background)
    groupView:insert(btnMapMountain)
    groupView:insert(btnMapForest)
    groupView:insert(btnMapWater)

    groupView:insert(menu_barLight.newMenubutton())
    group:insert(groupView)


------------- other scene ---------------
    storyboard.removeAll ()
    storyboard.purgeAll()
    menu_barLight.checkMemory()
end

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    display.remove(groupView)
    groupView = nil
    storyboard.removeAll ()
    storyboard.purgeAll()
-----------------
end

function scene:destroyScene( event )
    local group = self.view

    display.remove(groupView)
    groupView = nil

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
    

--    
