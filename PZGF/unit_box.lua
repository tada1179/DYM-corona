local storyboard = require( "storyboard" )
--storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
-----------------------------------------------------------------------------------------
local screenW = display.contentWidth
local screenH = display.contentHeight

local countID = 0
local user_id
local Allcharacter
local countCharac
local numRow
local numColum = 5

local team_id
local holddteam_no
local txtInuse = "In-use"

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local sizetext = FontAndSize.fontGuest
local sizetextName = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead

local sizeleaderW = screenW*.14
local sizeleaderH = screenH*.095
local unitAll = 0
local numCoin = {}
local characterItem = {}
local ShowCharact
local scrollView
local groupView
-----------------------------------------------
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
        numRow = math.ceil( unitAll / numColum)
        if unitAll > Allcharacter then
            ShowCharact = Allcharacter
        else
            ShowCharact =  unitAll
        end
        local k = 1
        numCoin[0] = 0
        while(k <= Allcharacter) do
            characterItem[k] = {}
            characterItem[k].holdcharac_id= allRow.chracter[k].holdcharac_id
            characterItem[k].dataTable = allRow.chracter[k].charac_img_mini
            characterItem[k].charactID = allRow.chracter[k].charac_id
            characterItem[k].element = tonumber(allRow.chracter[k].charac_element)
            characterItem[k].level = tonumber(allRow.chracter[k].charac_lv)
            characterItem[k].use = allRow.chracter[k].use_id
            numCoin[k] = numCoin[k-1] + (characterItem[k].level*100)
            k = k + 1
        end
    end
end
local function onbtnBackButton(event)
    local options =
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
    if event.target.id == "back" then
        display.remove(characterItem)
        characterItem = nil

        display.remove(groupView)
        groupView = nil

        scrollView:removeSelf()
        scrollView = nil



       storyboard.gotoScene("unit_main","fade",100 )

    elseif event.target.id == "EXTENSION" then
        require("alertMassage").addSlot{user_id = user_id}
    end
end

local function selectLeader(event)

    if event.target.id == "leader1" then

        storyboard.gotoScene( "character", "fade", 100 )
    elseif event.target.id == "leader2" then


    elseif event.target.id == "leader3" then


    elseif event.target.id == "leader4" then


    elseif event.target.id == "leader5" then

    end
    return true

end

local function scrollViewList ()
    local function onTouchGameOverScreen ( self, event )
        if event.phase == "ended" and event.target.id =="1179" then
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

        elseif event.phase == "ended" and event.target.id ~= "1179" then
            local reScene = require("character_scene").character_unitBox(event.target.id,holddteam_no,team_id,user_id)
        end

        return true
    end

    scrollView = widget.newScrollView{
        width = screenW *.77,
        height = screenH * .38,
        top = screenH *.35,
        left = screenW *.13,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true

    }
    local groupView = display.newGroup()

    local LeaderpointX = 0
    local LeaderpointY = 0

    local LVpointX  = screenH*.07
    local LVpointY  = screenW * .03

    local InusepointX = screenH*.04
    local InusepointY = screenW*.015

    local frame =  require("alertMassage").loadFramElement()
    local sheetInfo = require("chara_icon")
--    local myImageSheet = graphics.newImageSheet( "img/character/chara_icon.png", sheetInfo:getSheet() )
    local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )
    countID = 0
    countCharac = 0
    for i = 1, numRow , 1 do  -- create colum
        for j = 1, numColum, 1 do --create row
            if countCharac < ShowCharact then
                countID = countID + 1
                local listCharacter = widget.newButton{
                    defaultFile= frame[characterItem[countID].element]  ,
                    width=sizeleaderW , height=sizeleaderH,
                    top = LeaderpointX,
                    left = LeaderpointY,
                    onEvent = onButtonEvent	-- event listener function
                }

                listCharacter.id = characterItem[countID].holdcharac_id

                local framImage = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[countID].dataTable) ,sizeleaderW, sizeleaderH)
                framImage:setReferencePoint( display.TopLeftReferencePoint )
                framImage.x = LeaderpointY
                framImage.y = LeaderpointX
                scrollView:insert(framImage)
                scrollView:insert(listCharacter)

                local textLV = display.newText("Lv."..characterItem[countID].level, LVpointY,LVpointX,typeFont, sizetext)
                textLV:setTextColor(255, 255, 255)
                scrollView:insert(textLV)

                if characterItem[countID].use then
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

                    local textInuse = display.newText(txtInuse, InusepointY,InusepointX,typeFont, sizetext)
                    textInuse:setTextColor(200, 0, 200)
                    groupView:insert(textInuse)
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
            LVpointY = LVpointY + (screenW *.15)
            InusepointY = InusepointY + (screenW *.15)
        end
        LeaderpointY = 0
        LVpointY  = screenW * .03
        InusepointY = screenW*.015

        LeaderpointX = LeaderpointX + (screenH*.11)
        LVpointX = LVpointX + (screenH *.11)
        InusepointX = InusepointX+ (screenH *.11)
    end

end

local function createBackButton()
    local image_btnback = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
        defaultFile= image_btnback,
        overFile= image_btnback,
        width=screenW/10, height=screenH/21,
        onRelease = onbtnBackButton	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW - (screenW *.845)
    backButton.y = screenH - (screenH *.7)
    groupView:insert(backButton)

    local image_btnback = "img/background/button/BOX_EXTENSION.png"
    local boxButton = widget.newButton{
        defaultFile= image_btnback,
        overFile= image_btnback,
        width=screenW*.35, height=screenH*.06,
        onRelease = onbtnBackButton	-- event listener function
    }
    boxButton.id="EXTENSION"
    boxButton:setReferencePoint( display.TopLeftReferencePoint )
    boxButton.x = screenW *.52
    boxButton.y = screenH *.75
    groupView:insert(boxButton)
end

function scene:createScene( event )
    local group = self.view
    groupView = display.newGroup()
    user_id = menu_barLight.user_id()
    unitAll = menu_barLight.slot()

    group:insert(background)

    local titleText = display.newImageRect( "img/text/UNIT_BOX.png", screenW/4.5, screenH/34 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.14

    LoadTeam()
    scrollViewList()
    local function onTouchGameUnitBox ( self, event )
        -- print("touch")
        if event.phase == "began" then


            return true
        end
    end

    local colorBLOCK_BOX = display.newRect(screenW*.115, screenH*.745, screenW*.76, screenH*.07)
    colorBLOCK_BOX.alpha = 0.8
    colorBLOCK_BOX.touch = onTouchGameUnitBox
    colorBLOCK_BOX:setFillColor(181, 181, 181)
    colorBLOCK_BOX:addEventListener( "touch", colorBLOCK_BOX )

    local unitText = display.newText("UNIT", screenW*.15, screenH *.75,typeFont, 18)
    unitText:setTextColor(0, 0, 0)
    unitText:setTextColor(255, 255, 255)
    local unitTextNumber = display.newText("UNIT", screenW*.4, screenH *.75,typeFont, 18)
    unitTextNumber:setTextColor(0, 0, 0)
    unitTextNumber:setTextColor(255, 255, 255)
    unitTextNumber.text = Allcharacter

    local unitAllText = display.newText("BOX CONTAIN", screenW*.15, screenH *.78,typeFont, 18)
    unitAllText:setTextColor(0, 0, 0)
    unitAllText:setTextColor(255, 255, 255)

    local unitAllTextNumber = display.newText("BOX CONTAIN", screenW*.335, screenH *.78,typeFont, 18)
    unitAllTextNumber:setTextColor(0, 0, 0)
    unitAllTextNumber:setTextColor(255, 255, 255)
    unitAllTextNumber.text = unitAll

    local slot = menu_barLight.slot()
    local HoldcharacterAll = menu_barLight.HoldcharacterAll()
    if slot >= HoldcharacterAll then
       -- storyboard.gotoScene( "map" ,"fade", 100 )
    else
        require("alertMassage").NoHaveSlot("unit_box")
    end

    groupView:insert(scrollView)

    groupView:insert(titleText)
--    groupView:insert(menu_barLight.newMenubutton())
    groupView:insert(menu_barLight.newMenubutton())

    groupView:insert(colorBLOCK_BOX)

    groupView:insert(unitAllText)
    groupView:insert(unitAllTextNumber)
    groupView:insert(unitText)
    groupView:insert(unitTextNumber)

    createBackButton()
    group:insert(groupView)

    menu_barLight.checkMemory()
    ------------- other scene ---------------



end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "unit_man" )
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
