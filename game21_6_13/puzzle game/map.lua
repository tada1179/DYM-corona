
print("map.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
----------------------------------------------------------------------


local menu_bar

local btnMapWater
local btnMapMountain
local btnMapForest
local gdisplay



local function onMapRelease(event)
    if event.target.id == "water" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map_substate", "fade", 100 ) --game-scene
--        storyboard.gotoScene( "misstion", "fade", 100 ) --game-scene

    elseif  event.target.id == "forest" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map_substate", "fade", 100 ) --game-scene
--        storyboard.gotoScene( "misstion", "fade", 100 )

    elseif  event.target.id == "mountain" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map_substate", "fade", 100 ) --game-scene
--        storyboard.gotoScene( "misstion", "fade", 100 )
    end
    return true	-- indicates successful touch
end


local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end

function scene:createScene( event)
    print("--------------map lua----------------")

    local group = self.view
    gdisplay = display.newGroup()
    local sizemenu = display.contentHeight*.1

    --local background = display.newImageRect( "img/background/as_frame_main_test_1.png", display.contentWidth, display.contentHeight )
    --local background = display.newImageRect( "img/background/2.jpg", display.contentWidth, display.contentHeight )
    local background = display.newImageRect( "img/background/MAP_Chinese-ornament-frame.jpg", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    btnMapWater = widget.newButton{
            default="img/map/water_dark.png",
            over="img/map/water_glow.png",
            width=display.contentWidth*.26, height=display.contentHeight*.187,
            onRelease = onMapRelease	-- event listener function
    }
    btnMapWater.id="water"
    btnMapWater:setReferencePoint( display.CenterReferencePoint )
    btnMapWater.x = display.contentWidth - (display.contentWidth*.63)
    btnMapWater.y =  display.contentHeight - (display.contentHeight*.323)

    btnMapForest = widget.newButton{
            default="img/map/forest_dark.png",
            over="img/map/forest_glow.png",
            width=display.contentWidth*.375, height=display.contentHeight*.233,
            onRelease = onMapRelease	-- event listener function
    }
    btnMapForest.id="forest"
    btnMapForest:setReferencePoint( display.CenterReferencePoint )
    btnMapForest.x = display.contentWidth - (display.contentWidth*.43)
    btnMapForest.y = display.contentHeight - (display.contentHeight*.273)

    btnMapMountain = widget.newButton{
            default="img/map/mountain_dark.png",
            over="img/map/mountain_glow.png",
            width=display.contentWidth*.43, height=display.contentHeight*.18,
            onRelease = onMapRelease	-- event listener function
    }
    btnMapMountain.id="mountain"
    btnMapMountain:setReferencePoint( display.CenterReferencePoint )
    btnMapMountain.x = display.contentWidth - (display.contentWidth*.46)
    btnMapMountain.y = display.contentHeight - (display.contentHeight*.458)

    group:insert(background)


    group:insert(btnMapMountain)
    group:insert(btnMapForest)
    group:insert(btnMapWater)
    menu_barLight = menu_barLight.newMenubutton()

    gdisplay:insert(menu_barLight)
    group:insert(gdisplay)


------------- other scene ---------------
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
     storyboard.removeScene( "team_main" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha" )
    storyboard.removeScene( "commu_main" )
    storyboard.removeScene( "team_item" )
end

function scene:enterScene( event )
    local group = self.view	
    print("scene: enter")
end

function scene:exitScene( event )
    local group = self.view     
     print("scene: exit")
     
--    btnMapWater.isVisible = false
--    btnMapMountain.isVisible = false
--    btnMapForest.isVisible = false
--    
--    if btnTeam then
--		btnTeam:removeSelf()	-- widgets must be manually removed
--		btnTeam = nil
--	end
--    btnBattle.isVisible = false
--   
--    btnGacha.isVisible = false
--    btnShop.isVisible = false
--    btnCommu.isVisible = false

-----------------   
end

function scene:destroyScene( event )
    local group = self.view   
  
    print("scene: destroy")
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
    

--    
