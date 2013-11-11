local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local menu_barLight = require("menu_barLight")
local widget = require "widget"
local util = require("util")
local alertMSN  = require("alertMassage")
local mypage = storyboard.getCurrentSceneName()
local loadImageSprite = require ("downloadData").loadImageSprite_Gacha2()
--------------------------------------
local TimerCount = {}
local UseFriend = 200
local UseDimond = 5
local sentoyou
local user_id
local myFrientPoint
local myDiamondPoint
local Myslot
local characterAll


local gdisplay
local groupView_FriendPoint = nil
local typeFont = "Optima-Bold"
local fontSize =  24 /  display.contentScaleY     --  25 pixel
local fontSizeHead =  30 /  display.contentScaleY -- 30 pixel
local screenW, screenH = display.contentWidth, display.contentHeight
local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local sizetext = FontAndSize.fontGuest
local sizetextName = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead
local image_sheet = {
    "gacha_dragon.png",
    "gacha_aura.png",
}
local sheetdata_light = {
    {width = screenW, height = screenH,numFrames = (((screenW/2)*10)/screenW)*((screenH*10)/screenH), sheetContentWidth =((screenW/2)*10) ,sheetContentHeight =(screenH*10) },
    {width = screenW, height = screenH,numFrames = ((screenW*10)/screenW)*((screenH*10)/screenH), sheetContentWidth =screenW*10 ,sheetContentHeight =screenH*10 }

}
local imgBG = "gacha_bg_gacha.png"

--------------------------------------
local function darkon()
    --print("darkon")

    local sheet_light = graphics.newImageSheet( image_sheet[1],system.DocumentsDirectory, sheetdata_light[1] )
    local sequenceData = { name="darkon", sheet=sheet_light, start=1, count=sheetdata_light[2].numFrames, time=4000, loopCount=0 }

    local myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    gdisplay:insert(myAnimation)

    local function swapSheet()
        myAnimation:setSequence( "darkon" )
        myAnimation:play()
    end
    TimerCount.myTimer = timer.performWithDelay( 50, swapSheet )
end
local function lightaura()
    require("menu").removeDisplay()
    local sheet_light = graphics.newImageSheet( image_sheet[2],system.DocumentsDirectory, sheetdata_light[2] )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count=sheetdata_light[2].numFrames, time=5000, loopCount=0 }

    local myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    gdisplay:insert(myAnimation)

    local function swapSheetaura()
        myAnimation:setSequence( "lightaura" )
        myAnimation:play()
    end
    TimerCount.myTimer = timer.performWithDelay( 50, swapSheetaura )
end
local function onTouchScreen(self,event)
    if event.phase == "began" then


        return true
    end
end

local function Diamond()
    groupView_FriendPoint = display.newGroup()
    local BGbackground = display.newRoundedRect(0,0, screenW, screenH,0)
    BGbackground.strokeWidth = 0
    BGbackground.alpha = .5
    BGbackground:setFillColor(0 ,0 ,0)
    groupView_FriendPoint:insert(BGbackground)


    groupView_FriendPoint.touch = onTouchScreen
    groupView_FriendPoint:addEventListener( "touch", groupView_FriendPoint )

    -- gdisplay:insert(groupView_FriendPoint)


    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local bckCaution = display.newImageRect( image_Caution, screenW*.95,screenH*.6 )
    bckCaution:setReferencePoint( display.CenterReferencePoint )
    bckCaution.x = screenW*.5
    bckCaution.y = screenH*.6
    bckCaution.alpha = .9
    groupView_FriendPoint:insert(bckCaution)

    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        defaultFile = img_OK,
        overFile = img_OK,
        width=screenW*.3, height= screenH*.07,
        onRelease = GachaRelease	-- event listener function
    }
    btnOK.id = "Diamond_OK" --ok
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = screenW*.3
    btnOK.y = screenH*.78
    groupView_FriendPoint:insert(btnOK)

    local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local btncancel = widget.newButton{
        defaultFile = img_cancel,
        overFile = img_cancel,
        width=screenW*.3, height= screenH*.07,
        onRelease = GachaRelease	-- event listener function
    }
    btncancel.id = "Diamond_cencel"  --cencel
    btncancel:setReferencePoint( display.TopLeftReferencePoint )
    btncancel.alpha = 1
    btncancel.x = screenW*.55
    btncancel.y = screenH*.75
    groupView_FriendPoint:insert(btncancel)

    local SmachText_T = util.wrappedText("  USE 5 GOLDS TO SUMMON \nCHARACTER ", screenW*.28, fontSizeHead,typeFont, {255, 255, 255})
    SmachText_T.x = screenW*.15
    SmachText_T.y = screenH*.40
    groupView_FriendPoint:insert(SmachText_T)

    local img_friend = display.newImageRect( "img/background/button/as_butt_menu.png",  screenW*.3,screenH*.13 )
    img_friend:setReferencePoint( display.CenterReferencePoint )
    img_friend:setFillColor(255 ,0 ,255)
    img_friend.x = screenW*.5
    img_friend.y = screenH*.6
    groupView_FriendPoint:insert(img_friend)

    local SmachText_s = util.wrappedText("ACCUMULATED GOLDS: "..myDiamondPoint, screenW*.28, fontSize,typeFont, {255, 255, 255})
    SmachText_s.x = screenW*.25
    SmachText_s.y = screenH*.68
    groupView_FriendPoint:insert(SmachText_s)
end
local function FriendPoint()
    groupView_FriendPoint = display.newGroup()
    local BGbackground = display.newRoundedRect(0,0, screenW, screenH,0)
    BGbackground.strokeWidth = 0
    BGbackground.alpha = .5
    BGbackground:setFillColor(0 ,0 ,0)
    groupView_FriendPoint:insert(BGbackground)


    groupView_FriendPoint.touch = onTouchScreen
    groupView_FriendPoint:addEventListener( "touch", groupView_FriendPoint )

   -- gdisplay:insert(groupView_FriendPoint)


    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local bckCaution = display.newImageRect( image_Caution, screenW*.95,screenH*.6 )
    bckCaution:setReferencePoint( display.CenterReferencePoint )
    bckCaution.x = screenW*.5
    bckCaution.y = screenH*.6
    bckCaution.alpha = .9
    groupView_FriendPoint:insert(bckCaution)

    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        defaultFile = img_OK,
        overFile = img_OK,
        width=screenW*.3, height= screenH*.07,
        onRelease = GachaRelease	-- event listener function
    }
    btnOK.id = "FriendPoint_OK" --ok
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = screenW*.3
    btnOK.y = screenH*.78
    groupView_FriendPoint:insert(btnOK)

    local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local btncancel = widget.newButton{
        defaultFile = img_cancel,
        overFile = img_cancel,
        width=screenW*.3, height= screenH*.07,
        onRelease = GachaRelease	-- event listener function
    }
    btncancel.id = "FriendPoint_cencel"  --cencel
    btncancel:setReferencePoint( display.TopLeftReferencePoint )
    btncancel.alpha = 1
    btncancel.x = screenW*.55
    btncancel.y = screenH*.75
    groupView_FriendPoint:insert(btncancel)

    local SmachText_T = util.wrappedText("  USE 200 FRIEND POINTS TO\nSUMMON CHARACTER ", screenW*.28, fontSizeHead,typeFont, {255, 255, 255})
    SmachText_T.x = screenW*.15
    SmachText_T.y = screenH*.4
    groupView_FriendPoint:insert(SmachText_T)

    local img_friend = display.newImageRect( "img/background/button/as_butt_menu.png", screenW*.3,screenH*.13 )
    img_friend:setReferencePoint( display.CenterReferencePoint )
    img_friend:setFillColor(255 ,255 ,255)
    img_friend.x = screenW*.5
    img_friend.y = screenH*.6
    groupView_FriendPoint:insert(img_friend)

    local SmachText_s = util.wrappedText("ACCUMULATED FRIEND POINTS: "..myFrientPoint, screenW*.28, fontSize,typeFont, {255, 255, 255})
    SmachText_s.x = screenW*.17
    SmachText_s.y = screenH*.68
    groupView_FriendPoint:insert(SmachText_s)
end
function GachaRelease(event)
    menu_barLight.SEtouchButton()
    local changePoint
    if groupView_FriendPoint ~= nil then
        display.remove(groupView_FriendPoint)
        groupView_FriendPoint = nil
    end

    local k, v
    for k,v in pairs(TimerCount) do
        timer.cancel(v )
        v = nil; k = nil
    end


    TimerCount = nil
    TimerCount = {}

    if event.target.id == "FriendPoint_OK" then    --OK
        if myFrientPoint < UseFriend then
            alertMSN.NoFriendPoint()
        elseif Myslot < characterAll then
            alertMSN.NoHaveSlot(mypage)
        else
            changePoint =  myFrientPoint - UseFriend
            local option = {

                effect = "fade",
                time = 100,
                params =
                {
                    changePoint = changePoint,
                    sentoyou = event.target.id,
                    user_id = user_id
                }
            }

            local gdisplayGacha = display.newGroup()
            local function onTouchGacha_card(event)

                display.remove(gdisplay)
                gdisplay = nil

                     storyboard.gotoScene("gacha_card",option)

            end


            local background1 = display.newImageRect(imgBG,system.DocumentsDirectory,screenW,screenH)
            background1:setReferencePoint( display.TopLeftReferencePoint )
            background1.x, background1.y = 0, 0
            gdisplayGacha:insert(background1)
            gdisplayGacha.touch = onTouchGacha_card
            gdisplayGacha:addEventListener( "touch", gdisplayGacha )
            gdisplay:insert(gdisplayGacha)
            lightaura()
            darkon()
        end
    elseif event.target.id == "Diamond_OK" then
        if myDiamondPoint < UseDimond then
            alertMSN.NoDiamondPoint()
        elseif Myslot < characterAll then
            alertMSN.NoHaveSlot(mypage)
        else

            changePoint = myDiamondPoint - UseDimond
            local option = {

                effect = "fade",
                time = 100,
                params =
                {
                    changePoint = changePoint,
                    sentoyou = event.target.id,
                    user_id = user_id
                }
            }
            local gdisplayGacha = display.newGroup()
            local function onTouchGacha_card(event)

                display.remove(gdisplay)
                gdisplay = nil

                require("menu").removeDisplay()
                storyboard.gotoScene("gacha_card",option)

            end

            local background1 = display.newImageRect(imgBG,system.DocumentsDirectory,screenW,screenH)
            background1:setReferencePoint( display.TopLeftReferencePoint )
            background1.x, background1.y = 0, 0
            gdisplayGacha:insert(background1)
            gdisplayGacha.touch = onTouchGacha_card
            gdisplayGacha:addEventListener( "touch", gdisplayGacha )
            gdisplay:insert(gdisplayGacha)
            lightaura()
            darkon()
        end

    elseif event.target.id == 1 then
        FriendPoint()

    elseif event.target.id == 2 then
        Diamond()

    end

end
function scene:createScene( event )
    local group = self.view

    myFrientPoint = menu_barLight.FrientPoint()

    myDiamondPoint = menu_barLight.diamond()
    user_id = menu_barLight.user_id()
    Myslot = menu_barLight.slot()
    characterAll = menu_barLight.characterAll()
    characterAll = characterAll + 1
    gdisplay = display.newGroup()
    gdisplay:insert(background)

    local img_text = "img/text/gachapon.png"
    local titleText = display.newImageRect(img_text,screenW*.3,screenH*.027 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.5
    titleText.y = screenH *.32
    gdisplay:insert(titleText)

    gdisplay:insert(menu_barLight.newMenubutton())
    local maxlist = 2
    local pointY = screenH*.4

   for i = 1,maxlist,1 do
        if i==1 then
            text = "FRIEND POINT GACHAPON"

        elseif i==2 then
            text = "GOLD GACHAPON"

        end
        local iconbox = "img/background/iconbox.png"
        local btnOK = widget.newButton{
            defaultFile = iconbox,
            overFile = iconbox,
            width=  screenW*.62, height= screenH*.08,
            onRelease = GachaRelease,	-- event listener function
            label = text  ,
            labelColor = {
                default = { 255, 255, 255, 255},
                over = { 255, 255, 255, 255 },
            }         ,
            font = typeFont,
            fontSize = sizetextName,
        }
        btnOK.id = i --ok
        btnOK:setReferencePoint( display.CenterReferencePoint )
        btnOK.alpha = 1
        btnOK.x = screenW*.5
        btnOK.y = pointY
        gdisplay:insert(btnOK)

        pointY = pointY + screenH*.1
    end



    local usedataFrientPoint = 200
    local dataFrientPoint = menu_barLight.FrientPoint()
    if dataFrientPoint >= usedataFrientPoint then
        local backcolor =  display.newRoundedRect(screenW*.73, screenH*.38, screenW*.05, screenH*.033,5)
        backcolor.strokeWidth = 2
        backcolor:setStrokeColor(255,255,255)
        backcolor.alpha = 1
        backcolor:setFillColor(200, 0, 0)
        gdisplay:insert(backcolor)

        local sizeMaxfriend = 20
        local maxFriendPoint = math.floor(dataFrientPoint/usedataFrientPoint)
        local maxLenght = string.len(maxFriendPoint)
        local pointNum = (screenW*.75)-((maxLenght*sizeMaxfriend)/5)

        local Myfriend = display.newText(maxFriendPoint, pointNum, screenH*.38, typeFont, sizeMaxfriend)
        Myfriend:setTextColor(0, 0, 0)
        gdisplay:insert(Myfriend)

    end

    --FriendPoint()
    group:insert(gdisplay)
    ------------- other scene ---------------
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "gacha_card" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
