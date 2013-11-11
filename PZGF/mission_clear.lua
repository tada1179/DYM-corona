local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"

local alertMSN = require ("alertMassage")
local http = require("socket.http")
local json = require("json")
local util = require("util")

local menu_barLight = require ("menu_barLight")
local loadImageSprite = require ("downloadData").loadImageSprite_LVLup_Animation()

menu_barLight.mainsound()
----------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local image_flagtest = "img/background/puzzle/flagtest.png"
local image_btnnext = "img/background/button/Button_NEXT.png"
local image_text = "img/text/MISSION_CLEAR.png"
local typeFont = native.systemFontBold
----------------------
local NumFlag =nil
local mission_id =nil
local mission_exp =nil
local NumCoin =nil
local getCharac_id ={}
local levelUpChar ={}
local characterImg ={}
--------------------
local backButton

local treasure = {}
local transitionStash = {}

local user_id
local imgFlagBox = {}
local myItem = {}
local allItem
local gdisplay

local maxlv = 99
local TimersST = {}
local frame = alertMSN.loadFramElement()
local slot
local HoldcharacterAll
local sheetInfo = require("chara_icon")
local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )

local image_sheet = {
    "LVLup_Animation_1font.png",
    "LVLup_Animation_2shield.png",
    "LVLup_Animation_3effect.png",
}
------------------------------------------------------------------------------
local function popLevelUpBoss()
    local groupGameLayer = display.newGroup()
     local Fontlevel = function()
        local sheetdata_light = {width = 512, height = 512,numFrames = 45, sheetContentWidth = 2560 ,sheetContentHeight = 4608 }

        local sheet_light = graphics.newImageSheet( image_sheet[1],system.DocumentsDirectory, sheetdata_light )
        local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

        local Victory_font = display.newSprite( sheet_light, sequenceData )
        Victory_font:setReferencePoint( display.CenterReferencePoint)
        Victory_font.x = screenW*.5
        Victory_font.y = screenH*.5
        local function FNFontlevel()
            Victory_font:setSequence( "lightaura" )
            Victory_font:play()
        end
        groupGameLayer:insert(Victory_font)
        TimersST.myTimer = timer.performWithDelay(0,FNFontlevel )
     end
    local shield = function()
        local sheetdata_light = {width = 512, height = 512,numFrames = 45, sheetContentWidth = 2560 ,sheetContentHeight = 4608 }

        local sheet_light = graphics.newImageSheet( image_sheet[2],system.DocumentsDirectory, sheetdata_light )
        local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

        local Victory_slide = display.newSprite( sheet_light, sequenceData )
        Victory_slide:setReferencePoint( display.CenterReferencePoint)
        Victory_slide.x = screenW*.5
        Victory_slide.y = screenH*.5
        local function FNshield()
            Victory_slide:setSequence( "lightaura" )
            Victory_slide:play()
        end
        groupGameLayer:insert(Victory_slide)
        TimersST.myTimer = timer.performWithDelay(0,FNshield )
    end
    local effect = function()
        local sheetdata_light = {width = 512, height = 512,numFrames = 45, sheetContentWidth = 2560 ,sheetContentHeight = 4608 }

        local sheet_light = graphics.newImageSheet( image_sheet[3],system.DocumentsDirectory, sheetdata_light )
        local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

        local Victory_effect = display.newSprite( sheet_light, sequenceData )
        Victory_effect:setReferencePoint( display.CenterReferencePoint)
        Victory_effect.x = screenW*.5
        Victory_effect.y = screenH*.5
        local function FNeffect()
            Victory_effect:setSequence( "lightaura" )
            Victory_effect:play()
        end
        groupGameLayer:insert(Victory_effect)
        TimersST.myTimer = timer.performWithDelay(0,FNeffect )
    end
    local stopPoplevelup = function()
        display.remove(groupGameLayer)
        groupGameLayer = nil
    end
    TimersST.myTimer = timer.performWithDelay(500,effect )
    TimersST.myTimer = timer.performWithDelay(500,shield )
    TimersST.myTimer = timer.performWithDelay(500,Fontlevel )
    transition.to( groupGameLayer, { time=3500, xScale=1, yScale=1, alpha=1,onComplete = stopPoplevelup})

end
local function popLevelUp(param)
--     local imgPig = "img/character/chara_icon/luibei_i101.png"
     local imgPig = param.charac_img
     local imgFRM = tonumber(param.charac_element)

    local groupGameLayer = display.newGroup()
     local pigcharac = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(imgPig) ,screenW*.32,screenH*.2)--contentWidth contentHeight
     pigcharac:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
     pigcharac.x = display.contentWidth*.5
     pigcharac.y = display.contentHeight*.5

     local FRpigcharac = display.newImageRect(frame[imgFRM],screenW*.32,screenH*.2)--contentWidth contentHeight
--     local FRpigcharac = display.newImageRect(fream[1],screenW*.28,screenH*.2)--contentWidth contentHeight
     FRpigcharac:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
     FRpigcharac.x = display.contentWidth*.5
     FRpigcharac.y = display.contentHeight*.5


     local Fontlevel2 = function()
        local sheetdata_light = {width = 512, height = 512,numFrames = 45, sheetContentWidth = 2560 ,sheetContentHeight = 4608 }

        local sheet_light = graphics.newImageSheet( image_sheet[1],system.DocumentsDirectory, sheetdata_light )
        local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

        local Victory_font = display.newSprite( sheet_light, sequenceData )
        Victory_font:setReferencePoint( display.CenterReferencePoint)
        Victory_font.x = screenW*.5
        Victory_font.y = screenH*.5
        local function FNFontlevel2()
            Victory_font:setSequence( "lightaura" )
            Victory_font:play()
        end
        groupGameLayer:insert(Victory_font)
        TimersST.myTimer = timer.performWithDelay(0,FNFontlevel2 )
     end
    local shield2 = function()
        local sheetdata_light = {width = 512, height = 512,numFrames = 45, sheetContentWidth = 2560 ,sheetContentHeight = 4608 }

        local sheet_light = graphics.newImageSheet( image_sheet[2],system.DocumentsDirectory, sheetdata_light )
        local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

        local Victory_slide = display.newSprite( sheet_light, sequenceData )
        Victory_slide:setReferencePoint( display.CenterReferencePoint)
        Victory_slide.x = screenW*.5
        Victory_slide.y = screenH*.5
        local function FNshield2()
            Victory_slide:setSequence( "lightaura" )
            Victory_slide:play()
        end
        groupGameLayer:insert(Victory_slide)
        TimersST.myTimer = timer.performWithDelay(0,FNshield2 )
    end
    local effect2 = function()
        local sheetdata_light = {width = 512, height = 512,numFrames = 45, sheetContentWidth = 2560 ,sheetContentHeight = 4608 }

        local sheet_light = graphics.newImageSheet( image_sheet[3],system.DocumentsDirectory, sheetdata_light )
        local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=3000, loopCount=1 }

        local Victory_effect = display.newSprite( sheet_light, sequenceData )
        Victory_effect:setReferencePoint( display.CenterReferencePoint)
        Victory_effect.x = screenW*.5
        Victory_effect.y = screenH*.5
        local function FNeffect2()
            Victory_effect:setSequence( "lightaura" )
            Victory_effect:play()
        end
        groupGameLayer:insert(Victory_effect)
        TimersST.myTimer = timer.performWithDelay(0,FNeffect2 )
    end
    local stopPoplevelup = function()
        display.remove(groupGameLayer)
        groupGameLayer = nil
    end
     TimersST.myTimer = timer.performWithDelay(500,effect2 )
     TimersST.myTimer = timer.performWithDelay(500,shield2 )
     groupGameLayer:insert(pigcharac)
     groupGameLayer:insert(FRpigcharac)
     TimersST.myTimer = timer.performWithDelay(500,Fontlevel2 )
    transition.to( groupGameLayer, { time=3500,delay=100, xScale=1, yScale=1, alpha=1,onComplete = stopPoplevelup})

end
local function popLevelMax(param)

end
local function loadCharacter(event)
    --    NumFlag = 6
    --    getCharac_id = {13,119,82,13,119,82,13}

    local Linkmission = "http://133.242.169.252/DYM/hold_characterFromList.php"
    local numberHold_character =  Linkmission.."?user_id="..user_id.."&NumFlag="..NumFlag

    for i=1,NumFlag,1 do
        numberHold_character =numberHold_character.."&character_id"..i.."="..getCharac_id[i]
    end


    local numberHold = http.request(numberHold_character)
    local allRow  = json.decode(numberHold)

    allItem = tonumber(allRow.chrAll)

    if allItem == 0 then
        print("No Dice")
    else
        local k = 1
        while(k <= allItem) do
            myItem[k] = {}
            myItem[k].holdcharac_id = allRow.character[k].holdcharac_id
            myItem[k].charac_id = allRow.character[k].charac_id
            myItem[k].charac_name = allRow.character[k].charac_name
            myItem[k].charac_element = tonumber(allRow.character[k].charac_element)
            myItem[k].charac_img_mini = allRow.character[k].charac_img_mini
            k = k + 1

        end
    end

end
local function onBtnonclick(event)
     menu_barLight.SEtouchButton()
    if event.target.id == "next" then
        if slot >= HoldcharacterAll then
            storyboard.gotoScene( "map" ,"fade", 100 )
        else
            alertMSN.NoHaveSlot("map")
        end


    else
        local option = {
            effect = "fade",
            time = 100,
            params = {
                character_id = event.target.id,
                user_id = user_id ,
            }

        }
        storyboard.gotoScene( "characterprofile" ,option)
    end
    return true
end
local function createButton()
    local sizeimgW = screenW*.15
    local sizeimgH = screenH*.1
    local pointxFLAGfrm = screenW*.1


    for i = 1, allItem ,1 do
        imgFlagBox[i] = display.newImageRect(image_flagtest,sizeimgW,sizeimgH)
        imgFlagBox[i]:setReferencePoint( display.TopLeftReferencePoint )
        imgFlagBox[i].x = pointxFLAGfrm
        imgFlagBox[i].y = screenH *.69
        gdisplay:insert(imgFlagBox[i])

        pointxFLAGfrm = pointxFLAGfrm + screenW*.13
    end
end
local function onTouchFileScreen()
    background:removeEventListener( "touch", background )

    local nextButton = widget.newButton{
        defaultFile= image_btnnext,
        overFile= image_btnnext,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnonclick	-- event listener function
    }
    nextButton.id="next"
    nextButton:setReferencePoint( display.TopLeftReferencePoint )
    nextButton.x = display.contentWidth *.73
    nextButton.y = display.contentHeight - (display.contentHeight *.7)
    gdisplay:insert(nextButton)


    local sizeimgW = screenW*.12
    local sizeimgH = screenH*.08
    local pointxFLAGfrm = screenW*.1
    local imgCharacter = {}
    local imgfrm = {}


    local i = 1

    local function openPicture(id)
        transitionStash.newTransition = transition.to( imgFlagBox[id], { time=200,delay=0, alpha=0,onComplete = CountPic})

        imgCharacter[i] = widget.newButton{
            defaultFile = frame[myItem[i].charac_element],
            overFile = frame[myItem[i].charac_element] ,
            width = sizeimgW, height=sizeimgH,
            --onRelease = onBtnonclick	-- event listener function
        }
        imgCharacter[i].id= myItem[i].holdcharac_id
        imgCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
        imgCharacter[i].x = pointxFLAGfrm
        imgCharacter[i].y = screenH *.69


        imgfrm[i] = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(myItem[i].charac_img_mini),sizeimgW,sizeimgH)
        imgfrm[i]:setReferencePoint( display.TopLeftReferencePoint )
        imgfrm[i].x = pointxFLAGfrm
        imgfrm[i].y = screenH *.69
        pointxFLAGfrm = pointxFLAGfrm + screenW*.13
        gdisplay:insert(imgfrm[i])
        gdisplay:insert(imgCharacter[i])
    end
    function CountPic()
        if i<=allItem then
            openPicture(i)
            i = i+1
        end

    end
    CountPic()


end
function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()

    user_id = menu_barLight.user_id()
    local user_lv = menu_barLight.userLevel()
    slot = menu_barLight.slot()
    HoldcharacterAll = menu_barLight.HoldcharacterAll()

    local mission_name = "mission battle"
    local chapter_name = "Chapter NAme"
    NumCoin = 1000
    mission_exp = 84
    local NumPer = 99
    NumFlag = 0
     local mission_expNext =100
    -----------------------

    user_id = event.params.user_id
    mission_id = event.params.mission_id
    mission_name = event.params.mission_name
    chapter_name = event.params.chapter_name
    NumFlag = event.params.NumFlag
    mission_exp = event.params.mission_exp
    NumCoin = event.params.NumCoin
    getCharac_id = event.params.getCharac_id
    characterImg = event.params.levelUpChar
    local levelUpChar = json.decode(characterImg)

    local image_background  = "img/background/background_a1.png"
    background = display.newImageRect(image_background,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    group:insert(background)
    background.touch = onTouchFileScreen
    background:addEventListener( "touch", background )

    local titleText = display.newImageRect(image_text,screenW*.356,screenH*.028)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = display.contentWidth*.5
    titleText.y = display.contentHeight*.325
    group:insert(titleText)

    local img_tapLV = "img/background/frame/as_enemy_bar.png"
    local img_tapLV_color = "img/head/blue_colour.png"
    local TapLV = display.newImageRect(img_tapLV,screenW*.6,screenH*.025)
    TapLV:setReferencePoint(display.CenterReferencePoint)
    TapLV.x,TapLV.y = screenW*.5,screenH*.55

    local max_colorBar = screenW*.510
    local myexp = menu_barLight.user_exp()   --you have
    --B + (B * ((L - 1) / M) * (L*1.1)) = E
    local B = 84
    local M =  maxlv --99
    local mission_expNext =0
    local expLvBefor = 0

    for L=1,user_lv+1,1 do
        if L == user_lv then
            expLvBefor =  math.floor(mission_expNext + (B + (B * ((L - 1 ) / M) * ( L*1.1 ))))
        end
        mission_expNext = math.floor(mission_expNext + (B + (B * ((L - 1 ) / M) * ( L*1.1 ))))
    end
    local between = mission_expNext - expLvBefor
    local userhave = myexp - expLvBefor

    NumPer = math.floor((userhave/between)*100)
    local lenghtColor = math.floor(max_colorBar *(NumPer/100))

    local TapLVColor = display.newImageRect(img_tapLV_color,lenghtColor,screenH*.025)--color tab
    TapLVColor:setReferencePoint(display.CenterLeftReferencePoint)
    TapLVColor.x,TapLVColor.y = screenW*.24,screenH*.55
    group:insert(TapLVColor)
    group:insert(TapLV)

    local txt_LV = display.newText("Lv."..user_lv.." ( "..NumPer.."% )", 0, 0, typeFont, 20)
    txt_LV:setReferencePoint(display.TopLeftReferencePoint)
    txt_LV:setTextColor(255, 255, 255)
    txt_LV.x = screenW*.21
    txt_LV.y = screenH*.58
    group:insert(txt_LV)

    local txt_ExpAll = display.newText(myexp.."/"..mission_expNext.." Exp", 0, 0, typeFont, 20)
    txt_ExpAll:setReferencePoint(display.TopRightReferencePoint)
    txt_ExpAll:setTextColor(255, 255, 255)
    txt_ExpAll.x = screenW*.8
    txt_ExpAll.y = screenH*.58
    group:insert(txt_ExpAll)

    --text name mission
    local txtNamemission = display.newText(mission_name, 0, 0, typeFont, 23)
    txtNamemission:setTextColor(255, 255, 255)
    txtNamemission.x = screenW*.48
    txtNamemission.y = screenH*.42
    group:insert(txtNamemission)

    local txtNameChapter = display.newText(chapter_name, 0, 0, typeFont, 30)
    txtNameChapter:setTextColor(255, 255, 255)
    txtNameChapter.x = screenW*.48
    txtNameChapter.y = screenH*.38
    group:insert(txtNameChapter)

    local txtExpCoin = util.wrappedText("EXP\nCOIN", screenW*.3, 25,typeFont, {255, 255, 255})
    txtExpCoin:setReferencePoint(display.TopLeftReferencePoint)
    txtExpCoin.x = screenW *.25
    txtExpCoin.y = screenH *.42
    group:insert(txtExpCoin)

    local NumExpCoin = util.wrappedText(mission_exp.."\n"..NumCoin, screenW*.3, 25,typeFont, {255, 255, 255})
    NumExpCoin:setReferencePoint(display.TopLeftReferencePoint)
    NumExpCoin.x = screenW *.65
    NumExpCoin.y = screenH *.42
    group:insert(NumExpCoin)

    local txt_flag = display.newText("FLAG", 0, 0, typeFont, 20)
    txt_flag:setTextColor(255, 255, 255)
    txt_flag.x = screenW*.15
    txt_flag.y = screenH*.67

    loadCharacter()
    createButton()


    local dataTable = {}
    if levelUpChar ~= nil then
        if levelUpChar.Levelup ~=nil then
          for k = 1 ,levelUpChar.All ,1 do
              dataTable[k] = {}
              dataTable[k].status = levelUpChar.Levelup[k].status
              if dataTable[k].status == "boss" then
                  popLevelUpBoss()
              else
                  dataTable[k].hold_charac_id = levelUpChar.Levelup[k].hold_charac_id
                  dataTable[k].charac_img = levelUpChar.Levelup[k].charac_img
                  dataTable[k].charac_element = levelUpChar.Levelup[k].charac_element
                  dataTable[k].status = levelUpChar.Levelup[k].status
                  local option = {
                      hold_charac_id =  dataTable[k].hold_charac_id  ,
                      charac_img =  dataTable[k].charac_img ,
                      charac_element =  tonumber(dataTable[k].charac_element ),
                      status =  dataTable[k].status
                  }
                  if dataTable[k].status then   --status = 99 ,level max
                      popLevelUp(option)
                  else
                      popLevelUp(option)
                  end
              end
          end
        end

    end
    --popLevelUp()


    require("menu").ShowDisplay()

    group:insert(titleText)
    group:insert(txtNamemission)


    group:insert(txt_flag)

    group:insert(gdisplay)
end
function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "puzzleCode" )
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

