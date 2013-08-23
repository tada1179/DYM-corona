local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.disableAutoPurge = true
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()

local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
-------------------------------------------------
local character_id
local user_id
-------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight

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
local strcoin = "0000"
local strsmash = "SMASH ATTACK"
local sizetextname = 24
local sizetxtHPLV = 18
local typeFont = native.systemFontBold

local tapPowerredW = 0
local tapPowerredH = screenH*.012

local tapPoweryellow = 0
local tapPoweryelloH = screenH*.012

local character = {}
local framCharac = {}

local characterChoose = {}
local characterCHooseLV = {}
local pointCharacY = {}
local pointCharacX = {}
local countCHNo
local LinkURL = "http://localhost/DYM/Onecharacter.php"
local gdisplay = display.newGroup()
-------------------------------------------
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
               pointCharacX = pointCharacX ,
               characterCHooseLV = characterCHooseLV
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


    display.remove(gdisplay)
    gdisplay = nil

    characterChoose = nil
    characterCHooseLV = nil
    pointCharacY = nil
    pointCharacX = nil
    countCHNo = nil

    character = nil
    framCharac = nil
    leaderSelect = nil
    leader_type = nil
    leader_name= nil
    leader_DEF= nil
    leader_ATK = nil
    leader_HP = nil
    leader_LV = nil
    Frameleader= nil
    Imageleader = nil

    character_name = nil
    character_type = nil
    character_LV = nil
    character_HP = nil
    character_DEF = nil
    character_ATK = nil
    ImageCharacter = nil
    FrameCharacter = nil
    characterSelect = nil

    character_id = nil
    user_id = nil
    if event.target.id == "back" then
        storyboard.gotoScene( "characterAll" )


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

    local frame = {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }
    local frame0 = "img/characterIcon/as_cha_frm00.png"
    local backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnonclick
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
    gdisplay:insert(backButton)

    -- choose card
    local image_btnCHOOSE_CARD = "img/background/button/CHOOSE_CARD.png"
    local btnchoose = widget.newButton{
        default= image_btnCHOOSE_CARD,
        over= image_btnCHOOSE_CARD,
        width=screenW*.26, height=screenH*.055,
        onRelease = onBtnonclick
    }
    btnchoose.id="choose"
    btnchoose:setReferencePoint( display.TopLeftReferencePoint )
    btnchoose.x = screenW *.16
    btnchoose.y = screenH *.764
    gdisplay:insert(btnchoose)

    -- enchant
    local image_btnenchant = "img/background/button/ENCHANT.png"
    local btnenchant = widget.newButton{
        default= image_btnenchant,
        over= image_btnenchant,
        width=screenW*.21, height=screenH*.05,
        onRelease = onBtnonclick
    }
    btnenchant.id="enchant"
    btnenchant:setReferencePoint( display.TopLeftReferencePoint )
    btnenchant.x = screenW *.635
    btnenchant.y = screenH *.77
    gdisplay:insert(btnenchant)

    -- charecter leader power up ------------------------------------------------------
    local btnleader = widget.newButton{
        default= ImageCharacter,
        over= ImageCharacter,
        width=screenW*.165, height=screenH*.115,
        onRelease = onBtnonclick
    }
    btnleader.id= "leader"
    btnleader:setReferencePoint( display.TopLeftReferencePoint )
    btnleader.x = screenW *.185
    btnleader.y = screenH *.395
    gdisplay:insert(btnleader)

    local framImage = display.newImageRect(frame[FrameCharacter] ,screenW*.165, screenH*.115)
    framImage:setReferencePoint( display.TopLeftReferencePoint )
    framImage.x = screenW *.185
    framImage.y = screenH *.395
    gdisplay:insert(framImage)
 --------------------------------------------------------------------------------------

     local character = {}
    for i = 1, 5 ,1 do
        if countCHNo then
            if i <= countCHNo then
                local framCharac= display.newImageRect(frame[Frameleader[i]] ,screenW*.115, screenH*.08)
                framCharac:setReferencePoint( display.TopLeftReferencePoint )
                framCharac.x = i*(screenW*.135) + (screenW *.05)
                framCharac.y = screenH *.672

                character[i] = widget.newButton{
                    default= Imageleader[i],
                    over= Imageleader[i],
                    width=screenW*.115, height=screenH*.08,
                    --onRelease = onBtnonclick
                }
                character[i].id="character"..i
                character[i]:setReferencePoint( display.TopLeftReferencePoint )
                character[i].x = i*(screenW*.135) + (screenW *.05)
                character[i].y = screenH *.672

                gdisplay:insert(character[i])
                gdisplay:insert(framCharac)

            else
                character[i] = widget.newButton{
                    default= frame0,
                    over= frame0,
                    width=screenW*.115, height=screenH*.08,
                    --onRelease = onBtnonclick
                }
                character[i].id="character"..i
                character[i]:setReferencePoint( display.TopLeftReferencePoint )
                character[i].x = i*(screenW*.135) + (screenW *.05)
                character[i].y = screenH *.672
                gdisplay:insert(character[i])
            end

        else
            character[i] = widget.newButton{
                default= frame0,
                over= frame0,
                width=screenW*.115, height=screenH*.08,
                --onRelease = onBtnonclick
            }
            character[i].id="character"..i
            character[i]:setReferencePoint( display.TopLeftReferencePoint )
            character[i].x = i*(screenW*.135) + (screenW *.05)
            character[i].y = screenH *.672
            gdisplay:insert(character[i])
        end

    end

    local image_SKL = "img/background/button/SKL.png"
    local image_LSKL = "img/background/button/LSKL.png"
    -- button SKL
    local btnSKL = widget.newButton{
        default= image_SKL,
        over= image_SKL,
        width=screenW*.087, height=screenH*.033,
        onRelease = onBtnonclick
    }
    btnSKL.id="SKL"
    btnSKL:setReferencePoint( display.TopLeftReferencePoint )
    btnSKL.x = screenW *.185
    btnSKL.y = screenH *.518
    gdisplay:insert(btnSKL)

    -- button LSKL
    local btnLSKL = widget.newButton{
        default= image_LSKL,
        over= image_LSKL,
        width=screenW*.087, height=screenH*.033,
        onRelease = onBtnonclick
    }
    btnLSKL.id="LSKL"
    btnLSKL:setReferencePoint( display.TopLeftReferencePoint )
    btnLSKL.x = screenW *.28
    btnLSKL.y = screenH *.518
    gdisplay:insert(btnLSKL)
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
        countCHNo = paramsCharac.countCHNo
        character_id = paramsCharac.character_id
        user_id = paramsCharac.user_id

        if countCHNo then
            for k = 1,countCHNo, 1  do
                characterChoose[k] = paramsCharac.characterChoose[k]
                pointCharacX[k] = paramsCharac.pointCharacX[k]
                pointCharacY[k] = paramsCharac.pointCharacY[k]
                characterCHooseLV[k] = paramsCharac.characterCHooseLV[k]

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


    local background = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    gdisplay:insert(background)

    local image_text = "img/text/POWER_UP.png"
    local titleText = display.newImageRect(image_text,screenW*.25,screenH*.028)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = display.contentWidth*.5
    titleText.y = display.contentHeight*.325
    gdisplay:insert(titleText)

    local titlebase = display.newImageRect(image_baseunit,screenW*.65,screenH*.027)--contentWidth contentHeight
    titlebase:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titlebase.x = screenW*.51
    titlebase.y = display.contentHeight*.37
    gdisplay:insert(titlebase)

    local image_txtHPLV = "img/background/character/HP,LV,ATC,DEF_character.png"
    local titleHPLV = display.newImageRect(image_txtHPLV,screenW*.05,screenH*.08)--contentWidth contentHeight
    titleHPLV:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleHPLV.x = screenW*.41
    titleHPLV.y = screenH*.485
    gdisplay:insert(titleHPLV)

    --*****************
    local image_txtLV_NEXT = "img/text/LV_NEXT.png"
    local txtLVNEXT = display.newImageRect(image_txtLV_NEXT,screenW*.08,screenH*.036)--contentWidth contentHeight
    txtLVNEXT:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    txtLVNEXT.x = screenW*.23
    txtLVNEXT.y = screenH*.575
    gdisplay:insert(txtLVNEXT)

    local image_txtEXPGAIN = "img/text/EXPGAIN.png"
    local txtEXPGAIN = display.newImageRect(image_txtEXPGAIN,screenW*.14,screenH*.014)--contentWidth contentHeight
    txtEXPGAIN:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    txtEXPGAIN.x = screenW*.53
    txtEXPGAIN.y = screenH*.585
    gdisplay:insert(txtEXPGAIN)
    --*****************

    local image_enchant = "img/background/powerup/ENCHANT_UNIT.png"
    local titleEnchant = display.newImageRect(image_enchant,screenW*.65,screenH*.027)--contentWidth contentHeight
    titleEnchant:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleEnchant.x = screenW*.51
    titleEnchant.y = screenH*.642
    gdisplay:insert(titleEnchant)

    local image_tappower = "img/background/powerup/line_transparent.png"
    local powerLine = display.newImageRect(image_tappower ,screenW*.65,screenH*.012)--contentWidth contentHeight
    powerLine:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    powerLine.x = screenW*.51
    powerLine.y = screenH*.61
    gdisplay:insert(powerLine)

    local image_tapred = "img/background/powerup/line_red.png"
    local powerred = display.newImageRect(image_tapred,tapPowerredW,0)--contentWidth contentHeight
    powerred:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    powerred.x = screenW*.51
    powerred.y = screenH*.61
    gdisplay:insert(powerred)

    local image_tapyellow = "img/background/powerup/line_yellow.png"
    local poweryellow = display.newImageRect(image_tapyellow,tapPoweryellow,0)--contentWidth contentHeight
    poweryellow:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    poweryellow.x = screenW*.51
    poweryellow.y = screenH*.61
    gdisplay:insert(poweryellow)

    local txtcoin = display.newText(strcoin, screenW*.74, screenH*.628, native.systemFontBold, 18)
    txtcoin:setTextColor(255, 0, 255)
    gdisplay:insert(txtcoin)

    --text name character
    local txtNamecharacter = display.newText(character_name, screenW*.385, screenH*.385, typeFont, sizetextname)
    txtNamecharacter:setTextColor(0, 0, 255)
    gdisplay:insert(txtNamecharacter)

    local txtsmash = display.newText(strsmash, screenW*.385,  screenH*.415, typeFont, sizetxtHPLV)
    txtsmash:setTextColor(0, 150, 0)
    gdisplay:insert(txtsmash)


    local txtLV = display.newText(character_LV, screenW*.47, screenH*.438, typeFont, sizetxtHPLV)
    txtLV:setTextColor(255, 255, 255)
    gdisplay:insert(txtLV)

    local txtHP = display.newText(character_HP, screenW*.47, screenH*.46, typeFont, sizetxtHPLV)
    txtHP:setTextColor(255, 255, 255)
    gdisplay:insert(txtHP)

    local txtATK = display.newText(character_ATK, screenW*.47, screenH*.482, typeFont, sizetxtHPLV)
    txtATK:setTextColor(255, 255, 255)
    gdisplay:insert(txtATK)

    local txtDEF = display.newText(character_DEF, screenW*.47, screenH*.504, typeFont, sizetxtHPLV)
    txtDEF:setTextColor(255, 255, 255)
    gdisplay:insert(txtDEF)

    createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)
    group:insert(gdisplay)

    --------------------------------------------
    storyboard.removeAll()
    storyboard.purgeAll()

end
function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    display.remove(gdisplay)
    gdisplay = nil

    storyboard.removeAll()
    storyboard.purgeAll()

    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )
end

function scene:destroyScene( event )
    local group = self.view


end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

