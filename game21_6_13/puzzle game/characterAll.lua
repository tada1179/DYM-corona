
print("characterAll.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local includeFUN = require("includeFunction")
local character_scene = require("character_scene")
local http = require("socket.http")
local json = require("json")
-----------------------------------------------------------------------------------------
local groupGameLayer
local listCharacter = {}
local backButton
local LinkURL = "http://localhost/DYM/hold_character.php"
local LinkOneCharac = "http://localhost/DYM/character.php"

local viewback = display.newGroup()
local screenW = display.contentWidth
local screenH = display.contentHeight

local numCharacter_up = 5 --power up select character max 5 item
local numCH = 10
local numALL = 10
local numCoin = 0
local numUnit = 0

local countID = 0
local user_id
local Allcharacter
local countCharac = 0
local numRow
local numColum
local allRow = {}

local txtchoose = "choose"
local team_id
local holddteam_no
local character_id
local dataTable = {}
local charactID = {}
local element = {}
local level = {}

local characterChoose = {}
local pointChoose = {}
local BLOCK_character = {}
local pointCharacX = {}
local pointCharacY = {}

local numCharacAll
local numCharac
local txtCoin
local txtUnit


local scrollView
local  options
local BLOCK_BOX
local titleBox
local btnreset
local btnOK

local typeFont = native.systemFontBold
local sizetext = 20

local sizeleaderW = display.contentWidth*.135
local sizeleaderH = display.contentWidth*.135

local maxfram = 5

local countCHNo = 0


local function LoadTeam()
    print("user_id:"..user_id)

    local numberHold_character =  LinkURL.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)

    if numberHold == nil then
        print("No Dice")
    else
        allRow  = json.decode(numberHold)
        Allcharacter = allRow.chrAll
        numColum = 5
        numRow = math.ceil( Allcharacter / 5)
        numALL = numRow * numColum

        local k = 1
        while(k <= Allcharacter) do
            dataTable[k] = allRow.chracter[k].charac_img_mini
            charactID[k] = allRow.chracter[k].charac_id
            element[k] = allRow.chracter[k].charac_element
            level[k] = allRow.chracter[k].charac_lv
            k = k + 1
        end
    end
end
local function BackButton(event)

    options =
    {
        effect = "fade",
        time = 100,
        params = {
            character_id = 1 ,
            holddteam_no =  holddteam_no  ,
            team_id =  team_id ,
            user_id = user_id
        }
    }
    print( "11 event: "..event.target.id)
    storyboard.gotoScene( "unit_main", options )
    storyboard.disableAutoPurge = true
    return true	-- indicates successful touch
end
local function PowerUpButtonEvent(event)

    print("PowerUpButtonEvent event: "..event.target.id)
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
            user_id = user_id
        }
    }

    if event.target.id == "reset" then

      for i = 1 ,countCHNo,1  do
          BLOCK_character[i].alpha = 0
          pointChoose[i].alpha = 0
      end
      countCHNo = 0
      numCoin = 0
      if numCoin then
          viewback.alpha = 0.8
      end
    elseif event.target.id == "ok" then
        print("countCHNo",countCHNo)
        for i = 1 ,countCHNo,1  do
            BLOCK_character[i].alpha = 0
            pointChoose[i].alpha = 0
        end
        storyboard.gotoScene("power_up_main",option)
    end

end

local function character_choose(id,user_id,countNo,targetX,targetY)--event.target.id,user_id,countNo,targetX,targetY
    print("FN character_choose")
    local sizeleaderW = display.contentWidth*.135
    local sizeleaderH = display.contentWidth*.135
    local backView = display.newGroup()
    local displayView = display.newGroup()
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


    local function onTouchGameOverScreen ( self,event )
        print("11 touch countNo:",countNo)
        print("event.target.id:",event.target.id)
        local framImagex
        local framImagey

        if event.phase == "began" then
            countCHNo = countCHNo - 1
            backView.alpha = 0

            for i = 1,countCHNo ,1 do
                print("i:",i)
                if i < countNo then
                    print("<< countNo i:",i)
                    framImagex = pointChoose[i].x
                    framImagey = pointChoose[i].y
                    BLOCK_character[i].alpha = 0
                    pointChoose[i].alpha = 0
                else
                    print(">> countNo i:",i)
                    framImagex = pointChoose[i+1].x
                    framImagey = pointChoose[i+1].y
                    BLOCK_character[i+1].alpha = 0
                    pointChoose[i+1].alpha = 0
                end
                pointCharacX[i] = framImagex
                pointCharacY[i] = framImagey
                character_choose(characterChoose[i],user_id,i,framImagex,framImagey )

            end
        end
        return true
    end

    BLOCK_character[countNo]  =  display.newRect(targetX, targetY, sizeleaderW, sizeleaderH)
    BLOCK_character[countNo] .alpha = .8
    BLOCK_character[countNo]:setFillColor(130 ,130, 130)


    pointChoose[countNo] = display.newImageRect(frameNo[countNo] ,screenW*.05, screenH*.03)
    pointChoose[countNo]:setReferencePoint( display.TopLeftReferencePoint )
    pointChoose[countNo].x = targetX
    pointChoose[countNo].y = targetY


    backView:insert(BLOCK_character[countNo])
    backView:insert(pointChoose[countNo])

    backView.id = id
    backView.touch = onTouchGameOverScreen
    backView:addEventListener( "touch", backView )
    pointCharacX[countNo] = targetX
    pointCharacY[countNo] = targetY


    return countCHNo
end


local function scrollViewList ()
    local LeaderpointX
    local LeaderpointY

    local LVpointX
    local LVpointY

    local InusepointX
    local InusepointY

    local groupView = display.newGroup()
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
        print(event.phase)

        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
            local scrollBar = self.scrollBar
        elseif event.phase == "moved" then


            print("----///event.y:"..event.y)

            if event.markY ~= event.y and event.markX == event.x then
                print("if mark")
            else
                print("else mark")
            end

            local dy = math.abs( event.y - event.yStart )
            print("dy",dy)
            -- if finger drags button more than 5 pixels, pass focus to scrollView
            if  dy > 5 then
                scrollView:takeFocus( event )
                --moveScrollBar(dy)
            end

        elseif  event.phase == "ended" or event.phase == "release" then
            print("Character:"..event.target.id)
            if character_id == nil then
                print("no have character_id")
                character_scene.character_powerUP(event.target.id,user_id)
                --(select touch,holddteam_no,team_id)
            else
                local  targetX = event.target.x + (screenW * .08)
                local  targetY = event.target.y + (screenH * .305)
                countCHNo = countCHNo + 1
                if countCHNo <= numCharacter_up then
                    print("click countNo :",countCHNo)
                    characterChoose[countCHNo] = event.target.id
                    character_choose(characterChoose[countCHNo],user_id,countCHNo,targetX,targetY)

                    local characterID =  LinkOneCharac.."?character="..characterChoose[countCHNo].."&user_id="..user_id
                    local characterImg = http.request(characterID)
                    local characterSelect
                    local character_type
                    local character_name
                    local character_DEF
                    local character_ATK
                    local character_HP
                    local character_LV
                    local FrameCharacter
                    local ImageCharacter



                    if characterImg == nil then
                        print("No Dice")
                    else
                        characterSelect  = json.decode(characterImg)
                        character_type = "smach"
                        character_name = characterSelect.chracter[1].charac_name
                        character_DEF = characterSelect.chracter[1].charac_def
                        character_ATK = characterSelect.chracter[1].charac_atk
                        character_HP = characterSelect.chracter[1].charac_hp
                        character_LV = characterSelect.chracter[1].charac_lv
                        ImageCharacter = characterSelect.chracter[1].charac_img_mini
                        FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)

                        numCoin = numCoin + (character_LV*100)
                        txtCoin.text = string.format( numCoin )

                    end

                end
                if numCoin then
                    viewback.alpha = 0
                end
            end

        end

        return true
    end

    scrollView = widget.newScrollView{
        width = display.contentWidth *.75,
        height = display.contentHeight * .45,
        top = display.contentHeight *.35,
        left = display.contentWidth *.15,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true

    }


    for i = 1, numRow , 1 do  -- create colum
        for j = 1, numColum, 1 do --create row
            LeaderpointX = display.contentWidth *(-0.15+(i*0.15))
            LeaderpointY = display.contentHeight *(-0.12+(j*0.1))

            LVpointX = display.contentWidth *(-0.045+(i*0.15))
            LVpointY = display.contentHeight *(-0.1+(j*0.1))

            InusepointX = display.contentWidth *(-0.09+(i*0.15))
            InusepointY = display.contentHeight *(-0.113+(j*0.1))

            if countCharac < Allcharacter then



                countID = countID + 1
                listCharacter[countID] = widget.newButton{
                    default= dataTable[countID],
                    width=sizeleaderW , height=sizeleaderH,
                    top = LeaderpointX,
                    left = LeaderpointY,
                    onEvent = onButtonEvent	-- event listener function
                }

                listCharacter[countID].id = charactID[countID]
                scrollView:insert(listCharacter[countID])

                for m = 1, maxfram,1 do
                    local numele =  tonumber(element[countID])
                    if m == numele  then
                        local framImage = display.newImageRect(frame[m] ,sizeleaderW, sizeleaderH)
                        framImage:setReferencePoint( display.TopLeftReferencePoint )
                        framImage.x = LeaderpointY
                        framImage.y = LeaderpointX
                        scrollView:insert(framImage)
                    end

                end

                local textLV = display.newText("Lv."..level[countID], LVpointY,LVpointX,typeFont, sizetext)
                textLV:setTextColor(255, 255, 255)
                scrollView:insert(textLV)

                if character_id == charactID[countID] then
                    local backcharacter = display.newRect(LeaderpointY, LeaderpointX, sizeleaderW, sizeleaderH)
                    backcharacter.strokeWidth = 1
                    backcharacter.alpha = 0.8
                    backcharacter:setFillColor(0, 0, 0)
                    scrollView:insert(backcharacter)

                    groupView:insert(backcharacter)
                    groupView.touch = onTouchGameOverScreen
                    groupView:addEventListener( "touch", groupView )
                    scrollView:insert(groupView)


                end


                countCharac = countCharac + 1
            end
        end

    end
end

local function createBackButton()

    local image_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = BackButton	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
end
local function onTouchGameOverScreen ( self, event )

    if event.phase == "began" then

        --storyboard.gotoScene( "menu-scene", "fade", 400  )

        return true
    end
end
function scene:createScene( event )
    print("--------------character ALl power up----------------")
    local image_textBox = "img/text/COIN,EXP,UNIT_BOX.png"
    local img_reset = "img/background/button/as_team_reset.png"
    local img_OK = "img/background/button/OK.png"
    local image_background = "img/background/background_1.jpg"

    local group = self.view
    groupGameLayer = display.newGroup()
    local gdisplay = display.newGroup()
    user_id = includeFUN.USERIDPhone()
    print("SystemPhone::"..user_id)

    LoadTeam()
    local groupBKKView = display.newGroup()
    local groupView = display.newGroup()
    local params = event.params

    if params then
        countCHNo = params.countCHNo
        print("countCHNo",countCHNo)
        if countCHNo then
            print("create countCHNo",countCHNo)
            countCHNo = params.countCHNo
            character_id = params.character_id
            user_id = params.user_id

            for k = 1,countCHNo, 1  do
                characterChoose[k] = params.characterChoose[k]
                pointCharacX[k] = params.pointCharacX[k]
                pointCharacY[k] = params.pointCharacY[k]
                character_choose(characterChoose[k] ,user_id,k,pointCharacX[k] ,pointCharacY[k] )
            end
        else
            countCHNo = 0

        end
        character_id = params.character_id
        numCharacAll = display.newText(Allcharacter.."/"..numALL, display.contentWidth*.5, display.contentHeight*.815,typeFont, sizetext)
        numCharacAll:setTextColor(205, 170, 125)



        BLOCK_BOX =  display.newRect(screenW*.07, screenH*.76, screenW*.86, screenH*.075)
        BLOCK_BOX.alpha = .8
        BLOCK_BOX:setFillColor(130 ,130, 130)

        groupBKKView:insert(BLOCK_BOX)
        groupBKKView.touch = onTouchGameOverScreen
        groupBKKView:addEventListener( "touch", groupBKKView )
        groupView:insert(BLOCK_BOX)
        groupView:insert(numCharacAll)

        titleBox = display.newImageRect( image_textBox, screenW*.15, screenH*.065)
        titleBox:setReferencePoint( display.CenterReferencePoint )
        titleBox.x = screenW*.35
        titleBox.y = screenH*.8
        groupView:insert(titleBox)

        btnreset = widget.newButton{
            default= img_reset,
            width=screenH*.1 , height=screenW*.1,
            top = screenH*.765,
            left = screenW*.085,
            onRelease = PowerUpButtonEvent	-- event listener function
        }btnreset.id = "reset"
        groupView:insert(btnreset)

        btnOK = widget.newButton{
            default= img_OK,
            width=screenH*.1 , height=screenW*.1,
            top = screenH*.765,
            left = screenW*.76,
            onRelease = PowerUpButtonEvent	-- event listener function
        }btnOK.id = "ok"
        groupView:insert(btnOK)
        local backcharacter
        local backreset
        if countCHNo == 0  then
            backcharacter = display.newRect(screenW*.76, screenH*.765, screenH*.1, screenW*.1)
            backcharacter.strokeWidth = 1
            backcharacter.alpha = 0.8
            backcharacter:setFillColor(0, 0, 0)
            groupView:insert(backcharacter)

            backreset = display.newRect(screenW*.085, screenH*.765, screenH*.1, screenW*.1)
            backreset.strokeWidth = 1
            backreset.alpha = 0.8
            backreset:setFillColor(0, 0, 0)
            groupView:insert(backreset)

            viewback:insert(backreset)
            viewback:insert(backcharacter)
            viewback.touch = onTouchGameOverScreen
            viewback:addEventListener( "touch", viewback )
        else
            viewback.alpha = 0
        end

        txtCoin = display.newText(numCoin, display.contentWidth*.5, display.contentHeight*.763,typeFont, sizetext)
        txtCoin.text = string.format( numCoin )
        txtCoin:setTextColor(205, 170, 125)
        groupView:insert(txtCoin)

        txtUnit = display.newText(numUnit, display.contentWidth*.5, display.contentHeight*.79,typeFont, sizetext)
        txtUnit.text = string.format( numUnit )
        txtUnit:setTextColor(205, 170, 125)
        groupView:insert(txtUnit)

    end


    local background = display.newImageRect(image_background , display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    scrollViewList()

    local titleText = display.newImageRect( "img/text/POWER_UP.png", display.contentWidth/4.5, display.contentHeight/34 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.14

    numCharac = display.newText(Allcharacter.."/"..numALL, display.contentWidth*.7, display.contentHeight*.31,typeFont, sizetext)
    numCharac.text = string.format( Allcharacter.."/"..numALL )
    numCharac:setTextColor(205, 170, 125)



    createBackButton()

    print("countID:"..countID)
    groupGameLayer:insert(scrollView)
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background)
    group:insert(groupGameLayer)
    group:insert(backButton)
    group:insert(titleText)

    group:insert(numCharac)
    group:insert(groupView)
    group:insert(viewback)
    group:insert(gdisplay)

    ------------- other scene ---------------
    storyboard.removeScene( "power_up_main" )
    storyboard.removeScene( "team_main" )
    storyboard.removeScene( "character_scene" )
    storyboard.removeScene( "characterprofile" )
end

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
