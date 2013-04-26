
-----------------------------------------------------------------------------------------
--
-- team_main.lua
--
-- ##ref
--
-- Map
-----------------------------------------------------------------------------------------
print("character.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

--------- icon event -------------
local btnBattle
local btnTeam
local btnGacha
local btnShop
local btnCommu
local imageprofile
local backButton

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

    -- back button
    elseif event.target.id == "back" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_item" ,"fade", 100 )

    -- back image profile
    elseif event.target.id == "imageprofile" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "characterprofile" ,"fade", 100 )
    end
    return true
end
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
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


local function createButton()
    --button BACK
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

    --button image profile
    imageprofile = widget.newButton{
        default="img/background/character/FRAME_LAYOUT.png",
        over="img/background/character/FRAME_LAYOUT.png",
        width=viewableScreenW/3.23, height=viewableScreenH/4.5,
        onRelease = onBtnRelease	-- event listener function
    }
    imageprofile.id="imageprofile"
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x = viewableScreenW/2.65
    imageprofile.y = viewableScreenH/2.24

end



function scene:createScene( event )
    print("--------------map_sub----------------")
    local group = self.view
    checkMemory()


    local background = display.newImageRect( "img/background/character/character.jpg", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local titleText = display.newImageRect( "img/text/CHARACTER.png", display.contentWidth/3.5, display.contentHeight/33 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    createMENU()
    createButton()
    group:insert(background)
    group:insert(imageprofile)
    group:insert(backButton)
    group:insert(titleText)

    group:insert(btnBattle)
    group:insert(btnCommu)
    group:insert(btnGacha)
    group:insert(btnShop)
    group:insert(btnTeam)

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
