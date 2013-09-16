
local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.isDebug = true
local scene = storyboard.newScene()
local menu_barLight = require ("menu_barLight")
local widget = require "widget"
-- ------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local groupView = display.newGroup()

local btnLeaderBoard
local btnAchivement

local image_background1 = "img/background/background_1.jpg"
--    local image_background1 = "img/background/MAP_Chinese-ornament-frame.png"
local background

local image_text = "img/setting/game_center/game-center.png"
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

    if event.target.id == "leaderboard" then
       --storyboard.gotoScene( "leaderboard", "fade", 100 )

    elseif event.target.id == "achivement" then
        storyboard.gotoScene( "achivement", "fade", 100 )
	elseif event.target.id == "back" then
 		storyboard.gotoScene( "game-setting", "fade", 100 )
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
    local img_leaderboard = "img/setting/game_center/leader-board.png"
    local img_achivement = "img/setting/game_center/achivement.png"
	
	btnLeaderBoard = widget.newButton{
        defaultFile=img_leaderboard,
        overFile=img_leaderboard,
        width=screenW*.65, height=screenH*.09,
        onRelease = onRelistMenu	-- event listener function
    }
    btnLeaderBoard.id="leaderboard"
    btnLeaderBoard:setReferencePoint( display.CenterReferencePoint )
    btnLeaderBoard.x = screenW *.5
    btnLeaderBoard.y = screenH *.4
    groupView:insert(btnLeaderBoard)

    btnAchivement = widget.newButton{
        defaultFile= img_achivement,
        overFile= img_achivement,
        width=screenW*.65, height=screenH*.09,
        onRelease = onRelistMenu	-- event listener function
    }
    btnAchivement.id="achivement"
    btnAchivement:setReferencePoint( display.CenterReferencePoint )
    btnAchivement.x =  screenW *.5
    btnAchivement.y = screenH *.52
    groupView:insert(btnAchivement)

end
function scene:createScene( event )
    print("-- unit_main --")
    local group = self.view
    background = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    groupView:insert(background)

    titleText = display.newImageRect(image_text,screenW/3,screenH/35)--contentWidth contentHeight
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