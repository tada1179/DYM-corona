
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local alertMSN = require("alertMassage")
local http = require("socket.http")
local json = require("json")
local sheetInfo = require("chara_icon")
local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )


-----------------------------------------------------------------------------------------

local LinkURL = "http://133.242.169.252/DYM/useCharacter.php"

local countID = 0
local user_id
local Allcharacter
local countCharac = 0
local numRow
local numColum = 5
local team_id
local holddteam_no
local characterItem = {}
local txtInuse = "In-use"

local typeFont = native.systemFontBold
local sizetext = 20
local screenW = display.contentWidth
local screenH = display.contentHeight

local sizeleaderW = screenW*.14
local sizeleaderH = screenH*.095

local scrollView
local gdisplay
------------------------------------
local function LoadTeam()
    local numberHold_character =  LinkURL.."?user_id="..user_id.."&team_id="..team_id
    local numberHold = http.request(numberHold_character)
    local allRow = {}

    if numberHold == nil then
        print("No Dice")
    else
        allRow  = json.decode(numberHold)
        Allcharacter = allRow.chrAll
        numRow = math.ceil( Allcharacter / numColum)

        local k = 1
        while(k <= Allcharacter) do
            characterItem[k] = {}
            characterItem[k].holdcharac_id= allRow.chracter[k].holdcharac_id
            characterItem[k].dataTable = allRow.chracter[k].charac_img_mini
            characterItem[k].charactID = allRow.chracter[k].charac_id
            characterItem[k].element = tonumber(allRow.chracter[k].charac_element)
            characterItem[k].level= allRow.chracter[k].charac_lv
            characterItem[k].use = allRow.chracter[k].use_id

            k = k + 1
        end
    end
end
local function BackButton(event)

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
--    scrollView:removeSelf()
--    scrollView = nil

    display.remove(gdisplay)
    gdisplay = nil

    characterItem = nil

    if event.target.id == "back" then
        storyboard.gotoScene( "team_main","fade",100 )

    end

end

local function scrollViewList ()
    local frame =  alertMSN.loadFramElement()
    local backcharacter
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
                --moveScrollBar(dy)
            end

        elseif event.phase == "ended" then
            --print("BTN Release")
            require("character_scene").character(event.target.id,holddteam_no,team_id,user_id)
        end

        return true
    end

    scrollView = widget.newScrollView{
        width = screenW*.75,
        height = screenH * .4,
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

    local LVpointX = screenW * .1
    local LVpointY = screenH * .02

    local InusepointX = screenW * .05
    local InusepointY = screenH *  .01
    countID = 0
    countCharac = 0
    local listCharacter = {}

    for i = 1, numRow , 1 do  -- create colum
        for j = 1, numColum, 1 do --create row

            if countCharac < Allcharacter then
                countID = countID + 1

            listCharacter[countID] = widget.newButton{
                defaultFile= frame[characterItem[countID].element],
                width=sizeleaderW , height=sizeleaderH,
                top = LeaderpointX,
                left = LeaderpointY,
                onEvent = onButtonEvent	-- event listener function
            }

            listCharacter[countID].id = characterItem[countID].holdcharac_id



            local framImage = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[countID].dataTable )   ,sizeleaderW, sizeleaderH)
            framImage:setReferencePoint( display.TopLeftReferencePoint )
            framImage.x = LeaderpointY
            framImage.y = LeaderpointX
            scrollView:insert(framImage)
            scrollView:insert(listCharacter[countID])

            local textLV = display.newText("Lv."..characterItem[countID].level, LVpointY,LVpointX,typeFont, sizetext)
            textLV:setTextColor(255, 255, 255)
            scrollView:insert(textLV)

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
            LeaderpointY = LeaderpointY + (screenW*.155)
            LVpointY = LVpointY + (screenW*.155)
            InusepointY = InusepointY + (screenW*.155)
        end
        LeaderpointY = 0
        LVpointY = screenH * .02
        InusepointY = screenH *  .01

        LeaderpointX = LeaderpointX + (screenH*.105)
        LVpointX = LVpointX + (screenH*.105)
        InusepointX = InusepointX + (screenH*.105)
    end
end

local function createBackButton()
    local image_btnback = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
        defaultFile= image_btnback,
        overFile= image_btnback,
        width=screenW*.12, height=screenH*.05,
        onRelease = BackButton	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW*.15
    backButton.y = screenH*.3
    gdisplay:insert(backButton)
end

function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()
    local image_background = "img/background/background_1.jpg"
    user_id = menu_barLight.user_id()

    local params = event.params
    if params then
        holddteam_no = params.holddteam_no
        team_id = params.team_id
    else
        holddteam_no = params.holddteam_no
        team_id = params.team_id
    end

    LoadTeam()

    scrollViewList()

    local titleText = display.newImageRect( "img/text/UNIT_BOX.png", display.contentWidth/4.5, screenH/34 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH /3.14

    local BLOCK_BOX = display.newImageRect( "img/background/character/BLOCK_BOX_EXTENTION_LAYOUT_13.png", display.contentWidth*.9, screenH*.13 )
    BLOCK_BOX:setReferencePoint( display.CenterReferencePoint )
    BLOCK_BOX.x = screenW*.5
    BLOCK_BOX.y = screenH *.8

    gdisplay:insert(background)
    gdisplay:insert(scrollView)
    createBackButton()
    gdisplay:insert(titleText)
    gdisplay:insert(BLOCK_BOX)
    gdisplay:insert(menu_barLight.newMenubutton())
    group:insert(gdisplay)

    menu_barLight.checkMemory()
    ------------- other scene ---------------
    storyboard.purgeAll()
    storyboard.removeAll ()


end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene("team_main")
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
