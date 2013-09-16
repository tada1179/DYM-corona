local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
-----------------------------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local gdisplay = display.newGroup()
local previous_scene_name = storyboard.getPrevious()
local scrollView
local maxChapter
local characterItem = {}

local chapter_id
local user_id
local map_id
---------------------------------
local function loatCharacter()
     print("chapter_id == ",chapter_id)
    local http = require("socket.http")
    local json = require("json")
    local Linkmission = "http://localhost/dym/mission_list.php"
    local numberHold_character =  Linkmission.."?user_id="..user_id.."&chapter_id="..chapter_id
    local numberHold = http.request(numberHold_character)
    local framele = require("alertMassage").loadFramElement()

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
    local typeFont = native.systemFontBold
    local framele = require("alertMassage").loadFramElement()
    scrollView = widget.newScrollView{
        width = screenW *.77,
        height = screenH * .4,
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
            print("mission touch == ", event.target.id)
            local option = {

                effect = "fade",
                time = 100,
                params =
                {
                    mission_id = event.target.id,
                    chapter_id = chapter_id,
                    map_id = map_id,
                    user_id = user_id

                }
            }
            storyboard.gotoScene( "guest",option )
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
         print("mission for  characterItem[i].mission_id = ", characterItem[i].mission_id)
--        if true then
        if characterItem[i].ID_clear == "clear" then
            local imgFrmList = "img/background/misstion/CLEAR_LAYOUT.png"
            local imgBoss = display.newImageRect( characterItem[i].mission_img_boss, screenW*.12, screenH*.08)
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
            backButton.id= characterItem[i].mission_id

            local NameMission = display.newText(characterItem[i].mission_name, pointNameX, pointNameY,typeFont, 23)
            NameMission:setTextColor(200, 200, 200)
            scrollView:insert(NameMission)

            local txtbattle = display.newText("Battle : "..characterItem[i].mission_run, screenW*.35, pointbattleY,typeFont, 20)
            txtbattle:setTextColor(147, 112, 219)
            scrollView:insert(txtbattle)

            local txtstamina = display.newText("stamina : "..characterItem[i].mission_stamina, screenW*.08, pointbattleY,typeFont, 20)
            txtstamina:setTextColor(173, 255, 47)
            scrollView:insert(txtstamina)

        else
            local imgFrmList = "img/background/misstion/NEW_LAYOUT.png"
            local imgBoss = display.newImageRect( characterItem[i].mission_img_boss, screenW*.12, screenH*.08)
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
            backButton.id= characterItem[i].mission_id

            local NameMission = display.newText(characterItem[i].mission_name, pointNameX, pointNameY,typeFont, 23)
            NameMission:setTextColor(200, 200, 200)
            scrollView:insert(NameMission)

            local txtbattle = display.newText("Battle : "..characterItem[i].mission_run, screenW*.35, pointbattleY,typeFont, 20)
            txtbattle:setTextColor(147, 112, 219)
            scrollView:insert(txtbattle)

            local txtstamina = display.newText("stamina : "..characterItem[i].mission_stamina, screenW*.08, pointbattleY,typeFont, 20)
            txtstamina:setTextColor(173, 255, 47)
            scrollView:insert(txtstamina)
        end
        pointbattleY = pointbattleY + (screenH*.11)
        pointNameY = pointNameY + (screenH*.11)
        pointListY = pointListY + (screenH*.11)
        pointPic = pointPic + (screenH*.11)

        scrollView:insert(backButton)
    end
    gdisplay:insert(scrollView)

end
function scene:createScene( event )
    print("---- misstion ----")
    local group = self.view

    local img_text =  "img/text/MISSION_SELECT.png"
    user_id = event.params.user_id
    chapter_id =  event.params.chapter_id
    map_id =  event.params.map_id

    local image_background = "img/background/background_11.png"
    local background = display.newImageRect(image_background,screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    gdisplay:insert(background)

    local titleText = display.newImageRect(img_text,screenW/2.65,screenH/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH /3.1
    gdisplay:insert(titleText)

    local function onBtnReleasechapter(event)
        menu_barLight = nil
        display.remove(background)
        background = nil

        display.remove(titleText)
        titleText = nil

        display.remove(gdisplay)
        gdisplay = nil

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
    gdisplay:insert(menu_barLight.newMenubutton())
    gdisplay:insert(backButton)
    group:insert(gdisplay)
    menu_barLight.checkMemory()
    ------------- other scene ---------------
    --storyboard.removeScene ("map_substate")
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    menu_barLight = nil

    display.remove(gdisplay)
    gdisplay = nil

    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )
    local group = self.view
    menu_barLight = nil

    display.remove(gdisplay)
    gdisplay = nil

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene


