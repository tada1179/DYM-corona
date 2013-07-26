local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
-----------------------------------------------------------------------------------------
local screenW = display.contentWidth
local screenH = display.contentHeight

local numCharacter_up = 10 --discharge can select character max 10 item
local numCoin = 0
local user_id
local Allcharacter = nil
local numRow = nil
local numColum = 5

local characterCHooseLV = {}
local characterChoose = {}
local pointChoose = {}
local BLOCK_character = {}
local pointCharacX = {}
local pointCharacY = {}

local txtCoin
local txtUnit

local scrollView
local gdisplay = display.newGroup()
local backView = display.newGroup()
local viewback = display.newGroup()

local backViewchoose = display.newGroup()
local groupView = display.newGroup()

local typeFont = native.systemFontBold
local sizetext = 20

local sizeleaderW = screenW*.135
local sizeleaderH = screenW*.135

local countCHNo = 0

------------ team character -----------------
local characterItem = {}
storyboard.isDebug = true
---------------------------------------------

local function LoadTeam()
    local LinkURL = "http://localhost/DYM/useCharacterAll.php"
    local numberHold_character =  LinkURL.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)

    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        Allcharacter = allRow.chrAll
        numRow = math.ceil( Allcharacter / 5)

        local k = 1
        while(k <= Allcharacter) do
            characterItem[k] = {}
            characterItem[k].holdcharac = allRow.chracter[k].holdcharac_id
            characterItem[k].dataTable = allRow.chracter[k].charac_img_mini
            characterItem[k].charactID = allRow.chracter[k].charac_id
            characterItem[k].element = tonumber(allRow.chracter[k].charac_element)
            characterItem[k].level = tonumber(allRow.chracter[k].charac_lv)
            characterItem[k].use = allRow.chracter[k].use_id
            k = k + 1
        end
    end
end
local function BackButton(event)
    characterCHooseLV = nil
    characterChoose = nil
    pointChoose = nil
    BLOCK_character = nil
    pointCharacX = nil
    pointCharacY = nil
    numCharacter_up = nil --discharge can select character max 10 item
    numCoin = nil
    user_id = nil
    Allcharacter = nil
    numRow = nil
    numColum = nil
    characterItem = nil
    typeFont = nil
    sizetext = nil

    sizeleaderW = nil
    sizeleaderH = nil
    countCHNo = nil

     backView:removeSelf()
     display.remove(backView)
     backView = nil

     viewback:removeEventListener( "touch", viewback )
     viewback:removeSelf()
     display.remove(viewback)
     viewback = nil

     gdisplay:removeSelf()
     display.remove(gdisplay)
     gdisplay = nil

     scrollView:removeSelf()
     display.remove(scrollView)
     scrollView = nil

     groupView:removeEventListener( "touch", groupView )
     groupView:removeSelf()
     display.remove(groupView)
     groupView = nil

     backViewchoose:removeEventListener( "touch",backViewchoose )
     backViewchoose:removeSelf()
     display.remove(backViewchoose)
     backViewchoose = nil

    storyboard.gotoScene( "unit_main", "fade",100 )
end
local function PowerUpButtonEvent(event)

    if event.target.id == "reset" and countCHNo > 0 then
        for i = 1 ,countCHNo,1  do
            BLOCK_character[i].alpha = 0
            pointChoose[i].alpha = 0
        end
        countCHNo = 0
        numCoin = 0

        if numCoin then
            viewback.alpha = 0.8
        end
        txtUnit.text = string.format(countCHNo.."/"..numCharacter_up )
        txtCoin.text = string.format(numCoin )

    elseif event.target.id == "ok" and countCHNo > 0 then
        local alertMassage = require("alertMassage")
       alertMassage.confrimDischarge(countCHNo,characterChoose,numCoin,user_id) --

    end
    menu_barLight.checkMemory()
    return true
end
local function character_choose(id,user_id,countNo,targetX,targetY,lv)--event.target.id,user_id,countNo,targetX,targetY
    local sizeleaderW = screenW*.14
    local sizeleaderH = screenH*.095

    local ViewView = display.newGroup()
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
        local framImagex
        local framImagey

        if event.phase == "began" and countCHNo > 0 then
            countCHNo = countCHNo - 1
            ViewView.alpha = 0
            txtUnit.text = string.format( countCHNo.."/"..numCharacter_up )

            ViewView:removeEventListener( "touch", ViewView )
            ViewView:removeSelf()
            display.remove(ViewView)
            ViewView = nil

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
                numCoin = 0
                pointChoose[countNo].alpha = 0
                BLOCK_character[countNo].alpha = 0
                txtCoin.text = string.format( numCoin )
                viewback.alpha = 0.8

--
--                display.remove(ViewView)
--                ViewView = nil

            else
                numCoin = tonumber( numCoin - (characterCHooseLV[countNo]*100))
                txtCoin.text = string.format( numCoin )
            end


        end
        menu_barLight.checkMemory()
        return true
    end

    txtCoin.text = string.format( numCoin )
    txtUnit.text = string.format( countCHNo.."/"..numCharacter_up )

    BLOCK_character[countNo]  =  display.newRect(targetX, targetY, sizeleaderW, sizeleaderH)
    BLOCK_character[countNo].alpha = .8
    BLOCK_character[countNo]:setFillColor(130 ,130, 130)
    ViewView:insert(BLOCK_character[countNo])

    pointChoose[countNo] = display.newImageRect(frameNo[countNo] ,screenW*.05, screenH*.03)
    pointChoose[countNo]:setReferencePoint( display.TopLeftReferencePoint )
    pointChoose[countNo].x = targetX
    pointChoose[countNo].y = targetY
    ViewView:insert(pointChoose[countNo])

    ViewView.id = id
    ViewView.touch = onTouchGameOverScreennum
    ViewView:addEventListener( "touch", ViewView )

    pointCharacX[countNo] = targetX
    pointCharacY[countNo] = targetY

    backViewchoose:insert(ViewView)
    menu_barLight.checkMemory()
    return countCHNo
end
local function scrollViewList ()
    local frame = {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
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
            -- if finger drags button more than 5 pixels, pass focus to scrollView
            if  dy > 5 then
                scrollView:takeFocus( event )
            end

        elseif  event.phase == "ended" or event.phase == "release" then
                local  targetX = event.target.x + (screenW * .06)
                local  targetY = event.target.y + (screenH * .305)
                countCHNo = countCHNo + 1
                if countCHNo <= numCharacter_up then
                    characterChoose[countCHNo] = event.target.id
                    txtUnit.text = string.format(countCHNo.."/"..numCharacter_up )

                    local LinkOneCharac = "http://localhost/DYM/Onecharacter.php"
                    local characterID =  LinkOneCharac.."?character="..characterChoose[countCHNo].."&user_id="..user_id
                    local characterImg = http.request(characterID)
                    local character_LV

                    if characterImg == nil then
                        print("No Dice")
                    else
                        local characterSelect  = json.decode(characterImg)
                        character_LV = tonumber(characterSelect.chracter[1].charac_lv)
                        numCoin = numCoin + tonumber(character_LV*100)
                    end
                    character_choose(characterChoose[countCHNo],user_id,countCHNo,targetX,targetY,character_LV)
                end
                if numCoin then
                    viewback.alpha = 0
                end
        end

        return true
    end

    scrollView = widget.newScrollView{
        width = screenW *.75,
        height = screenH * .45,
        top = screenH *.35,
        left = screenW *.13,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true

    }
    local LeaderpointX = 0
    local LeaderpointY = 0

    local LVpointX = screenW *.1
    local LVpointY = screenW *.03

    local InusepointX = screenH *.04
    local InusepointY = screenW *.015
    local countCharac = 0
    local countID = 0
    local listCharacter = {}
    for i = 1, numRow , 1 do  -- create colum
        for j = 1, numColum, 1 do --create row

            if countCharac < Allcharacter then

                countID = countID + 1
                listCharacter[countID] = widget.newButton{
                    default= characterItem[countID].dataTable,
                    width=sizeleaderW , height=sizeleaderH,
                    top = LeaderpointX,
                    left = LeaderpointY,
                    onEvent = onButtonEvent	-- event listener function
                }

                listCharacter[countID].id = characterItem[countID].holdcharac
                scrollView:insert(listCharacter[countID])

                local framImage = display.newImageRect(frame[characterItem[countID].element] ,sizeleaderW, sizeleaderH)
                framImage:setReferencePoint( display.TopLeftReferencePoint )
                framImage.x = LeaderpointY
                framImage.y = LeaderpointX
                scrollView:insert(framImage)

                local textLV = display.newText("Lv."..characterItem[countID].level, LVpointY,LVpointX,typeFont, sizetext)
                textLV:setTextColor(255, 255, 255)
                scrollView:insert(textLV)
                local txtInuse  = "In-use"

                if characterItem[countID].use then
                    local backcharacter = display.newRect(LeaderpointY, LeaderpointX, sizeleaderW, sizeleaderH)
                    backcharacter.alpha = 0.8
                    backcharacter:setFillColor(0, 0, 0)
                    scrollView:insert(backcharacter)

                    groupView:insert(backcharacter)
                    groupView.touch = onTouchGameOverScreen
                    groupView:addEventListener( "touch", groupView )
                    scrollView:insert(groupView)

                    local textInuse = display.newText(txtInuse, InusepointY,InusepointX,typeFont, sizetext)
                    textInuse:setTextColor(200, 0, 200)
                    groupView:insert(textInuse)
                end
                countCharac = countCharac + 1
            end
            LeaderpointY = LeaderpointY+(screenH*.1)
            LVpointY = LVpointY + (screenH*.1)
            InusepointY = InusepointY + (screenH*.1)
        end
        LeaderpointY = 0
        LVpointY = screenW *.03
        InusepointY = screenW *.015
        InusepointX = InusepointX + (screenW*.15)
        LVpointX = LVpointX + (screenW*.15)
        LeaderpointX = LeaderpointX + (screenW*.15)
    end
end
local function createBackButton()
    local image_btnback = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=screenW/10, height=screenH/21,
        onRelease = BackButton	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW - (screenW *.845)
    backButton.y = screenH - (screenH *.7)
    gdisplay:insert(backButton)

end
local function onTouchGameOverScreen ( self, event )

    if event.phase == "began" then

        --storyboard.gotoScene( "menu-scene", "fade", 400  )

        return true
    end
end
function scene:createScene( event )
    print("--discharge_main--")
    local img_title = "img/text/DISCHARGE.png"
    local image_textBox = "img/text/coin,unit,unit_box.png"
    local img_reset = "img/background/button/as_team_reset.png"
    local img_OK = "img/background/button/OK.png"

    local group = self.view
    user_id = menu_barLight.user_id()
    local numSlot = menu_barLight.slot()
    LoadTeam()
    local grouptab = display.newGroup()
    local params = event.params

    if params then
        countCHNo = params.countCHNo
        numCoin = params.numCoin

    end
    local numCharacAll = display.newText(Allcharacter.."/"..numSlot, screenW*.5, screenH*.815,typeFont, sizetext)
    numCharacAll:setTextColor(205, 170, 125)

    local BLOCK_BOX =  display.newRect(screenW*.07, screenH*.76, screenW*.86, screenH*.075)
    BLOCK_BOX.alpha = .8
    BLOCK_BOX:setFillColor(130 ,130, 130)

    grouptab:insert(BLOCK_BOX)
    grouptab:insert(numCharacAll)

    local titleBox = display.newImageRect( image_textBox, screenW*.15, screenH*.065)
    titleBox:setReferencePoint( display.CenterReferencePoint )
    titleBox.x = screenW*.35
    titleBox.y = screenH*.8
    grouptab:insert(titleBox)

    local btnreset = widget.newButton{
        default= img_reset,
        width=screenH*.1 , height=screenW*.1,
        top = screenH*.765,
        left = screenW*.085,
        onRelease = PowerUpButtonEvent	-- event listener function
    }btnreset.id = "reset"
    grouptab:insert(btnreset)

    local btnOK = widget.newButton{
        default= img_OK,
        width=screenH*.1 , height=screenW*.1,
        top = screenH*.765,
        left = screenW*.76,
        onRelease = PowerUpButtonEvent	-- event listener function
    }btnOK.id = "ok"
    grouptab:insert(btnOK)

    if countCHNo == 0  then
        local backcharacter = display.newRoundedRect(screenW*.76, screenH*.765, screenH*.1, screenW*.1,8)
        backcharacter.strokeWidth = 0
        backcharacter.alpha = 0.8
        backcharacter:setFillColor(0, 0, 0)
        grouptab:insert(backcharacter)

        local backreset = display.newRoundedRect(screenW*.085, screenH*.765, screenH*.1, screenW*.1,8)
        backreset.strokeWidth = 0
        backreset.alpha = 0.8
        backreset:setFillColor(0, 0, 0)
        grouptab:insert(backreset)

        viewback:insert(backreset)
        viewback:insert(backcharacter)
        viewback.touch = onTouchGameOverScreen
        viewback:addEventListener( "touch", viewback )
    else
        viewback.alpha = 0
    end

    txtCoin = display.newText(numCoin, screenW*.53, screenH*.763,typeFont, sizetext)
    txtCoin:setReferencePoint( display.TopLeftReferencePoint )
    txtCoin.text = string.format( numCoin )
    txtCoin:setTextColor(205, 170, 125)
    grouptab:insert(txtCoin)

    txtUnit = display.newText(countCHNo, screenW*.54, screenH*.79,typeFont, sizetext)
    txtUnit:setReferencePoint( display.TopLeftReferencePoint )
    txtUnit.text = string.format( countCHNo.."/"..numCharacter_up )
    txtUnit:setTextColor(205, 170, 125)
    grouptab:insert(txtUnit)

--    end
    local background = display.newImageRect("img_back", system.DocumentsDirectory,screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    scrollViewList()

    local titleText = display.newImageRect( img_title, screenW/4.5, screenH/34 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.14

    local numCharac = display.newText(Allcharacter.."/"..numSlot, screenW*.7, screenH*.31,typeFont, sizetext)
    numCharac.text = string.format( Allcharacter.."/"..numSlot )
    numCharac:setTextColor(205, 170, 125)

    gdisplay:insert(background)
    gdisplay:insert(scrollView)
    createBackButton()
    gdisplay:insert(titleText)
    gdisplay:insert(numCharac)
    gdisplay:insert(grouptab)
    gdisplay:insert(viewback)
    gdisplay:insert(backView)
    gdisplay:insert(menu_barLight.newMenubutton())
    group:insert(gdisplay)
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
    storyboard.removeAll ()
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
