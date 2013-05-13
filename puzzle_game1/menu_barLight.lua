--
-- Created by IntelliJ IDEA.
-- User: APPLE
-- Date: 4/29/13
-- Time: 8:53 AM
-- To change this template use File | Settings | File Templates.
--

module(..., package.seeall)
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local widget = require "widget"
--------- icon event -------------

local btnBattle
local btnTeam
local btnGacha
local btnShop
local btnCommu

 function newMenubutton()
     print("menu_barLight.lua")
     local group = display.newGroup()


     function onBtnnewMenuRelease(event)
         if event.target.id == "battle" then
             print( "event: "..event.target.id)
             storyboard.gotoScene( "map", "fade", 100 )
         elseif  event.target.id == "team" then
             print( "event: "..event.target.id)
             storyboard.gotoScene( "unit_main", "fade", 100 )
--             storyboard.gotoScene( "team_main", "fade", 100 )

         elseif  event.target.id == "shop" then
             print( "event: "..event.target.id)
             storyboard.gotoScene( "shop_main", "fade", 100 )

         elseif  event.target.id == "gacha" then
             print( "event: "..event.target.id)
             storyboard.gotoScene( "gacha", "fade", 100 )
         elseif  event.target.id == "commu" then
             print( "event: "..event.target.id)
             storyboard.gotoScene( "commu_main", "fade", 100 )
         end

         return true	-- indicates successful touch
     end
    local sizemenu = display.contentHeight*.1

    btnBattle = widget.newButton{
        default = "img/menu/battle_light.png",
        over = "img/menu/battle_dark.png",
        width= sizemenu ,
        height= sizemenu,
        onRelease = onBtnnewMenuRelease
    }
    btnBattle.id="battle"
    btnBattle:setReferencePoint( display.CenterReferencePoint )
    btnBattle.x =display.contentWidth-(display.contentWidth*.834)
    btnBattle.y =  display.contentHeight-(display.contentHeight*.112)

    btnTeam = widget.newButton{
        default="img/menu/team_light.png",
        over="img/menu/team_dark.png",
        width=sizemenu,
        height=sizemenu,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnTeam.id="team"
    btnTeam:setReferencePoint( display.CenterReferencePoint )
    btnTeam.x = display.contentWidth-(display.contentWidth*.667) -- 0.5 + .167
    btnTeam.y = display.contentHeight-(display.contentHeight*.112)

    btnShop = widget.newButton{
        default="img/menu/store_light.png",
        over="img/menu/store_dark.png",
        width=sizemenu, height=sizemenu,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnShop.id="shop"
    btnShop:setReferencePoint( display.CenterReferencePoint )
    btnShop.x = display.contentWidth-(display.contentWidth*.5)-- display center
    btnShop.y = display.contentHeight-(display.contentHeight*.112)

    btnGacha = widget.newButton{
        default="img/menu/gacha_light.png",
        over="img/menu/gacha_dark.png",
        width=sizemenu, height=sizemenu,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnGacha.id="gacha"
    btnGacha:setReferencePoint( display.CenterReferencePoint )
    btnGacha.x = display.contentWidth-(display.contentWidth*.333) -- 0.5 - .167
    btnGacha.y = display.contentHeight-(display.contentHeight*.112)

    btnCommu = widget.newButton{
        default="img/menu/commu_light.png",
        over="img/menu/commu_dark.png",
        width=sizemenu, height=sizemenu,
        onRelease = onBtnnewMenuRelease	-- event listener function
    }
    btnCommu.id="commu"
    btnCommu:setReferencePoint( display.CenterReferencePoint )
    btnCommu.x = display.contentWidth-(display.contentWidth*.166)
    btnCommu.y = display.contentHeight-(display.contentHeight*.112)

    group:insert(btnBattle)
    group:insert(btnTeam)
    group:insert(btnShop)
    group:insert(btnGacha)
    group:insert(btnCommu)

     return group
end
