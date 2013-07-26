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
local txtLV
local txtHP
local txtATK
local txtDEF
local txtNEXT = 100
local txtCOST = 100
local txtL_skill = "@hotmail.com\nfacebook/tada1179"
local txtskill = "txtskill123456789\nfacebook/tada1179"
local character_name

-- ** set paramiter
local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
--------- icon event -------------
local imageprofile
local imageFream
local backButton
local ImageCharacter
local ImageCharacterFull
local FrameCharacter

local sizeImageprofileW =  screenW*.3
local sizeImageprofileH =  screenH*.25

local options
local gdisplay = display.newGroup()

local function characterShow(event)
    local params = event.params
    local character_id = params.character_id
    local user_id = params.user_id
    local friend_id = params.friend_id
    local Nofriend_id = params.Nofriend_id

    options =
    {
        effect = "fade",
        time = 100,
        params = {
            character_id =character_id ,
            friend_id =  friend_id  ,
            user_id = user_id  ,
            Nofriend_id = Nofriend_id,
            page = previous_scene_name
        }
    }

    local LinkURL = "http://localhost/DYM/Onecharacter_friend.php"
    local characterID =  LinkURL.."?user_id="..user_id.."&friend_id="..Nofriend_id
    local characterImg = http.request(characterID)

    if characterImg == nil then
        print("No Dice")
    else
        local characterSelect  = json.decode(characterImg)
        character_name = characterSelect.chracter[1].charac_name
        txtDEF = characterSelect.chracter[1].friend_def
        txtATK = characterSelect.chracter[1].friend_atk
        txtHP = characterSelect.chracter[1].friend_hp
        txtLV = characterSelect.chracter[1].friend_lv

        ImageCharacter = characterSelect.chracter[1].friend_img_mini
        ImageCharacterFull = characterSelect.chracter[1].friend_img
        FrameCharacter = tonumber(characterSelect.chracter[1].friend_element)
    end
    return true
end

local function onBtnRelease(event)
    display:remove(gdisplay)
    gdisplay = nil

    print("page previous_scene_name=",previous_scene_name)
    if event.target.id == "back" then
        storyboard.gotoScene( previous_scene_name ,options)
        -- back image profile
    elseif event.target.id == "imageprofile" then

        storyboard.gotoScene( previous_scene_name ,options )
    end

end
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
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
        width=screenW*.1, height=display.contentHeight/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
    gdisplay:insert(backButton)

    --button image profile
    local imageFream = widget.newButton{
        default= frame[FrameCharacter],
        over= frame[FrameCharacter],
        width=screenW*.16, height=screenH*.12,
        onRelease = onBtnRelease	-- event listener function
    }
    imageFream.id="imageprofile"
    imageFream.x = viewableScreenW/4.2
    imageFream.y = viewableScreenH/1.65


    local imageprofile = display.newImageRect(ImageCharacter,screenW*.16,screenH*.12)
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

    local namelenght = string.len(character_name)
    local pointName =  (screenW*.5) - ((namelenght*sizetextName)/4)

    local background2 = display.newImageRect(image_background, display.contentWidth, display.contentHeight )
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0
    gdisplay:insert(background2)

    local NameText = display.newText(character_name, pointName, screenH *.3,typeFont, sizetextName)
    NameText:setTextColor(255, 255, 255)
    gdisplay:insert(NameText)

    local LVPHtext = display.newImageRect(image_LVPH, screenW*.44, screenH*.07 )
    LVPHtext:setReferencePoint( display.CenterReferencePoint )
    LVPHtext.x = screenW*.57
    LVPHtext.y = screenH*.628
    gdisplay:insert(LVPHtext)

    local smashText = display.newText(txtSmach[numsmash], 0, 0,typeFont, sizetext)
    smashText:setTextColor(255, 255, 255)
    smashText.x = screenW *.59
    smashText.y = screenH *.62
    gdisplay:insert(smashText)

    -- ***  LV HP ATK DEF  *** --
    local showLV = display.newText(txtLV, screenW *.41, screenH *.59,typeFont, sizetext)
    showLV:setTextColor(255, 0, 255)
    gdisplay:insert(showLV)
    local showHP = display.newText(txtHP, screenW *.41, screenH *.61,typeFont, sizetext)
    showHP:setTextColor(255, 0, 255)
    gdisplay:insert(showHP)
    local showATK = display.newText(txtATK, screenW *.41, screenH *.63,typeFont, sizetext)
    showATK:setTextColor(255, 0, 255)
    gdisplay:insert(showATK)
    local showDEF = display.newText(txtDEF, screenW *.41, screenH *.65,typeFont, sizetext)
    showDEF:setTextColor(255, 0, 255)
    gdisplay:insert(showDEF)

    -- *** NEXT COST *** --
    local showNEXT = display.newText(txtNEXT, screenW *.58, screenH *.59,typeFont, sizetext)
    showNEXT:setTextColor(255, 0, 255)
    gdisplay:insert(showNEXT)
    local showCOST = display.newText(txtCOST, screenW *.8, screenH *.59,typeFont, sizetext)
    showCOST:setTextColor(255, 0, 255)
    gdisplay:insert(showCOST)

    -- *** MASSAGE SKILL L SKILL *** --
    local showMSNL_skill = display.newText(txtL_skill, screenW *.15,  screenH *.70,typeFont, sizetext)
    showMSNL_skill:setTextColor(255, 0, 255)
    gdisplay:insert(showMSNL_skill)
    local showMSNskill = display.newText(txtskill, screenW *.15,  screenH *.78,typeFont, sizetext)
    showMSNskill:setTextColor(255, 0, 255)
    gdisplay:insert(showMSNskill)


    local charaterImage = display.newImageRect(ImageCharacterFull,sizeImageprofileW , sizeImageprofileH)
    charaterImage:setReferencePoint( display.CenterReferencePoint )
    charaterImage.x = screenW*.5
    charaterImage.y = screenH *.48
    gdisplay:insert(charaterImage)

    local skillText = display.newImageRect(image_skill, screenW*.095, screenH*.093 )
    skillText:setReferencePoint( display.CenterReferencePoint )
    skillText.x = screenW*.2
    skillText.y = screenH*.734
    gdisplay:insert(skillText)


    createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

--    group:insert(background2)
--    group:insert(imageprofile)
--    group:insert(imageFream)
--    group:insert(backButton)
--    group:insert(charaterImage)
--
--    group:insert(showLV)
--    group:insert(showHP)
--    group:insert(showATK)
--    group:insert(showDEF)
--    group:insert(showNEXT)
--    group:insert(showCOST)
--
--    group:insert(showMSNskill)
--    group:insert(showMSNL_skill)
--
--    group:insert(smashText)
--    group:insert(NameText)
--    group:insert(skillText)
--    group:insert(LVPHtext)
    group:insert(gdisplay)

    checkMemory()
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
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )
end

function scene:destroyScene( event )
    local group = self.view
    character_name = nil
    txtDEF = nil
    txtATK  = nil
    txtHP  = nil
    txtLV = nil
    ImageCharacter = nil
    ImageCharacterFull = nil
    FrameCharacter = nil

    txtNEXT = nil
    txtCOST = nil
    txtL_skill = nil
    txtskill = nil
    options = nil
    sizeImageprofileW = nil
    sizeImageprofileH = nil
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
