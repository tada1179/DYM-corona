local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.disableAutoPurge = true
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()

local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local alertMSN = require("alertMassage")
local json = require("json")
local Bgdisplay
local gdisplay
local gdisplay2
local TimersST = {}
local transitionStash = {}
local fream
local params
local user_id
local character_id
gdisplay2 = display.newGroup()
-------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local function backgroundFX()
    local sheetdata_light = {width = screenW, height = screenH,numFrames = 90, sheetContentWidth = 1600*2 ,sheetContentHeight = 8640*2 }
    local image_sheet = {
        "img/sprite/Upgrade_Animation/powerup/2backeffect.png" ,
        "img/sprite/Upgrade_Animation/powerup/3circle1.png",
        "img/sprite/Upgrade_Animation/powerup/3circle2.png",
        "img/sprite/Upgrade_Animation/powerup/4effect.png",
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sheet_light2 = graphics.newImageSheet( image_sheet[2], sheetdata_light )
    local sheet_light3 = graphics.newImageSheet( image_sheet[3], sheetdata_light )
    local sheet_light4 = graphics.newImageSheet( image_sheet[4], sheetdata_light )
    local sequenceData = {
        { name="lightaura", sheet=sheet_light, start=55, count= sheetdata_light.numFrames , time=2000, loopCount=1 },
        { name="lightaura2", sheet=sheet_light2, start=1, count= sheetdata_light.numFrames , time=2000, loopCount=1 },
        { name="lightaura3", sheet=sheet_light3, start=1, count= sheetdata_light.numFrames , time=2000, loopCount=1 },
        { name="lightaura4", sheet=sheet_light4, start=1, count= sheetdata_light.numFrames , time=2000, loopCount=1 }
    }

    local Victory_aura
    local function FNbackground()
        Victory_aura = display.newSprite( sheet_light, sequenceData )
        Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
        Victory_aura.x = 0
        Victory_aura.y = 0
        Victory_aura:setSequence( "lightaura" )
        Victory_aura:play()
        gdisplay:insert(Victory_aura)
    end
    local function FNbackground2()
        Victory_aura = display.newSprite( sheet_light2, sequenceData )
        Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
        Victory_aura.x = 0
        Victory_aura.y = 0
        Victory_aura:setSequence( "lightaura2" )
        Victory_aura:play()
        gdisplay:insert(Victory_aura)
    end
    local function FNbackground3()
        Victory_aura = display.newSprite( sheet_light3, sequenceData )
        Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
        Victory_aura.x = 0
        Victory_aura.y = 0
        Victory_aura:setSequence( "lightaura3" )
        Victory_aura:play()
        gdisplay:insert(Victory_aura)
    end
    local function FNbackground4()
        Victory_aura = display.newSprite( sheet_light4, sequenceData )
        Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
        Victory_aura.x = 0
        Victory_aura.y = 0
        Victory_aura:setSequence( "lightaura4" )
        Victory_aura:play()
        gdisplay:insert(Victory_aura)
    end



    TimersST.myTimer = timer.performWithDelay(0,FNbackground )
    TimersST.myTimer = timer.performWithDelay(100,FNbackground2 )
    TimersST.myTimer = timer.performWithDelay(100,FNbackground3 )
    TimersST.myTimer = timer.performWithDelay(0,FNbackground4 )

    return true
end

local function circle1FX()
   -- gdisplay = display.newGroup()
    local sheetdata_light = {width = screenW, height = screenH,numFrames = 90, sheetContentWidth = 1600*2 ,sheetContentHeight = 8640*2 }
    local image_sheet = {
        "img/sprite/Upgrade_Animation/powerup/3circle1.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

    local Victory_aura1 = display.newSprite( sheet_light, sequenceData )
    Victory_aura1:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura1.x = 0
    Victory_aura1.y = 0
    local function FN3circle1()
        Victory_aura1:setSequence( "lightaura" )
        Victory_aura1:play()
    end
    gdisplay:insert(Victory_aura1)
    TimersST.myTimer = timer.performWithDelay(50,FN3circle1 )

    return true
end
local function circle2FX()
   -- gdisplay = display.newGroup()
    local sheetdata_light = {width = screenW, height = screenH,numFrames = 90, sheetContentWidth = 1600*2 ,sheetContentHeight = 8640*2 }
    local image_sheet = {
        "img/sprite/Upgrade_Animation/powerup/3circle2.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

    local Victory_aura1 = display.newSprite( sheet_light, sequenceData )
    Victory_aura1:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura1.x = 0
    Victory_aura1.y = 0
    local function FN3circle2()
        Victory_aura1:setSequence( "lightaura" )
        Victory_aura1:play()
    end
    gdisplay:insert(Victory_aura1)
    TimersST.myTimer = timer.performWithDelay(50,FN3circle2 )

    return true
end
local function effectFX()
   -- gdisplay = display.newGroup()
    local sheetdata_light = {width = screenW, height = screenH,numFrames = 90, sheetContentWidth = 1600*2 ,sheetContentHeight = 8640*2 }
    local image_sheet = {
        "img/sprite/Upgrade_Animation/powerup/4effect.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

    local Victory_aura1 = display.newSprite( sheet_light, sequenceData )
    Victory_aura1:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura1.x = 0
    Victory_aura1.y = 0
    local function FNeffectFX()
        Victory_aura1:setSequence( "lightaura" )
        Victory_aura1:play()
    end
    gdisplay:insert(Victory_aura1)
    TimersST.myTimer = timer.performWithDelay(0,FNeffectFX )

    return true
end
local function powerup2_1()
    display.remove(gdisplay)
    gdisplay = nil


    local sheetdata_light = {width = screenW, height = screenH,numFrames = 50, sheetContentWidth = 1600*2 ,sheetContentHeight = 4800*2 }
    local image_sheet = {
        "img/sprite/Upgrade_Animation/powerup2/2circle.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

    local Victory_aura = display.newSprite( sheet_light, sequenceData )
    Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura.x = 0
    Victory_aura.y = 0
    local function FNeffectFX2_1()
        Victory_aura:setSequence( "lightaura" )
        Victory_aura:play()
    end
    gdisplay2:insert(Victory_aura)
    TimersST.myTimer = timer.performWithDelay(0,FNeffectFX2_1 )


end
local function powerup2_2()
    local function onTouchtoCharacter (self, event )
        display.remove(gdisplay)
        gdisplay = nil
        display.remove(gdisplay2)
        gdisplay2 = nil

        display.remove(Bgdisplay)
        Bgdisplay = nil

        cancelAllTimers ()
        cancelAllTransitions ()

       -- if event.phase == "began" then
            local option = {
                effect = "fade",
                time = 100,
                params = {
                    character_id =character_id ,
                    user_id = user_id
                }
            }

            storyboard.gotoScene("pageWith",option)
            storyboard.gotoScene("power_up_main",option)
            storyboard.removeScene("pageWith",option)
        --end

    end
    display.remove(gdisplay)
    gdisplay = nil

    gdisplay2 = display.newGroup()
    local sheetdata_light = {width = screenW, height = screenH,numFrames = 50, sheetContentWidth = 1600*2 ,sheetContentHeight = 4800*2 }
    local image_sheet = {
        "img/sprite/Upgrade_Animation/powerup2/3effect.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

    local Victory_aura = display.newSprite( sheet_light, sequenceData )
    Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura.x = 0
    Victory_aura.y = 0
    local function FNeffectFX2_1()
        Victory_aura:setSequence( "lightaura" )
        Victory_aura:play()
    end
    gdisplay2:insert(Victory_aura)
    TimersST.myTimer = timer.performWithDelay(0,FNeffectFX2_1 )

    local imgCharacterMain = display.newImageRect(params.ImageCharacter,screenW*.24,screenH*.17)--contentWidth contentHeight
    imgCharacterMain:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    imgCharacterMain.x,imgCharacterMain.y = screenW*.5,screenH*.5
    gdisplay2:insert(imgCharacterMain)

    local FrmCharacterMain = display.newImageRect(fream[params.elementMain],screenW*.24,screenH*.17)--contentWidth contentHeight
    FrmCharacterMain:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    FrmCharacterMain.x,FrmCharacterMain.y =  screenW*.5,screenH*.5
    gdisplay2:insert(FrmCharacterMain)

    transitionStash.newTransition = transition.to( Victory_aura, { time=2500,delay = 50, xScale=1, yScale=1, alpha=1,onComplete =onTouchtoCharacter  })
--    gdisplay2.touch = onTouchtoCharacter
--    gdisplay2:addEventListener( "touch", gdisplay2 )

end


function cancelAllTimers()
    local k, v
    for k,v in pairs(TimersST) do
        timer.cancel(v )
        v = nil; k = nil
    end


    TimersST = nil
    TimersST = {}
end

function cancelAllTransitions()
    local k, v
    for k,v in pairs(transitionStash) do
        transition.cancel( v )
        v = nil; k = nil
    end

    transitionStash = nil
    transitionStash = {}
end
function scene:createScene( event )
    print("--------** power up save **-------:")
    Bgdisplay = display.newGroup()
    gdisplay = display.newGroup()
    local group = self.view
    user_id = menu_barLight.user_id()

    fream = alertMSN.loadFramElement()
    local ImgDisplay = display.newGroup()
    params = event.params
    character_id = params.character_id
    local imgCharacter = {}
    local FrmCharacter = {}
    local imgCharacterMain
    local pointImgX = {screenW*.30,screenW*.7,screenW*.17,screenW*.83,screenW*.5}
    local pointImgY = {screenH*.30,screenH*.30,screenH*.55,screenH*.55,screenH*.73 }

    local background = display.newImageRect("img/sprite/Upgrade_Animation/powerup/1bg.png",screenW,screenH)--contentWidth contentHeight
--    local background = display.newImageRect("img/sprite/Upgrade_Animation/1UpgradeAnimation.png",screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    group:insert(background)

    TimersST.myTimer = timer.performWithDelay(0,circle1FX )



    for i = 1,params.countCHNo,1 do

        imgCharacter[i] = display.newImageRect(params.Imageleader[i],screenW*.15,screenH*.1)--contentWidth contentHeight
        imgCharacter[i]:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
        imgCharacter[i].x,imgCharacter[i].y = pointImgX[i],pointImgY[i]
        ImgDisplay:insert(imgCharacter[i])

        FrmCharacter[i] = display.newImageRect(fream[params.element[i]],screenW*.15,screenH*.1)--contentWidth contentHeight
        FrmCharacter[i]:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
        FrmCharacter[i].x,FrmCharacter[i].y = pointImgX[i],pointImgY[i]
        ImgDisplay:insert(FrmCharacter[i])
    end

    imgCharacterMain = display.newImageRect(params.ImageCharacter,screenW*.15,screenH*.1)--contentWidth contentHeight
    imgCharacterMain:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    imgCharacterMain.x,imgCharacterMain.y = screenW*.5,screenH*.5
    ImgDisplay:insert(imgCharacterMain)

    local FrmCharacterMain = display.newImageRect(fream[params.elementMain],screenW*.15,screenH*.1)--contentWidth contentHeight
    FrmCharacterMain:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    FrmCharacterMain.x,FrmCharacterMain.y =  screenW*.5,screenH*.5
    ImgDisplay:insert(FrmCharacterMain)

    Bgdisplay:insert(gdisplay)
    Bgdisplay:insert(ImgDisplay)

    TimersST.myTimer = timer.performWithDelay(0,circle2FX )
    TimersST.myTimer = timer.performWithDelay(500,effectFX )
    TimersST.myTimer = timer.performWithDelay(4000,powerup2_1 )
    TimersST.myTimer = timer.performWithDelay(4000,powerup2_2 )



--    TimersST.myTimer = timer.performWithDelay(0,backgroundFX )
   -- group:insert(gdisplay)
    Bgdisplay:insert(gdisplay2)
    group:insert(Bgdisplay)

--    group:insert(ImgDisplay)
    --------------------------------------------
    storyboard.removeAll()
    storyboard.purgeAll()

end
function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    display.remove(gdisplay)
    gdisplay = nil
    display.remove(gdisplay2)
    gdisplay2 = nil

    storyboard.removeAll()
    storyboard.purgeAll()

    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )
end

function scene:destroyScene( event )
    local group = self.view


end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

