print("power_up_main")

local storyboard = require("storyboard")
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()

local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local util = require ("util")
local http = require("socket.http")
local json = require("json")
-------------------------------------------------
local character_id
local user_id
local LinkURL = "http://localhost/DYM/character.php"
-------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight

local image_text = "img/text/POWER_UP.png"
-- -----------CHARACTER MAIN BIG----------------------------
local character_name
local character_type =0
local character_LV=0
local character_HP =0
local character_DEF=0
local character_ATK =0
local ImageCharacter
local FrameCharacter
local characterSelect

-- ----------------CHARACTER SELECT ----------------------------------------
local leaderSelect
local leader_type ={}
local leader_name={}
local leader_DEF={}
local leader_ATK ={}
local leader_HP ={}
local leader_LV ={}
local Frameleader={}
local Imageleader={}
-- --------------------------------------------------------

--local image_background1 = "img/background/pageBackground_JPG/power_up.psd"


local image_enchant = "img/background/powerup/ENCHANT_UNIT.png"
local image_btnenchant = "img/background/button/ENCHANT.png"
local image_btnCHOOSE_CARD = "img/background/button/CHOOSE_CARD.png"
local image_freamset = "img/background/powerup/FRAME_SET.png"
local image_leaderChar = "img/CharacterIcon/as_cha_frm00.png"

local image_txtHPLV = "img/background/character/HP,LV,ATC,DEF_character.png"
local image_txtLV_NEXT = "img/text/LV_NEXT.png"
local image_txtEXPGAIN = "img/text/EXPGAIN.png"

local image_tappower = "img/background/powerup/line_transparent.png"
local image_tapred = "img/background/powerup/line_red.png"
local image_tapyellow = "img/background/powerup/line_yellow.png"

local image_SKL = "img/background/button/SKL.png"
local image_LSKL = "img/background/button/LSKL.png"

local frame = {
    "img/characterIcon/as_cha_frm01.png",
    "img/characterIcon/as_cha_frm02.png",
    "img/characterIcon/as_cha_frm03.png",
    "img/characterIcon/as_cha_frm04.png",
    "img/characterIcon/as_cha_frm05.png"
}
local frame0 = "img/characterIcon/as_cha_frm00.png"

local strcoin = "0000"
local strsmash = "SMASH ATTACK"
local sizetextname = 24
local sizetxtHPLV = 18
local typeFont = native.systemFontBold

local tapPowerredW = 0
local tapPowerredH = screenH*.012

local tapPoweryellow = 0
local tapPoweryelloH = screenH*.012

local backButton
local btnenchant
local btnchoose
local btnleader
local framImage
local btnSKL
local btnLSKL

local character = {}
local framCharac = {}

local characterChoose = {}
local pointCharacY = {}
local pointCharacX = {}
local countCHNo

local function onBtnonclick(event)
    local options
   if countCHNo then
       options =
       {
           effect = "fade",
           time = 100,
           params = {
               character_id =character_id ,
               user_id = user_id  ,
               countCHNo = countCHNo,
               characterChoose = characterChoose   ,
               pointCharacY = pointCharacY  ,
               pointCharacX = pointCharacX
           }
       }

   else
       options =
       {
           effect = "fade",
           time = 100,
           params = {
               character_id =character_id ,
               user_id = user_id
           }
       }
   end


    print( "event: "..event.target.id)
    if event.target.id == "back" then

        storyboard.gotoScene( previous_scene_name ,"fade", 100 )

    elseif event.target.id == "choose" then
            storyboard.gotoScene( "characterAll" ,options )

    elseif event.target.id == "enchant" then
        storyboard.gotoScene( "unit_main" ,"fade", 100 )

    elseif event.target.id == "leader" then
        storyboard.gotoScene( "characterprofile" ,options )

    elseif event.target.id == "character1" then
        --storyboard.gotoScene( "characterprofile" ,"fade", 100 )
    end
    return true
end

local function loadCharacter(id,USER_id)
    local characterID =  LinkURL.."?character="..id.."&user_id="..USER_id
    local characterImg = http.request(characterID)

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
    end
    return true

end
local function createButton()
    local image_btnback = "img/background/button/Button_BACK.png"


    backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnonclick	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)

    -- choose card
    btnchoose = widget.newButton{
        default= image_btnCHOOSE_CARD,
        over= image_btnCHOOSE_CARD,
        width=screenW*.26, height=screenH*.055,
        onRelease = onBtnonclick	-- event listener function
    }
    btnchoose.id="choose"
    btnchoose:setReferencePoint( display.TopLeftReferencePoint )
    btnchoose.x = screenW *.16
    btnchoose.y = screenH *.764

    -- enchant
    btnenchant = widget.newButton{
        default= image_btnenchant,
        over= image_btnenchant,
        width=screenW*.21, height=screenH*.05,
        onRelease = onBtnonclick	-- event listener function
    }
    btnenchant.id="enchant"
    btnenchant:setReferencePoint( display.TopLeftReferencePoint )
    btnenchant.x = screenW *.635
    btnenchant.y = screenH *.77

    -- charecter leader power up ------------------------------------------------------
    btnleader = widget.newButton{
        default= ImageCharacter,
        over= ImageCharacter,
        width=screenW*.165, height=screenH*.115,
        onRelease = onBtnonclick	-- event listener function
    }
    btnleader.id= "leader"
    btnleader:setReferencePoint( display.TopLeftReferencePoint )
    btnleader.x = screenW *.185
    btnleader.y = screenH *.395

    framImage = display.newImageRect(frame[FrameCharacter] ,screenW*.165, screenH*.115)
    framImage:setReferencePoint( display.TopLeftReferencePoint )
    framImage.x = screenW *.185
    framImage.y = screenH *.395

 --------------------------------------------------------------------------------------
    local groupCharac = display.newGroup()

    for i = 1, 5 ,1 do
        print("countCHNo fo r :",countCHNo)
        if countCHNo then
            if i <= countCHNo then
                framCharac[i] = display.newImageRect(frame[Frameleader[i]] ,screenW*.115, screenH*.08)
                framCharac[i]:setReferencePoint( display.TopLeftReferencePoint )
                framCharac[i].x = i*(screenW*.135) + (screenW *.05)
                framCharac[i].y = screenH *.672
                groupCharac:insert(framCharac[i])

                character[i] = widget.newButton{
                    default= Imageleader[i],
                    over= Imageleader[i],
                    width=screenW*.115, height=screenH*.08,
                    --onRelease = onBtnonclick	-- event listener function
                }
                character[i].id="character"..i
                character[i]:setReferencePoint( display.TopLeftReferencePoint )
                character[i].x = i*(screenW*.135) + (screenW *.05)
                character[i].y = screenH *.672
            else
                character[i] = widget.newButton{
                    default= frame0,
                    over= frame0,
                    width=screenW*.115, height=screenH*.08,
                    --onRelease = onBtnonclick	-- event listener function
                }
                character[i].id="character"..i
                character[i]:setReferencePoint( display.TopLeftReferencePoint )
                character[i].x = i*(screenW*.135) + (screenW *.05)
                character[i].y = screenH *.672
            end

        else
            character[i] = widget.newButton{
                default= frame0,
                over= frame0,
                width=screenW*.115, height=screenH*.08,
                --onRelease = onBtnonclick	-- event listener function
            }
            character[i].id="character"..i
            character[i]:setReferencePoint( display.TopLeftReferencePoint )
            character[i].x = i*(screenW*.135) + (screenW *.05)
            character[i].y = screenH *.672
        end
        groupCharac:insert(character[i])

    end

    -- button SKL
    btnSKL = widget.newButton{
        default= image_SKL,
        over= image_SKL,
        width=screenW*.087, height=screenH*.033,
        onRelease = onBtnonclick	-- event listener function
    }
    btnSKL.id="SKL"
    btnSKL:setReferencePoint( display.TopLeftReferencePoint )
    btnSKL.x = screenW *.185
    btnSKL.y = screenH *.518

    -- button LSKL
    btnLSKL = widget.newButton{
        default= image_LSKL,
        over= image_LSKL,
        width=screenW*.087, height=screenH*.033,
        onRelease = onBtnonclick	-- event listener function
    }
    btnLSKL.id="LSKL"
    btnLSKL:setReferencePoint( display.TopLeftReferencePoint )
    btnLSKL.x = screenW *.28
    btnLSKL.y = screenH *.518
end



function scene:createScene( event )
    print("--------** power up main **-------:")
    local group = self.view
    local image_background1 = "img/background/background_1.jpg"
    local image_baseunit = "img/background/powerup/BASE_UNIT.png"

    local params = event.params
    if params then
        character_id = params.character_id
        user_id = params.user_id
    end

    local paramsCharac = event.params
    if paramsCharac then
--        characterChoose  = paramsCharac.characterChoose
        countCHNo = paramsCharac.countCHNo
        character_id = paramsCharac.character_id
        user_id = paramsCharac.user_id

        if countCHNo then
            for k = 1,countCHNo, 1  do
                characterChoose[k] = paramsCharac.characterChoose[k]
                pointCharacX[k] = paramsCharac.pointCharacX[k]
                pointCharacY[k] = paramsCharac.pointCharacY[k]

                print("characterChoose[k]:",characterChoose[k])
                local characterID =  LinkURL.."?character="..characterChoose[k].."&user_id="..user_id
                local characterImg = http.request(characterID)


                if characterImg == nil then
                    print("No Dice")
                else
                    leaderSelect  = json.decode(characterImg)
                    leader_type = "smach"
                    leader_name[k] = leaderSelect.chracter[1].charac_name
                    leader_DEF[k] = leaderSelect.chracter[1].charac_def
                    leader_ATK[k] = leaderSelect.chracter[1].charac_atk
                    leader_HP[k] = leaderSelect.chracter[1].charac_hp
                    leader_LV[k] = leaderSelect.chracter[1].charac_lv
                    Imageleader[k] = leaderSelect.chracter[1].charac_img_mini
                    Frameleader[k] = tonumber(leaderSelect.chracter[1].charac_element)
                end
            end
        end



    end


    loadCharacter(character_id,user_id)

    local gdisplay = display.newGroup()
    local background1 = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0

    local titleText = display.newImageRect(image_text,screenW*.25,screenH*.028)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = display.contentWidth*.5
    titleText.y = display.contentHeight*.325

    local titlebase = display.newImageRect(image_baseunit,screenW*.65,screenH*.027)--contentWidth contentHeight
    titlebase:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titlebase.x = screenW*.51
    titlebase.y = display.contentHeight*.37


    local titleHPLV = display.newImageRect(image_txtHPLV,screenW*.05,screenH*.08)--contentWidth contentHeight
    titleHPLV:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleHPLV.x = screenW*.41
    titleHPLV.y = screenH*.485

    --*****************
    local txtLVNEXT = display.newImageRect(image_txtLV_NEXT,screenW*.08,screenH*.036)--contentWidth contentHeight
    txtLVNEXT:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    txtLVNEXT.x = screenW*.23
    txtLVNEXT.y = screenH*.575

    local txtEXPGAIN = display.newImageRect(image_txtEXPGAIN,screenW*.14,screenH*.014)--contentWidth contentHeight
    txtEXPGAIN:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    txtEXPGAIN.x = screenW*.53
    txtEXPGAIN.y = screenH*.585
    --*****************

    local titleEnchant = display.newImageRect(image_enchant,screenW*.65,screenH*.027)--contentWidth contentHeight
    titleEnchant:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleEnchant.x = screenW*.51
    titleEnchant.y = screenH*.642

    local powerLine = display.newImageRect(image_tappower ,screenW*.65,screenH*.012)--contentWidth contentHeight
    powerLine:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    powerLine.x = screenW*.51
    powerLine.y = screenH*.61

    local powerred = display.newImageRect(image_tapred,tapPowerredW,0)--contentWidth contentHeight
    powerred:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    powerred.x = screenW*.51
    powerred.y = screenH*.61

    local poweryellow = display.newImageRect(image_tapyellow,tapPoweryellow,0)--contentWidth contentHeight
    poweryellow:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    poweryellow.x = screenW*.51
    poweryellow.y = screenH*.61

    local txtcoin = display.newText(strcoin, screenW*.74, screenH*.628, native.systemFontBold, 18)
    txtcoin:setTextColor(255, 0, 255)

    --text name character
    local txtNamecharacter = display.newText(character_name, screenW*.385, screenH*.385, typeFont, sizetextname)
    txtNamecharacter:setTextColor(0, 0, 255)
    local txtsmash = display.newText(strsmash, screenW*.385,  screenH*.415, typeFont, sizetxtHPLV)
    txtsmash:setTextColor(0, 150, 0)

    local txtLV = display.newText(character_LV, screenW*.47, screenH*.438, typeFont, sizetxtHPLV)
    txtLV:setTextColor(255, 255, 255)
    local txtHP = display.newText(character_HP, screenW*.47, screenH*.46, typeFont, sizetxtHPLV)
    txtHP:setTextColor(255, 255, 255)
    local txtATK = display.newText(character_ATK, screenW*.47, screenH*.482, typeFont, sizetxtHPLV)
    txtATK:setTextColor(255, 255, 255)
    local txtDEF = display.newText(character_DEF, screenW*.47, screenH*.504, typeFont, sizetxtHPLV)
    txtDEF:setTextColor(255, 255, 255)

    createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background1)

    group:insert(backButton)
    group:insert(titlebase)
    group:insert(titleEnchant)
    group:insert(txtcoin)

    group:insert(titleHPLV)

    group:insert(btnSKL)
    group:insert(btnLSKL)

    group:insert(btnenchant)
    group:insert(btnchoose)
    group:insert(btnleader)
    group:insert(framImage)

    group:insert(txtLVNEXT)
    group:insert(txtEXPGAIN)

    group:insert(powerLine)
    group:insert(powerred)
    group:insert(poweryellow)

    group:insert(titleText)
    group:insert(txtNamecharacter)
    group:insert(txtsmash)
    group:insert(txtHP)
    group:insert(txtDEF)
    group:insert(txtLV)
    group:insert(txtATK)

    group:insert(character[1])
    group:insert(character[2])
    group:insert(character[3])
    group:insert(character[4])
    group:insert(character[5])

    if countCHNo then
        for i = 1,countCHNo,1  do
            group:insert(framCharac[i])

        end

    end
    group:insert(gdisplay)

    --------------------------------------------
    storyboard.removeScene( "character_scene" )
    storyboard.removeScene( "characterprofile" )
    storyboard.removeScene( "characterAll" )

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

