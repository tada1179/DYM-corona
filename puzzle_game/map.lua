
-----------------------------------------------------------------------------------------
--
-- map.lua
--
-- ##ref
--
-- Map
print("map.lua")
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"


--------- storyboard event -------------
--local effect1 =
--{
--    effect = "fade",
--    time = 1500,
--    params = { var1 = "custom", myVar = "another" }
--}

--------- icon event -------------
local btnBattle
local btnTeam
local btnGacha
local btnShop
local btnCommu

local btnMapWater
local btnMapMountain
local btnMapForest

local function onMapRelease(event)
    if event.target.id == "battle" then

        print( "event: "..event.target.id)          
       -- storyboard.gotoScene( "map", "fade", 100 )
        storyboard.gotoScene( "game-scene", "fade", 100 ) --game-scene

    elseif  event.target.id == "team" then

        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_main", "fade", 100 )

    elseif  event.target.id == "shop" then

        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_main", "fade", 100 )

    elseif  event.target.id == "gacha" then

        print( "event: "..event.target.id)
        --storyboard.gotoScene( "gacha_main", "fade", 100 )
        storyboard.gotoScene( "gacha", "fade", 100 )

    elseif  event.target.id == "commu" then

        print( "event: "..event.target.id)
        storyboard.gotoScene( "commu_main", "fade", 100 )

    end
--    storyboard.gotoScene( "title_page", "fade", 100 )	    
    return true	-- indicates successful touch
end


local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
--timer.performWithDelay( 5000, checkMemory, 0 )

--checkMemory()---- chk memory use


function scene:createScene( event)
    print("--------------map----------------")
    local group = self.view
    local sizemenu = display.contentHeight*.1
    --local background = display.newImageRect( "img/background/as_frame_main_test_1.png", display.contentWidth, display.contentHeight )
    --local background = display.newImageRect( "img/background/2.jpg", display.contentWidth, display.contentHeight )
    local background = display.newImageRect( "img/background/MAP_Chinese-ornament-frame.jpg", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    btnMapMountain=display.newImageRect( "img/background/mountain_dark.png",display.contentWidth*.43, display.contentHeight*.18 )
    btnMapMountain.id='mountain'
    btnMapMountain.x = display.contentWidth - (display.contentWidth*.46)
    btnMapMountain.y = display.contentHeight - (display.contentHeight*.458)

    btnMapForest=display.newImageRect( "img/background/forest_dark.png",display.contentWidth*.375, display.contentHeight*.233 )
    btnMapForest.id='forest'
    btnMapForest.x = display.contentWidth - (display.contentWidth*.43)

    btnMapForest.y = display.contentHeight - (display.contentHeight*.273)

    btnMapWater=display.newImageRect( "img/background/water_dark.png",display.contentWidth*.26, display.contentHeight*.187 )
    btnMapWater.id='water'
    btnMapWater.x = display.contentWidth - (display.contentWidth*.63)
    btnMapWater.y = display.contentHeight - (display.contentHeight*.323)

    btnBattle = widget.newButton{			
            default="img/menu/battle_light.png",
            over="img/menu/battle_dark.png",
            width=sizemenu, height=sizemenu,
            onRelease = onMapRelease	-- event listener function
    }
    btnBattle.id="battle"
    btnBattle:setReferencePoint( display.CenterReferencePoint )
    btnBattle.x =display.contentWidth-(display.contentWidth*.834)
    btnBattle.y =  display.contentHeight-(display.contentHeight*.112)

    btnTeam = widget.newButton{			
            default="img/menu/team_light.png",
            over="img/menu/team_dark.png",
            width=sizemenu, height=sizemenu,
            onRelease = onMapRelease	-- event listener function
    }
    btnTeam.id="team"
    btnTeam:setReferencePoint( display.CenterReferencePoint )
    btnTeam.x = display.contentWidth-(display.contentWidth*.667) -- 0.5 + .167
    btnTeam.y = display.contentHeight-(display.contentHeight*.112)
    
    btnShop = widget.newButton{			
            default="img/menu/store_light.png",
            over="img/menu/store_dark.png",
            width=sizemenu, height=sizemenu,
            onRelease = onMapRelease	-- event listener function
    }
    btnShop.id="shop"
    btnShop:setReferencePoint( display.CenterReferencePoint )
    btnShop.x = display.contentWidth-(display.contentWidth*.5)-- display center
    btnShop.y = display.contentHeight-(display.contentHeight*.112)
    
    btnGacha = widget.newButton{			
            default="img/menu/gacha_light.png",
            over="img/menu/gacha_dark.png",
            width=sizemenu, height=sizemenu,
            onRelease = onMapRelease	-- event listener function
    }
    btnGacha.id="gacha"
    btnGacha:setReferencePoint( display.CenterReferencePoint )
    btnGacha.x = display.contentWidth-(display.contentWidth*.333) -- 0.5 - .167
    btnGacha.y = display.contentHeight-(display.contentHeight*.112)
    
    btnCommu = widget.newButton{			
            default="img/menu/commu_light.png",
            over="img/menu/commu_dark.png",
            width=sizemenu, height=sizemenu,
            onRelease = onMapRelease	-- event listener function
    }
    btnCommu.id="commu"
    btnCommu:setReferencePoint( display.CenterReferencePoint )
    btnCommu.x = display.contentWidth-(display.contentWidth*.166)
    btnCommu.y = display.contentHeight-(display.contentHeight*.112)
    
    group:insert(background)   
    group:insert(btnMapMountain)
    group:insert(btnMapForest)
    group:insert(btnMapWater)
    
    group:insert(btnBattle)
    group:insert(btnCommu)
    group:insert(btnGacha)
    group:insert(btnShop)
    group:insert(btnTeam)

    local function onStartTouch(event)
        local phase = event.phase

        if event.phase == "began" then

            print( "event began: ".. event.target.id )
            if event.target.id=="water" then               
                btnMapWater=display.newImageRect( "img/background/water_glow.png",display.contentWidth*.26, display.contentHeight*.187 )
                btnMapWater.x = display.contentWidth - (display.contentWidth*.63)
                btnMapWater.y = display.contentHeight - (display.contentHeight*.323)

                timer.performWithDelay( 300, function() btnMapWater:removeSelf()  end, 1 )
            elseif event.target.id=="mountain" then
                btnMapMountain=display.newImageRect( "img/background/mountain_glow.png",display.contentWidth*.43, display.contentHeight*.18 )
                btnMapMountain.x = display.contentWidth - (display.contentWidth*.46)
                btnMapMountain.y = display.contentHeight - (display.contentHeight*.458)

               timer.performWithDelay( 300, function() btnMapMountain:removeSelf() end, 1 )
            elseif event.target.id=="forest" then
                btnMapForest=display.newImageRect( "img/background/forest_glow.png",display.contentWidth*.375, display.contentHeight*.233 )
                btnMapForest.x = display.contentWidth - (display.contentWidth*.43)

                btnMapForest.y = display.contentHeight - (display.contentHeight*.273)

                timer.performWithDelay( 300, function() btnMapForest:removeSelf() end, 1 )
            end

            self = event.target.id
            display.getCurrentStage():setFocus( self )
            self.isFocus = true

        elseif self.isFocus  then
            print("set fuscus")
            if( phase == "ended" or phase == "Release" ) then
                -- reset touch focus
                  timer.performWithDelay( 500, function()
                      storyboard.gotoScene( "map_substate", "crossFade", 500 )  --  goto map_substate
                  end, 1 )

                  print( "event moded: ".. event.target.id )

            end
            display.getCurrentStage():setFocus( nil )
            self.isFocus = false
        end
            timer.performWithDelay( 500, function()
              storyboard.gotoScene( "map_substate", "crossFade", 500 )  --  goto map_substate
        end, 1 )
    end   --


    btnMapWater:addEventListener( "touch", onStartTouch ) -- touch togo map kingdoms
    btnMapMountain:addEventListener( "touch", onStartTouch ) -- touch togo map kingdoms
    btnMapForest:addEventListener( "touch", onStartTouch ) -- touch togo map kingdoms
    
------------- other scene ---------------
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
     storyboard.removeScene( "team_main" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha_main" )
    storyboard.removeScene( "commu_main" )
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
    




     
--    btnMapWater = widget.newButton{			
--            default="img/background/water_dark.png",
--            over="img/background/water_glow.png",
--            width=100, height=100,
--            onRelease = onPlayBtnRelease	-- event listener function
--    }
--    btnMapWater:setReferencePoint( display.CenterReferencePoint )
--    btnMapWater.x, btnMapWater.y = 118, 300
--	btnMapWater.x = display.contentWidth*0.5
--	btnMapWater.y = display.contentHeight - 125
--    
