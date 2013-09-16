
local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.isDebug = true
local scene = storyboard.newScene()
local menu_barLight = require ("menu_barLight")
local widget = require "widget"
-- ------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local groupView = display.newGroup()

local btnprogramme

local image_background1 = "img/background/background_1.jpg"
--    local image_background1 = "img/background/MAP_Chinese-ornament-frame.png"
local background

local image_text = "img/setting/reg_shop_purchase/regarding_shop_purchase.png"
local titleText

-------------------------------------
local function onRelistMenu(event)
    display.remove(btnRegard)
    btnRegard = nil
    display.remove(btnReport)
    btnReport = nil
    display.remove(btnDeveloper)
    btnDeveloper = nil
    display.remove(background)
    background = nil
    display.remove(titleText)
    titleText = nil

    for i= groupView.numChildren,1,-1 do
        local child = groupView[i]
        child.parent:remove( child )
        child = nil
        groupView[i] = nil
    end
    display.remove(groupView)
    groupView = nil

    if event.target.id == "regard" then
       storyboard.gotoScene( "regard-shop-purchase", "fade", 100 )

    elseif event.target.id == "report" then
        storyboard.gotoScene( "bug_report", "fade", 100 )

    elseif event.target.id == "developer" then
        storyboard.gotoScene( "developer", "fade", 100 )
	elseif event.target.id == "back" then
		storyboard.gotoScene( "contact-us", "fade", 100 )
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

local function listMenu()
    local img_regarding = "img/setting/reg_shop_purchase/programme.png"
	
	btnprogramme = widget.newButton{
        defaultFile=img_regarding,
        overFile=img_regarding,
        width=screenW*.65, height=screenH*.09,
        onRelease = onRelistMenu	-- event listener function
    }
    btnprogramme.id="regard"
    btnprogramme:setReferencePoint( display.CenterReferencePoint )
    btnprogramme.x = screenW *.5
    btnprogramme.y = screenH *.43
    groupView:insert(btnprogramme)

end
function scene:createScene( event )
    print("-- unit_main --")
    local group = self.view
    background = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    groupView:insert(background)

    titleText = display.newImageRect(image_text,screenW/3,screenH/23)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH/3.15

	createBackButton()
    groupView:insert(titleText)
    groupView:insert(menu_barLight.newMenubutton())
    listMenu()
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
    display.remove(btnRegard)
    btnRegard = nil
    display.remove(btnReport)
    btnReport = nil
    display.remove(btnDeveloper)
    btnDeveloper = nil
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