
local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.isDebug = true
local scene = storyboard.newScene()
local menu_barLight = require ("menu_barLight")
local widget = require "widget"
-- ------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local groupView = display.newGroup()

local btnBox
local btnTeam
local btnPower
local btnUpgrade
local btnDischarge

local btnBack
local btnGallery
local btnAnnouncement
local btnEditname
local btnGameCenter
local btnContactUs

local image_background1 = "img/background/background_1.jpg"
--    local image_background1 = "img/background/MAP_Chinese-ornament-frame.png"
local background

local image_text = "img/setting/developer/DEVELOPER.png"
local titleText

-------------------------------------
local function onRelistMenu(event)
    display.remove(btnBox)
    btnBox = nil
    display.remove(btnTeam)
    btnTeam = nil
    display.remove(btnPower)
    btnPower = nil
    display.remove(btnUpgrade)
    btnUpgrade = nil
    display.remove(btnDischarge)
    btnDischarge = nil
    display.remove(background)
    background = nil
    display.remove(titleText)
    titleText = nil
	print("eventID", event.target.id)
    for i= groupView.numChildren,1,-1 do
        local child = groupView[i]
        child.parent:remove( child )
        child = nil
        groupView[i] = nil
    end
    display.remove(groupView)
    groupView = nil

    if event.target.id == "back" then
       storyboard.gotoScene( "contact-us", "fade", 100 )

    elseif event.target.id == "gallery" then
        storyboard.gotoScene( "team_main", "fade", 100 )

    elseif event.target.id == "announcement" then
        storyboard.gotoScene( "characterAll", "fade", 100 )

    elseif event.target.id == "editname" then
        storyboard.gotoScene( "upgrade_main", "fade", 100 )

    elseif event.target.id == "gamecenter" then
        storyboard.gotoScene( "discharge_main", "fade", 100 )

	elseif event.target.id == "contactus" then
	    storyboard.gotoScene( "discharge_main", "fade", 100 )
	elseif event.target.id == "help" then
	    storyboard.gotoScene( "discharge_main", "fade", 100 )	
		
    end
    --menu_barLight.checkMemory()
end

local function createBackButton()
    local imgBnt = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        defaultFile= imgBnt,
        overFile= imgBnt,
        width=screenW*.1, height=screenH*.05,
        onRelease = onRelistMenu	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW*.15
    backButton.y = screenH*.3
    groupView:insert(backButton)
end

-----------------list menu-----------------

local function listMenu()
    local img_team = "img/setting/GALLERY.png"
    local img_power = "img/setting/ANNOUNCEMENT.png"
    local img_upgrade = "img/setting/EDIT_NAME.png"
    local img_dischar = "img/setting/GAME_CENTER.png"
	local img_contact_us = "img/setting/CONTACT US.png"
    local img_box = "img/background/button/BOX.png"


    btnBox = widget.newButton{
        default=img_box,
        over=img_box,
        width=screenW/8.5, height=screenH/22.5,
        onRelease = onRelistMenu	-- event listener function
    }
    btnBox.id="BOX"
    btnBox:setReferencePoint( display.TopLeftReferencePoint )
    btnBox.x = screenW *.7
    btnBox.y = screenH *.31
    groupView:insert(btnBox)

    btnTeam = widget.newButton{
        default= img_team,
        over = img_team,
        width=screenW*.47, height=screenH*.06,
        onRelease = onRelistMenu	-- event listener function
    }
    btnTeam.id="team"
    btnTeam:setReferencePoint( display.CenterReferencePoint )
    btnTeam.x = screenW *.5
    btnTeam.y = screenH *.4
    groupView:insert(btnTeam)

    btnPower = widget.newButton{
        default= img_power,
        over= img_power,
        width=screenW*.47, height=screenH*.06,
        onRelease = onRelistMenu	-- event listener function
    }
    btnPower.id="power"
    btnPower:setReferencePoint( display.CenterReferencePoint )
    btnPower.x =  screenW *.5
    btnPower.y = screenH *.49
    groupView:insert(btnPower)

    btnUpgrade = widget.newButton{
        default= img_upgrade,
        over= img_upgrade,
        width=screenW*.47, height=screenH*.06,
        onRelease = onRelistMenu	-- event listener function
    }
    btnUpgrade.id="upgrade"
    btnUpgrade:setReferencePoint( display.CenterReferencePoint )
    btnUpgrade.x =  screenW *.5
    btnUpgrade.y = screenH *.58
    groupView:insert(btnUpgrade)

    btnDischarge = widget.newButton{
        default= img_dischar,
        over= img_dischar,
        width=screenW*.47, height=screenH*.06,
        onRelease = onRelistMenu	-- event listener function
    }
    btnDischarge.id="discharge"
    btnDischarge:setReferencePoint( display.CenterReferencePoint )
    btnDischarge.x =  screenW *.5
    btnDischarge.y = screenH *.67
    groupView:insert(btnDischarge)

end
function scene:createScene( event )
    print("-- unit_main --")
    local group = self.view
    background = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    groupView:insert(background)

    titleText = display.newImageRect(image_text,screenW/4,screenH/35)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH/3.15

	createBackButton()
	--groupView:insert(require ("SettingScrollImage").new())
    groupView:insert(titleText)
    groupView:insert(menu_barLight.newMenubutton())
    --listMenu()
    group:insert(groupView)
    menu_barLight.checkMemory()
    --------------------------
    storyboard.removeAll ()
    storyboard.purgeAll()
end
function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view

    storyboard.removeAll ()
    storyboard.purgeAll()

end

function scene:destroyScene( event )
    print("-----unit destroyScene")
    local group = self.view
    display.remove(btnBox)
    btnBox = nil
    display.remove(btnTeam)
    btnTeam = nil
    display.remove(btnPower)
    btnPower = nil
    display.remove(btnUpgrade)
    btnUpgrade = nil
    display.remove(btnDischarge)
    btnDischarge = nil
    display.remove(background)
    background = nil
    display.remove(titleText)
    titleText = nil

--    for i= groupView.numChildren,1,-1 do
--        local child = groupView[i]
--        child.parent:remove( child )
--        child = nil
--    end
    display.remove(groupView)
    groupView = nil
    --storyboard:removeScene("unit_main")
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
