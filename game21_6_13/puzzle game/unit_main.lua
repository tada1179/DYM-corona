--
print("unit_main")

local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")


local btnTeam
local btnPower
local btnUpgrade
local btnDischarge
local btnItem
local btnBox

local function onRelistMenu(event)
    if event.target.id == "BOX" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map", "fade", 100 )

    elseif event.target.id == "team" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_main", "fade", 100 )

    elseif event.target.id == "power" then
        print( "event: "..event.target.id)
--        storyboard.gotoScene( "power_up_main", "fade", 100 )
        storyboard.gotoScene( "characterAll", "fade", 100 )

    elseif event.target.id == "upgrade" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "upgrade_main", "fade", 100 )

    elseif event.target.id == "discharge" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "discharge_main", "fade", 100 )

    elseif event.target.id == "item" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "item_setting", "fade", 100 )

    end
    return true
end

local function listMenu()
    local img_team = "img/background/unit/button/TEAM_SETTING.png"
    local img_power = "img/background/unit/button/POWER_UP.png"
    local img_upgrade = "img/background/unit/button/UPGRADE.png"
    local img_dischar = "img/background/unit/button/DISCHARGE.png"
    local img_item = "img/background/unit/button/ITEM_SETTING.png"
    local img_box = "img/background/button/BOX.png"

    btnBox = widget.newButton{
        default=img_box,
        over=img_box,
        width=display.contentWidth/8.5, height=display.contentHeight/22.5,
        onRelease = onRelistMenu	-- event listener function
    }
    btnBox.id="BOX"
    btnBox:setReferencePoint( display.TopLeftReferencePoint )
    btnBox.x = display.contentWidth - (display.contentWidth *.365)
    btnBox.y = display.contentHeight - (display.contentHeight *.695)

    btnTeam = widget.newButton{
        default= img_team,
        over = img_team,
        width=display.contentWidth*.47, height=display.contentHeight*.06,
        onRelease = onRelistMenu	-- event listener function
    }
    btnTeam.id="team"
    btnTeam:setReferencePoint( display.CenterReferencePoint )
    btnTeam.x = display.contentWidth *.5
    btnTeam.y = display.contentHeight *.4

    btnPower = widget.newButton{
        default= img_power,
        over= img_power,
        width=display.contentWidth*.47, height=display.contentHeight*.06,
        onRelease = onRelistMenu	-- event listener function
    }
    btnPower.id="power"
    btnPower:setReferencePoint( display.CenterReferencePoint )
    btnPower.x =  display.contentWidth *.5
    btnPower.y = display.contentHeight *.49

    btnUpgrade = widget.newButton{
        default= img_upgrade,
        over= img_upgrade,
        width=display.contentWidth*.47, height=display.contentHeight*.06,
        onRelease = onRelistMenu	-- event listener function
    }
    btnUpgrade.id="upgrade"
    btnUpgrade:setReferencePoint( display.CenterReferencePoint )
    btnUpgrade.x =  display.contentWidth *.5
    btnUpgrade.y = display.contentHeight *.58

    btnDischarge = widget.newButton{
        default= img_dischar,
        over= img_dischar,
        width=display.contentWidth*.47, height=display.contentHeight*.06,
        onRelease = onRelistMenu	-- event listener function
    }
    btnDischarge.id="discharge"
    btnDischarge:setReferencePoint( display.CenterReferencePoint )
    btnDischarge.x =  display.contentWidth *.5
    btnDischarge.y = display.contentHeight *.67

    btnItem = widget.newButton{
        default= img_item,
        over= img_item,
        width=display.contentWidth*.47, height=display.contentHeight*.06,
        onRelease = onRelistMenu	-- event listener function
    }
    btnItem.id="item"
    btnItem:setReferencePoint( display.CenterReferencePoint )
    btnItem.x =  display.contentWidth *.5
    btnItem.y = display.contentHeight *.76
end

function scene:createScene( event )
    local group = self.view
    local gdisplay = display.newGroup()
    local image_background1 = "img/background/background_1.jpg"
    local image_text = "img/text/UNIT.png"

    local background1 = display.newImageRect(image_background1,display.contentWidth,display.contentHeight)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0

    local titleText = display.newImageRect(image_text,display.contentWidth/9,display.contentHeight/35)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = display.contentWidth/2
    titleText.y = display.contentHeight/3.15

    listMenu()
    group:insert(background1)
    group:insert(titleText)
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(btnBox)
    group:insert(btnTeam)
    group:insert(btnPower)
    group:insert(btnUpgrade)
    group:insert(btnDischarge)
    group:insert(btnItem)
    group:insert(gdisplay)

    --------------------------
    storyboard.removeScene( "character_scene" )
    storyboard.removeScene( "characterprofile" )
    storyboard.removeScene( "characterAll" )
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