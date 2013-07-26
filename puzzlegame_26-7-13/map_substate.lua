local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
-----------------------------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight

local pointListY = 0
local topBoundary = screenW *.1
local bottomBoundary = pointListY
local gdisplay = display.newGroup()
local text_title = "img/text/CHAPTER_SELECT.png"
local backButton
local background
local titleText = display.newImageRect(text_title ,screenW/1.8, screenH/17 )
-------------------------------------

local function onBtnRelease(event)
    menu_barLight = nil

    display.remove(backButton)
    backButton = nil

    display.remove(background)
    background = nil

    display.remove(titleText)
    titleText = nil

    for i= gdisplay.numChildren,1,-1 do
        local child = gdisplay[i]
        child.parent:remove( child )
        child = nil
    end
    display.remove(gdisplay)
    gdisplay = nil


   if event.target.id == "back" then -- back button
        storyboard.gotoScene( "map" ,"fade", 100 )
   end
    return true	-- indicates successful touch
end

local function createBackButton()
    local imgBnt = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        default= imgBnt,
        over= imgBnt,
        width=screenW*.1, height=screenH*.05,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW*.15
    backButton.y = screenH*.3
    gdisplay:insert(backButton)
end

function scene:createScene( event )
    print("-- map substate --")

    local group = self.view

    background = display.newImageRect("img_back", system.DocumentsDirectory,screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0,0
    gdisplay:insert(background)


    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.12
    gdisplay:insert(titleText)

    createBackButton()
    gdisplay:insert(require ("scrollImage").new())
    gdisplay:insert(menu_barLight.newMenubutton())
    group:insert(gdisplay)

------------- other scene ---------------
    storyboard.purgeAll()
    storyboard.removeAll()
    menu_barLight.checkMemory()
end

function scene:enterScene( event )
    local group = self.view	
end

function scene:exitScene( event )
    local group = self.view
    menu_barLight = nil

    display.remove(backButton)
    backButton = nil

    display.remove(background)
    background = nil

    display.remove(titleText)
    titleText = nil


    display.remove(gdisplay)
    gdisplay = nil

    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )
    local group = self.view

--    display.remove(gdisplay)
--    gdisplay = nil

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene


