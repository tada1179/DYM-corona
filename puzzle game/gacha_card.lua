local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
--------------------------------------
local gdisplay = display.newGroup()
local screenW, screenH = display.contentWidth, display.contentHeight
--------------------------------------
local function lightaura()
    local sheetdata_light = {width = screenW, height = screenH,numFrames = 47, sheetContentWidth =(screenW*5) ,sheetContentHeight = (screenH*10) }
    local image_sheet = "img/sprite/gacha_card/aura.png"
    local sheet_light = graphics.newImageSheet( image_sheet, sheetdata_light )
    local sequenceData = { name="sheet", sheet=sheet_light, start=1, count=sheetdata_light.numFrames, time=3200, loopCount=1 }

    local myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    gdisplay:insert(myAnimation)

    local function swapSheet()
        myAnimation.alpha = 1
        myAnimation:setSequence( "sheet" )
        myAnimation:play()
    end
    myAnimation.alpha = 0.1
    timer.performWithDelay( 7400, swapSheet )
end
local function darkon()
    local sheetdata_light =  {width = screenW, height = screenH,numFrames = 125, sheetContentWidth =(screenW/2)*10 ,sheetContentHeight =(screenH*12.5)*2 }
    local image_sheet = "img/sprite/gacha_card/dragon.png"
    local sheet_light = graphics.newImageSheet( image_sheet, sheetdata_light )
    local sequenceData = { name="sheet", sheet=sheet_light, start=1, count=sheetdata_light.numFrames, time=9000, loopCount=1 }

    local myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    gdisplay:insert(myAnimation)

    local function swapSheet()
        myAnimation:setSequence( "sheet" )
        myAnimation:play()

    end
    timer.performWithDelay( 1000, swapSheet )
end

local function bg_gacha()
    local sheetdata_light = {width = screenW, height = screenH,numFrames = (((screenW*5)/screenW)+((screenH*15)/screenH)), sheetContentWidth =(screenW*5) ,sheetContentHeight =(screenH*15) }
    local image_sheet = "img/sprite/gacha_card/bg_gacha.png"
    local sheet_light = graphics.newImageSheet( image_sheet, sheetdata_light )
    local sequenceData = { name="sheet", sheet=sheet_light, start=1, count=sheetdata_light.numFrames, time=1500, loopCount=1 }

    local myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    gdisplay:insert(myAnimation)

    local function swapSheet()
        myAnimation:setSequence( "sheet" )
        myAnimation:play()
    end
    timer.performWithDelay( 50, swapSheet )
end
function scene:createScene( event )
    local group = self.view
    bg_gacha()

    darkon()
    lightaura()

    local function openpage()
        gdisplay:removeSelf()
        gdisplay = nil
        local character_id = 16
        local USER_id = require( "menu_barLight" ).user_id()
        local option = {
            effect = "zoomInOutFade",
            time = 200,
            params = {
                character_id =character_id ,
                user_id = USER_id
            }
        }
        storyboard.gotoScene("characterprofile",option)
    end
    timer.performWithDelay( 11000, openpage )
    group:insert(gdisplay)
    local menu_barLight = require ("menu_barLight")
    menu_barLight.checkMemory()
    ------------- other scene ---------------
    storyboard.removeAll ()
    storyboard.purgeAll()


end

function scene:enterScene( event )
    local group = self.view

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
