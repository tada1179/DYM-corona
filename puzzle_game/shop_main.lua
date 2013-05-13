
-----------------------------------------------------------------------------------------
--
-- shop_main.lua
--
-- ##ref
--
-- Map
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"


--------- icon event -------------
local btnBattle
local btnTeam
local btnGacha
local btnShop
local btnCommu


local function onBtnRelease(event)
    if event.target.id == "battle" then
        print( "event: "..event.target.id)          
        storyboard.gotoScene( "map", "fade", 100 )        
    elseif  event.target.id == "team" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_main", "fade", 100 )
    elseif  event.target.id == "shop" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_main", "fade", 100 )
    elseif  event.target.id == "gacha" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "gacha_main", "fade", 100 )
    elseif  event.target.id == "commu" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "commu_main", "fade", 100 )
    end
--    storyboard.gotoScene( "title_page", "fade", 100 )	    
    return true	-- indicates successful touch
end

function scene:createScene( event )  
    print("--------------map_sub----------------")
    local group = self.view
     
    local background = display.newImageRect( "img/background/test2.jpg", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0     
    
    btnBattle = widget.newButton{			
            default="img/background/battle_light.png",
            over="img/background/battle_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnBattle.id="battle"
    btnBattle:setReferencePoint( display.CenterReferencePoint )
    btnBattle.x, btnBattle.y = 43, 432

    btnTeam = widget.newButton{			
            default="img/background/team_light.png",
            over="img/background/team_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnTeam.id="team"
    btnTeam:setReferencePoint( display.CenterReferencePoint )
    btnTeam.x, btnTeam.y = 100, 432
    
    btnShop = widget.newButton{			
            default="img/background/store_light.png",
            over="img/background/store_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnShop.id="shop"
    btnShop:setReferencePoint( display.CenterReferencePoint )
    btnShop.x, btnShop.y = 160, 432
    
    btnGacha = widget.newButton{			
            default="img/background/gacha_light.png",
            over="img/background/gacha_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnGacha.id="gacha"
    btnGacha:setReferencePoint( display.CenterReferencePoint )
    btnGacha.x, btnGacha.y = 218, 432
    
    btnCommu = widget.newButton{			
            default="img/background/commu_light.png",
            over="img/background/commu_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnCommu.id="commu"
    btnCommu:setReferencePoint( display.CenterReferencePoint )
    btnCommu.x, btnCommu.y = 275, 432
    
    
    group:insert(background) 
      
    group:insert(btnBattle)
    group:insert(btnCommu)
    group:insert(btnGacha)
    group:insert(btnShop)
    group:insert(btnTeam)  
    
------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "team_main" )
    storyboard.removeScene( "gacha_main" )
    storyboard.removeScene( "commu_main" )
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
