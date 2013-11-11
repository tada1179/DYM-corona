
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local alertMSN = require ("alertMassage")
local http = require("socket.http")
local json = require("json")
local loadImageSprite = require ("downloadData").loadImageSprite_Upgrade_Animation2()
-----------------------------------------------------------------------------------------
local screenW = display.contentWidth
local screenH = display.contentHeight

local numCharacter_up = 5 --power up select character max 5 item
local numALL = nil
local numCoin
local numUnit
local countID
local user_id
local Allcharacter
local countCharac
local numRow
local numColum = 5
--local allRow = {}

local character_id
local characterChoose = {}
local characterCHooseLV = {}
local characterCHooseImg = {}

local pointChoose = {}
local BLOCK_character = {}

local pointCharacX = {}
local pointCharacY = {}

local numCharacAll
local txtCoin
local txtUnit

local countCHNo
local characterItem = {}
local character_LV = nil

local groupTapCoin
local viewback
local scrollView
local gplayView
local groupClick
local formula = {}
local check = "00"
local unitAll = 0
local ShowCharact

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local sizetext = FontAndSize.fontGuest
local sizetextName = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead
---------------
local function LoadTeam()
    local LinkURL = "http://133.242.169.252/DYM/useCharacterAll.php"
    local numberHold_character =  LinkURL.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)

    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        Allcharacter = allRow.chrAll
        --local slot = menu_barLight.slot()

        local k = 1
        local m = 0
        while(k <= Allcharacter) do
            characterItem[k] = {}
            characterItem[k].charac_lvbase = tonumber(allRow.chracter[k].charac_lvbase)
            characterItem[k].charac_lvmax = tonumber(allRow.chracter[k].charac_lvmax)

            if character_id == nil then
                if  characterItem[k].charac_lvbase ~= characterItem[k].charac_lvmax  then
                    m = m + 1
                    characterItem[m].holdcharac_id= allRow.chracter[k].holdcharac_id
                    characterItem[m].dataTable = allRow.chracter[k].charac_img_mini
                    characterItem[m].charactID = allRow.chracter[k].charac_id
                    characterItem[m].element = tonumber(allRow.chracter[k].charac_element)
                    characterItem[m].charac_sac = tonumber(allRow.chracter[k].charac_sac)
                    characterItem[m].exp = tonumber(allRow.chracter[k].charac_exp)
                    characterItem[m].level = tonumber(allRow.chracter[k].charac_lv)
                    characterItem[m].charac_lvbase = tonumber(allRow.chracter[k].charac_lvbase)
                    characterItem[m].charac_lvmax = tonumber(allRow.chracter[k].charac_lvmax)
                    characterItem[m].use = allRow.chracter[k].use_id
                    formula[m] = math.ceil(characterItem[m].charac_sac+(characterItem[m].charac_sac*((characterItem[m].level-1)/characterItem[m].charac_lvmax)*1.5))
                end

            else
                characterItem[k].holdcharac_id= allRow.chracter[k].holdcharac_id
                characterItem[k].dataTable = allRow.chracter[k].charac_img_mini
                characterItem[k].charactID = allRow.chracter[k].charac_id
                characterItem[k].element = tonumber(allRow.chracter[k].charac_element)
                characterItem[k].charac_sac = tonumber(allRow.chracter[k].charac_sac)
                characterItem[k].exp = tonumber(allRow.chracter[k].charac_exp)
                characterItem[k].level = tonumber(allRow.chracter[k].charac_lv)
                characterItem[k].use = allRow.chracter[k].use_id
                formula[k] = math.ceil(characterItem[k].charac_sac+(characterItem[k].charac_sac*((characterItem[k].level-1)/characterItem[k].charac_lvmax)*1.5))
                if  characterItem[k].charac_lvbase == characterItem[k].charac_lvmax  then
                    characterItem[k].level = "MAX"
                end

            end

            k = k + 1
        end
        if character_id == nil then
            Allcharacter = m
        end

        numRow = math.ceil( unitAll / numColum)
        if unitAll > Allcharacter then
            ShowCharact = Allcharacter
        else
            ShowCharact =  unitAll
        end
    end
  --  print("------ ---- ---123456 --",ShowCharact)

    numRow = math.ceil( unitAll / 5)
    numALL = numRow * numColum
    if unitAll > Allcharacter then
        ShowCharact = Allcharacter
    else
        ShowCharact =  unitAll
    end
   -- db:close()
end
local function PowerUpButtonEvent(event)
    menu_barLight.SEtouchButton()
    local option =
    {
        effect = "fade",
        time = 100,
        params = {
            characterChoose = characterChoose ,
            pointCharacY = pointCharacY ,
            pointCharacX = pointCharacX ,
            countCHNo =  countCHNo  ,
            character_id = character_id  ,
            user_id = user_id ,
            characterCHooseLV = characterCHooseLV ,
            SUMformula = numUnit,
        }
    }

    if event.target.id == "reset" and countCHNo > 0 then
      for i = 1 ,countCHNo,1  do
          BLOCK_character[i].alpha = 0
          pointChoose[i].alpha = 0
      end

      countCHNo = 0
      numCoin = 0
      txtCoin.text = string.format( numCoin )
      txtUnit.text = string.format( countCHNo )
      numCharacAll.text = string.format(countCHNo.."/"..numALL )

      if numCoin then
          viewback.alpha = 0.8
      end

    else
        viewback:removeSelf()
        viewback = nil

        if event.target.id == "ok" then

            storyboard.gotoScene("power_up_main",option)

        elseif event.target.id == "back" then

            storyboard.gotoScene("unit_main",option)

        end

    end
    return true
end

local function character_choose(id,user_id,countNo,targetX,targetY,lv)--event.target.id,user_id,countNo,targetX,targetY
    local sizeleaderW = screenW*.14
    local sizeleaderH = screenH*.095
    local backView = display.newGroup()
    local framImage

    local frameNo =
    {
        "img/characterIcon/frameNo/1.png",
        "img/characterIcon/frameNo/2.png",
        "img/characterIcon/frameNo/3.png",
        "img/characterIcon/frameNo/4.png",
        "img/characterIcon/frameNo/5.png",
        "img/characterIcon/frameNo/6.png",
        "img/characterIcon/frameNo/7.png",
        "img/characterIcon/frameNo/8.png",
        "img/characterIcon/frameNo/9.png",
        "img/characterIcon/frameNo/10.png"

    }

    characterChoose[countNo] = id
    characterCHooseLV[countNo] = lv

    local function onTouchGameOverScreennum ( self,event )
        menu_barLight.SEtouchButton()
        local framImagex
        local framImagey
        check = "11"
       -- print("ontouch = ",event.target.id)
        if event.phase == "ended" and countCHNo > 0 and event.target.id == "1179" then


            countCHNo = countCHNo - 1
            txtUnit.text = string.format( countCHNo )
            backView.alpha = 0

            for i = 1,countCHNo ,1 do
                if i < countNo then
                    framImagex = pointChoose[i].x
                    framImagey = pointChoose[i].y
                    BLOCK_character[i].alpha = 0
                    pointChoose[i].alpha = 0

                else
                    framImagex = pointChoose[i+1].x
                    framImagey = pointChoose[i+1].y
                    BLOCK_character[i+1].alpha = 0
                    pointChoose[i+1].alpha = 0
                end
                pointCharacX[i] = framImagex
                pointCharacY[i] = framImagey
                character_choose(characterChoose[i],user_id,i,framImagex,framImagey,characterCHooseLV[i])

            end
            if countCHNo == 0 then
                BLOCK_character[countNo].alpha = 0
                pointChoose[countNo].alpha = 0
                numCoin = 0
                txtCoin.text = string.format( numCoin )
                numCharacAll.text = string.format( countCHNo.."/"..numALL )
                viewback.alpha = 0.8

                backView:removeEventListener( "touch", backView )
                backView:removeSelf()
                display.remove(backView)
                backView = nil
            else
                numCoin = tonumber( numCoin - (100*character_LV))
                txtCoin.text = string.format( numCoin )

                numUnit = tonumber( numUnit - (formula[countNo]))
                txtUnit.text = string.format( numUnit )

            end
            event.target.id = "1179"
        end
        menu_barLight.checkMemory()
        return true
    end

    txtCoin.text = string.format( numCoin )
    txtUnit.text = string.format( numUnit )
    numCharacAll.text = string.format( countCHNo.."/"..numALL )

    BLOCK_character[countNo]  =  display.newRect(targetX, targetY, sizeleaderW, sizeleaderH)
    BLOCK_character[countNo] .alpha = .8
    BLOCK_character[countNo]:setFillColor(130 ,130, 130)
    backView:insert(BLOCK_character[countNo])

    pointChoose[countNo] = display.newImageRect(frameNo[countNo] ,screenW*.05, screenH*.03)
    pointChoose[countNo]:setReferencePoint( display.TopLeftReferencePoint )
    pointChoose[countNo].x = targetX
    pointChoose[countNo].y = targetY
    backView:insert(pointChoose[countNo])

    backView.id = "1179"
    backView.touch = onTouchGameOverScreennum
    backView:addEventListener( "touch", backView )

    pointCharacX[countNo] = targetX
    pointCharacY[countNo] = targetY

    groupClick:insert(backView)
    scrollView:insert(backView)
    menu_barLight.checkMemory()
    return countCHNo

end

local function scrollViewList ()
   -- local group = event.view
    local sizeleaderW = screenW*.14
    local sizeleaderH = screenH*.095
    local groupView = display.newGroup()
    local frame = {}
    frame = alertMSN.loadFramElement()
    scrollView = widget.newScrollView{
        width = screenW *.77,
        height = screenH * .4,
        top = screenH *.35,
        left = screenW *.14,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true
    }
    local function onTouchGameOverScreen ( self, event )
        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    function onButtonEvent(event)

        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
            local scrollBar = self.scrollBar
        elseif event.phase == "moved" then

            local dy = math.abs( event.y - event.yStart )
            if  dy > 5 then
                scrollView:takeFocus( event )
            end

        elseif  event.phase == "ended" and event.target.id ~= "1179" then
            menu_barLight.SEtouchButton()
            if character_id == nil then
                local  targetX = event.target.x - (screenW * .07)
                local  targetY = event.target.y - (screenH * .048)
                 local point = {
                     x =  targetX,
                     y =  targetY,
                 }
                local character_scene = require("character_scene")
                character_scene.character_powerUP(event.target.id,user_id,gplayView,point)--(select touch,holddteam_no,team_id)
            else
                local  targetX = event.target.x - (screenW * .07)
                local  targetY = event.target.y - (screenH * .048)

                if countCHNo < numCharacter_up then
                    countCHNo = countCHNo + 1
                    characterChoose[countCHNo] = event.target.id

                    local LinkOneCharac = "http://133.242.169.252/DYM/Onecharacter.php"
                    local characterID =  LinkOneCharac.."?character="..characterChoose[countCHNo].."&user_id="..user_id
                    local characterImg = http.request(characterID)
                    local characterSelect
                    --local character_LV
                    local character_exp

                    if characterImg == nil then
                        print("No Dice")
                    else

                        characterSelect  = json.decode(characterImg)
                        --character_LV = characterSelect.chracter[1].charac_lv
                        character_exp = characterSelect.chracter[1].charac_exp

                        numCoin = numCoin + (character_LV*100)
                        txtCoin.text = string.format( numCoin )

                       -- print("formula[countCHNo] === ",formula[countCHNo])
                        numUnit = numUnit + (formula[countCHNo])
                        txtUnit.text = string.format( numUnit )

                    end

                    character_choose(characterChoose[countCHNo],user_id,countCHNo,targetX,targetY,character_LV)
                end
                if numCoin then
                    viewback.alpha = 0
                end
            end
        end
        return true
    end

    local LeaderpointX = 0
    local LeaderpointY = 0

    local LVpointX  =  screenH*.07
    local LVpointY  =  screenW*.03

    local InusepointX = screenW*.02
    local InusepointY = screenH*.03
    --print("Allcharacter = ",Allcharacter)
   local listCharacter = {}
    countID = 0
    countCharac = 0
    local sheetInfo = require("chara_icon")
--    local myImageSheet = graphics.newImageSheet( "img/character/chara_icon.png", sheetInfo:getSheet() )
    local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )

    for i = 1, numRow , 1 do  -- create colum
        for j = 1, numColum, 1 do --create row

            if countCharac < ShowCharact then

                countID = countID + 1
                listCharacter[countID] = widget.newButton{
                    sheet= myImageSheet,
--                    defaultFile= characterItem[countID].dataTable,
                    defaultFile= frame[characterItem[countID].element]  ,
                    width=sizeleaderW , height=sizeleaderH,
                    top = LeaderpointX,
                    left = LeaderpointY,
                    onEvent = onButtonEvent	-- event listener function
                }
                listCharacter[countID].id = characterItem[countID].holdcharac_id


                local framImage = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[countID].dataTable) ,sizeleaderW, sizeleaderH)
                framImage:setReferencePoint( display.TopLeftReferencePoint )
                framImage.x = LeaderpointY
                framImage.y = LeaderpointX
                scrollView:insert(framImage)
                scrollView:insert(listCharacter[countID])

                local textLV = display.newText("Lv."..characterItem[countID].level, LVpointY,LVpointX,typeFont, sizetext)
                textLV:setReferencePoint( display.CenterReferencePoint )
                if characterItem[countID].level == "MAX" then
                    textLV.x =  LVpointY + screenW*.04
                    textLV:setTextColor(255 ,215 ,0)
                else
                    textLV:setTextColor(255, 255, 255)
                end


                scrollView:insert(textLV)
               -- print("HAVE HAVE == character_id",character_id)
              if character_id == characterItem[countID].holdcharac_id then
                 -- print("HAVE HAVE ==")
                  listCharacter[countID].id = "1179"
                    local backcharacter = display.newRect(LeaderpointY, LeaderpointX, sizeleaderW, sizeleaderH)
                    backcharacter.strokeWidth = 0
                    backcharacter.alpha = 0.8
                    backcharacter:setFillColor(0, 0, 0)
                    scrollView:insert(backcharacter)

                    local texINUSE = display.newText("In use", InusepointX,InusepointY,typeFont, sizetext)
                    texINUSE:setTextColor(255, 0, 255)

                    groupView:insert(backcharacter)
                    groupView.touch = onTouchGameOverScreen
                    groupView:addEventListener( "touch", groupView )
                    scrollView:insert(groupView)
                    scrollView:insert(texINUSE)
              end
              if character_id then
                    if characterItem[countID].use then
                        listCharacter[countID].id = "1179"
                        local backcharacter = display.newRect(LeaderpointY, LeaderpointX, sizeleaderW, sizeleaderH)
                        backcharacter.alpha = 0.8
                        backcharacter.id = "1179"
                        backcharacter:setFillColor(0, 0, 0)
                        scrollView:insert(backcharacter)

                        groupView.id = "1179"
                        groupView:insert(backcharacter)
                        groupView.touch = onTouchGameOverScreen
                        groupView:addEventListener( "touch", groupView )
                        scrollView:insert(groupView)

                        local textInuse = display.newText("In use", InusepointX,InusepointY,typeFont, sizetext)
                        textInuse:setTextColor(200, 0, 200)
                        groupView:insert(textInuse)
                    end
              end

                countCharac = countCharac + 1
            elseif countID < unitAll then
                local framImage = display.newImageRect("img/characterIcon/as_cha_frm00.png" ,sizeleaderW, sizeleaderH)
                framImage:setReferencePoint( display.TopLeftReferencePoint )
                framImage.x = LeaderpointY
                framImage.y = LeaderpointX
                scrollView:insert(framImage)
                countID = countID + 1
            end


            LeaderpointY = LeaderpointY + (screenW *.15)
            LVpointY = LVpointY +  (screenW *.15)
            InusepointX = InusepointX + (screenW*.15)

        end

        InusepointX =  screenW*.02
        LeaderpointY = 0
        LVpointY =  screenW*.03
        LeaderpointX = LeaderpointX + (screenH *.11)
        LVpointX = LVpointX + (screenH *.11)
        InusepointY = InusepointY + (screenH *.11)

    end
end

function scene:createScene( event )
    viewback = display.newGroup()
    gplayView = display.newGroup()
    groupTapCoin = display.newGroup()
    groupClick = display.newGroup()
    countCHNo = 0
    numCoin = 0
    numUnit = 0
    character_LV = nil
    character_id = nil
    local image_textBox = "img/text/COIN,EXP,UNIT_BOX.png"
    local img_reset = "img/background/button/as_team_reset.png"
    local img_OK = "img/background/button/OK.png"
--    local image_background = "img/background/background_1.jpg"
    local groupTapCoin = nil
    local group = self.view
    user_id = menu_barLight.user_id()
    unitAll = menu_barLight.slot()

    local groupView = display.newGroup()

    local params = event.params

    local function onTouchGameOverScreenCreate ( self, event )
        if event.phase == "began" then
            --storyboard.gotoScene( "menu-scene", "fade", 400  )
            return true
        end
    end

    gplayView:insert(background)
    if params then
        countCHNo = params.countCHNo
        if countCHNo then
            countCHNo = params.countCHNo
            numUnit = params.SUMformula
            character_id = params.character_id
            user_id = params.user_id
        end

    end
    LoadTeam()
    scrollViewList()

    local titleText = display.newImageRect( "img/text/POWER_UP.png", screenW/4.5, screenH/34 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.14

    local numCharac = display.newText(Allcharacter.."/"..unitAll, screenW*.7, screenH*.31,typeFont, sizetext)
    numCharac.text = string.format( Allcharacter.."/"..unitAll )
    numCharac:setTextColor(205, 170, 125)

    local image_btnback = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
        defaultFile= image_btnback,
        over= image_btnback,
        width=screenW/10, height=screenH/21,
        onRelease = PowerUpButtonEvent	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW - (screenW *.845)
    backButton.y = screenH - (screenH *.7)
    if params then
        groupTapCoin = display.newGroup()
        txtCoin = display.newText(numCoin, screenW*.5, screenH*.763,typeFont, sizetext)
        txtCoin.text = string.format( numCoin )
        txtCoin:setTextColor(205, 170, 125)

        txtUnit = display.newText(numUnit, screenW*.5, screenH*.79,typeFont, sizetext)
        txtUnit.text = string.format( numUnit )
        txtUnit:setTextColor(205, 170, 125)

        numCharacAll = display.newText(numUnit.."/"..unitAll, screenW*.5, screenH*.815,typeFont, sizetext)
        numCharacAll:setTextColor(205, 170, 125)

        character_LV = tonumber(params.character_LV)
       -- print("****** ******* character_LV ==== ",character_LV)
        countCHNo = params.countCHNo
        if countCHNo then
            countCHNo = params.countCHNo
            numUnit = params.SUMformula
            character_id = params.character_id
            user_id = params.user_id

            for k = 1,countCHNo, 1  do
                characterChoose[k] = params.characterChoose[k]
                characterCHooseLV[k] = params.characterCHooseLV[k]
                pointCharacX[k] = params.pointCharacX[k]
                pointCharacY[k] = params.pointCharacY[k]
                character_choose(characterChoose[k] ,user_id,k,pointCharacX[k] ,pointCharacY[k],characterCHooseLV[k] )
                numCoin = numCoin + (characterCHooseLV[k]*100)
            end

            txtCoin.text = string.format( numCoin )

            txtUnit.text = string.format( numUnit )
        else

            countCHNo = 0
        end


       -- character_id = params.character_id


        local BLOCK_BOX =  display.newRect(screenW*.07, screenH*.76, screenW*.86, screenH*.075)
        BLOCK_BOX.alpha = .8
        BLOCK_BOX:setFillColor(130 ,130, 130)
        groupTapCoin:insert(BLOCK_BOX)
        groupTapCoin:insert(numCharacAll)

        local titleBox = display.newImageRect( image_textBox, screenW*.15, screenH*.065)
        titleBox:setReferencePoint( display.CenterReferencePoint )
        titleBox.x = screenW*.35
        titleBox.y = screenH*.8
        groupTapCoin:insert(titleBox)

        local btnreset = widget.newButton{
            defaultFile= img_reset,
            width=screenH*.1 , height=screenW*.1,
            top = screenH*.765,
            left = screenW*.085,
            onRelease = PowerUpButtonEvent	-- event listener function
        }btnreset.id = "reset"
        groupTapCoin:insert(btnreset)

        local btnOK = widget.newButton{
            defaultFile= img_OK,
            width=screenH*.1 , height=screenW*.1,
            top = screenH*.765,
            left = screenW*.76,
            onRelease = PowerUpButtonEvent	-- event listener function
        }btnOK.id = "ok"
        groupTapCoin:insert(btnOK)


        local  backcharacter = display.newRoundedRect(screenW*.76, screenH*.765, screenH*.1, screenW*.1,5)
        backcharacter.strokeWidth = 0
        backcharacter:setFillColor(0, 0, 0)
        groupTapCoin:insert(backcharacter)

        local backreset = display.newRoundedRect(screenW*.085, screenH*.765, screenH*.1, screenW*.1,5)
        backreset.strokeWidth = 0
        backreset:setFillColor(0, 0, 0)
        groupTapCoin:insert(backreset)

        viewback:insert(backreset)
        viewback:insert(backcharacter)

        if countCHNo == 0  then

            viewback.alpha = 0.8
            viewback.touch = onTouchGameOverScreenCreate
            viewback:addEventListener( "touch", viewback )

        else
            viewback:removeEventListener( "touch", viewback )
            viewback.alpha = 0
        end

        local slot = menu_barLight.slot()
        local HoldcharacterAll = menu_barLight.HoldcharacterAll()
        if slot >= HoldcharacterAll then
           -- storyboard.gotoScene( "map" ,"fade", 100 )
        else
            alertMSN.NoHaveSlot("characterAll")
        end

        groupTapCoin:insert(txtCoin)
        groupTapCoin:insert(txtUnit)
    end


    gplayView:insert(scrollView)
    gplayView:insert(groupClick)
    gplayView:insert(scrollView)
    gplayView:insert(backButton)
    gplayView:insert(titleText)
    gplayView:insert(numCharac)
    gplayView:insert(groupView)
    gplayView:insert(viewback)
    if groupTapCoin~= nil then
        gplayView:insert(groupTapCoin)
    end


    gplayView:insert(menu_barLight.newMenubutton())
    group:insert(gplayView)
    ------------- other scene ---------------
    menu_barLight.checkMemory()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene("unit_main")
    storyboard.purgeAll()
    storyboard.removeAll ()
end

function scene:exitScene( event )
    local group = self.view

    storyboard.purgeAll()
    storyboard.removeAll ()
end

function scene:destroyScene( event )
    local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
