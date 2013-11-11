
local storyboard = require("storyboard")
local scene = storyboard.newScene()
local menu_barLight = require ("menu_barLight")
local widget = require "widget"
-- ------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local groupView

local btnRegard
local btnReport
local btnDeveloper
local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local fontsize = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead

local image_frame = "img/background/frame/iconbox.png"
local titleText

-------------------------------------
local function onRelistMenu(event)
    if event.target.id == "back" then
        menu_barLight.SEtouchButtonBack()
    else
        menu_barLight.SEtouchButton()
    end


    display.remove(btnRegard)
    btnRegard = nil
    display.remove(btnReport)
    btnReport = nil
    display.remove(btnDeveloper)
    btnDeveloper = nil
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

    if event.target.id == 1 then
       storyboard.gotoScene( "regard-shop-purchase", "fade", 100 )

    elseif event.target.id == 3 then
        storyboard.gotoScene( "bugreport", "fade", 100 )

    elseif event.target.id == 2 then
        storyboard.gotoScene( "developer", "fade", 100 )
	elseif event.target.id == "back" then
		storyboard.gotoScene( "game-setting", "fade", 100 )
    end
    --menu_barLight.checkMemory()
end

local function createBackButton()
    local imgBnt = "img/background/button/Button_BACK.png"
   local  backButton = widget.newButton{
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
    local text
	local max = 3
    local pointListY = screenH*.4
    local btnRegard = {}
    for i=1,max,1 do
        if i==1 then
            text = "REGARDING SHOP PURCHASE"
        elseif i==2 then
            text = "DEVELOPER"
        elseif i==3 then
            text = "BUG REPORT"
        end

	    btnRegard[i] = widget.newButton{
            defaultFile=image_frame,
            overFile=image_frame,
            width=screenW*.65, height=screenH*.09,
            onRelease = onRelistMenu,	-- event listener function
            label = text,
            labelColor = {
            default = { 255, 255, 255, 255 },
            over = {  255, 255, 255, 255 },
        }
        }
        btnRegard[i].id=i
        btnRegard[i]:setReferencePoint( display.CenterReferencePoint )
        btnRegard[i].x = screenW *.5
        btnRegard[i].y =pointListY
        pointListY = pointListY + (screenH*.105)
        groupView:insert(btnRegard[i])
    end

end
function scene:createScene( event )
    local group = self.view
    groupView = display.newGroup()
    groupView:insert(background)

    titleText = display.newText("CONTACT US", screenW*.38, screenH*.3,typeFont, fontsizeHead)

    titleText:setReferencePoint( display.TopLeftReferencePoint )
    titleText:setTextColor(255, 255, 255)

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
    storyboard.purgeScene( "regard-shop-purchase" )
    storyboard.purgeScene( "bugreport" )
    storyboard.purgeScene( "developer" )
    storyboard.purgeScene( "game-setting" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view

    storyboard.removeAll ()
    storyboard.purgeAll()

end

function scene:destroyScene( event )
    local group = self.view
    display.remove(btnRegard)
    btnRegard = nil
    display.remove(btnReport)
    btnReport = nil
    display.remove(btnDeveloper)
    btnDeveloper = nil

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