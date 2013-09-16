local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.disableAutoPurge = true
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()

local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local alertMSN = require("alertMassage")
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
local NumCoin = 0
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
local SUMformula =0
local charac_lvmax ={}
local charac_sac ={}
local charac_hpStart ={}
local LevelStart


local countCHNo = 0
local LinkURL = "http://localhost/DYM/Onecharacter.php"
local gdisplay = display.newGroup()

local characterLEVELUP ={}
local ExpforChoose = 3
local ExpforUser = 2
local ExpLvNext = 1

local HPNext = 0
local DefNext = 0
local AtkNext = 0
-------------------------------------------
local function onBtnonclick(event)
    local options
    print("countCHNo ====== ",countCHNo)
   if countCHNo then
       options =
       {
           effect = "fade",
           time = 100,
           params = {
               character_id =character_id ,
               user_id = user_id  ,
               countCHNo = countCHNo,
               characterChoose = characterChoose ,
               pointCharacY = pointCharacY  ,
               pointCharacX = pointCharacX ,
               characterCHooseLV = characterCHooseLV ,
               character_LV = LevelStart,


               LVNext =characterLEVELUP.LV ,
               ExpNext = ExpforUser ,
               HPNext = HPNext ,
               DefNext = DefNext ,
               AtkNext = AtkNext ,
               Imageleader = Imageleader ,
               ImageCharacter = characterLEVELUP.ImageCharacter ,
               elementMain = characterLEVELUP.FrameCharacter ,
               element = Frameleader,
           }
       }

   else
       options =
       {
           effect = "fade",
           time = 100,
           params = {
               character_id =character_id ,
               character_LV =characterLEVELUP.LV ,
               user_id = user_id
           }
       }
   end


    display.remove(gdisplay)
    gdisplay = nil

    if event.target.id == "back" then
        storyboard.gotoScene( "characterAll" )


    elseif event.target.id == "choose" then
        storyboard.gotoScene( "characterAll" ,options )


    elseif event.target.id == "enchant" then
            local LinkURL = "http://localhost/DYM/power_up.php"
            local numberHold_character =  LinkURL.."?user_id="..user_id.."&character_id="..character_id.."&LVNext="..characterLEVELUP.LV.."&ExpNext="..ExpforUser.."&HPNext="..HPNext.."&DefNext="..DefNext.."&AtkNext="..AtkNext
            local numberHold = http.request(numberHold_character)
            local allRow = {}
            if numberHold == nil then
                print("No Dice")
            else
                allRow  = json.decode(numberHold)
            end

            storyboard.gotoScene( "power_up_save" ,options )

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
        characterLEVELUP.type = "smach"
        characterLEVELUP.name = characterSelect.chracter[1].charac_name
        characterLEVELUP.DEF = characterSelect.chracter[1].charac_def
        characterLEVELUP.ATK = characterSelect.chracter[1].charac_atk
        characterLEVELUP.HP = characterSelect.chracter[1].charac_hp
        characterLEVELUP.LV = characterSelect.chracter[1].charac_lv
        characterLEVELUP.charac_exp = tonumber(characterSelect.chracter[1].charac_exp)
        characterLEVELUP.ImageCharacter = characterSelect.chracter[1].charac_img_mini
        characterLEVELUP.FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)
        characterLEVELUP.expstart = tonumber(characterSelect.chracter[1].charac_expstart)
        characterLEVELUP.charac_lvmax = tonumber(characterSelect.chracter[1].charac_lvmax)
        characterLEVELUP.charac_hpStart = tonumber(characterSelect.chracter[1].charac_hpStart)
        LevelStart =  characterLEVELUP.LV
    end
    return true

end
local function createButton()
    local image_btnback = "img/background/button/Button_BACK.png"
    local frame = {}
    frame = alertMSN.loadFramElement()
    local frame0 = "img/characterIcon/as_cha_frm00.png"

    local backButton = widget.newButton{
        defaultFile= image_btnback,
        overFile= image_btnback,
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
        defaultFile= image_btnCHOOSE_CARD,
        overFile= image_btnCHOOSE_CARD,
        width=screenW*.26, height=screenH*.055,
        onRelease = onBtnonclick
    }
    btnchoose.id="choose"
    btnchoose:setReferencePoint( display.TopLeftReferencePoint )
    btnchoose.x = screenW *.16
    btnchoose.y = screenH *.764
    gdisplay:insert(btnchoose)

    -- enchant
    local function onTouchenchant (self, event )

        if event.phase == "began" then


            return true
        end

    end
    local image_btnenchant = "img/background/button/ENCHANT.png"
    local btnenchant = widget.newButton{
        defaultFile= image_btnenchant,
        overFile= image_btnenchant,
        width=screenW*.21, height=screenH*.05,
        onRelease = onBtnonclick
    }
    btnenchant.id="enchant"
    btnenchant:setReferencePoint( display.TopLeftReferencePoint )
    btnenchant.x = screenW *.635
    btnenchant.y = screenH *.77
    gdisplay:insert(btnenchant)

    local BGdrop
    local groupView = display.newGroup()
   -- countCHNo= 0
    if countCHNo == 0 then
        BGdrop = display.newRoundedRect(screenW*.62, screenH*.77, screenW*.25, screenH*.05,5)
        BGdrop.strokeWidth = 0
        BGdrop.alpha = .8
        BGdrop:setFillColor(0 ,0 ,0)
        groupView:insert(BGdrop)
        groupView.touch = onTouchenchant
        groupView:addEventListener( "touch", groupView )
        gdisplay:insert(groupView)
    end


    -- charecter leader power up ------------------------------------------------------
    local btnleader = widget.newButton{
        defaultFile= characterLEVELUP.ImageCharacter,
        overFile= characterLEVELUP.ImageCharacter,
        width=screenW*.165, height=screenH*.115,
        onRelease = onBtnonclick
    }
    btnleader.id= "leader"
    btnleader:setReferencePoint( display.TopLeftReferencePoint )
    btnleader.x = screenW *.185
    btnleader.y = screenH *.395
    gdisplay:insert(btnleader)

    local framImage = display.newImageRect(frame[characterLEVELUP.FrameCharacter] ,screenW*.165, screenH*.115)
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
                    defaultFile= Imageleader[i],
                    overFile= Imageleader[i],
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
                    defaultFile= frame0,
                    overFile= frame0,
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
                defaultFile= frame0,
                overFile= frame0,
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
        defaultFile= image_SKL,
        overFile= image_SKL,
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
        defaultFile= image_LSKL,
        overFile= image_LSKL,
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
        print("countCHNo == ",countCHNo)
        if countCHNo then

            SUMformula = paramsCharac.SUMformula
            print("SUMformula === ",SUMformula)
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
                    leader_LV[k] = tonumber(leaderSelect.chracter[1].charac_lv)
                    charac_sac[k] = tonumber(leaderSelect.chracter[1].charac_expstart)
                    Imageleader[k] = leaderSelect.chracter[1].charac_img_mini
                    Frameleader[k] = tonumber(leaderSelect.chracter[1].charac_element)
                    charac_lvmax[k] = tonumber(leaderSelect.chracter[1].charac_lvmax)
--                    charac_hpStart[k] = tonumber(leaderSelect.chracter[1].charac_hpStart)


                end
            end
        else
            countCHNo = 0
        end

    end

    loadCharacter(character_id,user_id)

    NumCoin = countCHNo *(characterLEVELUP.LV*100)

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
    txtLVNEXT.y = screenH*.59
    gdisplay:insert(txtLVNEXT)

    local image_txtEXPGAIN = "img/text/EXPGAIN.png"
    local txtEXPGAIN = display.newImageRect(image_txtEXPGAIN,screenW*.14,screenH*.015)--contentWidth contentHeight
    txtEXPGAIN:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    txtEXPGAIN.x = screenW*.53
    txtEXPGAIN.y = screenH*.6
    gdisplay:insert(txtEXPGAIN)
    --*****************

    local image_enchant = "img/background/powerup/ENCHANT_UNIT.png"
    local titleEnchant = display.newImageRect(image_enchant,screenW*.65,screenH*.027)--contentWidth contentHeight
    titleEnchant:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleEnchant.x = screenW*.51
    titleEnchant.y = screenH*.642
    gdisplay:insert(titleEnchant)

-----***** ------
    ExpforChoose = SUMformula
    ExpLvNext = characterLEVELUP.charac_exp + math.ceil( characterLEVELUP.expstart+ (characterLEVELUP.expstart* ( (characterLEVELUP.LV-1)/characterLEVELUP.charac_lvmax) )*characterLEVELUP.LV )
    ExpforUser = characterLEVELUP.charac_exp
    ExpforUser = ExpforUser + ExpforChoose
    local ExpLvNext1 = math.ceil(ExpLvNext - ExpforUser)
    print("ExpLvNext want = ",ExpLvNext1)
    if ExpLvNext1 <= 0 then
        characterLEVELUP.LV =characterLEVELUP.LV+1 --nex level set new
        local nextLV = characterLEVELUP.LV --nex level check
        local ExpLvNext2 = math.ceil(ExpLvNext )
        local j = characterLEVELUP.LV

        repeat
            ExpLvNext = math.ceil(ExpLvNext +(characterLEVELUP.expstart+ (characterLEVELUP.expstart*(((j-1)/characterLEVELUP.charac_lvmax)*j) )) )
            ExpLvNext2 =  math.ceil(ExpLvNext - ExpforUser)
            if ExpLvNext2 <= 0 then
                nextLV = nextLV+ 1
                j = j + 1
            else
                characterLEVELUP.LV = j
                ExpLvNext = ExpLvNext2
                j = j + nextLV
            end
        until j > nextLV  or nextLV >= characterLEVELUP.charac_lvmax

    else
        ExpLvNext =  ExpLvNext1
    end

    print("LV NEXT = ",characterLEVELUP.LV)





    local R = math.ceil(( characterLEVELUP.charac_lvmax/30)*1.5)
    HPNext = math.ceil(characterLEVELUP.charac_hpStart +(characterLEVELUP.charac_hpStart*((LevelStart-1)/characterLEVELUP.charac_lvmax)+((LevelStart-1)*R)))
    AtkNext = math.ceil(characterLEVELUP.ATK +(characterLEVELUP.ATK *((LevelStart-1)/characterLEVELUP.charac_lvmax)+((LevelStart-1)*R)))
    DefNext = math.ceil(characterLEVELUP.DEF +(characterLEVELUP.DEF *((LevelStart-1)/characterLEVELUP.charac_lvmax)+((LevelStart-1)*R)))

    local txtNumExpforChoose = display.newText("+"..ExpforChoose, screenW*.45, screenH*.625, typeFont, 30)
    txtNumExpforChoose:setTextColor(255, 0, 0)
    gdisplay:insert(txtNumExpforChoose)

    local txtNumUseExp = display.newText(ExpLvNext, screenW*.30, screenH*.58, typeFont, 30)
    txtNumUseExp:setTextColor(255, 0, 255)
    gdisplay:insert(txtNumUseExp)


    local txtNumHaveExp = display.newText(ExpforUser, screenW*.63, screenH*.58, typeFont, 30)
    txtNumHaveExp:setTextColor(255, 0, 100)
    gdisplay:insert(txtNumHaveExp)

 -----


    local image_tappower = "img/background/powerup/line_transparent.png"
    local powerLine = display.newImageRect(image_tappower ,screenW*.65,screenH*.012)--contentWidth contentHeight
    powerLine:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    powerLine.x = screenW*.51
    powerLine.y = screenH*.56
    gdisplay:insert(powerLine)

    local image_tapred = "img/background/powerup/line_red.png"
    local powerred = display.newImageRect(image_tapred,tapPowerredW,0)--contentWidth contentHeight
    powerred:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    powerred.x = screenW*.51
    powerred.y = screenH*.56
    gdisplay:insert(powerred)

    local image_tapyellow = "img/background/powerup/line_yellow.png"
    local poweryellow = display.newImageRect(image_tapyellow,tapPoweryellow,0)--contentWidth contentHeight
    poweryellow:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    poweryellow.x = screenW*.51
    poweryellow.y = screenH*.56
    gdisplay:insert(poweryellow)

    local txtcoin = display.newText(NumCoin, screenW*.74, screenH*.628, native.systemFontBold, 20)
    txtcoin:setTextColor(255, 0, 255)
    gdisplay:insert(txtcoin)

    --text name character
    local txtNamecharacter = display.newText(characterLEVELUP.name, screenW*.385, screenH*.385, typeFont, sizetextname)
    txtNamecharacter:setTextColor(0, 0, 255)
    gdisplay:insert(txtNamecharacter)

    local txtsmash = display.newText(characterLEVELUP.type, screenW*.385,  screenH*.415, typeFont, sizetxtHPLV)
    txtsmash:setTextColor(0, 150, 0)
    gdisplay:insert(txtsmash)


    local txtLV = display.newText(LevelStart.."/"..characterLEVELUP.charac_lvmax.."    =>        / "..characterLEVELUP.charac_lvmax, 0, screenH*.438, typeFont, sizetxtHPLV)
    txtLV.x = screenW*.61
    txtLV:setTextColor(255, 255, 255)
    gdisplay:insert(txtLV)


    local txtLV_Next = display.newText((characterLEVELUP.LV), 0, screenH*.43, typeFont, 30)
    txtLV_Next.x = txtLV.x + 36
    txtLV_Next:setTextColor(255, 0, 255)
    gdisplay:insert(txtLV_Next)

    local txtHP = display.newText(characterLEVELUP.HP, 0, screenH*.46, typeFont, sizetxtHPLV)
    txtHP:setReferencePoint(display.TopLeftReferencePoint)
    txtHP.x = screenW*.47
    txtHP:setTextColor(255, 255, 255)
    gdisplay:insert(txtHP)
    local txtHPNext = display.newText("=> "..HPNext.."  (+"..   math.ceil(HPNext-characterLEVELUP.HP)..")", 0, screenH*.46, typeFont, sizetxtHPLV)
    txtHPNext:setReferencePoint(display.TopLeftReferencePoint)
    txtHPNext.x = screenW*.57
    txtHPNext:setTextColor(255, 255, 255)
    gdisplay:insert(txtHPNext)

    local txtATK = display.newText(characterLEVELUP.ATK, 0, screenH*.482, typeFont, sizetxtHPLV)
    txtATK:setReferencePoint(display.TopLeftReferencePoint)
    txtATK:setTextColor(255, 255, 255)
    txtATK.x =  screenW*.47
    gdisplay:insert(txtATK)
    local txtATKnext = display.newText("=> "..AtkNext.."  (+"..   math.ceil(AtkNext-characterLEVELUP.ATK)..")", 0, screenH*.482, typeFont, sizetxtHPLV)
    txtATKnext:setReferencePoint(display.TopLeftReferencePoint)
    txtATKnext.x =  screenW*.57
    txtATKnext:setTextColor(255, 255, 255)
    gdisplay:insert(txtATKnext)

    local txtDEF = display.newText(characterLEVELUP.DEF, 0, screenH*.504, typeFont, sizetxtHPLV)
    txtDEF:setReferencePoint(display.TopLeftReferencePoint)
    txtDEF.x =  screenW*.47
    txtDEF:setTextColor(255, 255, 255)
    gdisplay:insert(txtDEF)
    local txtDEFnext = display.newText("=> "..DefNext.."  (+"..   math.ceil(DefNext-characterLEVELUP.DEF)..")", 0, screenH*.504, typeFont, sizetxtHPLV)
    txtDEFnext:setReferencePoint(display.TopLeftReferencePoint)
    txtDEFnext.x =  screenW*.57
    txtDEFnext:setTextColor(255, 255, 255)
    gdisplay:insert(txtDEFnext)

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

