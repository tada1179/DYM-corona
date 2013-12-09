--#ref character_shoe.lua and button View profile

-- ** include ** --
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local previous_scene_name
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
local util = require ("util")
-----------------------------------------------------------------------------------------

local character_name
local skillline1 ,skillline2
local leaderline1 , leaderline2

-- ** set paramiter
local screenW, screenH = display.contentWidth, display.contentHeight
--------- icon event -------------
local characterItem = {}
local options
local gdisplay

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local sizetext = FontAndSize.fontGuest
local sizetextName = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead
fontsizeHead = fontsizeHead*1.5
-------------------------------------
local function characterShow(event)
    leaderline1 = ""
    leaderline2 = ""
    skillline1 = ""
    skillline2 = ""
    previous_scene_name = storyboard.getPrevious()
    local params = event.params
    local character_id = params.character_id
    local user_id = params.user_id
    local team_id = params.team_id
    local holddteam_no = params.holddteam_no

    if previous_scene_name == "gacha_card" then
        previous_scene_name = "map"
    end

    options =
    {
        effect = "zoomOutInFade",
        time = 200,
        params = {
            character_id =character_id ,
            holddteam_no =  holddteam_no  ,
            team_id =  team_id ,
            user_id = user_id  ,
            page = previous_scene_name
        }
    }

    local LinkURL = "http://133.242.169.252/DYM/Onecharacter.php"
    local characterID =  LinkURL.."?character="..character_id.."&user_id="..user_id
    local characterImg = http.request(characterID)

    if characterImg == nil then
        print("No Dice")
    else
        local characterSelect  = json.decode(characterImg)
        characterItem[1] = {}
        characterItem[1].holdcharac_id = characterSelect.chracter[1].holdcharac_id
        characterItem[1].character_name = characterSelect.chracter[1].charac_name
        characterItem[1].txtDEF = characterSelect.chracter[1].charac_def
        characterItem[1].txtATK = characterSelect.chracter[1].charac_atk
        characterItem[1].txtHP = characterSelect.chracter[1].charac_hp
        characterItem[1].txtLV = characterSelect.chracter[1].charac_lv
        characterItem[1].charac_lvmax = characterSelect.chracter[1].charac_lvmax
        characterItem[1].charac_type = characterSelect.chracter[1].charac_type
        characterItem[1].charac_cost = characterSelect.chracter[1].charac_cost
        characterItem[1].charac_leader = characterSelect.chracter[1].charac_leader
        characterItem[1].charac_leader = characterSelect.chracter[1].charac_leader
        characterItem[1].detail_leader = characterSelect.chracter[1].detail_leader

        characterItem[1].charac_skill = characterSelect.chracter[1].charac_skill
        characterItem[1].detail_skill = characterSelect.chracter[1].detail_skill

        characterItem[1].ImageCharacter = characterSelect.chracter[1].charac_img_mini
        characterItem[1].ImageCharacterFull = characterSelect.chracter[1].charac_img
        characterItem[1].FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)
        characterItem[1].charac_spw = tonumber(characterSelect.chracter[1].charac_spw)
        characterItem[1].charac_sph = tonumber(characterSelect.chracter[1].charac_sph)

        if string.len(characterItem[1].detail_leader) > 45 then
            leaderline1 =  string.sub(characterItem[1].detail_leader,1,45)
            leaderline2 =  string.sub(characterItem[1].detail_leader,45)

        elseif string.len(characterItem[1].detail_skill) > 45 then
            skillline1 =  string.sub(characterItem[1].detail_leader,1,45)
            skillline2 =  string.sub(characterItem[1].detail_leader,45)
        end

    end
    return true
end

local function onBtnRelease(event)
    menu_barLight.SEtouchButtonBack()
    display.remove(gdisplay)
    gdisplay = nil
    menu_barLight.SEtouchButton()
    require ("menu").ShowDisplay()
        storyboard.gotoScene( previous_scene_name ,options)
end

local function createButton()
    local frame = require("alertMassage") .loadBallElement()
    local sheetInfo = require("chara_full")
--    local myImageSheet = graphics.newImageSheet( "img/character/chara_full.png", sheetInfo:getSheet() )
    local myImageSheet = graphics.newImageSheet( "chara_full.png",system.DocumentsDirectory, sheetInfo:getSheet() )

    local imageFream = display.newImage(frame[characterItem[1].FrameCharacter],true)
    imageFream:setReferencePoint(display.TopLeftReferencePoint)
    imageFream.x = screenW*.2
    imageFream.y = screenH*.11
    local imageprofile = display.newImage(myImageSheet , sheetInfo:getFrameIndex(characterItem[1].ImageCharacterFull))

    if imageprofile.width ~= 1024 or imageprofile.height ~= 1024 then
        if imageprofile.width > imageprofile.height then
            imageprofile.height = math.floor(imageprofile.height / (imageprofile.width/1024))
            imageprofile.width = 1024
        else
            imageprofile.width = math.floor(imageprofile.width / (imageprofile.height/1024))
            imageprofile.height = 1024
        end
    end
    imageprofile.width = math.floor((imageprofile.width/characterItem[1].charac_spw) *2)
    imageprofile.height =  math.floor((imageprofile.height/characterItem[1].charac_sph) *2)
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x =  screenW*.5
    imageprofile.y =  screenH*.46
    gdisplay:insert(imageprofile)
    gdisplay:insert(imageFream)
end

function scene:createScene( event )
    require("menu").removeDisplay()
    local image_background = "img/background/character/bgCharacter2.png"
    local image_skill = "img/text/L.SKILL_SKILL.png"
    local image_LVPH = "img/text/LV_HP_ATC_DEF_NEXT_COST.png"
    local group = self.view
    gdisplay = display.newGroup()
    characterShow(event)

--    local myRectangle = display.newRect(screenW*.05, screenH*.7, screenW*.8, screenH*.25)
--    myRectangle:setReferencePoint( display.TopLeftReferencePoint )
--    myRectangle.strokeWidth = 3
--    myRectangle:setFillColor(140, 140, 140)
--    myRectangle:setStrokeColor(180, 180, 180)

    local namelenght = string.len(characterItem[1].character_name)
    local pointName =  (screenW*.5) - ((namelenght*fontsizeHead)/4)

    local background2 = display.newImageRect(image_background, screenW, screenH )
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0

    local NameText = display.newText(characterItem[1].character_name, pointName, screenH *.08,typeFont, fontsizeHead)
    NameText:setReferencePoint(display.TopLeftReferencePoint)
    NameText:setFillColor(255, 255, 255)
    local TEXTLV1 = "LV : \nHP : \nATK : "
    local LVPHtext1 = util.wrappedText(TEXTLV1, screenW*.28, sizetextName,typeFont, {200, 200, 200})
    LVPHtext1:setReferencePoint(display.TopLeftReferencePoint)
    LVPHtext1.x = screenW*.1
    LVPHtext1.y = screenH*.68

    local TEXTLV2 = characterItem[1].txtLV.."\n"..characterItem[1].txtHP .."\n"..characterItem[1].txtATK
    local LVPHtext2 = util.wrappedText(TEXTLV2, screenW*.28, sizetextName,typeFont, {200, 200, 200})
    LVPHtext2:setReferencePoint(display.TopLeftReferencePoint)
    LVPHtext2.x = screenW*.25
    LVPHtext2.y = screenH*.68

    local TEXTLV1 = "LV MAX : \nDEF : \nTYPE : "
    local LVPHtext3 = util.wrappedText(TEXTLV1, screenW*.28, sizetextName,typeFont, {200, 200, 200})
    LVPHtext3:setReferencePoint(display.TopLeftReferencePoint)
    LVPHtext3.x = screenW*.4
    LVPHtext3.y = screenH*.68

    local TEXTLV2 = characterItem[1].charac_lvmax.."      COST : "..characterItem[1].charac_cost.."\n"..characterItem[1].txtDEF.."\n"..characterItem[1].charac_type
    local LVPHtext4 = util.wrappedText(TEXTLV2, screenW*.28, sizetextName,typeFont, {200, 200, 200})
    LVPHtext4:setReferencePoint(display.TopLeftReferencePoint)
    LVPHtext4.x = screenW*.56
    LVPHtext4.y = screenH*.68

    local skill = "LEADER : \n\n\nSKILL : \n"
    local LVPHtext5 = util.wrappedText(skill, screenW*.28, sizetextName,typeFont, {0, 255, 0})
    LVPHtext5:setReferencePoint(display.TopLeftReferencePoint)
    LVPHtext5.x = screenW*.1
    LVPHtext5.y = screenH*.78

    local skill = characterItem[1].charac_leader.."\n\n\n"..characterItem[1].charac_skill
    local LVPHtext = util.wrappedText(skill, screenW*.28, sizetextName,typeFont, {200, 200, 200})
    LVPHtext:setReferencePoint(display.TopLeftReferencePoint)
    LVPHtext.x = screenW*.3
    LVPHtext.y = screenH*.78


    local skill = leaderline1.."\n"..leaderline2.."\n\n"..skillline1.."\n"..skillline2
    local LVPHtext6 = util.wrappedText(skill, screenW*.28, sizetextName,typeFont, {200, 200, 200})
    LVPHtext6:setReferencePoint(display.TopLeftReferencePoint)
    LVPHtext6.x = screenW*.11
    LVPHtext6.y = screenH*.81

    gdisplay:insert(background)
    gdisplay:insert(background2)
    createButton()

--    gdisplay:insert(myRectangle)
    gdisplay:insert(NameText)
    gdisplay:insert(LVPHtext)
    gdisplay:insert(LVPHtext1)
    gdisplay:insert(LVPHtext2)
    gdisplay:insert(LVPHtext3)
    gdisplay:insert(LVPHtext4)
    gdisplay:insert(LVPHtext5)
    gdisplay:insert(LVPHtext6)
    gdisplay:insert(menu_barLight.newMenubutton())

    gdisplay.touch = onBtnRelease
    gdisplay:addEventListener( "touch", gdisplay )

    group:insert(gdisplay)

    menu_barLight.checkMemory()
    ------------- other scene ---------------
--    storyboard.removeAll ()
--    storyboard.purgeAll()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene(previous_scene_name)
    storyboard.purgeAll()
    storyboard.removeAll ()
end

function scene:exitScene( event )
    local group = self.view
    display.remove(gdisplay)
    gdisplay = nil

    storyboard.purgeAll()
    storyboard.removeAll ()
end

function scene:destroyScene( event )
    local group = self.view

    display.remove(gdisplay)
    gdisplay = nil

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
