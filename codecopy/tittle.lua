local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local screenW = display.contentWidth
local screenH = display.contentHeight

local tapdisplay
local group
-----------------------------------------
local function gototouchtostart()
    local loadData = require( "loadData" ).newload()

    if loadData == 0 then
        storyboard.gotoScene( "register", "fade", 100 )
    else
        storyboard.gotoScene( "mainMenu", "fade", 100 )
    end

end

local function touchtostart()
    local texttouch = "img/fontTouch.png"
    local touchtext =  display.newImage( texttouch)
    touchtext.anchorX = 0.5
    touchtext.anchorY = 0.5
    touchtext.x = screenW*.5
    touchtext.y = screenH*.75
    tapdisplay:insert(touchtext)


    local timerText2 = function()
       transition.to(touchtext, { time=500,xScale = 0.95, alpha=.5} )
    end
    local timerText = function()
        transition.to(touchtext, { time=500,xScale = 1, alpha=1,onComplete = timerText2} )
    end

    timer.performWithDelay(1000, timerText, 0)


    group:addEventListener( "touch", gototouchtostart )
end
function scene:createScene( event )
    group = self.view
    tapdisplay = display.newGroup()

    local img_scorebar = "img/bgTitle.jpg"
    local BGMenuMode = display.newImage(img_scorebar)
    BGMenuMode.x = screenW*.5
    BGMenuMode.y = screenH*.5
    BGMenuMode.anchorX = 0.5
    BGMenuMode.anchorY = 0.5
    BGMenuMode.touch = touchtostart
    tapdisplay:insert(BGMenuMode)

    timer.performWithDelay( 2000, touchtostart)
    group:insert(tapdisplay)
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