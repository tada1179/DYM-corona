local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local loadImageSprite = require ("downloadData").loadImageSprite_Boss2()
local http = require("socket.http")
local json = require("json")
local framele = require("alertMassage").loadFramElement()

local sheetInfo = require("chara_icon")
local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )
-----------------------------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local gdisplay
local previous_scene_name = storyboard.getPrevious()
local namePage = storyboard.getCurrentSceneName()
local scrollView
local maxChapter
local characterItem = {}

local chapter_id
local user_id
local map_id
local powerStamina

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local fontsize = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead
---------------------------------
local function loatCharacter()
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    for count in db:urows ("SELECT * FROM MapSubstates WHERE chapter_id = '"..chapter_id.."';") do maxChapter = count  end
    for x in db:nrows("SELECT * FROM MapSubstates WHERE chapter_id = '"..chapter_id.."';") do

    end
    local Linkmission = "http://133.242.169.252/DYM/mission_list.php"
    local numberHold_character =  Linkmission.."?user_id="..user_id.."&chapter_id="..chapter_id
    local numberHold = http.request(numberHold_character)


    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        maxChapter = tonumber(allRow.All)

        local k = maxChapter
        while k > 0  do
            characterItem[k] = {}
            characterItem[k].mission_id = allRow.mission[k].mission_id
            characterItem[k].mission_name = allRow.mission[k].mission_name
            characterItem[k].mission_img= allRow.mission[k].mission_img
            characterItem[k].mission_img_boss= allRow.mission[k].mission_img_boss
            characterItem[k].mission_boss_element= tonumber(allRow.mission[k].mission_boss_element)
            characterItem[k].mission_stamina= tonumber(allRow.mission[k].mission_stamina)
            characterItem[k].mission_run= tonumber(allRow.mission[k].mission_run)
            characterItem[k].mission_characterNum= tonumber(allRow.mission[k].mission_characterNum)
            characterItem[k].ID_clear = allRow.mission[k].ID_clear
            k = k - 1
        end
    end


end
local function scrollViewFN()


    gdisplay = display.newGroup()
    scrollView = widget.newScrollView{
        width = screenW *.77,
        height = screenH * .45,
        top = screenH *.35,
        left = screenW *.14,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true ,
        horizontalScrollDisabled = false
    }

    local function onButtonEvent(event)
        if event.phase == "moved" then
            local dx = math.abs( event.x - event.xStart )
            local dy = math.abs( event.y - event.yStart )
            if  dy > 5 then
                scrollView:takeFocus( event )
            end

        elseif  event.phase == "ended" or event.phase == "release" then
            powerStamina = powerStamina - characterItem[event.target.id].mission_stamina
           -- powerStamina = 0
            if powerStamina <0 then
                local
                    params =
                    {
                       user_id = user_id,
                        namepage = namePage,
                        chapter_id = chapter_id,
                        map_id = map_id,
                    }

                require("alertMassage").stamina(params)

            else
                native.setActivityIndicator( true )
                menu_barLight.SEtouchButton()
                    local option = {

                        effect = "fade",
                        time = 100,
                        params =
                        {
                            mission_id = characterItem[event.target.id].mission_id,
                            mission_stamina = characterItem[event.target.id].mission_stamina,
                            chapter_id = chapter_id,
                            map_id = map_id,
                            user_id = user_id

                        }
                    }

--                for i=gdisplay.numChildren,1,-1 do
--                    local child = gdisplay[i]
--                    child.parent:remove( child )
--                    child = nil
--                end
                    storyboard.gotoScene( "guest",option )
            end

        end
    end



    local pointName = screenH*.02
    local pointNameX = screenW*.07
    local pointBonus = screenH*.11
    local pointbattleY  = screenH*.06
    local pointListY  = 0
    local pointNameY  = screenH*.01
    local pointPicX  = screenW*.57
    local pointPic  = screenH *.01

    local frmsizsX = screenW*.7
    local frmsizsY = screenH*.1
    local listCharacter = {}
    local backButton


    for i = maxChapter, 1, -1 do
        --        if true then
        local imgFrmList
        if characterItem[i].ID_clear == "clear" then
            imgFrmList = "img/background/misstion/CLEAR_LAYOUT.png"
        else
            imgFrmList = "img/background/misstion/NEW_LAYOUT.png"
        end
            local imgBoss = display.newImageRect( myImageSheet , sheetInfo:getFrameIndex(characterItem[i].mission_img_boss), screenW*.12, screenH*.08)
            imgBoss:setReferencePoint( display.TopLeftReferencePoint )
            imgBoss.x, imgBoss.y = pointPicX, pointPic
            scrollView:insert(imgBoss)

            imgBoss = display.newImageRect(framele[characterItem[i].mission_boss_element], screenW*.12, screenH*.08)
            imgBoss:setReferencePoint( display.TopLeftReferencePoint )
            imgBoss.x, imgBoss.y = pointPicX, pointPic
            scrollView:insert(imgBoss)

            backButton = widget.newButton{
                defaultFile= imgFrmList,
                overFile= imgFrmList,
                top = pointListY,
                left = 0,
                width=frmsizsX, height= frmsizsY,
                onEvent = onButtonEvent	-- event listener function
            }
            backButton.id= i

            local NameMission = display.newText(characterItem[i].mission_name, pointNameX, pointNameY,typeFont, fontsizeHead)
            NameMission:setReferencePoint(display.TopLeftReferencePoint)
            NameMission:setTextColor(200, 200, 200)
            scrollView:insert(NameMission)

            local txtbattle = display.newText("Battle : "..characterItem[i].mission_run, screenW*.35, pointbattleY,typeFont, fontsize)
            txtbattle:setReferencePoint(display.TopLeftReferencePoint)
            txtbattle:setTextColor(147, 112, 219)
            scrollView:insert(txtbattle)

            local txtstamina = display.newText("stamina : "..characterItem[i].mission_stamina, screenW*.08, pointbattleY,typeFont, fontsize)
            txtstamina:setReferencePoint(display.TopLeftReferencePoint)
            txtstamina:setTextColor(173, 255, 47)
            scrollView:insert(txtstamina)

        pointbattleY = pointbattleY + (screenH*.11)
        pointNameY = pointNameY + (screenH*.11)
        pointListY = pointListY + (screenH*.11)
        pointPic = pointPic + (screenH*.11)

        scrollView:insert(backButton)
    end
    gdisplay:insert(scrollView)

end
function scene:createScene( event )
    native.setActivityIndicator( false )
    local group = self.view
    local gdisplayScene =  display.newGroup()
    local img_text =  "img/text/MISSION_SELECT.png"
    user_id = event.params.user_id
    chapter_id =  event.params.chapter_id
    map_id =  event.params.map_id
    powerStamina = menu_barLight.power_STAMINA()
    gdisplayScene:insert(background)

    local titleText = display.newImageRect(img_text,screenW/2.65,screenH/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH /3.1
    gdisplayScene:insert(titleText)

    local function onBtnReleasechapter(event)
        menu_barLight.SEtouchButtonBack()

        display.remove(titleText)
        titleText = nil

        for i=gdisplayScene.numChildren,1,-1 do
            local child = gdisplayScene[i]
            child.parent:remove( child )
            child = nil
        end


        local option = {
            effect = "fade",
            time = 100,
            params =
            {
                map_id = map_id,
                user_id = user_id
            }
        }
        storyboard.gotoScene( "map_substate" ,option )

        return true
    end
    local imageBack = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
        defaultFile = imageBack,
        overFile = imageBack,
        width=screenW*.1, height=screenH*.05,
        onRelease = onBtnReleasechapter	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW *.15
    backButton.y = screenH *.3

    loatCharacter()
    scrollViewFN()
    -- gdisplay:insert(require("misstion_scroll").new{user_id=user_id, chapter_id=chapter_id, map_id=map_id})
    gdisplayScene:insert(menu_barLight.newMenubutton())
    gdisplayScene:insert(backButton)
    group:insert(gdisplayScene)
    group:insert(gdisplay)
    menu_barLight.checkMemory()
    ------------- other scene ---------------
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "guest" )
    storyboard.purgeScene( "map_substate" )
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


