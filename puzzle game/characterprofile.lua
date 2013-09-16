print("characterprofile.lua")
--#ref character_shoe.lua and button View profile

-- ** include ** --
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
-----------------------------------------------------------------------------------------
local txtSmach = {"IMPACT WEAPON","SLASH  WEAPON","PIERCE WEAPON"}
local numsmash = 3
local typeFont = native.systemFontBold
local sizetext = 16
local sizetextName = 30

-- ** massage ** --
local txtNEXT = 100
local txtCOST = 100
local txtL_skill = "@hotmail.com\nfacebook/tada1179"
local txtskill = "txtskill123456789\nfacebook/tada1179"
local character_name

-- ** set paramiter
local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
--------- icon event -------------
local characterItem = {}

local sizeImageprofileW =  screenW*.3
local sizeImageprofileH =  screenH*.25

local options
local gdisplay = display.newGroup()
-------------------------------------
local function characterShow(event)
    local params = event.params
    local character_id = params.character_id
    print("characterShow character_id == ",character_id)
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

    local LinkURL = "http://localhost/DYM/Onecharacter.php"
    local characterID =  LinkURL.."?character="..character_id.."&user_id="..user_id
    local characterImg = http.request(characterID)

    if characterImg == nil then
        print("No Dice")
    else
        local characterSelect  = json.decode(characterImg)
        print("characterImg ===== ",characterImg)
        characterItem[1] = {}
        characterItem[1].character_name = characterSelect.chracter[1].charac_name
        characterItem[1].txtDEF = characterSelect.chracter[1].charac_def
        characterItem[1].txtATK = characterSelect.chracter[1].charac_atk
        characterItem[1].txtHP = characterSelect.chracter[1].charac_hp
        characterItem[1].txtLV = characterSelect.chracter[1].charac_lv

        characterItem[1].ImageCharacter = characterSelect.chracter[1].charac_img_mini
        characterItem[1].ImageCharacterFull = characterSelect.chracter[1].charac_img
        characterItem[1].FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)
    end
    return true
end

local function onBtnRelease(event)
    display.remove(gdisplay)
    gdisplay = nil

    storyboard.gotoScene( previous_scene_name ,options)

end

local function createButton()
    local frame = {"img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }

    local image_btnback = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
        default = image_btnback,
        over= image_btnback,
        width=screenW*.1, height=screenH/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW *.15
    backButton.y = screenH *.3
    gdisplay:insert(backButton)

    --button image profile
    local imageFream = widget.newButton{
        default= frame[characterItem[1].FrameCharacter],
        over= frame[characterItem[1].FrameCharacter],
        width=screenW*.16, height=screenH*.12,
        onRelease = onBtnRelease	-- event listener function
    }
    imageFream.id="imageprofile"
    imageFream.x = viewableScreenW/4.2
    imageFream.y = viewableScreenH/1.65


    local imageprofile = display.newImageRect(characterItem[1].ImageCharacter,screenW*.16,screenH*.12)
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x =  imageFream.x
    imageprofile.y =  viewableScreenH/1.65
    gdisplay:insert(imageprofile)
    gdisplay:insert(imageFream)
end

function scene:createScene( event )
    local image_background = "img/background/character/background_character.png"
    local image_text = "img/text/CHARACTER_NAME.png"
    local image_skill = "img/text/L.SKILL_SKILL.png"
    local image_LVPH = "img/text/LV_HP_ATC_DEF_NEXT_COST.png"
    local group = self.view

    characterShow(event)

    local namelenght = string.len(characterItem[1].character_name)
    local pointName =  (screenW*.5) - ((namelenght*sizetextName)/4)

    local background2 = display.newImageRect(image_background, screenW, screenH )
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0

    local NameText = display.newText(characterItem[1].character_name, pointName, screenH *.3,typeFont, sizetextName)
    NameText:setTextColor(255, 255, 255)

    local LVPHtext = display.newImageRect(image_LVPH, screenW*.44, screenH*.07 )
    LVPHtext:setReferencePoint( display.CenterReferencePoint )
    LVPHtext.x = screenW*.57
    LVPHtext.y = screenH*.628

    local smashText = display.newText(txtSmach[numsmash], 0, 0,typeFont, sizetext)
    smashText:setTextColor(255, 255, 255)
    smashText.x = screenW *.59
    smashText.y = screenH *.62

    -- ***  LV HP ATK DEF  *** --
    local showLV = display.newText(characterItem[1].txtLV, screenW *.41, screenH *.59,typeFont, sizetext)
    showLV:setTextColor(255, 0, 255)
    local showHP = display.newText(characterItem[1].txtHP, screenW *.41, screenH *.61,typeFont, sizetext)
    showHP:setTextColor(255, 0, 255)
    local showATK = display.newText(characterItem[1].txtATK, screenW *.41, screenH *.63,typeFont, sizetext)
    showATK:setTextColor(255, 0, 255)
    local showDEF = display.newText(characterItem[1].txtDEF, screenW *.41, screenH *.65,typeFont, sizetext)
    showDEF:setTextColor(255, 0, 255)

    -- *** NEXT COST *** --
    local showNEXT = display.newText(txtNEXT, screenW *.58, screenH *.59,typeFont, sizetext)
    showNEXT:setTextColor(255, 0, 255)
    local showCOST = display.newText(txtCOST, screenW *.8, screenH *.59,typeFont, sizetext)
    showCOST:setTextColor(255, 0, 255)

    -- *** MASSAGE SKILL L SKILL *** --
    local showMSNL_skill = display.newText(txtL_skill, screenW *.15,  screenH *.70,typeFont, sizetext)
    showMSNL_skill:setTextColor(255, 0, 255)
    local showMSNskill = display.newText(txtskill, screenW *.15,  screenH *.78,typeFont, sizetext)
    showMSNskill:setTextColor(255, 0, 255)

    local charaterImage = display.newImageRect(characterItem[1].ImageCharacterFull,sizeImageprofileW , sizeImageprofileH)
    charaterImage:setReferencePoint( display.CenterReferencePoint )
    charaterImage.x = screenW*.5
    charaterImage.y = screenH *.48

    local skillText = display.newImageRect(image_skill, screenW*.095, screenH*.093 )
    skillText:setReferencePoint( display.CenterReferencePoint )
    skillText.x = screenW*.2
    skillText.y = screenH*.734

    gdisplay:insert(background2)
    gdisplay:insert(charaterImage)
    createButton()
    gdisplay:insert(showLV)
    gdisplay:insert(showHP)
    gdisplay:insert(showATK)
    gdisplay:insert(showDEF)
    gdisplay:insert(showNEXT)
    gdisplay:insert(showCOST)

    gdisplay:insert(showMSNskill)
    gdisplay:insert(showMSNL_skill)

    gdisplay:insert(smashText)
    gdisplay:insert(NameText)
    gdisplay:insert(skillText)
    gdisplay:insert(LVPHtext)
    gdisplay:insert(menu_barLight.newMenubutton())

    gdisplay.touch = onBtnRelease
    gdisplay:addEventListener( "touch", gdisplay )

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
    display.remove(gdisplay)
    gdisplay = nil

    storyboard.removeAll ()
    storyboard.purgeAll()
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )
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
