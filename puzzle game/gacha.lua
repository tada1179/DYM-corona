local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
--------------------------------------
local gdisplay = display.newGroup()
local screenW, screenH = display.contentWidth, display.contentHeight
--------------------------------------
local function darkon()
    local sheetdata_light =  {width = screenW, height = screenH,numFrames = (((screenW/2)*10)/screenW)*((screenH*10)/screenH), sheetContentWidth =((screenW/2)*10) ,sheetContentHeight =(screenH*10) }
    local image_sheet = "img/sprite/gacha/dragon.png"
    local sheet_light = graphics.newImageSheet( image_sheet, sheetdata_light )
    local sequenceData = { name="darkon", sheet=sheet_light, start=1, count=sheetdata_light.numFrames, time=4000, loopCount=0 }

    local myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    gdisplay:insert(myAnimation)

    local function swapSheet()
        myAnimation:setSequence( "darkon" )
        myAnimation:play()
    end
    timer.performWithDelay( 50, swapSheet )
end
local function lightaura()
    local sheetdata_light = {width = screenW, height = screenH,numFrames = ((screenW*10)/screenW)*((screenH*10)/screenH), sheetContentWidth =screenW*10 ,sheetContentHeight =screenH*10 }
    local image_sheet = "img/sprite/gacha/aura.png"
    local sheet_light = graphics.newImageSheet( image_sheet, sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count=sheetdata_light.numFrames, time=5000, loopCount=0 }

    local myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    gdisplay:insert(myAnimation)

    local function swapSheet()
        myAnimation:setSequence( "lightaura" )
        myAnimation:play()
    end
    timer.performWithDelay( 50, swapSheet )
end
function scene:createScene( event )
    local group = self.view
    local imgBG = "img/sprite/gacha/bg_gacha.png"
    local background = display.newImageRect(imgBG,screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    gdisplay:insert(background)

    lightaura()
    darkon()
    local function onTouchGacha_card(event)
        gdisplay:removeSelf()
        gdisplay = nil
        storyboard.gotoScene("gacha_card")
    end
    gdisplay.touch = onTouchGacha_card
    gdisplay:addEventListener( "touch", gdisplay )
    group:insert(gdisplay)
    local menu_barLight = require ("menu_barLight")
    menu_barLight.checkMemory()
    ------------- other scene ---------------
    storyboard.removeAll ()
    storyboard.purgeAll()


end

function scene:enterScene( event )
    local group = self.view
    --storyboard:gotoScene("gacha_card")
end

function scene:exitScene( event )
    local group = self.view
end

function scene:destroyScene( event )

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
