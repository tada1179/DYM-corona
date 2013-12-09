
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local alertMSN = require ("alertMassage")
local http = require("socket.http")
local json = require("json")
local sheetInfo = require("chara_icon")
-----------------------------------------------------------------------------------------
local screenW = display.contentWidth
local screenH = display.contentHeight

local numCharacter_up = 5 --power up select character max 5 item
local numALL = nil
local numCoin = 0
local numUnit = 0
local countID = 0
local user_id
local Allcharacter
local AllcharacterUse = 0
local countCharac = 0
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
local check
local unitAll = 0

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local sizetext = FontAndSize.fontGuest
local sizetextName = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead
---------------
local function LoadTeam()
    local LinkURL = "http://133.242.169.252/DYM/gallery.php"
    local numberHold_character =  LinkURL.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)
    local allRow = {}
    if numberHold == nil then
        print("No Dice")
    else
        allRow  = json.decode(numberHold)
        Allcharacter = allRow.chrAll
        numRow = math.ceil( Allcharacter / 5)
        numALL = numRow * numColum

        local k = 1
        while(k <= Allcharacter) do
            characterItem[k] = {}
            characterItem[k].holdcharac_id = tonumber(allRow.chracter[k].holdcharac_id)
            characterItem[k].dataTable = allRow.chracter[k].charac_img_mini
            characterItem[k].charactID = allRow.chracter[k].charac_id
            characterItem[k].charac_no = allRow.chracter[k].charac_no
            characterItem[k].element = tonumber(allRow.chracter[k].charac_element)
            characterItem[k].use = tonumber(allRow.chracter[k].use)
--            print("holdcharac_id:charac_no",characterItem[k].holdcharac_id ,characterItem[k].charac_no )
            k = k + 1
        end
    end
end
local function PowerUpButtonEvent(event)

        viewback:removeSelf()
        display.remove(viewback)
        viewback = nil

        if event.target.id == "back" then
            storyboard.gotoScene("game-setting","fade",100)

        end

    return true
end

local function scrollViewList (event)
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
    local group = event.view
    local sizeleaderW = screenW*.14
    local sizeleaderH = screenH*.095
    local groupView = display.newGroup()
    local frame = {}
    frame = alertMSN.loadFramElement()

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
                local  targetX = event.target.x - (screenW * .07)
                local  targetY = event.target.y - (screenH * .048)
                local point = {
                    x =  targetX,
                    y =  targetY,
                }
                local character_scene = require("character_scene")
                character_scene.character_gallery(event.target.id,user_id,gplayView,point)--(select touch,holddteam_no,team_id)
        end
        return true
    end

    local LeaderpointX = 0
    local LeaderpointY = 0

    local LVpointX  =  screenH*.07
    local LVpointY  =  screenW*.02

    local InusepointX = screenW*.02
    local InusepointY = screenH*.03
    local listCharacter = {}
    countCharac = 0
    countID = 0
    AllcharacterUse = 0

--    local myImageSheet = graphics.newImageSheet( "img/character/chara_icon.png", sheetInfo:getSheet() )
    local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )
    for i = 1, numRow , 1 do  -- create colum
        for j = 1, numColum, 1 do --create row
            countID = countID + 1

            if countID <= Allcharacter then

            if characterItem[countID].holdcharac_id ~= 1110 then
                AllcharacterUse = AllcharacterUse + 1

                if characterItem[countID].use == 1 then

                    listCharacter[countID] = widget.newButton{
                        defaultFile=  frame[characterItem[countID].element]  ,
                        width=sizeleaderW , height=sizeleaderH,
                        top = LeaderpointX,
                        left = LeaderpointY,
                        onEvent = onButtonEvent	-- event listener function
                    }
                    listCharacter[countID].id = characterItem[countID].holdcharac_id


                    local framImage = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[countID].dataTable),sizeleaderW, sizeleaderH)
                    framImage:setReferencePoint( display.TopLeftReferencePoint )
                    framImage.x = LeaderpointY
                    framImage.y = LeaderpointX
                    scrollView:insert(framImage)
                    scrollView:insert(listCharacter[countID])

                    local textLV = display.newText("no."..characterItem[countID].charac_no, LVpointY,LVpointX,typeFont, sizetext)
                    textLV:setReferencePoint( display.CenterReferencePoint )
                    textLV:setFillColor(255, 255, 255)
                    scrollView:insert(textLV)

                else

                    listCharacter[countID] = widget.newButton{
                        defaultFile= frame[characterItem[countID].element] ,
                        width=sizeleaderW , height=sizeleaderH,
                        top = LeaderpointX,
                        left = LeaderpointY,
                        onEvent = onButtonEvent	-- event listener function
                    }
                    listCharacter[countID].id = characterItem[countID].holdcharac_id


                    local framImage = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex( characterItem[countID].dataTable) ,sizeleaderW, sizeleaderH)
                    framImage:setReferencePoint( display.TopLeftReferencePoint )
                    framImage.x = LeaderpointY
                    framImage.y = LeaderpointX
                    scrollView:insert(framImage)
                    scrollView:insert(listCharacter[countID])

                    local textLV = display.newText("no."..characterItem[countID].charac_no, LVpointY,LVpointX,typeFont, sizetext)
                    textLV:setReferencePoint( display.CenterReferencePoint )
                    textLV:setFillColor(255, 255, 255)
                    scrollView:insert(textLV)

                    local backcharacter = display.newRect(LeaderpointY, LeaderpointX, sizeleaderW, sizeleaderH)
                    backcharacter.strokeWidth = 0
                    backcharacter.alpha = 0.8
                    backcharacter:setFillColor(0, 0, 0)
                    scrollView:insert(backcharacter)
                end
            else
                local framImage = display.newImageRect("img/characterIcon/as_cha_frm00.png" ,sizeleaderW, sizeleaderH)
                framImage:setReferencePoint( display.TopLeftReferencePoint )
                framImage.x = LeaderpointY
                framImage.y = LeaderpointX
                scrollView:insert(framImage)
            end

            end

            LeaderpointY = LeaderpointY + (screenW *.15)
            LVpointY = LVpointY +  (screenW *.15)
            InusepointX = InusepointX + (screenW*.15)

        end

        InusepointX =  screenW*.02
        LeaderpointY = 0
        LVpointY =  screenW*.02
        LeaderpointX = LeaderpointX + (screenH *.11)
        LVpointX = LVpointX + (screenH *.11)
        InusepointY = InusepointY + (screenH *.11)

    end
end

function scene:createScene( event )
    check = "00"
    countCHNo = 0
    gplayView = display.newGroup()
    groupClick = display.newGroup()
    groupTapCoin = display.newGroup()
    viewback = display.newGroup()

--    local image_background = "img/background/background_1.jpg"
    local groupTapCoin = nil
    local group = self.view
    user_id = menu_barLight.user_id()
    unitAll = menu_barLight.slot()
    LoadTeam()
    local groupView = display.newGroup()

    local function onTouchGameOverScreenCreate ( self, event )
        if event.phase == "began" then
            --storyboard.gotoScene( "menu-scene", "fade", 400  )
            return true
        end
    end
    gplayView:insert(background)
    scrollViewList(event)

    local titleText  = display.newText("GALLERY", 0, screenH*.30,typeFont, fontsizeHead)
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.5
    titleText:setFillColor(255, 255, 255)

    local numCharac = display.newText(AllcharacterUse.."/"..Allcharacter, screenW*.7, screenH*.31,typeFont, sizetext)
    numCharac.text = string.format( AllcharacterUse.."/"..Allcharacter )
    numCharac:setReferencePoint(display.TopLeftReferencePoint)
    numCharac:setFillColor(205, 170, 125)

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
    storyboard.purgeScene( "power_up_main" )
    storyboard.purgeScene( "game-setting" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view

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
