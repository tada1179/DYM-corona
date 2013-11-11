
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
    local group = self.view

    
    btnBattle = widget.newButton{			
            defaultFile="img/background/battle_light.png",
            overFile="img/background/battle_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnBattle.id="battle"
    btnBattle:setReferencePoint( display.CenterReferencePoint )
    btnBattle.x, btnBattle.y = 43, 432

    btnTeam = widget.newButton{			
            defaultFile="img/background/team_light.png",
            overFile="img/background/team_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnTeam.id="team"
    btnTeam:setReferencePoint( display.CenterReferencePoint )
    btnTeam.x, btnTeam.y = 100, 432
    
    btnShop = widget.newButton{			
            defaultFile="img/background/store_light.png",
            overFile="img/background/store_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnShop.id="shop"
    btnShop:setReferencePoint( display.CenterReferencePoint )
    btnShop.x, btnShop.y = 160, 432
    
    btnGacha = widget.newButton{			
            defaultFile="img/background/gacha_light.png",
            overFile="img/background/gacha_dark.png",
            width=53, height=53,
            onRelease = onBtnRelease	-- event listener function
    }
    btnGacha.id="gacha"
    btnGacha:setReferencePoint( display.CenterReferencePoint )
    btnGacha.x, btnGacha.y = 218, 432
    
    btnCommu = widget.newButton{			
            defaultFile="img/background/commu_light.png",
            overFile="img/background/commu_dark.png",
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
    storyboard.removeAll ()
end

function scene:enterScene( event )
    local group = self.view	
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
