local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.disableAutoPurge = true
local scene = storyboard.newScene()

local menu_barLight = require ("menu_barLight")
local alertMSN = require("alertMassage")
local Bgdisplay
local gdisplay
local gdisplay2
local TimersST = {}
local transitionStash = {}
local fream
local params
local user_id
local character_id
local myImageSheet
local sheetInfo = require("chara_icon")

local img_bG = "Upgrade_Animation_powerup_1bg.png"
local image_sheet = {
    "Upgrade_Animation_powerup_3circle1.png" , --1
    "Upgrade_Animation_powerup_3circle2.png" , --2
    "Upgrade_Animation_powerup_4effect.png"  , --3
    "Upgrade_Animation_powerup2_2circle.png" , --4
    "Upgrade_Animation_powerup2_3effect.png" , --5
}
local sheetdata_light = {
    {width = 640, height = 960,numFrames = 90, sheetContentWidth = 1600*2 ,sheetContentHeight = 8640*2},
    {width = 640, height = 960,numFrames = 50, sheetContentWidth = 1600*2 ,sheetContentHeight = 4800*2 }
}


-------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local screenH2
local screenW2

local function circle1FX()
    -- gdisplay = display.newGroup()      ,system.DocumentsDirectory


    local sheet_light = graphics.newImageSheet( image_sheet[1],system.DocumentsDirectory, sheetdata_light[1] )
    local sequenceData = { name="lightauraw", sheet=sheet_light, start=1, count= sheetdata_light[1].numFrames , time=3000, loopCount=1 }

    local Victory_aura1 = display.newSprite( sheet_light, sequenceData )
    Victory_aura1:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura1.x = 0
    Victory_aura1.y = 0
    local function FN3circle1()
        Victory_aura1:setSequence( "lightauraw" )
        Victory_aura1:play()
    end
    gdisplay:insert(Victory_aura1)
    TimersST.myTimer = timer.performWithDelay(50,FN3circle1 )

    return true
end
local function circle2FX()
    -- gdisplay = display.newGroup()
--    local sheetdata_light = {width = 640, height = 960,numFrames = 90, sheetContentWidth = 1600*2 ,sheetContentHeight = 8640*2 }
    local sheet_light = graphics.newImageSheet( image_sheet[2],system.DocumentsDirectory, sheetdata_light[1] )
    local sequenceData = { name="lightauras", sheet=sheet_light, start=1, count= sheetdata_light[1].numFrames , time=3000, loopCount=1 }

    local Victory_aura1 = display.newSprite( sheet_light, sequenceData )
    Victory_aura1:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura1.x = 0
    Victory_aura1.y = 0
    local function FN3circle2()
        Victory_aura1:setSequence( "lightauras" )
        Victory_aura1:play()
    end
    gdisplay:insert(Victory_aura1)
    TimersST.myTimer = timer.performWithDelay(50,FN3circle2 )

    return true
end
local function effectFX()
    -- gdisplay = display.newGroup()
--    local sheetdata_light = {width = 640, height = 960,numFrames = 90, sheetContentWidth = 1600*2 ,sheetContentHeight = 8640*2 }
    local sheet_light = graphics.newImageSheet( image_sheet[3],system.DocumentsDirectory, sheetdata_light[1] )
    local sequenceData = { name="lightaura1", sheet=sheet_light, start=1, count= sheetdata_light[1].numFrames , time=3000, loopCount=1 }

    local Victory_aura1 = display.newSprite( sheet_light, sequenceData )
    Victory_aura1:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura1.x = 0
    Victory_aura1.y = 0
    local function FNeffectFX()
        Victory_aura1:setSequence( "lightaura1" )
        Victory_aura1:play()
    end
    gdisplay:insert(Victory_aura1)
    TimersST.myTimer = timer.performWithDelay(0,FNeffectFX )

    return true
end
local function powerup2_1()
    display.remove(gdisplay)
    gdisplay = nil


--    local sheetdata_light = {width = 640, height = 960,numFrames = 50, sheetContentWidth = 1600*2 ,sheetContentHeight = 4800*2 }
    local sheet_light = graphics.newImageSheet( image_sheet[4],system.DocumentsDirectory, sheetdata_light[2] )
    local sequenceData = { name="lightaurad", sheet=sheet_light, start=1, count= sheetdata_light[2].numFrames , time=3000, loopCount=1 }

    local Victory_aura = display.newSprite( sheet_light, sequenceData )
    Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura.x = 0
    Victory_aura.y = 0
    local function FNeffectFX2_1()
        Victory_aura:setSequence( "lightaurad" )
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
        storyboard.gotoScene("power_up_main",option)

        --end

    end
    display.remove(gdisplay)
    gdisplay = nil

    gdisplay2 = display.newGroup()
--    local sheetdata_light = {width = 640, height = 960,numFrames = 50, sheetContentWidth = 1600*2 ,sheetContentHeight = 4800*2 }
    local sheet_light = graphics.newImageSheet( image_sheet[5],system.DocumentsDirectory, sheetdata_light[2] )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light[2].numFrames , time=3000, loopCount=1 }

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

    local imgCharacterMain = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(params.ImageCharacter),screenW*.24,screenH*.17)--contentWidth contentHeight
    imgCharacterMain:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    imgCharacterMain.x,imgCharacterMain.y = screenW2*.5,screenH2*.5
    gdisplay2:insert(imgCharacterMain)

    local FrmCharacterMain = display.newImageRect(fream[params.elementMain],screenW*.24,screenH*.17)--contentWidth contentHeight
    FrmCharacterMain:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    FrmCharacterMain.x,FrmCharacterMain.y =  screenW2*.5,screenH2*.5
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
    gdisplay2 = display.newGroup()
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
    screenW2 = 640
    screenH2 = 960
    local pointImgX = {screenW2*.30,screenW2*.7,screenW2*.17,screenW2*.83,screenW2*.5}
    local pointImgY = {screenH2*.30,screenH2*.30,screenH2*.55,screenH2*.55,screenH2*.73 }

    group:insert(background)

    local background1 = display.newImageRect(img_bG,system.DocumentsDirectory,screenW,screenH)--contentWidth contentHeight
    --    local background = display.newImageRect("img/sprite/Upgrade_Animation/1UpgradeAnimation.png",screenW,screenH)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0
    group:insert(background1)


    TimersST.myTimer = timer.performWithDelay(0,circle1FX )


--    myImageSheet = graphics.newImageSheet( "img/character/chara_icon.png", sheetInfo:getSheet() )
    myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )

    for i = 1,params.countCHNo,1 do

        imgCharacter[i] = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex( params.Imageleader[i]),screenW*.15,screenH*.1)--contentWidth contentHeight
        imgCharacter[i]:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
        imgCharacter[i].x,imgCharacter[i].y = pointImgX[i],pointImgY[i]
        ImgDisplay:insert(imgCharacter[i])

        FrmCharacter[i] = display.newImageRect(fream[params.element[i]],screenW*.15,screenH*.1)--contentWidth contentHeight
        FrmCharacter[i]:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
        FrmCharacter[i].x,FrmCharacter[i].y = pointImgX[i],pointImgY[i]
        ImgDisplay:insert(FrmCharacter[i])
    end

    imgCharacterMain = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex( params.ImageCharacter) ,screenW*.17,screenH*.1)--contentWidth contentHeight
    imgCharacterMain:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    imgCharacterMain.x,imgCharacterMain.y = screenW2*.5,screenH2*.5
    ImgDisplay:insert(imgCharacterMain)

    local FrmCharacterMain = display.newImageRect(fream[params.elementMain],screenW*.17,screenH*.1)--contentWidth contentHeight
    FrmCharacterMain:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    FrmCharacterMain.x,FrmCharacterMain.y =  screenW2*.5,screenH2*.5
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
    storyboard.purgeScene( "power_up_main" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view
    display.remove(gdisplay)
    gdisplay = nil
    display.remove(gdisplay2)
    gdisplay2 = nil

    storyboard.removeAll()
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

