
-----------------------------------------------------------------------------------------
--
-- team_main.lua
--
-- ##ref
--
-- Map
-----------------------------------------------------------------------------------------
print("team_main.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"

--------- icon event -------------
local btnBattle
local btnTeam
local btnGacha
local btnShop
local btnCommu
local leader1
local leader2
local leader3
local leader4
local leader5
local backButton
local character

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
        storyboard.gotoScene( "gacha", "fade", 100 )
    elseif  event.target.id == "commu" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "commu_main", "fade", 100 )


    elseif event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "guest" ,"fade", 100 )
    end
--    storyboard.gotoScene( "title_page", "fade", 100 )	    
    return true	-- indicates successful touch
end
local function checkMemory()
collectgarbage( "collect" )
local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end

local function selectLeader(event)
    if event.target.id == "leader1" then
        print("event: "..event.target.id)
        storyboard.gotoScene( "team_item", "fade", 100 )
    elseif event.target.id == "leader2" then

        print("event: "..event.target.id)
        storyboard.gotoScene( "team_item", "fade", 100 )
    elseif event.target.id == "leader3" then

        print("event: "..event.target.id)
        storyboard.gotoScene( "team_item", "fade", 100 )
    elseif event.target.id == "leader4" then

        print("event: "..event.target.id)
        storyboard.gotoScene( "team_item", "fade", 100 )
    elseif event.target.id == "leader5" then

        print("event: "..event.target.id)
        storyboard.gotoScene( "team_item", "fade", 100 )
    end

end

local function createLEADER()
    print("---createLEADER----")
    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09
    --960*.1 = 96 size image = 96*96
    leader1 = widget.newButton{
        default = "img/background/FRAME_LAYOUT_13.png",
        over = "img/background/FRAME_LAYOUT_13.png",
        width= sizeleaderW ,
        height= sizeleaderH,
        onRelease = selectLeader
    }
    leader1.id="leader1"
    leader1:setReferencePoint( display.CenterReferencePoint )
    leader1.x =display.contentWidth-(display.contentWidth*.825)
    leader1.y =  display.contentHeight-(display.contentHeight*.532)

    leader2 = widget.newButton{
        default = "img/background/FRAME_LAYOUT_13.png",
        over = "img/background/FRAME_LAYOUT_13.png",
        width= sizeleaderW ,
        height= sizeleaderH,
        onRelease = selectLeader
    }
    leader2.id="leader2"
    leader2:setReferencePoint( display.CenterReferencePoint )
    leader2.x =display.contentWidth-(display.contentWidth*.61)
    leader2.y =  display.contentHeight-(display.contentHeight*.532)

    leader3 = widget.newButton{
        default = "img/background/FRAME_LAYOUT_13.png",
        over = "img/background/FRAME_LAYOUT_13.png",
        width= sizeleaderW ,
        height= sizeleaderH,
        onRelease = selectLeader
    }
    leader3.id="leader3"
    leader3:setReferencePoint( display.CenterReferencePoint )
    leader3.x =display.contentWidth-(display.contentWidth*.465)
    leader3.y =  display.contentHeight-(display.contentHeight*.532)

    leader4 = widget.newButton{
        default = "img/background/FRAME_LAYOUT_13.png",
        over = "img/background/FRAME_LAYOUT_13.png",
        width= sizeleaderW ,
        height= sizeleaderH,
        onRelease = selectLeader
    }
    leader4.id="leader4"
    leader4:setReferencePoint( display.CenterReferencePoint )
    leader4.x =display.contentWidth-(display.contentWidth*.32)
    leader4.y =  display.contentHeight-(display.contentHeight*.532)

    leader5 = widget.newButton{
        default = "img/background/FRAME_LAYOUT_13.png",
        over = "img/background/FRAME_LAYOUT_13.png",
        width= sizeleaderW ,
        height= sizeleaderH,
        onRelease = selectLeader
    }
    leader5.id="leader5"
    leader5:setReferencePoint( display.CenterReferencePoint )
    leader5.x =display.contentWidth-(display.contentWidth*.175)
    leader5.y =  display.contentHeight-(display.contentHeight*.532)



end

local function createMENU()
    local sizemenu = display.contentHeight*.1
    btnBattle = widget.newButton{
        default = "img/menu/battle_dark.png",
        over = "img/menu/battle_light.png",
        width= sizemenu ,
        height= sizemenu,
        onRelease = onBtnRelease
    }
    btnBattle.id="battle"
    btnBattle:setReferencePoint( display.CenterReferencePoint )
    btnBattle.x =display.contentWidth-(display.contentWidth*.834)
    btnBattle.y =  display.contentHeight-(display.contentHeight*.112)

    btnTeam = widget.newButton{
        default="img/menu/team_dark.png",
        over="img/menu/team_light.png",
        width=sizemenu,
        height=sizemenu,
        onRelease = onBtnRelease	-- event listener function
    }
    btnTeam.id="team"
    btnTeam:setReferencePoint( display.CenterReferencePoint )
    btnTeam.x = display.contentWidth-(display.contentWidth*.667) -- 0.5 + .167
    btnTeam.y = display.contentHeight-(display.contentHeight*.112)

    btnShop = widget.newButton{
        default="img/menu/store_dark.png",
        over="img/menu/store_light.png",
        width=sizemenu, height=sizemenu,
        onRelease = onBtnRelease	-- event listener function
    }
    btnShop.id="shop"
    btnShop:setReferencePoint( display.CenterReferencePoint )
    btnShop.x = display.contentWidth-(display.contentWidth*.5)-- display center
    btnShop.y = display.contentHeight-(display.contentHeight*.112)

    btnGacha = widget.newButton{
        default="img/menu/gacha_dark.png",
        over="img/menu/gacha_light.png",
        width=sizemenu, height=sizemenu,
        onRelease = onBtnRelease	-- event listener function
    }
    btnGacha.id="gacha"
    btnGacha:setReferencePoint( display.CenterReferencePoint )
    btnGacha.x = display.contentWidth-(display.contentWidth*.333) -- 0.5 - .167
    btnGacha.y = display.contentHeight-(display.contentHeight*.112)

    btnCommu = widget.newButton{
        default="img/menu/commu_dark.png",
        over="img/menu/commu_light.png",
        width=sizemenu, height=sizemenu,
        onRelease = onBtnRelease	-- event listener function
    }
    btnCommu.id="commu"
    btnCommu:setReferencePoint( display.CenterReferencePoint )
    btnCommu.x = display.contentWidth-(display.contentWidth*.166)
    btnCommu.y = display.contentHeight-(display.contentHeight*.112)

end

local function createBackButton()
    backButton = widget.newButton{
        default="img/background/button/Button_BACK.png",
        over="img/background/button/Button_BACK.png",
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
end



function scene:createScene( event )  
    print("--------------map_sub11111----------------")
    local group = self.view
    checkMemory()
--    local background = display.newImageRect( "img/background//team/TEMPLATE.jpg", display.contentWidth, display.contentHeight )
    local background = display.newImageRect( "img/background/background_1.png", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local background2 = display.newImageRect( "img/background/background_2.png", display.contentWidth, display.contentHeight )
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0

    local titleText = display.newImageRect( "img/text/TEAM_SELECT.png", display.contentWidth/3, display.contentHeight/35 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    createLEADER()
    createMENU()
    createBackButton()

    group:insert(background)
    group:insert(leader5)
    group:insert(leader4)
    group:insert(leader3)
    group:insert(leader2)
    group:insert(leader1)
    group:insert(backButton)
    group:insert(titleText)
    group:insert(background2)


    group:insert(btnBattle)
    group:insert(btnCommu)
    group:insert(btnGacha)
    group:insert(btnShop)
    group:insert(btnTeam)


   local function onStartTouch(event)
        print("touch began")
        if event.phase == "began" then
            print("touch began")
        elseif( event.phase == "move" ) then
            print("touch move")
        elseif( event.phase == "ended" or event.phase == "Release" ) then
            print("touch ended")
        end
    end



------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "shop_main" )
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
