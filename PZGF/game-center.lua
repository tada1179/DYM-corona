
local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.isDebug = true
local scene = storyboard.newScene()
local menu_barLight = require ("menu_barLight")
local widget = require "widget"
-- ------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local groupView

local btnLeaderBoard
local btnAchivement

local titleText
local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local fontsize = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead

-------------------------------------
local function onRelistMenu(event)
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
       --storyboard.gotoScene( "leaderboard", "fade", 100 )

    elseif event.target.id == 2 then
       -- storyboard.gotoScene( "achivement", "fade", 100 )
	elseif event.target.id == "back" then
 		--storyboard.gotoScene( "game-setting", "fade", 100 )
    end
    storyboard.gotoScene( "game-setting", "fade", 100 )
    --menu_barLight.checkMemory()
end

local function createBackButton()
    local imgBnt = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
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
    local imgFrmList = "img/setting/iconbox.png"
	local mac = 2
    local text
    local pointListTxtY = screenH*.4
	local btnLeaderBoard  ={}
	for i = 1 ,mac,1 do
        if i== 1 then
            text = "LEADER BOARD"
        elseif i== 2 then
            text = "ACHIVEMENT"
        end

        btnLeaderBoard[i] = widget.newButton{
            defaultFile=imgFrmList,
            overFile=imgFrmList,
            width=screenW*.65, height=screenH*.09,
            onRelease = onRelistMenu,	-- event listener function
            label = text,
            labelColor = {
                default = { 255, 255, 255, 255 },
                over = {  255, 255, 255, 255 },
            }
        }
        btnLeaderBoard[i].id=i
        btnLeaderBoard[i]:setReferencePoint( display.CenterReferencePoint )
        btnLeaderBoard[i].x = screenW *.5
        btnLeaderBoard[i].y = pointListTxtY
        groupView:insert(btnLeaderBoard[i])
        pointListTxtY = pointListTxtY + (screenH*.105)
    end

end
function scene:createScene( event )
    groupView = display.newGroup()
    local group = self.view
    groupView:insert(background)

    titleText  = display.newText("GAME CENTER", 0, screenH*.30,typeFont, fontsizeHead)
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.5
    titleText:setTextColor(255, 255, 255)

	createBackButton()
    groupView:insert(titleText)
    groupView:insert(menu_barLight.newMenubutton())
    listMenu()
    group:insert(groupView)
    menu_barLight.checkMemory()
    --------------------------

end
function scene:enterScene( event )
    local group = self.view
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
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene    