
---------------------------------------------------------------------------------
-- game-scene.lua - GAME SCENE
print("game-scene.lua")
---------------------------------------------------------------------------------


local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
--** add function ---------------
local widget = require "widget"
local alertMSN = require("alertMassage")
local menu_barLight = require("menu_barLight")
local http = require("socket.http")
local json = require("json")
local physics = require( "physics" )
physics.start()
--physics.setGravity (0, 0)
--physics.setDrawMode ("hybrid")
--**-----------------------------

local _W = display.contentWidth
local _H = display.contentHeight
local background -- background
-- tada1179.w@gmail.com -------------------------------------------------

local user_id
local backButton
local bntItem
local characImage ={}
-- game option
-- 1 : ON
-- 2 : OFF
local character_numAll
local image_char = {}


local BGM = 1
local SFX = 1
local SKL = 1
local BTN = 1

local battle = nil
local mission = nil
local checkOption = 1

local NumExp = 50
local NumCoin = 200
local NumDiamond = 10
local NumFlag = 10
local colercharacter
local maxIcon = 5
local myAnimation
local BGsprite
local image_sheet
local BGAnimation
local Warning

local Gdisplay = display.newGroup()
--  tada1179.w@gmail.com ---------------------------------------------------
local   picture = {"img/element/red.png","img/element/green.png","img/element/blue.png","img/element/purple.png","img/element/pink.png","img/element/yellow.png"}

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-----***** MENU ITEM & Setting *****------
--  tada1179.w@gmail.com -------------------------------
local myItem = {}
local rowItem
local function createItem()

    local Linkmission = "http://localhost/dym/item.php"
    local numberHold_character =  Linkmission.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)


    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        rowItem = allRow.All

        local k = 1
        while(k <= rowItem) do
            myItem[k] = {}
            myItem[k].item_id = allRow.chracter[k].item_id
            myItem[k].element = tonumber(allRow.chracter[k].element)
            myItem[k].img = allRow.chracter[k].img
            myItem[k].holditem_id = allRow.chracter[k].holditem_id
            myItem[k].status = 1
            k = k +1
        end
    end
end
local function Victory_Animation_aura()
    local sheetdata_light = {width = _W, height = 425,numFrames = 75, sheetContentWidth = 3200 ,sheetContentHeight = 6375 }
    local image_sheet = {
        "img/sprite/Victory_Animation/aura.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=5500, loopCount=1 }

    local Victory_aura = display.newSprite( sheet_light, sequenceData )
    Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura.x = 0
    Victory_aura.y = 0
    local function FNVictory_aura()
        Victory_aura:setSequence( "lightaura" )
        Victory_aura:play()
    end
    groupGameLayer:insert(Victory_aura)
    timer.performWithDelay(0,FNVictory_aura )

    return true

end
local function Victory_Animation_font()
    local sheetdata_light = {width = _W, height = 425,numFrames = 75, sheetContentWidth = 3200 ,sheetContentHeight = 6375 }
    local image_sheet = {
        "img/sprite/Victory_Animation/font.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=5400, loopCount=1 }

    local Victory_aura = display.newSprite( sheet_light, sequenceData )
    Victory_aura:setReferencePoint( display.TopLeftReferencePoint)
    Victory_aura.x = 0
    Victory_aura.y = 0
    local function FNVictory_font()
        Victory_aura:setSequence( "lightaura" )
        Victory_aura:play()
    end
    groupGameLayer:insert(Victory_aura)
    timer.performWithDelay(100,FNVictory_font )

    return true

end

local function Warning_Animation()
    local sheetdata_light = {width = _W, height = 225,numFrames = 40, sheetContentWidth = 3200 ,sheetContentHeight = 1800 }
    local image_sheet = {
        "img/sprite/Warning_Animation/spritesheet.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= sheetdata_light.numFrames , time=5400, loopCount=1 }

    Warning = display.newSprite( sheet_light, sequenceData )
    Warning:setReferencePoint( display.TopLeftReferencePoint)
    Warning.x = 0
    Warning.y = 0
    local function FNWarning_Animation()
        Warning:setSequence( "lightaura" )
        Warning:play()
    end
    groupGameLayer:insert(Warning)
    timer.performWithDelay(100,FNWarning_Animation )

    return true

end
local function LeaveOption(event)
    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25


    local function ButtouRelease(event)
        local alertMSN =  require( "alertMassage" )
        if event.target.id == "OK" then
            groupView.alpha = 0
            local useTicket = 0 --0:No use ticket
            local optionBonus = {
                params = {
                    useTicket = useTicket,
                    NumDiamond = 0 ,
                    NumCoin = 0 ,
                    NumEXP = 0,
                    NumFlag = 0,
                    user_id = user_id
                }
            }
            alertMSN.confrimLeaveTicket(optionBonus)

        elseif event.target.id =="cancel"  then
            groupView.alpha = 0
        elseif event.target.id =="useticket"  then
            groupView.alpha = 0
            local useTicket = 1 --1:Yes use ticket
            local optionBonus = {
                params = {
                    useTicket = useTicket,
                    NumDiamond = NumDiamond ,
                    NumCoin = NumCoin ,
                    NumEXP = NumExp,
                    NumFlag = NumFlag,
                    user_id = user_id
                }
            }
            alertMSN.confrimLeaveTicket(optionBonus)

        end

        return true
    end
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local pointimg = _W*.25
    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local bckCaution = display.newImageRect( image_Caution, _W*.95,_H*.8 )
    bckCaution:setReferencePoint( display.CenterReferencePoint )
    bckCaution.x = _W*.5
    bckCaution.y = _H*.5
    bckCaution.alpha = .8
    groupView:insert(bckCaution)

    local image_GAME_OPTION = "img/background/button/RETREAT.png"
    local btnGameop = display.newImageRect( image_GAME_OPTION, _W*.4,_H*.08 )
    btnGameop:setReferencePoint( display.CenterReferencePoint )
    btnGameop.x = _W *.5
    btnGameop.y = _H*.28
    btnGameop.alpha = 1
    groupView:insert(btnGameop)

    local util = require("util")
    local txtMSN = "USE 1 TICKET\n RETREAT FROM BATTLE BUT\n RECIEVE ALL BONUS WHICH\n GOT FROM THE BATTLE\n\n\n\nRETREAT\n RETREAT FROM THE BATTLE\n WITH NO BOUNS WHICH\n GOT FROM THE BATTLE"
    local lotsOfTextObject = util.wrappedText( txtMSN, 30, sizetext, native.systemFont, {0,200,0} )
    lotsOfTextObject.x = _W*.15
    lotsOfTextObject.y = _H*.31
    groupView:insert(lotsOfTextObject)

    local img_useticket = "img/background/button/OK_button.png"
    local btnuseticket = widget.newButton{
        default = img_useticket,
        over = img_useticket,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnuseticket.id = "useticket"
    btnuseticket:setReferencePoint( display.CenterReferencePoint )
    btnuseticket.alpha = 1
    btnuseticket.x = _W*.5
    btnuseticket.y = _H*.52
    groupView:insert(btnuseticket)

    local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local btnucancel = widget.newButton{
        default = img_cancel,
        over = img_cancel,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnucancel.id = "cancel"
    btnucancel:setReferencePoint( display.CenterReferencePoint )
    btnucancel.alpha = 1
    btnucancel.x = _W*.68
    btnucancel.y = _H*.77
    groupView:insert(btnucancel)

    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        default = img_OK,
        over = img_OK,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnOK.id = "OK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = _W*.3
    btnOK.y = _H*.77
    groupView:insert(btnOK)
end
local function BonusOption(event)
    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25
    local image_itemBouns = {
        "img/background/misstion/COIN.png", --coin img
        "img/background/misstion/DIAMOND.png",
        "img/background/misstion/FLAG.png",

    }
    local function ButtouRelease(event)
        if event.target.id == "OK" then
            groupView.alpha = 0
        end

    end

    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local pointimg = _W*.25
    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local bckCaution = display.newImageRect( image_Caution, _W*.95,_H*.8 )
    bckCaution:setReferencePoint( display.CenterReferencePoint )
    bckCaution.x = _W*.5
    bckCaution.y = _H*.5
    bckCaution.alpha = .8
    groupView:insert(bckCaution)

    local image_GAME_OPTION = "img/background/button/BONUS_BUTTON.png"
    local btnGameop = display.newImageRect( image_GAME_OPTION, _W*.4,_H*.08 )
    btnGameop:setReferencePoint( display.CenterReferencePoint )
    btnGameop.x = _W *.5
    btnGameop.y = _H*.3
    btnGameop.alpha = 1
    groupView:insert(btnGameop)

    local img_coin = display.newImageRect( image_itemBouns[1], _W*.12,_H*.08 )
    img_coin:setReferencePoint( display.CenterReferencePoint )
    img_coin.x = pointimg
    img_coin.y = _H*.48
    img_coin.alpha = .8
    groupView:insert(img_coin)

    local img_diamond = display.newImageRect( image_itemBouns[2],  _W*.12,_H*.08 )
    img_diamond:setReferencePoint( display.CenterReferencePoint )
    img_diamond.x = pointimg
    img_diamond.y = _H*.58
    img_diamond.alpha = .8
    groupView:insert(img_diamond)

    local img_flag = display.newImageRect( image_itemBouns[3],  _W*.12,_H*.08 )
    img_flag:setReferencePoint( display.CenterReferencePoint )
    img_flag.x = pointimg
    img_flag.y = _H*.68
    img_flag.alpha = .8
    groupView:insert(img_flag)

    local txtTest = "200"
    local pointtxt = _W*.35
    local pointnum = _W*.65
    local txtEXP = display.newText("EXP", pointtxt, _H*.37, typeFont, sizetext)
    txtEXP:setTextColor(0, 200, 0)
    txtEXP.text =  string.format("EXP")
    txtEXP.alpha = 1
    groupView:insert(txtEXP)
    local numEXP = display.newText(NumExp, pointnum, _H*.37, typeFont, sizetext)
    numEXP:setTextColor(0, 200, 0)
    numEXP.text =  string.format(NumExp)
    numEXP.alpha = 1
    groupView:insert(numEXP)

    local txtcoin = display.newText("Coin", pointtxt, _H*.46, typeFont, sizetext)
    txtcoin:setTextColor(0, 200, 0)
    txtcoin.text =  string.format("Coin")
    txtcoin.alpha = 1
    groupView:insert(txtcoin)
    local numCoin = display.newText(NumCoin, pointnum, _H*.46, typeFont, sizetext)
    numCoin:setTextColor(0, 200, 0)
    numCoin.text =  string.format(NumCoin)
    numCoin.alpha = 1
    groupView:insert(numCoin)

    local txtdiamond = display.newText("Diamond", pointtxt, _H*.56, typeFont, sizetext)
    txtdiamond:setTextColor(0, 200, 0)
    txtdiamond.text =  string.format("Diamond")
    txtdiamond.alpha = 1
    groupView:insert(txtdiamond)
    local numDiamond = display.newText(NumDiamond, pointnum, _H*.56, typeFont, sizetext)
    numDiamond:setTextColor(0, 200, 0)
    numDiamond.text =  string.format(NumDiamond)
    numDiamond.alpha = 1
    groupView:insert(numDiamond)

    local txtflag = display.newText("FLAG", pointtxt, _H*.66, typeFont, sizetext)
    txtflag:setTextColor(0, 200, 0)
    txtflag.text =  string.format("FLAG")
    txtflag.alpha = 1
    groupView:insert(txtflag)
    local numFlag = display.newText(NumFlag, pointnum, _H*.66, typeFont, sizetext)
    numFlag:setTextColor(0, 200, 0)
    numFlag.text =  string.format(NumFlag)
    numFlag.alpha = 1
    groupView:insert(numFlag)

    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        default = img_OK,
        over = img_OK,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnOK.id = "OK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = _W*.5
    btnOK.y = _H*.77
    groupView:insert(btnOK)

end
local function GameOption(option)
    local gameOption = option.params
    mission =  gameOption.mission
    battle =  gameOption.battle

    BGM =  gameOption.BGM
    SFX =  gameOption.SFX
    BTN =  gameOption.BTN
    SKL =  gameOption.SKL
    checkOption =  2


    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25

    local backgroundCaution
    local btnGameop
    local btnBGM_ON
    local btnSFX_ON
    local btnSKL_ON
    local btnBTN_ON

    -- 1: on
    -- 2: off
    local img_button = {
        "img/background/button/ON.png",
        "img/background/button/OFF.png"
    }
    local function ButtouON_Off(event)

        if event.target.id == "BGM1" then
            BGM = 2
            btnBGM_ON.alpha = 0
            btnBGM_ON = widget.newButton{
                default = img_button[BGM],
                over = img_button[BGM],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBGM_ON.id = "BGM"..BGM
            btnBGM_ON:setReferencePoint( display.CenterReferencePoint )
            btnBGM_ON.alpha = 1
            btnBGM_ON.x = _W*.7
            btnBGM_ON.y = _H*.42
            groupView:insert(btnBGM_ON)

        elseif event.target.id == "BGM2" then
            BGM = 1
            btnBGM_ON.alpha = 0
            btnBGM_ON = widget.newButton{
                default = img_button[BGM],
                over = img_button[BGM],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBGM_ON.id = "BGM"..BGM
            btnBGM_ON:setReferencePoint( display.CenterReferencePoint )
            btnBGM_ON.alpha = 1
            btnBGM_ON.x = _W*.7
            btnBGM_ON.y = _H*.42
            groupView:insert(btnBGM_ON)

        elseif event.target.id == "SFX1" then
            SFX = 2
            btnSFX_ON.alpha = 0
            btnSFX_ON = widget.newButton{
                default = img_button[SFX],
                over = img_button[SFX],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSFX_ON.id = "SFX"..SFX
            btnSFX_ON:setReferencePoint( display.CenterReferencePoint )
            btnSFX_ON.alpha = 1
            btnSFX_ON.x = _W*.7
            btnSFX_ON.y = _H*.5
            groupView:insert(btnSFX_ON)

        elseif event.target.id == "SFX2" then
            SFX = 1
            btnSFX_ON.alpha = 0
            btnSFX_ON = widget.newButton{
                default = img_button[SFX],
                over = img_button[SFX],
                width=_W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSFX_ON.id = "SFX"..SFX
            btnSFX_ON:setReferencePoint( display.CenterReferencePoint )
            btnSFX_ON.alpha = 1
            btnSFX_ON.x = _W*.7
            btnSFX_ON.y = _H*.5
            groupView:insert(btnSFX_ON)

        elseif event.target.id == "SKL1" then
            SKL = 2
            btnSKL_ON.alpha = 0
            btnSKL_ON = widget.newButton{
                default = img_button[SKL],
                over = img_button[SKL],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSKL_ON.id = "SKL"..SKL
            btnSKL_ON:setReferencePoint( display.CenterReferencePoint )
            btnSKL_ON.alpha = 1
            btnSKL_ON.x = _W*.7
            btnSKL_ON.y = _H*.58
            groupView:insert(btnSKL_ON)

        elseif event.target.id == "SKL2" then
            SKL = 1
            btnSKL_ON.alpha = 0
            btnSKL_ON = widget.newButton{
                default = img_button[SKL],
                over = img_button[SKL],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnSKL_ON.id = "SKL"..SKL
            btnSKL_ON:setReferencePoint( display.CenterReferencePoint )
            btnSKL_ON.alpha = 1
            btnSKL_ON.x = _W*.7
            btnSKL_ON.y = _H*.58
            groupView:insert(btnSKL_ON)

        elseif event.target.id == "BTN1" then
            BTN = 2
            btnBTN_ON.alpha = 0
            btnBTN_ON = widget.newButton{
                default = img_button[BTN],
                over = img_button[BTN],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBTN_ON.id = "BTN"..BTN
            btnBTN_ON:setReferencePoint( display.CenterReferencePoint )
            btnBTN_ON.alpha = 1
            btnBTN_ON.x = _W*.7
            btnBTN_ON.y = _H*.66
            groupView:insert(btnBTN_ON)
        elseif event.target.id == "BTN2" then
            BTN = 1
            btnBTN_ON.alpha = 0
            btnBTN_ON = widget.newButton{
                default = img_button[BTN],
                over = img_button[BTN],
                width= _W*.2, height= _H*.05,
                onRelease = ButtouON_Off	-- event listener function
            }
            btnBTN_ON.id = "BTN"..BTN
            btnBTN_ON:setReferencePoint( display.CenterReferencePoint )
            btnBTN_ON.alpha = 1
            btnBTN_ON.x = _W*.7
            btnBTN_ON.y = _H*.66
            groupView:insert(btnBTN_ON)

        end


    end
    local function ButtouRelease(event)
        local option = {
            params = {
                BGM = BGM,
                SFX = SFX,
                SKL = SKL,
                BTN = BTN,
                battle = battle,
                mission = mission,
                checkOption = checkOption

            }
        }
        groupView.alpha = 0
    end
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    backgroundCaution = display.newImageRect( image_Caution, _W*.95,_H*.8 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = _W *.5
    backgroundCaution.y = _H*.5
    backgroundCaution.alpha = .8
    groupView:insert(backgroundCaution)

    local image_GAME_OPTION = "img/background/button/GAME_OPTION.png"
    btnGameop = display.newImageRect( image_GAME_OPTION, _W*.4,_H*.08 )
    btnGameop:setReferencePoint( display.CenterReferencePoint )
    btnGameop.x = _W *.5
    btnGameop.y = _H*.31
    btnGameop.alpha = 1
    groupView:insert(btnGameop)

    local image_ON = "img/background/button/ON.png"
    btnBGM_ON = widget.newButton{
        default = img_button[BGM],
        over = img_button[BGM],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnBGM_ON.id = "BGM"..BGM
    btnBGM_ON:setReferencePoint( display.CenterReferencePoint )
    btnBGM_ON.alpha = 1
    btnBGM_ON.x = _W*.7
    btnBGM_ON.y = _H*.42
    groupView:insert(btnBGM_ON)

    btnSFX_ON = widget.newButton{
        default = img_button[SFX],
        over = img_button[SFX],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnSFX_ON.id = "SFX"..SFX
    btnSFX_ON:setReferencePoint( display.CenterReferencePoint )
    btnSFX_ON.alpha = 1
    btnSFX_ON.x = _W*.7
    btnSFX_ON.y = _H*.5
    groupView:insert(btnSFX_ON)

    btnSKL_ON = widget.newButton{
        default = img_button[SKL],
        over = img_button[SKL],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnSKL_ON.id = "SKL"..SKL
    btnSKL_ON:setReferencePoint( display.CenterReferencePoint )
    btnSKL_ON.alpha = 1
    btnSKL_ON.x = _W*.7
    btnSKL_ON.y = _H*.58
    groupView:insert(btnSKL_ON)

    btnBTN_ON = widget.newButton{
        default = img_button[BTN],
        over = img_button[BTN],
        width=_W*.2, height= _H*.05,
        onRelease = ButtouON_Off	-- event listener function
    }
    btnBTN_ON.id = "BTN"..BTN
    btnBTN_ON:setReferencePoint( display.CenterReferencePoint )
    btnBTN_ON.alpha = 1
    btnBTN_ON.x = _W*.7
    btnBTN_ON.y = _H*.66
    groupView:insert(btnBTN_ON)



    local pointtxt = _H*.12
    local txtBGM = display.newText("BGM", pointtxt, _H*.4, typeFont, sizetext)
    txtBGM:setTextColor(0, 200, 0)
    txtBGM.text =  string.format("BGM")
    txtBGM.alpha = 1
    groupView:insert(txtBGM)

    local txtSFx = display.newText("SFx", pointtxt, _H*.48, typeFont, sizetext)
    txtSFx:setTextColor(0, 200, 0)
    txtSFx.text =  string.format("SFx")
    txtSFx.alpha = 1
    groupView:insert(txtSFx)

    local txtSkill = display.newText("Skill Confirmation", pointtxt, _H*.56, typeFont, sizetext)
    txtSkill:setTextColor(0, 200, 0)
    txtSkill.text =  string.format("Skill Confirmation")
    txtSkill.alpha = 1
    groupView:insert(txtSkill)

    local txtBattle = display.newText("Battle Notification", pointtxt, _H*.64, typeFont, sizetext)
    txtBattle:setTextColor(0, 200, 0)
    txtBattle.text =  string.format("Battle Notification")
    txtBattle.alpha = 1
    groupView:insert(txtBattle)


    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        default = img_OK,
        over = img_OK,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnOK.id = "OK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = _W*.5
    btnOK.y = _H*.75
    groupView:insert(btnOK)

    return   option

end
local function MenuInPuzzle(option)

    local c = option.params
    mission =  c.mission
    battle =  c.battle
    BGM =  c.BGM
    SFX =  c.SFX
    BTN =  c.BTN
    SKL =  c.SKL
    checkOption =  c.checkOption



    local groupView = display.newGroup()
    local typeFont = native.systemFontBold
    local sizetext = 25

    --    mission = "ABCDEFGHIJK"
    local strMission = string.len(mission)
    local pointMission =  (_W*.5)-(strMission/4)

    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then


            return true
        end
    end

    local function ButtouRelease(event)
        groupView.alpha = 0
        if event.target.id == "setting" then

            GameOption(option)

        elseif event.target.id == "BONUS" then
            BonusOption(option)

        elseif event.target.id == "LEAVE" then
            LeaveOption(event)

        elseif event.target.id == "cancel" then

        end

    end

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local myRectangle = display.newRoundedRect(0, 0, _W, _H,0)
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .9
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local backgroundCaution = display.newImageRect( image_Caution, _W*.95,_H*.18 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = _W *.5
    backgroundCaution.y = _H*.4
    backgroundCaution.alpha = 1
    groupView:insert(backgroundCaution)

    local image_power= "img/element/green.png"
    local imgPower = display.newImageRect( image_power, _W*.5,_H*.15 )
    imgPower:setReferencePoint( display.CenterReferencePoint )
    imgPower.x = _W *.5
    imgPower.y = _H*.2
    imgPower.alpha = 1
    groupView:insert(imgPower)


    local NameMission = display.newText(battle, pointMission, _H*.35, typeFont, sizetext)
    NameMission:setTextColor(0, 200, 0)
    NameMission.text =  string.format(mission)
    NameMission.alpha = 1
    groupView:insert(NameMission)

    local  NameBattle = display.newText(battle, _W*.5, _H*.4, typeFont, sizetext)
    NameBattle:setTextColor(200, 200, 200)
    NameBattle.text =  string.format("BATTLE :"..battle)
    NameBattle.alpha = 1
    groupView:insert(NameBattle)

    local img_setting = "img/background/button/SETTING.png"
    local setting = widget.newButton{
        default = img_setting,
        over = img_setting,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    setting.id = "setting"
    setting:setReferencePoint( display.TopLeftReferencePoint )
    setting.alpha = 1
    setting.x = _W*.37
    setting.y = _H*.5
    groupView:insert(setting)

    local img_BONUS = "img/background/button/BONUS.png"
    local setBONUS = widget.newButton{
        default = img_BONUS,
        over = img_BONUS,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    setBONUS.id = "BONUS"
    setBONUS:setReferencePoint( display.TopLeftReferencePoint )
    setBONUS.alpha = 1
    setBONUS.x = _W*.37
    setBONUS.y = _H*.6
    groupView:insert(setBONUS)

    local img_LEAVE = "img/background/button/LEAVE.png"
    local setLEAVE = widget.newButton{
        default = img_LEAVE,
        over = img_LEAVE,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    setLEAVE.id = "LEAVE"
    setLEAVE:setReferencePoint( display.TopLeftReferencePoint )
    setLEAVE.alpha = 1
    setLEAVE.x = _W*.37
    setLEAVE.y = _H*.7
    groupView:insert(setLEAVE)

    local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local btncancel = widget.newButton{
        default = img_cancel,
        over = img_cancel,
        width=_W*.3, height= _H*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btncancel.id = "cancel"
    btncancel:setReferencePoint( display.TopLeftReferencePoint )
    btncancel.alpha = 1
    btncancel.x = _W*.37
    btncancel.y = _H*.8
    groupView:insert(btncancel)

    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )

    return option

end

local function createCharacter(event)
    character_numAll = 4
--    character_numAll = math.random(1,character_numAll)
    colercharacter = math.random(1,5)


    local LinkURL = "http://localhost/DYM/character_battle.php"
    local URL =  LinkURL.."?user_id="..user_id.."&character_numAll="..character_numAll
    local response = http.request(URL)

    if response == nil then
        print("No Dice")

    else
        local dataTable = json.decode(response)
        -- character_numAll = dataTable.All

        local m = 1
        while m <= character_numAll do
            if dataTable.character ~= nil then
                image_char[m] = {}
                image_char[m].charac_id = tonumber(dataTable.character[m].charac_id)
                image_char[m].charac_name = dataTable.character[m].charac_name
                image_char[m].charac_img = dataTable.character[m].charac_img
                image_char[m].charac_element = tonumber(dataTable.character[m].charac_name)
                image_char[m].charac_spw = tonumber(dataTable.character[m].charac_spw)
                image_char[m].charac_sph = tonumber(dataTable.character[m].charac_sph)
            end
            m = m + 1
        end
    end

    for i=1,character_numAll,1 do
        local imgCharacter = image_char[i].charac_img
        characImage[i] = display.newImage(imgCharacter,true)

        if characImage[i].width ~= 1024 or characImage[i].height ~= 1024 then
            if characImage[i].width > characImage[i].height then
                characImage[i].height = math.floor(characImage[i].height / (characImage[i].width/1024))
                characImage[i].width = 1024
            else
                characImage[i].width = math.floor(characImage[i].width / (characImage[i].height/1024))
                characImage[i].height = 1024
            end
        end
        --resize to big character
        --        if image_char[i].charac_id == 6  then--img/character/character_TU/kanu-v101.png
        --            characImage[i].width = math.floor(characImage[i].width/3.5)
        --            characImage[i].height =  math.floor(characImage[i].height/3.5)
        --
        --        elseif image_char[i].charac_id == 20 then
        --            characImage[i].width = math.floor(characImage[i].width/4.5)
        --            characImage[i].height =  math.floor(characImage[i].height/4.5)
        --        else
        --            characImage[i].width = math.floor(characImage[i].width/5)
        --            characImage[i].height =  math.floor(characImage[i].height/5)
        --        end
        characImage[i].width = math.floor(characImage[i].width/image_char[i].charac_sph)
        characImage[i].height =  math.floor(characImage[i].height/image_char[i].charac_sph)

        characImage[i]:setReferencePoint( display.BottomCenterReferencePoint)
        characImage[i].x = (_W/(character_numAll+1))*i
        characImage[i].y = _H*.27
        characImage[i].id = i
        groupGameLayer:insert(characImage[i])
       physics.addBody( characImage[i],"static", { density = 1.0, friction = 0, bounce = 0.2, radius = 20 } )

    end
end
local function miniIconCharac(event)
    local teamNumber = 1

    local frm_frind = 1
    local img_frind = "img/characterIcon/img/TouTaku-f101.png"

    local FramElement = alertMSN.loadFramElement()
    local characIcon = {}
    local imgcharacIcon = {}
    local datacharcter = {}
    local rowCharac

    local LinkURL = "http://localhost/DYM/team_setting.php"
    local URL =  LinkURL.."?user_id="..user_id.."&team_no="..teamNumber
    local response = http.request(URL)
    if response == nil then
        print("No Dice")

    else
        local dataTable = json.decode(response)
        rowCharac = dataTable.chrAll

        local m = 1
        while m <= rowCharac do
            datacharcter[m] = {}
            if dataTable.chracter ~= nil then
                datacharcter[m].imagePicture= dataTable.chracter[m].imgMini
                datacharcter[m].holdcharac_id = tonumber(dataTable.chracter[m].holdcharac_id)
                datacharcter[m].element = tonumber(dataTable.chracter[m].element)
                datacharcter[m].team_no = tonumber(dataTable.chracter[m].team_no)
            end
            m = m+1
        end
    end

    local function optionIcon(event)

        alertMSN.NoDataInList()
    end
    --    local pointIconx = -_W*.161
    local pointIconx = _W*.005
    local countChr = 1
    local sizeleaderW = _W*.16
    local sizeleaderH = _H*.106
    for i=1,rowCharac,1 do
        pointIconx = (tonumber(_W*.166)*(datacharcter[i].team_no - 1)) + _W*.005
        imgcharacIcon[i] = display.newImageRect( datacharcter[i].imagePicture , _W*.16, _H*.106 )
        imgcharacIcon[i]:setReferencePoint( display.TopLeftReferencePoint )
        imgcharacIcon[i].x,imgcharacIcon[i].y = pointIconx, _H*.31
        characIcon[i] = widget.newButton{
            default = FramElement[datacharcter[i].element] ,
            over =FramElement[datacharcter[i].element] ,
            width = sizeleaderW ,
            height= sizeleaderH,
            onRelease = optionIcon
        }
        characIcon[i].id= countChr
        characIcon[i]:setReferencePoint( display.TopLeftReferencePoint )
        characIcon[i].x, characIcon[i].y = pointIconx, _H*.31

    end

    imgcharacIcon[rowCharac+1] = display.newImageRect( img_frind , _W*.16, _H*.106 )
    imgcharacIcon[rowCharac+1]:setReferencePoint( display.TopLeftReferencePoint )
    imgcharacIcon[rowCharac+1].x,imgcharacIcon[rowCharac+1].y = (tonumber(_W*.166)*5)+_W*.005, _H*.31
    characIcon[rowCharac+1] = widget.newButton{
        default = FramElement[frm_frind] ,
        over =FramElement[frm_frind] ,
        width = sizeleaderW ,
        height= sizeleaderH,
        onRelease = optionIcon
    }
    characIcon[rowCharac+1].id= countChr
    characIcon[rowCharac+1]:setReferencePoint( display.TopLeftReferencePoint )
    characIcon[rowCharac+1].x, characIcon[rowCharac+1].y = pointIconx, _H*.31
    characIcon[rowCharac+1].x, characIcon[rowCharac+1].y = (tonumber(_W*.166)*5)+_W*.005, _H*.31

end
local function miniIconCharac_frame(event)
    local teamNumber = 1

    local frm_frind = 1
    local img_frind = "img/characterIcon/img/TouTaku-i101.png"

    local FramElement = alertMSN.loadFramElement()
    local characIcon = {}
    local imgcharacIcon = {}
    local datacharcter = {}
    local rowCharac

    local LinkURL = "http://localhost/DYM/team_setting.php"
    local URL =  LinkURL.."?user_id="..user_id.."&team_no="..teamNumber
    local response = http.request(URL)
    if response == nil then
        print("No Dice")

    else
        local dataTable = json.decode(response)
        rowCharac = dataTable.chrAll

        local m = 1
        while m <= rowCharac do
            datacharcter[m] = {}
            if dataTable.chracter ~= nil then
                datacharcter[m].imagePicture= dataTable.chracter[m].imgMini
                datacharcter[m].holdcharac_id = tonumber(dataTable.chracter[m].holdcharac_id)
                datacharcter[m].element = tonumber(dataTable.chracter[m].element)
                datacharcter[m].team_no = tonumber(dataTable.chracter[m].team_no)
            end
            m = m+1
        end
    end

    local function optionIcon(event)

        alertMSN.NoDataInList()
    end
    --    local pointIconx = -_W*.161
    local pointIconx = _W*.005
    local countChr = 1
    local sizeleaderW = _W*.16
    local sizeleaderH = _H*.106

    for i=1,rowCharac,1 do
        print("datacharcter[m].holdcharac_id",i,datacharcter[i].holdcharac_id)
        pointIconx = (tonumber(_W*.166)*(datacharcter[i].team_no - 1)) + _W*.005
        characIcon[i] = widget.newButton{
            default = datacharcter[i].imagePicture,
            over = datacharcter[i].imagePicture ,
            width = sizeleaderW ,
            height= sizeleaderH,
            onRelease = optionIcon
        }
        characIcon[i].id= countChr
        characIcon[i]:setReferencePoint( display.TopLeftReferencePoint )
        characIcon[i].x, characIcon[i].y = pointIconx, _H*.31
        groupGameLayer:insert(characIcon[i])
    end
    characIcon[rowCharac+1] = widget.newButton{
        default = img_frind ,
        over = img_frind ,
        width = sizeleaderW ,
        height= sizeleaderH,
        onRelease = optionIcon
    }
    characIcon[rowCharac+1].id= countChr
    characIcon[rowCharac+1]:setReferencePoint( display.TopLeftReferencePoint )
    characIcon[rowCharac+1].x, characIcon[rowCharac+1].y = pointIconx, _H*.31
    characIcon[rowCharac+1].x, characIcon[rowCharac+1].y = (tonumber(_W*.166)*5)+_W*.005, _H*.31
    groupGameLayer:insert(characIcon[rowCharac+1])

end
local function battleIcon(event,numcharacter,colercharacter)
    local IMGtransition
    local centerImg = (_W*.16)/2
    local img =  "img/element/object.png"
    local randI = math.random(1,6)
--    local randI = 6
    colercharacter = math.random(1,5)
--    colercharacter = 3
   local  battleIconcolor = display.newImageRect( img, 64, 64 )
    if colercharacter == 1 then
        battleIconcolor:setFillColor(255 ,0 ,0) --red
    elseif colercharacter == 2 then
        battleIconcolor:setFillColor( 0 ,205 ,0)     --green
    elseif colercharacter == 3 then
        battleIconcolor:setFillColor( 0 ,191 ,255) --blue
    elseif colercharacter == 4 then
        battleIconcolor:setFillColor(131 ,111 ,255) --purple
    elseif colercharacter == 5 then
        battleIconcolor:setFillColor( 255 ,255 ,0) --yellow
    end

    --battleIconcolor:setFillColor(255,0,0)
    physics.addBody( battleIconcolor, { bounce=0.5, density=1.0 ,friction = 0, radius=14 } )

    battleIconcolor.x, battleIconcolor.y = (tonumber(_W*.166)*(randI-1)) + _W*.005 + centerImg, _H*.36
    local vx, vy = characImage[numcharacter].x - battleIconcolor.x, -180
    --all icon element in puzzle   vy = -400,transition.to (time = 300)
    battleIconcolor.isBullet = true
    battleIconcolor.isSleepingAllowed = true
    battleIconcolor:setLinearVelocity( vx*5,vy*5 )
    local function listener()
        display.remove(battleIconcolor)
        battleIconcolor = nil
        IMGtransition = nil

    end
    if battleIconcolor.isSleepingAllowed == true then
        IMGtransition = transition.to( battleIconcolor, { time=100, xScale=1.3, yScale=1.3, alpha=0.1,onComplete = listener} )
    end
    --menu_barLight.checkMemory()
end

--timerStash.newTimer
--transitionStash.newTransition

local function swapSheet()
    local IMGtransition
    local IMGtimer
    local myAnimation = display.newImageRect( image_sheet[BGsprite] , display.contentWidth, 425 )
    myAnimation:setReferencePoint( display.CenterReferencePoint )
    myAnimation.x, myAnimation.y = _W*.5, _H*.2
    Gdisplay:insert(myAnimation)
    local k = 1
    local i = 0
    local j = 0
    local function finish()
        display.remove(myAnimation)
        myAnimation = nil

        IMGtransition = nil
        IMGtimer = nil
    end
    local function scalTran4()
        k = k - 0.05
        j = j + 0.05
        if k < 0.05 then
            k = 0
            j = 1
        end
        myAnimation.y = myAnimation.y - math.random(1,3)
        myAnimation.x = myAnimation.x - math.random(1,3)
        IMGtransition = transition.to( myAnimation, { time=200, xScale=1.1+i, yScale=1.1+i, alpha=k,y = myAnimation.y ,x = myAnimation.x} )
        if k == 0 then
            finish()
        end
        BGAnimation.alpha = j
        i = i +0.01

    end
    local function scalTran3()
        k = k - 0.05
        j = j + 0.05
        myAnimation.y = myAnimation.y + math.random(1,2)
        myAnimation.x = myAnimation.x + math.random(1,2)
        IMGtransition = transition.to( myAnimation, { time=200, xScale=1.1+i, yScale=1.1+i, alpha=k,y = myAnimation.y ,x = myAnimation.x} )
        IMGtimer = timer.performWithDelay(200, scalTran4)
        i = i +0.01
        BGAnimation.alpha = j
    end
    local function scalTran2()
        k = k - 0.05
        j = j + 0.05
        myAnimation.y = myAnimation.y - math.random(1,4)
        myAnimation.x = myAnimation.x - math.random(1,4)
        IMGtransition = transition.to( myAnimation, { time=200, xScale=1.1+i, yScale=1.1+i, alpha=k,y = myAnimation.y ,x = myAnimation.x} )
        IMGtimer = timer.performWithDelay(200, scalTran3)
        i = i +0.01
        BGAnimation.alpha = j
    end
    local function scalTran()
        k = k - 0.05
        j = j + 0.05
        myAnimation.y = myAnimation.y + math.random(1,2)
        myAnimation.x = myAnimation.x + math.random(1,2)
        IMGtransition = transition.to( myAnimation, { time=200, xScale=1.1+i, yScale=1.1+i, alpha=k,y = myAnimation.y ,x = myAnimation.x} )
        IMGtimer = timer.performWithDelay( 200, scalTran2 )
        i = i +0.01
        BGAnimation.alpha = j
    end

    IMGtimer = timer.performWithDelay( 0, scalTran )
    IMGtimer = timer.performWithDelay( 1000, scalTran )
    IMGtimer = timer.performWithDelay( 2000, scalTran )
    IMGtimer = timer.performWithDelay( 3000, scalTran )
    IMGtimer = timer.performWithDelay( 4000, scalTran )
    menu_barLight.checkMemory()

end
local function fncallSprite2()

    local sheetdata_light = {width = _W, height = 425,numFrames = 100, sheetContentWidth = _W*10 ,sheetContentHeight = (2125*2) }
    local image_sheet = {
        "img/sprite/BG_Forest/Autumn/sprite_sheet.png"
        ,"img/sprite/BG_Forest/Spring/sprite_sheet.png"
        ,"img/sprite/BG_Forest/Summer/sprite_sheet.png"
        ,"img/sprite/BG_Forest/War/sprite_sheet.png"
        ,"img/sprite/BG_Forest/Winter/sprite_sheet.png"


        ,"img/sprite/BG_Mountain/Autumn/sprite_sheet.png"
        ,"img/sprite/BG_Mountain/Spring/sprite_sheet.png"
        ,"img/sprite/BG_Mountain/Summer/sprite_sheet.png"
        ,"img/sprite/BG_Mountain/War/sprite_sheet.png"
        ,"img/sprite/BG_Mountain/Winter/sprite_sheet.png"

        ,"img/sprite/BG_Water/Autumn/sprite_sheet.png"
        ,"img/sprite/BG_Water/Spring/sprite_sheet.png"
        ,"img/sprite/BG_Water/Spring_blue/sprite_sheet.png"
        ,"img/sprite/BG_Water/Summer/sprite_sheet.png"
        ,"img/sprite/BG_Water/War/sprite_sheet.png"
        ,"img/sprite/BG_Water/Winter/sprite_sheet.png"
    }
    local sheet_light = graphics.newImageSheet( image_sheet[BGsprite], sheetdata_light )
    local sequenceData = { name="lightaura", sheet=sheet_light, start=1, count= 100, time=4500, loopCount=1 }

    myAnimation = display.newSprite( sheet_light, sequenceData )
    myAnimation:setReferencePoint( display.TopLeftReferencePoint)
    myAnimation.x = 0
    myAnimation.y = 0
    Gdisplay:insert(myAnimation)

end
local function swapSheet2()
    myAnimation:setSequence( "lightaura" )
    myAnimation:play()
end
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
local function createBackButton(event)
    --loadImage()
    local gameoption =  event.params
    if gameoption then
        mission = gameoption.mission
        battle = gameoption.battle
        BGM = gameoption.BGM
        SFX = gameoption.SFX
        SKL = gameoption.SKL
        BTN = gameoption.BTN
        checkOption = gameoption.checkOption
    else
        mission = "ABCDTADA KWANTA"
        battle = "1/5"

        -- 1 : ON
        -- 2 : OFF
        BGM = 1
        SFX = 1
        SKL = 1
        BTN = 1
        checkOption = 1
    end
    -------tada1179.w@gmail.com


    --loadImage()
    -------tada1179.w@gmail.com

    local function ButtouMenu(event)
        if (event.phase == "ended" or event.phase == "release") then
            if event.target.id == "Menu"  then
                local option = {
                    params = {
                        battle = battle  ,
                        mission = mission ,
                        BGM = BGM ,
                        SFX = SFX ,
                        SKL = SKL,
                        BTN = BTN,
                        checkOption = checkOption
                    }
                }

                MenuInPuzzle(option)

            elseif event.target.id == "Item" then
                --loadImage()

            end

        end

    end

    local imgMenu ="img/background/button/as_butt_pzl_menu.png"
    backButton = widget.newButton{
        default = imgMenu,
        over = imgMenu,
        width=_W*.12, height= _H*.04,
        onRelease = ButtouMenu	-- event listener function
    }
    backButton.id = "Menu"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.alpha = 1
    backButton.x = _W - (_W*.12)
    backButton.y = 0
    --groupGameLayer:insert(backButton)

    local imgItem ="img/background/button/as_butt_sell_plus.png"
    bntItem = widget.newButton{
        default = imgItem,
        over = imgItem,
        width=_W*.12, height= _H*.04,
        onRelease = ButtouMenu	-- event listener function
        --        onRelease = loadImage	-- event listener function
    }
    bntItem.id = "Item"
    bntItem:setReferencePoint( display.TopLeftReferencePoint )
    bntItem.alpha = 1
    bntItem.x = 0
    bntItem.y = 0
    --groupGameLayer:insert(bntItem)
end

-- connect HTTP
local ltn12 = require("ltn12")
function showImage( i)
    native.setActivityIndicator( false )
    testImage = display.newImage(i,system.DocumentsDirectory,_W*.1,_H*(i/4));
    groupGameLayer:insert(testImage)
end
--
function loadImage()
    -- Create local file for saving data
    local path = {}
    local myFile = {}
    for i=1,2,1 do
        path[i] = system.pathForFile(i, system.DocumentsDirectory )
        myFile[i] = io.open( path[i], "w+b" )

        native.setActivityIndicator( true )		-- show busy

        -- Request remote file and save data to local file
        local link = {
            "https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-ash3/1017071_10152000604808012_2051013729_n.jpg",
            "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-prn2/10154_10152000605128012_1226496876_n.jpg"
        }

        http.request{
            --        url = "http://developer.anscamobile.com/demo/hello.png",
            url = link[i],
            sink = ltn12.sink.file(myFile[i]),
        }
        _H = _H +300
        -- Call the showImage function after a short time dealy
        timer.performWithDelay( 400, showImage(i))

    end
end

--  tada1179.w@gmail.com ------------------------------

function scene:createScene( event )
    local screenGroup = self.view
    user_id = menu_barLight.user_id()
    image_sheet = {
        "img/sprite/BG_Forest/Autumn/ForestKingdom.jpg"
        ,"img/sprite/BG_Forest/Spring/ForestKingdom.jpg"
        ,"img/sprite/BG_Forest/Summer/ForestKingdom.jpg"
        ,"img/sprite/BG_Forest/War/ForestKingdom.jpg"
        ,"img/sprite/BG_Forest/Winter/ForestKingdom.jpg"

        ,"img/sprite/BG_Mountain/Autumn/MountainKingdom.jpg"
        ,"img/sprite/BG_Mountain/Spring/MountainKingdom.jpg"
        ,"img/sprite/BG_Mountain/Summer/MountainKingdom.jpg"
        ,"img/sprite/BG_Mountain/War/MountainKingdom.jpg"
        ,"img/sprite/BG_Mountain/Winter/MountainKingdom.jpg"

        ,"img/sprite/BG_Water/Autumn/WaterKingdom.jpg"
        ,"img/sprite/BG_Water/Spring/WaterKingdom.jpg"
        ,"img/sprite/BG_Water/Spring_blue/WaterKingdom.jpg"
        ,"img/sprite/BG_Water/Summer/WaterKingdom.jpg"
        ,"img/sprite/BG_Water/War/WaterKingdom.jpg"
        ,"img/sprite/BG_Water/Winter/WaterKingdom.jpg"
    }

    BGsprite = 13

    groupGameLayer = display.newGroup()
    groupEndGameLayer = display.newGroup()

    --score text
    local background = display.newImageRect( "img/background/bg_puzzle_test.tga" , display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

--    local lightWigth = display.newRoundedRect( 0,_W*.67, _W, _H, 4)
    --    lightWigth:setFillColor( 255, 255, 255 )
    --fncallSprite2()
    BGAnimation = display.newImageRect( image_sheet[BGsprite] , display.contentWidth, 425 )
    BGAnimation:setReferencePoint( display.CenterReferencePoint )
    BGAnimation.x, BGAnimation.y = _W*.5, _H*.2
    Gdisplay:insert(BGAnimation)

    groupGameLayer:insert ( background )
    groupGameLayer:insert ( Gdisplay )

    createBackButton(event)
    createCharacter(event)
    miniIconCharac_frame(event)

--    groupGameLayer:insert ( lightWigth )
    groupGameLayer:insert ( backButton )
    groupGameLayer:insert(bntItem)
    --    groupGameLayer:insert(characImage)


    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    local function clickSheet(event)
        --        require ("alertMassage").sprite_fight()
        local numcharacter = math.random(1,character_numAll)


        local pointX = characImage[numcharacter].x
        local pointY = characImage[numcharacter].y
        if image_char[numcharacter].charac_id == 6  then  --img/character/character_TU/kanu-v101.png
            pointX = characImage[numcharacter].x - (characImage[numcharacter].width/4)

        elseif image_char[numcharacter].charac_id == 5  then--img/character/character_TU/chohi-v101.png
            pointX = characImage[numcharacter].x - (characImage[numcharacter].width/7)

        elseif image_char[numcharacter].charac_id == 13  then--img/character/character_TU/chohi-v101.png
            pointX = characImage[numcharacter].x - (characImage[numcharacter].width/8)

        elseif image_char[numcharacter].charac_id == 20 or --img/character/character_Alina/SUN JIAN.png
                image_char[numcharacter].charac_id == 18 then--img/character/character_TU/kautu-v101.png

            pointX = characImage[numcharacter].x + (characImage[numcharacter].width/6)
        end

        require ("alertMassage").sprite_sheet(character_numAll,numcharacter,colercharacter,pointX,pointY)
        timer.performWithDelay( 150)
        if characImage[numcharacter].id == numcharacter then
            local function swapSheet()
                characImage[numcharacter].x = characImage[numcharacter].x + 5
            end
            local function swapSheet2()
                characImage[numcharacter].x = characImage[numcharacter].x - 10
            end
            timer.performWithDelay( 50, swapSheet )
            timer.performWithDelay( 100, swapSheet2 )
            timer.performWithDelay( 150, swapSheet )
        end

    end

    local function clickSheet_data(event)
        local lightWigth
        local function onTouchdiamondFail(self, event )

            if event.phase == "began" then

                return true
            end
        end
        local function removeEventListener(self, event )
            display.remove(Warning)
            Warning = nil

            display.remove(lightWigth)
            lightWigth = nil

            return true
        end
        if event.target.id == "Warning" then
            lightWigth = display.newRoundedRect( 0,0, _W, _H, 4)
            lightWigth:setFillColor( 0, 0, 0 )
            lightWigth.alpha = 0.5
            groupGameLayer:insert(lightWigth)
            lightWigth.touch = onTouchdiamondFail
            lightWigth:addEventListener( "touch", lightWigth )

            local myWarningAnimation = Warning_Animation()
            transition.to( myWarningAnimation, { time=5500 ,onComplete = removeEventListener} )
        elseif event.target.id == "Victory" then
            lightWigth = display.newRoundedRect( 0,0, _W, _H, 4)
            lightWigth:setFillColor( 0, 0, 0 )
            lightWigth.alpha = 0.5
            groupGameLayer:insert(lightWigth)
            lightWigth.touch = onTouchdiamondFail
            lightWigth:addEventListener( "touch", lightWigth )

            Victory_Animation_aura()
            Victory_Animation_font()
        elseif event.target.id == "spritebattle" then

            local numcharacter = math.random(1,character_numAll)
            local colercharacter = math.random(1,5)
            --battleIcon(event,numcharacter,colercharacter)

            local pointX = characImage[numcharacter].x + image_char[numcharacter].charac_spw
            local pointY = characImage[numcharacter].y
            battleIcon(event,numcharacter,colercharacter)
            timer.performWithDelay( 1500)
            require ("alertMassage").sprite_sheet(character_numAll,numcharacter,colercharacter,pointX,pointY)
            timer.performWithDelay( 1150)
            if characImage[numcharacter].id == numcharacter then
                local function swapSheet()
                    characImage[numcharacter].x = characImage[numcharacter].x + 5
                end
                local function swapSheet2()
                    characImage[numcharacter].x = characImage[numcharacter].x - 10
                end
                timer.performWithDelay( 50, swapSheet )
                timer.performWithDelay( 100, swapSheet2 )
                timer.performWithDelay( 150, swapSheet )
            end
        elseif event.target.id == "BG_sheet" then

            display.remove(backgroundTop)
            backgroundTop = nil
            timer.performWithDelay( 50, swapSheet )

            menu_barLight.checkMemory()
        end

    end
    local image_ok = "img/background/button/OK_button.png"
    local image_box = "img/background/button/BOX_EXTENSION.png"
    local image_BONUS = "img/background/button/BONUS.png"
    local image_ON = "img/background/button/ON.png"
    local btnClick = widget.newButton{
        default=image_ok,
        over=image_ok,
        width=_W*.2, height=_H*.05,
        onRelease = clickSheet_data	-- event listener function
    }
    btnClick.id="spritebattle"
    btnClick:setReferencePoint( display.CenterReferencePoint )
    btnClick.x =_W *.8
    btnClick.y = _H*.55
    groupGameLayer:insert(btnClick)

    local btnClick2 = widget.newButton{
        default=image_box,
        over=image_box,
        width=_W*.2, height=_H*.05,
        onRelease = clickSheet_data	-- event listener function
    }
    btnClick2.id="BG_sheet"
    btnClick2:setReferencePoint( display.CenterReferencePoint )
    btnClick2.x =_W *.8
    btnClick2.y = _H*.65
    groupGameLayer:insert(btnClick2)

    local btnClick3 = widget.newButton{
        default=image_BONUS,
        over=image_BONUS,
        width=_W*.2, height=_H*.05,
        onRelease = clickSheet_data	-- event listener function
    }
    btnClick3.id="Victory"
    btnClick3:setReferencePoint( display.CenterReferencePoint )
    btnClick3.x =_W *.8
    btnClick3.y = _H*.75
    groupGameLayer:insert(btnClick3)

    local btnClick4 = widget.newButton{
        default=image_ON,
        over=image_ON,
        width=_W*.2, height=_H*.05,
        onRelease = clickSheet_data	-- event listener function
    }
    btnClick4.id="Warning"
    btnClick4:setReferencePoint( display.CenterReferencePoint )
    btnClick4.x =_W *.8
    btnClick4.y = _H*.85
    groupGameLayer:insert(btnClick4)
    -------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------------------------------------------------------------
    -- insterting display groups to the screen group (storyboard group)
    screenGroup:insert ( groupGameLayer )
    screenGroup:insert ( groupEndGameLayer )

    ------------- other scene ---------------
    require ("menu_barLight").checkMemory()
    storyboard.purgeAll()
    storyboard.removeAll ()
    ------------------------------------


end

-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
    local screenGroup = self.view

    -----------------------------------------------------------------------------

    --      This event requires build 2012.782 or later.

    -----------------------------------------------------------------------------

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local screenGroup = self.view

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. start timers, load audio, start listeners, etc.)

    -----------------------------------------------------------------------------

    -- remove previous scene's view

    -- storyboard.purgeScene( "scene4" )

    -- reseting values
    score = 0


    --transition.to( gameTimerBar, { time = gameTimer * 1000, width=0 } )
    --timers.gameTimerUpdate = timer.performWithDelay(1000, gameTimerUpdate, 0)



end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local screenGroup = self.view

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

    -----------------------------------------------------------------------------

    --[[if timers.gameTimerUpdate then
        timer.cancel(timers.gameTimerUpdate)
        timers.gameTimerUpdate = nil
     end
     --]]

end

-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
    local screenGroup = self.view

    -----------------------------------------------------------------------------

    --      This event requires build 2012.782 or later.

    -----------------------------------------------------------------------------

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
    local screenGroup = self.view

    -----------------------------------------------------------------------------

    --      INSERT code here (e.g. remove listeners, widgets, save state, etc.)

    -----------------------------------------------------------------------------

end

-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
    local screenGroup = self.view
    local overlay_scene = event.sceneName  -- overlay scene name

    -----------------------------------------------------------------------------

    --      This event requires build 2012.797 or later.

    -----------------------------------------------------------------------------

end

-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
    local screenGroup = self.view
    local overlay_scene = event.sceneName  -- overlay scene name

    -----------------------------------------------------------------------------

    --      This event requires build 2012.797 or later.

    -----------------------------------------------------------------------------

end

---------------------------------------------------------------------------------

---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )

-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )

---------------------------------------------------------------------------------

return scene