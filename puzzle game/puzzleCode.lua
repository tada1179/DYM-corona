-----------------------------------------------------------------------------------------
--
-- test.lua
--
-- ##ref
--
-- test puzzle play
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mRandom = math.random

local gemsTable = {}
local picture = { "img/element/red.png",        --- 1
    "img/element/green.png",    ---2
    "img/element/blue.png",      ---3
    "img/element/purple.png",   ---4
    "img/element/pink.png",      ---5
    "img/element/yellow.png" }  ---6
local onGemTouch
local sizeGem = 96
local widthGem = 106
local gemX, gemY = 6, 5
local stTableX, enTableX = 3, 636

local limitCountGemSlide = 4    ---- chk amount gems
local limitCountGem = 3    ---- chk amount gems
local groupGem = { 0, 0, 0, 0, 0, 0 }
local groupGemChk = { 0, 0, 0, 0, 0, 0 }
local gemToBeDestroyed
local isGemTouchEnabled = true
local countSlide = 0

local channelX = {   54,   --1
    160,  --2
    266,  --3
    372,  --4
    478,  --5
    584   --6
}
local channelY ={   479,  --1
    585,  --2
    691,  --3
    797,  --4
    903,  --5
}

--local amountPlayer = 5 -- simple for test card input to mission
local state_main -- state
local teamPlayer = {}  --- pic, element, hp, protect, lv, power special, leader, power special
local playerDB  ={}  -- data for player
local teamComm={}
local commDB  ={}  -- data for computer
local posXch={10,115,220,325,430,535} ---- à¸£à¸°à¸¢à¸°à¸«à¹à¸²à¸

-------------------------- HP value -------------------------
local number ={}
local hpPlayer = 100
local hpFull = 100
local fullLineHP = 570
local lifeline_sh
--------------------------

timerStash = {}
transitionStash = {}


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
local datacharcter = {}
local rowCharac
local myAnimationSheet
local timerIMG

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

local function BossSprite()
    print("BOSS BOSS")
    local function flash()
        local sheetdata_light = {width = 640, height = 425,numFrames = 40, sheetContentWidth = 3200 ,sheetContentHeight = 3400 }
        local image_sheet = {
            "img/sprite/Boss_Effect/1flash.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2500, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = _W*.5
        CoinSheet.y = _H*.35

        local IMGtransition
        local function clearSheet()
            display.remove(CoinSheet)
            CoinSheet = nil
            IMGtransition = nil
        end
        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
            timerIMG = nil

        end
        timerIMG = timer.performWithDelay( 1000, swapSheet )
        IMGtransition = transition.to( CoinSheet, { time=3500,  alpha=1,onComplete = clearSheet} )

    end
    local function thunder()
        local sheetdata_light = {width = 640, height = 425,numFrames = 30, sheetContentWidth = 3200 ,sheetContentHeight = 2550 }
        local image_sheet = {
            "img/sprite/Boss_Effect/2thunder.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=sheetdata_light.numFrames, time=2000, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = _W*.5
        CoinSheet.y = _H*.35
        local IMGtransition
        local function clearSheet()
            display.remove(CoinSheet)
            CoinSheet = nil
            IMGtransition = nil
        end
        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
            timerIMG = nil

        end
        timerIMG = timer.performWithDelay( 1000, swapSheet )
        IMGtransition = transition.to( CoinSheet, { time=3000,  alpha=1,onComplete = clearSheet} )

    end
    local function groundcrack()
        local sheetdata_light = {width = 640, height = 425,numFrames = 40, sheetContentWidth = 3200 ,sheetContentHeight = 3400 }
        local image_sheet = {
            "img/sprite/Boss_Effect/3groundcrack.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2000, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = _W*.5
        CoinSheet.y = _H*.35
        local IMGtransition
        local function clearSheet()
            display.remove(CoinSheet)
            CoinSheet = nil

            IMGtransition = nil
        end
        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
            timerIMG = nil

        end
        timerIMG = timer.performWithDelay( 1000, swapSheet )
        IMGtransition = transition.to( CoinSheet, { time=3000,  alpha=1,onComplete = clearSheet} )

    end

    timer.performWithDelay( 0, flash )
    timer.performWithDelay( 500, thunder )
    timer.performWithDelay( 500, groundcrack )
    menu_barLight.checkMemory()
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
        timer.performWithDelay(6500,BossSprite )
    end
    groupGameLayer:insert(Warning)
    timer.performWithDelay(1000,FNWarning_Animation )


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

local function battle_Animation(all,battle)
    print("BB battle_Animation")
    local square =  display.newImage( "img/Battle_Animation/background.png")
    square:setReferencePoint( display.LeftReferencePoint )
    square.x, square.y = 0, _H*.2
    local w,h = _W, _H

    local picBattle = "img/Battle_Animation/"..all.."/"..battle..".png"
    local NumberBattle =  display.newImage( picBattle)
    NumberBattle:setReferencePoint( display.RightReferencePoint )
    NumberBattle.x, NumberBattle.y = _W, _H*.2
    local A,B  = 0, 0


    local listener1 = function( obj )
        print( "Transition 1 completed on object: " .. tostring( obj ) )
    end

    local listener2 = function( obj )
        print( "Transition 2 completed on object: " .. tostring( obj ) )
    end
    local listener3 = function( obj )
        display.remove(obj)
        obj = nil
    end

    -- (1) move square to bottom right corner; subtract half side-length
    --     b/c the local origin is at the square's center; fade out square
    transition.to( square, { time=500, delay=500 ,alpha=1, x=(w-300), onComplete=listener1 } )
    transition.to( NumberBattle, { time=500 , delay=500, alpha=1, x=(A+300), onComplete=listener1 } )

    -- (2) fade square back in after 2.5 seconds
    transition.to( square, { time=500, delay=2500, alpha=1.0, onComplete=listener2 } )
    transition.to( NumberBattle, { time=500, delay=2500, alpha=1.0, onComplete=listener2 } )

    transition.to( square, { time=500, delay=2500,alpha=0, onComplete=listener3 } )
    transition.to( NumberBattle, { time=500, delay=2500,alpha=0, onComplete=listener3 } )

end
local all = 3
local pagebattle = 13
local function createCharacter(event)
    battle_Animation(all,pagebattle)
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
        groupGameTop:insert(characImage[i])
        physics.addBody( characImage[i],"static", { density = 1.0, friction = 0, bounce = 0.2, radius = 20 } )

    end
end
local function miniIconCharac(event)
    local teamNumber = event.params.team
    local friend_id = event.params.friend_id

    local frm_frind = 1
    local img_frind = "img/characterIcon/img/TouTaku-i101.png"

    local FramElement = alertMSN.loadFramElement()
    local characIcon = {}
    local imgcharacIcon = {}
--    local datacharcter = {}
    --local rowCharac

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
        print("MMM rowCharac,frm_frind",m,rowCharac,frm_frind)
        if m > rowCharac then
            datacharcter[6] = {}
            local url = "http://localhost/DYM/holdcharacter.php?charac_id="
            local character =   url..friend_id
            local response = http.request(character)
            local Data_character = json.decode(response)
            if Data_character then
                datacharcter[6].holdcharac_id =  Data_character[1].holdcharac_id
                datacharcter[6].imagePicture =  Data_character[1].charac_img_mini
                datacharcter[6].element =  tonumber(Data_character[1].charac_element)
                datacharcter[6].teamno  = 6
            end
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
        datacharcter[i].poinCenter = imgcharacIcon[i].x + (_W*.08)
        groupGameTop:insert(imgcharacIcon[i])
        groupGameTop:insert(characIcon[i])
    end

    imgcharacIcon[rowCharac+1] = display.newImageRect( datacharcter[6].imagePicture , _W*.16, _H*.106 )
    imgcharacIcon[rowCharac+1]:setReferencePoint( display.TopLeftReferencePoint )
    imgcharacIcon[rowCharac+1].x,imgcharacIcon[rowCharac+1].y = (tonumber(_W*.166)*5)+_W*.005, _H*.31
    characIcon[rowCharac+1] = widget.newButton{
        default = FramElement[datacharcter[6].element] ,
        over =FramElement[datacharcter[6].element] ,
        width = sizeleaderW ,
        height= sizeleaderH,
        onRelease = optionIcon
    }
    characIcon[rowCharac+1].id= countChr
    characIcon[rowCharac+1]:setReferencePoint( display.TopLeftReferencePoint )
    characIcon[rowCharac+1].x, characIcon[rowCharac+1].y = pointIconx, _H*.31
    characIcon[rowCharac+1].x, characIcon[rowCharac+1].y = (tonumber(_W*.166)*5)+_W*.005, _H*.31
    datacharcter[rowCharac+1].poinCenter = imgcharacIcon[rowCharac+1].x + (_W*.08)
    groupGameTop:insert(imgcharacIcon[rowCharac+1])
    groupGameTop:insert(characIcon[rowCharac+1])

    textNumber()
end
local function miniIconCharac_frame(event)
    local teamNumber = 1

    local frm_frind = 1
    local img_frind = "img/characterIcon/img/TouTaku-i101.png"

    local FramElement = alertMSN.loadFramElement()
    local characIcon = {}
    local imgcharacIcon = {}
    --local datacharcter = {}
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
        groupGameTop:insert(characIcon[i])
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
    groupGameTop:insert(characIcon[rowCharac+1])

end

local function getCharacterCoin(num,pointX,pointY)
    local FlagPNG
    local function getCoin()
        local sheetdata_light = {width = 100, height = 100,numFrames = 40, sheetContentWidth = 500 ,sheetContentHeight = 800 }
        local image_sheet = {
            "img/sprite/Item_Effect/coin.png"
        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2000, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = pointX
        CoinSheet.y = _H*.27

        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
            timerIMG = nil

        end
        timerIMG = timer.performWithDelay( 1000, swapSheet )

    end
    local function getFlag()
        local sheetdata_light = {width = 100, height = 100,numFrames = 40, sheetContentWidth = 500 ,sheetContentHeight = 800 }
        local image_sheet = {
            "img/sprite/Item_Effect/flag.png"

        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2000, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = pointX
        CoinSheet.y = _H*.27
        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
        end

        timer.performWithDelay( 1000, swapSheet )


    end
    local function gettreasure()
        local sheetdata_light = {width = 100, height = 100,numFrames = 40, sheetContentWidth = 500 ,sheetContentHeight = 800 }
        local image_sheet = {
            "img/sprite/Item_Effect/treasure.png"

        }
        local sheet_light = graphics.newImageSheet( image_sheet[1], sheetdata_light )
        local sequenceData = {
            { name="sheet", sheet=sheet_light, start=1, count=40, time=2000, loopCount=1 }
        }
        local CoinSheet = display.newSprite( sheet_light, sequenceData )
        CoinSheet:setReferencePoint( display.BottomCenterReferencePoint)
        CoinSheet.x = pointX
        CoinSheet.y = _H*.27
        local function swapSheet()
            CoinSheet:setSequence( "sheet" )
            CoinSheet:play()
        end

        timer.performWithDelay( 1000, swapSheet )


    end
    local function clearCharacter()
        display.remove(characImage[num])
        characImage[num] = nil

        character_numAll = character_numAll - 1
        print("character_numAll",character_numAll)
    end
    local function clearFlagPNG()
        display.remove(FlagPNG)
        FlagPNG = nil
    end

    if character_numAll == 1 then
        FlagPNG = display.newImageRect( "img/sprite/Item_Effect/flagtest.png", _W*.15, _H*.1 )
        FlagPNG:setReferencePoint( display.BottomCenterReferencePoint )
        FlagPNG.x, FlagPNG.y = pointX, _H*.27
    end

    transitionStash.newTransition = transition.to(characImage[num], { time=1000, alpha=0.3,onComplete = clearCharacter} )
--    if character_numAll > 2 then
--        transitionStash.newTransition = transition.to(FlagPNG, { time=100, alpha=0,onComplete = clearFlagPNG} )
--        --getFlag()
--        gettreasure()
--    elseif character_numAll <= 1 then
--        Warning_Animation()
--    else
--
--        getCoin()
--    end
--    if character_numAll < 1 then
--        timer.performWithDelay( 0, Victory_Animation_aura )
--        timer.performWithDelay( 0, Victory_Animation_font )

--    end

--    Warning_Animation()
    --BossSprite()
--    transitionStash.newTransition = transition.to(background, { time=1000, alpha=0.3,onComplete = clearCharacter} )

--
end
local function sprite_sheet(characterAll,num,color,pointX,pointY)
    print("sprite_sheet")
    local characterAll = characterAll+1
    local sheetdata_light = {
        {width = 512/2, height = 535/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4280/2 }  ,
        {width = 512/1.6, height = 535/1.6,numFrames = 40, sheetContentWidth =2560/1.6 ,sheetContentHeight =4280/1.6 }  ,
        {width = 512/2, height = 578/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4624/2 }  ,
        {width = 512/2, height = 504/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4032/2 }  ,
        {width = 512/2, height = 520/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4160/2 }  ,

    }
    local image_sheet = {
        "img/sprite/element/Fire.png",
        "img/sprite/element/Earth.png",
        "img/sprite/element/Water.png",
        "img/sprite/element/Dark.png",
        "img/sprite/element/Light.png",
    }
    local sheet_light = graphics.newImageSheet( image_sheet[color], sheetdata_light[color] )
    local sequenceData = {
        { name="sheet", sheet=sheet_light, start=1, count=40, time=600, loopCount=1 }
    }
    local poiny = pointY

    display.remove(myAnimationSheet)
    myAnimationSheet = nil

    myAnimationSheet = display.newSprite( sheet_light, sequenceData )
    myAnimationSheet:setReferencePoint( display.BottomCenterReferencePoint)
    myAnimationSheet.x = pointX

    if color == 1 then
        myAnimationSheet.y = poiny + display.contentHeight*.05

    elseif color == 2 then
        myAnimationSheet.y = poiny + display.contentHeight*.065

    elseif color == 3 then
        myAnimationSheet.y = poiny + display.contentHeight*.03

    elseif color == 4 then
        myAnimationSheet.y = poiny

    elseif color == 5 then
        myAnimationSheet.y = poiny+ display.contentHeight*.03
    end

    local function swapSheet()
        myAnimationSheet:setSequence( "sheet" )
        myAnimationSheet:play()
        timerIMG = nil

    end
    timerIMG = timer.performWithDelay( 50, swapSheet )
    getCharacterCoin(num,pointX,pointY)
    menu_barLight.checkMemory()
    return true
end
local function battleIcon(randI,numcharacter,colercharacter)  --ตำแหน่งที่บอลออก.-ตำแหน่งที่บอลจะไปยิง.-สี
    print("** battleIcon")
    local IMGtransition
    local centerImg = (_W*.16)/2
    local img =  "img/element/object.png"
   -- local randI = math.random(1,6)
    --    local randI = 6
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
    groupGameTop:insert(battleIconcolor)

    local function listener()
        display.remove(battleIconcolor)
        battleIconcolor = nil
        IMGtransition = nil

        local pointX = characImage[numcharacter].x + image_char[numcharacter].charac_spw
        local pointY = characImage[numcharacter].y
--        require ("alertMassage").sprite_sheet(character_numAll,numcharacter,colercharacter,pointX,pointY)
        sprite_sheet(character_numAll,numcharacter,colercharacter,pointX,pointY)
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

    end
    if battleIconcolor.isSleepingAllowed == true then
        IMGtransition = transition.to( battleIconcolor, { time=200, xScale=2, yScale=2, alpha=0.1,onComplete = listener} )
    end
    --menu_barLight.checkMemory()
end


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

-------------------------------------------------------------
function cancelAllTimers()
    local k, v

    for k,v in pairs(timerStash) do
        timer.cancel( v )
        v = nil; k = nil
    end

    timerStash = nil
    timerStash = {}
end

function cancelAllTransitions()
    local k, v

    for k,v in pairs(transitionStash) do
        transition.cancel( v )
        v = nil; k = nil
    end

    transitionStash = nil
    transitionStash = {}
end

local function handleLowMemory( event )
    print( "memory warning received!" )
end
Runtime:addEventListener( "??MemoryWarning", handleLowMemory )

local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
--checkMemory()

local function newGem (i,j)
    local R = mRandom(1,6)
    local newGem

    newGem = display.newImageRect(picture[R],sizeGem,sizeGem)

    newGem.x = i * widthGem - 52
    newGem.y = j * widthGem + 373

    newGem.i = i
    newGem.j = j

    newGem.ismarkRoworcolum = false
    newGem.isMarkedToDestroy = false

    newGem.destination_y = j * widthGem + 373 --newGem.y


    newGem.color = R
    if 	(R == 1 ) then
        newGem.gemType = "RED"
    elseif (R == 2 ) then
        newGem.gemType = "GREEN"
    elseif (R == 3 ) then
        newGem.gemType = "BLUE"
    elseif (R == 4 ) then
        newGem.gemType = "PURPLE"
    elseif (R == 5 ) then
        newGem.gemType = "PINK"
    elseif (R == 6 ) then
        newGem.gemType = "YELLOW"
    end

    --new gem falling animation
    transitionStash.newTransition = transition.to( newGem, { time=100, y= newGem.destination_y} )
    groupGameLayer:insert( newGem )


    newGem.touch = onGemTouch
    newGem:addEventListener( "touch", newGem )

    return newGem
end

function copyGem(self,event)
    --    print("copyGem(self,event)  ")
    --    print("pointXY :"..gemsTable[self.i][self.j].i,gemsTable[self.i][self.j].j)
    copyGemXR, copyGemXL, copyGemYU, copyGemYD = {}, {}, {}, {}
    intervalGem = sizeGem + 8
    ------ ---  -- - chk event  -Right  -Left  -Up  -Down----
    rotateR = gemX + 1
    for R = 1, gemX, 1 do
        --        copyGemX[R] = gemsTable[R][self.j].colorR
        --        print("color :"..gemsTable[R][self.j].gemType, copyGemX[R])
        copyGemXR[R] = display.newImageRect(picture[gemsTable[R][self.j].colorR],sizeGem,sizeGem)
        copyGemXR[R].x, copyGemXR[R].y  = enTableX + (intervalGem * R), gemsTable[gemX][self.j].markY

        copyGemXL[R] = display.newImageRect(picture[gemsTable[rotateR - R][self.j].colorR],sizeGem,sizeGem)
        copyGemXL[R].x, copyGemXL[R].y  = stTableX - (intervalGem * R), gemsTable[gemX][self.j].markY
        groupGameLayer:insert( copyGemXR[R] )
        groupGameLayer:insert( copyGemXL[R] )
    end

    stTableY, enTableY = 400, 903
    rotateC = gemY + 1
    for C = 1, gemY, 1 do
        copyGemYU[C] = display.newImageRect(picture[gemsTable[self.i][C].colorR],sizeGem,sizeGem)
        copyGemYU[C].x, copyGemYU[C].y  = gemsTable[self.i][gemY].markX, enTableY + (intervalGem * C)

        copyGemYD[C] = display.newImageRect(picture[gemsTable[self.i][rotateC - C].colorR],sizeGem,sizeGem)
        copyGemYD[C].x, copyGemYD[C].y  = gemsTable[self.i][gemY].markX, stTableY - (intervalGem * C)
        groupGameLayer:insert( copyGemYD[C] )
        groupGameLayer:insert( copyGemYU[C] )
    end
    groupGameLayer:insert(groupGameTop )
end

function pasteGem(self, event)
    if(self.chkFtPosit == "x") then

        positSt = gemsTable[self.i][self.j].i
        positEn = gemsTable[self.i][self.j].x
        slideEvent = (event.x - event.xStart)

        colorTmp ={}
        markY = gemsTable[self.i][self.j].markY
        markJ = gemsTable[self.i][self.j].j
        slideL, slideR = 0, 0

        if ( slideEvent > 60 or slideEvent < -60) then
            countSlide = countSlide +1
        end

        for posX = gemX, 1, -1 do
            colorTmp[posX] = gemsTable[posX][self.j].colorR
            gemsTable[posX][self.j]:removeSelf()
        end

        if(positEn > 533 ) then
            slideL = 0
            slideR = 1
        elseif (positEn > 427 and positEn < 533) then
            slideL = 5
            slideR = 1
        elseif (positEn > 319 and positEn < 427) then
            slideL = 4
            slideR = 2
        elseif (positEn > 216 and positEn < 319) then
            slideL = 3
            slideR = 3
        elseif (positEn > 111 and positEn < 216) then
            slideL = 2
            slideR = 4
        else-- R to L only
            slideL = 1
            slideR = 5
        end
        -- for chk and loop
        --print("slideEvent "..slideEvent," last position "..positEn)
        for posX = gemX, 1, -1 do
            if( posX == gemX) then
                if(positSt > slideL)  then   --- L
                    color = colorTmp[positSt - slideL]
                    maxXTmp = positSt - slideL
                else                        --- R
                    color = colorTmp[positSt + slideR]
                    maxXTmp = positSt + slideR
                end
            else
                if(maxXTmp == 1 ) then
                    maxXTmp = gemX
                    color = colorTmp[maxXTmp]
                else
                    maxXTmp = maxXTmp - 1
                    color = colorTmp[maxXTmp]
                end
            end

            gemsTable[posX][self.j] = display.newImageRect(picture[color],sizeGem,sizeGem)
            groupGameLayer:insert(gemsTable[posX][self.j])
            if 	(color == 1 ) then
                gemsTable[posX][self.j].gemType = "RED"
            elseif (color == 2 ) then
                gemsTable[posX][self.j].gemType = "GREEN"
            elseif (color == 3 ) then
                gemsTable[posX][self.j].gemType = "BLUE"
            elseif (color == 4 ) then
                gemsTable[posX][self.j].gemType = "PURPLE"
            elseif (color == 5 ) then
                gemsTable[posX][self.j].gemType = "PINK"
            elseif (color == 6 ) then
                gemsTable[posX][self.j].gemType = "YELLOW"
            end

            gemsTable[posX][self.j].color = color
            gemsTable[posX][self.j].x = channelX[posX]
            gemsTable[posX][self.j].y = markY
            gemsTable[posX][self.j].i = posX
            gemsTable[posX][self.j].j = markJ

            gemsTable[posX][self.j].destination_y = markY
            gemsTable[posX][self.j].isMarkedToDestroy = false
            gemsTable[posX][self.j].touch = onGemTouch
            gemsTable[posX][self.j]:addEventListener( "touch", gemsTable[posX][self.j] )
        end

    elseif (self.chkFtPosit == "y") then
        positSt = gemsTable[self.i][self.j].j
        positEn = gemsTable[self.i][self.j].y
        slideEvent = (event.y - event.yStart)

        colorTmp = {}
        markX = gemsTable[self.i][self.j].markX
        markI = gemsTable[self.i][self.j].i
        slideU, slideD = 0, 0

        if ( slideEvent > 60 or slideEvent < -60) then
            countSlide = countSlide +1
        end

        for posY = gemY, 1, -1 do
            colorTmp[posY] = gemsTable[self.i][posY].colorR
            gemsTable[self.i][posY]:removeSelf()
        end

        if(positEn > 852 ) then
            slideU = 0
            slideD = 1
        elseif (positEn > 746 and positEn < 852) then
            slideU = 4
            slideD = 1
        elseif (positEn > 640 and positEn < 746) then
            slideU = 3
            slideD = 2
        elseif (positEn > 534 and positEn < 640) then
            slideU = 2
            slideD = 3
        else-- U to D only
            slideU = 1
            slideD = 4
        end

        for posY = gemY, 1, -1 do
            if( posY == gemY) then
                if(positSt > slideU)  then   --- U 
                    color = colorTmp[positSt - slideU]
                    maxYTmp = positSt - slideU
                else                        --- D
                    color = colorTmp[positSt + slideD]
                    maxYTmp = positSt + slideD
                end
            else
                if(maxYTmp == 1 ) then
                    maxYTmp = gemY
                    color = colorTmp[maxYTmp]
                else
                    maxYTmp = maxYTmp - 1
                    color = colorTmp[maxYTmp]
                end
            end

            gemsTable[self.i][posY] = display.newImageRect(picture[color],sizeGem,sizeGem)
            groupGameLayer:insert(gemsTable[self.i][posY])
            if 	(color == 1 ) then
                gemsTable[self.i][posY].gemType = "RED"
            elseif (color == 2 ) then
                gemsTable[self.i][posY].gemType = "GREEN"
            elseif (color == 3 ) then
                gemsTable[self.i][posY].gemType = "BLUE"
            elseif (color == 4 ) then
                gemsTable[self.i][posY].gemType = "PURPLE"
            elseif (color == 5 ) then
                gemsTable[self.i][posY].gemType = "PINK"
            elseif (color == 6 ) then
                gemsTable[self.i][posY].gemType = "YELLOW"
            end

            gemsTable[self.i][posY].color = color
            gemsTable[self.i][posY].x = markX
            gemsTable[self.i][posY].y = channelY[posY]
            gemsTable[self.i][posY].i = markI
            gemsTable[self.i][posY].j = posY

            gemsTable[self.i][posY].destination_y = channelY[posY]
            gemsTable[self.i][posY].isMarkedToDestroy = false
            gemsTable[self.i][posY].touch = onGemTouch
            gemsTable[self.i][posY]:addEventListener( "touch", gemsTable[self.i][posY] )
        end
    else
        --print("just click dont move")
    end

    for R = 1, gemX, 1 do
        copyGemXR[R]:removeSelf()
        copyGemXL[R]:removeSelf()
    end
    for C = 1, gemY, 1 do
        copyGemYU[C]:removeSelf()
        copyGemYD[C]:removeSelf()
    end


    if ( lineY ~=nil) then
        lineY:removeSelf()
        lineY= nil
    end
    if ( lineX ~=nil) then
        lineX:removeSelf()
        lineX= nil
    end

    --      for i = 1, gemX, 1 do --- x
    --        for j = 1, gemY, 1 do --- y
    --            print("à¸¢à¸¢à¸¢à¸¢i"..i.." j"..j.."    dest"..gemsTable[i][j].destination_y )
    --        end
    --    end

end

function slideGem(self,event)
    -- print(self.chkFtPosit)
    if(self.chkFtPosit == "x") then -- -- -- -- -- slide X           
        if ( lineY ~=nil) then
            lineY:removeSelf()
            lineY= nil
        end

        self.slideEvent = (event.x - event.xStart)

        -- gemsTable[][].j :: gemsTable[][].i == point self // gemsTable[self.i][self.j] == data self VIP
        if(gemsTable[self.i][self.j].x <= 20 or gemsTable[self.i][self.j].x >= 620) then     --  jump end dont move                  
            pasteGem(self,event)
        else
            intervalGem = sizeGem + 8
            for posX = 1, gemX, 1 do
                if gemsTable[posX][self.j].i == self.i then     -- self gem pos               
                    gemsTable[posX][self.j].x = self.markX + self.slideEvent
                else
                    gemsTable[posX][self.j].x = gemsTable[posX][self.j].markX + self.slideEvent
                end

                copyGemXR[posX].x = enTableX + gemsTable[posX][self.j].markX + self.slideEvent
                copyGemXL[posX].x = stTableX - gemsTable[posX][self.j].markX + self.slideEvent
            end
        end
    elseif (self.chkFtPosit == "y") then -- ---- -- slide Y      
        if ( lineX ~=nil) then
            lineX:removeSelf()
            lineX= nil
        end

        self.slideEvent = (event.y - event.yStart)

        -- print("JUMP ".. gemsTable[self.i][self.j].y)--
        if(gemsTable[self.i][self.j].y <= 455 or gemsTable[self.i][self.j].y >= 940) then        --  jump end dont move
            pasteGem(self,event)
        else
            intervalGem = sizeGem + 8
            for posY = 1, gemY, 1 do
                if gemsTable[self.i][posY].i == self.y then     -- self gem pos               
                    gemsTable[self.i][posY].y = self.markY + self.slideEvent
                else
                    gemsTable[self.i][posY].y = gemsTable[self.i][posY].markY + self.slideEvent
                end

                stTableY, enTableY = 853, 530
                copyGemYU[posY].x = gemsTable[self.i][posY].markX--
                copyGemYU[posY].y = enTableY + gemsTable[self.i][posY].markY + self.slideEvent

                copyGemYD[posY].x = gemsTable[self.i][posY].markX
                copyGemYD[posY].y = stTableY - gemsTable[self.i][posY].markY + self.slideEvent
            end
        end
    else
        print ("Error SlideGem Func X Y")
    end

end
local function enableGemTouch()
    isGemTouchEnabled = true
    print("isGemTouchEnabled:",isGemTouchEnabled)
end
local myNumber = {}
local myPink
function textNumber()
    local num = 0
    for k = 1 ,rowCharac+1,1 do
        myNumber[k] = display.newText(num,0 , _H*.35,native.systemFontBold, 25)
        myNumber[k].x= datacharcter[k].poinCenter
        myNumber[k]:setTextColor(255, 255, 255)
        myNumber[k].alpha = 0
    end

    myPink = display.newText(num,0 , _H*.415,native.systemFontBold, 25)
    myPink.x= _W*.45
    myPink.alpha = 0

end
local function ClearNumber()
    for k = 1 ,rowCharac+1,1 do
        display.remove(myNumber[k])
        myNumber[k] = nil
    end
    display.remove(myPink)
    myPink = nil

    textNumber()

end
local function clearmyAnimationSheet()
    display.remove(myAnimationSheet)
    myAnimationSheet = nil
end
local pointStart
local function PopNumIconCharacter(color,countColor)
    if rowCharac then
        local pointIcon = {
            _W*.075 ,
            _W*.24 ,
            _W*.405 ,
            _W*.57 ,
            _W*.735 ,
            _W*.90 ,
        }
        print("PopNumIconCharacter ",color)
        if color == "PINK" and lifeline_sh.width < fullLineHP then
            myPink.alpha = 1
            myPink.text = string.format("+"..countColor * 50 )
            myPink:setTextColor(255 ,20, 147)
            transitionStash.newTransition = transition.to(myPink, { time=700, alpha=1, xScale=2, yScale = 2,onComplete = ClearNumber} )
            hpPlayer =  hpPlayer + (countColor*5*rowCharac)
            lifeline_sh.width =  hpPlayer
            lifeline_sh:setReferencePoint( display.TopLeftReferencePoint )
            lifeline_sh.x = pointStart
        else

        for i = 1 ,rowCharac,1 do
            print("MY countColor,element,color",countColor,datacharcter[i].element,color )
            if datacharcter[i].element == 1 and color == "RED" then --RED
--                print("RED")
                myNumber[i].alpha = 1
                myNumber[i].text = string.format(""..countColor * 50 )
                myNumber[i]:setTextColor(255, 0 ,0)
                transitionStash.newTransition = transition.to( myNumber[i], { time=700, alpha=1, xScale=2, yScale = 2,onComplete = ClearNumber} )
                battleIcon(datacharcter[i].team_no,i,datacharcter[i].element)
                clearmyAnimationSheet()

            elseif datacharcter[i].element == 2 and color == "GREEN" then --GREEN
--                print("GREEN")
                myNumber[i].alpha = 1
                myNumber[i].text = string.format(""..countColor * 5 )
                myNumber[i]:setTextColor( 0 ,139, 0)
                transitionStash.newTransition = transition.to( myNumber[i], { time=700, alpha=1, xScale=2, yScale = 2,onComplete = ClearNumber})
                battleIcon(datacharcter[i].team_no,i,datacharcter[i].element)
                clearmyAnimationSheet()

            elseif datacharcter[i].element == 3 and color == "BLUE" then --BLUE
--                print("BLUE")
                myNumber[i].alpha = 1
                myNumber[i].text = string.format(""..countColor * 5 )
                myNumber[i]:setTextColor(0 ,191, 255)
                transitionStash.newTransition = transition.to( myNumber[i], { time=700, alpha=1, xScale=2, yScale = 2,onComplete = ClearNumber})
                battleIcon(datacharcter[i].team_no,i,datacharcter[i].element)
                clearmyAnimationSheet()

            elseif datacharcter[i].element == 4 and color == "PURPLE" then --PURPLE
--                print("PURPLE")
                myNumber[i].alpha = 1
                myNumber[i].text = string.format(""..countColor * 5 )
                myNumber[i]:setTextColor(106, 90, 205)
                transitionStash.newTransition = transition.to( myNumber[i], { time=700, alpha=1, xScale=2, yScale = 2,onComplete = ClearNumber})
                battleIcon(datacharcter[i].team_no,i,datacharcter[i].element)
                clearmyAnimationSheet()

            elseif datacharcter[i].element == 5 and color == "YELLOW" then --YELLOW
--                print("YELLOW")
                myNumber[i].alpha = 1
                myNumber[i].text = string.format(""..countColor * 5 )
                myNumber[i]:setTextColor(255, 255, 0)
                transitionStash.newTransition = transition.to( myNumber[i], { time=700, alpha=1, xScale=2, yScale = 2,onComplete = ClearNumber})
                battleIcon(datacharcter[i].team_no,i,datacharcter[i].element)
                clearmyAnimationSheet()
            end

        end
      end

    end
    checkMemory()


end
local function shiftGems ()
    print ("Shifting Gems")

    for i = 1, gemX, 1 do
        if gemsTable[i][1].isMarkedToDestroy then
            gemToBeDestroyed = gemsTable[i][1]

            gemsTable[i][1] = newGem(i,1)

            gemToBeDestroyed:removeSelf()
            gemToBeDestroyed = nil
        end
    end
    -- rest of the rows
    for j = 2, gemY, 1 do  -- j = row number - need to do like this it needs to be checked row by row
        for i = 1, gemX, 1 do
            if gemsTable[i][j].isMarkedToDestroy then --if you find and empty hole then shift down all gems in column
                gemToBeDestroyed = gemsTable[i][j]
                for k = j, 2, -1 do -- starting from bottom - finishing at the second row
                    gemsTable[i][k] = gemsTable[i][k-1]
                    gemsTable[i][k].destination_y = gemsTable[i][k].destination_y + 106
                    transitionStash.newTransition = transition.to( gemsTable[i][k], { time=100, y= gemsTable[i][k].destination_y} )

                    gemsTable[i][k].j = gemsTable[i][k].j + 1
                end

                gemsTable[i][1] = newGem(i,1)

                gemToBeDestroyed:removeSelf()
                gemToBeDestroyed = nil
            end
        end
    end
    timer.performWithDelay( 50, checkdoubleAll )
--    timer.performWithDelay( 1000, enableGemTouch )
end --shiftGems()
local function destroyGems()
    print("destroyGems")
    lockGemMutiChk = true
    local color
    local countColor = 0
    for i = 1, gemX, 1 do
        for j = 1, gemY, 1 do

            if gemsTable[i][j].isMarkedToDestroy  then
               print("+++ +++ DestroyGems gemsTable[i][j].gemType",i,j,gemsTable[i][j].gemType)
                color = gemsTable[i][j].gemType
                countColor = countColor + 1
                --  print("nameType"..nameType)
                gemsTable[i][j]:setStrokeColor(140, 140, 140)
                gemsTable[i][j].strokeWidth = 7
                gemsTable[i][j]:setFillColor(150)

                isGemTouchEnabled = false
                -- transitionStash.newTransition = transition.to( gemsTable[i][j], { time=300, alpha=0.1, xScale=2, yScale = 2} )
            end
        end
    end
    PopNumIconCharacter(color,countColor)
    timer.performWithDelay( 1000, shiftGems ) -- 3 sce

    for  pt = 1 , 6 , 1 do
        groupGem[pt] =0
    end

    lockGemMuti = 0
    --checkMemory()
end

local numcolor = {0,0,0,0,0,0 }
local function checkPointball(i,j)

end

local function cleanUpGems()
    print("Cleaning Up Gems")

    for i = 1, gemX, 1 do
        for j = 1, gemY, 1 do
            -- show that there is not enough
            if gemsTable[i][j].isMarkedToDestroy then
                transitionStash.newTransition = transition.to( gemsTable[i][j], { time=100, xScale=1.2, yScale = 1.2 } )
                transitionStash.newTransition = transition.to( gemsTable[i][j], { time=100, delay=100, xScale=1.0, yScale = 1.0} )
            end

            gemsTable[i][j].isMarkedToDestroy = false
        end
    end

    for  pt = 1, table.getn(picture), 1 do
        groupGem[pt] =0
    end
end
local function markPreDestory (i,j,chkMuti)
    --print("=== > MarkPreDestory :color [i][j]",gemsTable[i][j].gemType,i,j)
    if (gemsTable[i][j].gemType == "RED") then
        if (chkMuti == 0) then
            groupGemChk[1] = groupGemChk[1] + 1
        else
            groupGemChk[1] = 0
        end
        --print("RED groupGemChk[1] = ",groupGemChk[1])
    elseif (gemsTable[i][j].gemType == "GREEN") then
        if (chkMuti == 0) then
            groupGemChk[2] = groupGemChk[2] + 1
        else
            groupGemChk[2] = 0
        end
        --print("GREEN groupGemChk[2] = ",groupGemChk[2])
    elseif (gemsTable[i][j].gemType == "BLUE") then
        if (chkMuti == 0) then
            groupGemChk[3] = groupGemChk[3] + 1
        else
            groupGemChk[3] = 0
        end
        --print("BLUE groupGemChk[3] = ",groupGemChk[3])
    elseif (gemsTable[i][j].gemType == "PURPLE") then
        if (chkMuti == 0) then
            groupGemChk[4] = groupGemChk[4] + 1
        else
            groupGemChk[4] = 0
        end
        --print("PURPLE groupGemChk[4] = ",groupGemChk[4])
    elseif (gemsTable[i][j].gemType == "PINK") then
        if (chkMuti == 0) then
            groupGemChk[5] = groupGemChk[5] + 1
        else
            groupGemChk[5] = 0
        end
        --print("PINK groupGemChk[5] = ",groupGemChk[5])
    elseif (gemsTable[i][j].gemType == "YELLOW") then
        if (chkMuti == 0) then
            groupGemChk[6] = groupGemChk[6] + 1
        else
            groupGemChk[6] =0
        end
        --print("YELLOW groupGemChk[6] = ",groupGemChk[6])
    end

    gemsTable[i][j].isMarkedToDestroy = true
end

local function markToDestroy(self, chkMuti)
    self.isMarkedToDestroy = true
   -- print("----** MarkToDestroy color[i][j]",self.gemType,self.i,self.j)

    if self.i>1 then -- LEFT
       -- print("LEFt .isMarkedToDestroy = ",gemsTable[self.i-1][self.j].isMarkedToDestroy )
        if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == false then
            if (gemsTable[self.i-1][self.j]).gemType == self.gemType then
                markPreDestory (self.i-1,self.j,chkMuti)
                markToDestroy( gemsTable[self.i-1][self.j],chkMuti)
            end
        end
    end

    if self.i<gemX then -- RIGHT
       -- print("RIGHT .isMarkedToDestroy = ",gemsTable[self.i+1][self.j].isMarkedToDestroy )
        if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == false  then
            if (gemsTable[self.i+1][self.j]).gemType == self.gemType then
                markPreDestory (self.i+1,self.j,chkMuti)
                markToDestroy( gemsTable[self.i+1][self.j],chkMuti )
            end
        end
    end

    if self.j>1 then -- UP
       -- print("UP .isMarkedToDestroy = ",gemsTable[self.i][self.j-1].isMarkedToDestroy )
        if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == false  then
            if (gemsTable[self.i][self.j-1]).gemType == self.gemType then
                markPreDestory (self.i,self.j-1,chkMuti)
                markToDestroy( gemsTable[self.i][self.j-1] ,chkMuti)
            end
        end
    end

    if self.j<gemY then -- DOWN
       -- print("DOWN .isMarkedToDestroy = ",gemsTable[self.i][self.j+1].isMarkedToDestroy )
        if (gemsTable[self.i][self.j+1]).isMarkedToDestroy== false then
            if (gemsTable[self.i][self.j+1]).gemType == self.gemType then
                markPreDestory (self.i,self.j+1,chkMuti)
                markToDestroy( gemsTable[self.i][self.j+1] ,chkMuti)
            end
        end
    end



end
local function doubleToDestroy( chkMuti)
    --self.isMarkedToDestroy = true
    --print("self.gemType",self.gemType)
for i = 1, gemX, 1 do --6
    for j = 1, gemY, 1 do  --5
    --print("i:j",i,j)
    if i>1 then
        if (gemsTable[i-1][j]).isMarkedToDestroy == false then
            if (gemsTable[i-1][j]).gemType == (gemsTable[i][j]).gemType then
                markPreDestory (i-1,j,chkMuti)
                --print("i:j",i,j,"i-1:j",i-1,j)
            end
        end
    end

    if i<gemX then
        if (gemsTable[i+1][j]).isMarkedToDestroy == false  then
            if (gemsTable[i+1][j]).gemType == (gemsTable[i][j]).gemType then
                markPreDestory (i+1,j,chkMuti)
                --print("i:j",i,j,"i+1:j",i+1,j)
            end
        end
    end

    if j>1 then
        if (gemsTable[i][j-1]).isMarkedToDestroy == false  then
            if (gemsTable[i][j-1]).gemType == (gemsTable[i][j]).gemType then
                markPreDestory (i,j-1,chkMuti)
                --print("i:j",i,j,"i:j-1",i,j-1)
            end
        end
    end

    if j<gemY then
        if (gemsTable[i][j+1]).isMarkedToDestroy== false then
            if (gemsTable[i][j+1]).gemType == (gemsTable[i][j]).gemType then
                markPreDestory (i,j+1,chkMuti)
                --print("i:j",i,j,"i:j+1",i,j+1)
            end
        end
    end

    end
end

end

function chkGruopDel (self,chkMuti)
    self.isMarkedToDestroy = false
    --print("DELETE ==== >i,j",self.i,self.j)
    if self.i>1 then
        if (gemsTable[self.i-1][self.j]).isMarkedToDestroy == true and  gemsTable[self.i-1][self.j].gemType == self.gemType then
            markPreDestory (self.i-1,self.j,chkMuti)
            chkGruopDel( gemsTable[self.i-1][self.j] ,chkMuti)
        end
    end

    if self.i<gemX then
        if (gemsTable[self.i+1][self.j]).isMarkedToDestroy == true  and gemsTable[self.i+1][self.j].gemType == self.gemType then
            markPreDestory (self.i+1,self.j,chkMuti)
            chkGruopDel( gemsTable[self.i+1][self.j],chkMuti )
        end
    end

    if self.j>1 then
        if (gemsTable[self.i][self.j-1]).isMarkedToDestroy == true and gemsTable[self.i][self.j-1].gemType == self.gemType then
            markPreDestory (self.i,self.j-1,chkMuti)
            chkGruopDel( gemsTable[self.i][self.j-1] ,chkMuti)
        end
    end

    if self.j<gemY then
        if (gemsTable[self.i][self.j+1]).isMarkedToDestroy== true and gemsTable[self.i][self.j+1].gemType == self.gemType then
            markPreDestory (self.i,self.j+1,chkMuti)
            chkGruopDel( gemsTable[self.i][self.j+1] ,chkMuti)
        end
    end
end

function chkGruopGem(self,kk)
    --print("CHKGROUP GEM :[kk][color]",kk,self.gemType)

    if (self.gemType == "RED") then
           --print("RED =[groupGemChk][groupGem][kk]",groupGemChk[1],groupGem[1],kk)
        if groupGemChk[1]  >= limitCountGemSlide then
            if (kk ~= "RED") then
                groupGem[1]= groupGem[1]+groupGemChk[1]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[1] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[1] = 0
    elseif (self.gemType == "GREEN") then
           --print("GREEN = [groupGemChk][groupGem][kk]",groupGemChk[2],groupGem[2],kk)
        if groupGemChk[2]  >= limitCountGemSlide then
            if (kk ~= "GREEN") then
                groupGem[2]= groupGem[2]+groupGemChk[2]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[2] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[2] = 0
    elseif (self.gemType == "BLUE") then
           --print("BLUE = [groupGemChk][groupGem][kk]",groupGemChk[3],groupGem[3],kk)
        if groupGemChk[3]  >= limitCountGemSlide then
            if ( kk ~= "BLUE") then
                groupGem[3]= groupGem[3]+groupGemChk[3]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[3] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[3] = 0
    elseif (self.gemType == "PURPLE") then
            -- print("PURPLE =[groupGemChk][groupGem][kk]",groupGemChk[4],groupGem[4],kk)
        if groupGemChk[4]  >= limitCountGemSlide then
            if (kk ~= "PURPLE") then
                groupGem[4]= groupGem[4]+groupGemChk[4]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[4] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[4] = 0
    elseif (self.gemType == "PINK") then
         -- print("PINK =[groupGemChk][groupGem][kk]",groupGemChk[5],groupGem[5],kk)
        if groupGemChk[5]  >= limitCountGemSlide then
            if ( kk ~= "PINK") then
                groupGem[5]= groupGem[5]+groupGemChk[5]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[5] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[5] = 0
    elseif (self.gemType == "YELLOW") then
            --   print("YELLOW =[groupGemChk][groupGem][kk]",groupGemChk[6],groupGem[6],kk)
        if groupGemChk[6]  >= limitCountGemSlide then
            if kk ~= "YELLOW" then
                groupGem[6]= groupGem[6]+groupGemChk[6]
            end
        --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[6] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[6] = 0
    end
end
function chkGruopGem2(self)
    --print("chkGruopGem2 color",self.gemType)
    if (self.gemType == "RED") then
        if groupGemChk[1]  >= limitCountGem then
            groupGem[1]= groupGem[1]+groupGemChk[1]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[1] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[1] = 0
    elseif (self.gemType == "GREEN") then
        if groupGemChk[2]  >= limitCountGem then
            groupGem[2]= groupGem[2]+groupGemChk[2]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[2] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[2] = 0
    elseif (self.gemType == "BLUE") then
        if groupGemChk[3]  >= limitCountGem then
           groupGem[3]= groupGem[3]+groupGemChk[3]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[3] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[3] = 0
    elseif (self.gemType == "PURPLE") then
        if groupGemChk[4]  >= limitCountGem then
           groupGem[4]= groupGem[4]+groupGemChk[4]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[4] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[4] = 0
    elseif (self.gemType == "PINK") then
        if groupGemChk[5]  >= limitCountGem then
           groupGem[5]= groupGem[5]+groupGemChk[5]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[5] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[5] = 0
    elseif (self.gemType == "YELLOW") then
        if groupGemChk[6]  >= limitCountGem then
           groupGem[6]= groupGem[6]+groupGemChk[6]
            --elseif gemsTable[self.i][self.j].isMarkedToDestroy == true and groupGemChk[6] == 0 then
        else
            chkGruopDel (self,1)
        end
        groupGemChk[6] = 0
    end
end
function lockGem(self, event)
    -- print("LockGem"..self.i,self.j)
    if( self.chkFtPosit ~= "" ) then
        if( self.chkFtPosit == "x" ) then
            slideEvent = (event.x - event.xStart)
        else
            slideEvent = (event.y - event.yStart)
        end

        if ( slideEvent > 60 or slideEvent < -60) then
            if( self.chkFtPosit == "x" ) then
                positEn = slideEvent + gemsTable[self.i][self.j].x

                if(positEn > 533 ) then
                    self.i =  6
                elseif (positEn > 427 and positEn < 533) then
                    self.i =  5
                elseif (positEn > 319 and positEn < 427) then
                    self.i =  4
                elseif (positEn > 216 and positEn < 319) then
                    self.i =  3
                elseif (positEn > 111 and positEn < 216) then
                    self.i =  2
                else
                    self.i =  1
                end
            elseif ( self.chkFtPosit == "y" ) then
                positEn = slideEvent + gemsTable[self.i][self.j].y

                if(positEn > 852 ) then
                    self.j = 5
                elseif (positEn > 746 and positEn < 852) then
                    self.j = 4
                elseif (positEn > 640 and positEn < 746) then
                    self.j = 3
                elseif (positEn > 534 and positEn < 640) then
                    self.j = 2
                else
                    self.j = 1
                end
            else
                print("-- not  send chkFtPosit")
            end

            --         --   print("self.i"..self.i.." self.j"..self.j)
            --              if (self.chkFtPosit=="x") then
            --                  for stX = 1, gemX, 1 do
            --                      self.i = stX
            --                      self.gemType=gemsTable[self.i][self.j].gemType
            --
            --                      --print("self.i"..self.i.." self.j"..self.j..self.gemType)
            --                      markToDestroy(self,0)
            --
            --                     local kk = stX -1
            --                     if(kk > 0) then
            --                          kk = gemsTable[kk][self.j].gemType
            --                      else
            --                          kk = "COLOR FT"
            --                     end
            --
            --                      chkGruopGem(self, kk)
            --
            --                      --print("xxx".. self.gemType,numberOfMarkedToDestroy )
            --                  end
            --              elseif (self.chkFtPosit=="y" ) then
            --                  for stY = 1, gemY, 1 do
            --                      self.j = stY
            --                      self.gemType=gemsTable[self.i][self.j].gemType
            --
            --                      markToDestroy(self,0)
            --
            --                     local kk = stY -1
            --                     if(kk > 0) then
            --                          kk = gemsTable[self.i][kk].gemType
            --                     else
            --                          kk = "COLOR FT"
            --                     end
            --
            --                      chkGruopGem(self,kk)
            --                     -- print("yyy".. self.gemType,numberOfMarkedToDestroy )
            --                  end
            --              else
            --                  print("not heve self.chkFtPosit")
            --              end

            --              --print(" - lockGem")
            --              local  overMin = 0
            --              for p = 1 , table.getn(picture), 1 do
            --              --    print(p.." "..groupGem[p])
            --                  if(groupGem[p] >= limitCountGem) then
            --                      overMin = limitCountGem
            --                  end
            --              end
            --          --      print("destroy "..numberOfMarkedToDestroy)
            --              if overMin >= limitCountGem then
            --                  destroyGems(self)
            --              else
            --                  cleanUpGems()
            --              end
        end

    else
        --print(" self.chkFtPosit")
    end

end

function rndLock2(RC,i,j, event)
    if RC == "x" then

        for stX = 1, gemX, 1 do
            gemsTable[i][j].i = stX
            gemsTable[i][j].gemType=gemsTable[i][j].gemType

            --    print("self.i"..self.i.." self.j"..self.j..self.gemType)
            markToDestroy(gemsTable[i][j],0)

            local kk = stX -1
            if(kk > 0) then
                kk = gemsTable[kk][j].gemType
            else
                kk = "COLOR FT"
            end

            chkGruopGem(gemsTable[i][j], kk)

            --print("xxx".. self.gemType,numberOfMarkedToDestroy )
        end
    else
        for stY = 1, gemY, 1 do
            gemsTable[i][j].j = stY
            gemsTable[i][j].gemType=gemsTable[i][j].gemType

            markToDestroy(gemsTable[i][j],0)

            local kk = stY -1
            if(kk > 0) then
                kk = gemsTable[i][kk].gemType
            else
                kk = "COLOR FT"
            end

            chkGruopGem(gemsTable[i][j],kk)
            -- print("yyy".. self.gemType,numberOfMarkedToDestroy )
        end
    end
end


function rndLock(self, event)
    -- print("gemsTable[self.i][self.j].gemType",gemsTable[self.i][self.j].gemType)

    if (self.chkFtPosit=="x") then
        for stX = 1, gemX, 1 do
            self.i = stX
            self.gemType=gemsTable[self.i][self.j].gemType

            --    print("self.i"..self.i.." self.j"..self.j..self.gemType)
            markToDestroy(self,0)

            local kk = stX -1
            if(kk > 0) then
                kk = gemsTable[kk][self.j].gemType
            else
                kk = "COLOR FT"
            end

            chkGruopGem(self, kk)

            --print("xxx".. self.gemType,numberOfMarkedToDestroy )
        end
    elseif (self.chkFtPosit=="y" ) then
        for stY = 1, gemY, 1 do
            self.j = stY
            self.gemType=gemsTable[self.i][self.j].gemType

            markToDestroy(self,0)

            local kk = stY -1
            if(kk > 0) then
                kk = gemsTable[self.i][kk].gemType
            else
                kk = "COLOR FT"
            end

            chkGruopGem(self,kk)
            -- print("yyy".. self.gemType,numberOfMarkedToDestroy )
        end
    else
        print("not heve self.chkFtPosit")
    end

    local  overMin = 0
    for p = 1 , table.getn(picture), 1 do
        --    print(p.." "..groupGem[p])
        if(groupGem[p] >= limitCountGem) then
            overMin = limitCountGem
        end
    end
    print("destroy "..overMin)
    if overMin >= limitCountGem then
        destroyGems()
        print("----------------------------------------------------")
        --          for  i = 1 ,gemX, 1 do
        --               for  j = 1 , gemY, 1 do
        --                   gemsTable[i][j].colorR = gemsTable[i][j].color   --- - -- - copy gem
        --               gemsTable[i][j].markX = gemsTable[i][j].x
        --               gemsTable[i][j].markY = gemsTable[i][j].y
        --                print("chk "..gemsTable[i][j].i, gemsTable[i][j].j,gemsTable[i][j].color)
        --               end
        --           end
        --       rndLock(self, event)
    else
        cleanUpGems()
    end
    --
end
function test(self)
    -- print("65chk "..gemsTable[1][1].i, gemsTable[1][1].j,gemsTable[1][1].color)
    for  i = 1 ,gemX, 1 do
        for  j = 1 , gemY, 1 do
            gemsTable[i][j].colorR = gemsTable[i][j].color   --- - -- - copy gem
            gemsTable[i][j].markX = gemsTable[i][j].x
            gemsTable[i][j].markY = gemsTable[i][j].y
            print("65chk "..gemsTable[i][j].i, gemsTable[i][j].j,gemsTable[i][j].color)
        end
    end
end

function formulaMission( randomGem, powerChr)
    print("formula")
end
local y = 403
local function numberToimg (hp,stHp,si,i)
    number[i] =display.newImageRect("img/other/"..hp..".png",si,25)
    number[i]:setReferencePoint( display.TopLeftReferencePoint )
    number[i].x, number[i].y = stHp, y
    groupGameTop:insert ( number[i] )
end
local function checkdoubleRight(i,j,RC)

    if gemsTable[i][j].gemType == "RED" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[1] = numcolor[1] + 1
    elseif gemsTable[i][j].gemType == "GREEN" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[2] = numcolor[2] + 1
    elseif gemsTable[i][j].gemType == "BLUE" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[3] = numcolor[3] + 1
    elseif gemsTable[i][j].gemType == "PURPLE" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[4] = numcolor[4] + 1
    elseif gemsTable[i][j].gemType == "PINK" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[5] = numcolor[5] + 1
    elseif gemsTable[i][j].gemType == "YELLOW" and gemsTable[i][j].isMarkedToDestroy == true then
        numcolor[6] = numcolor[6] + 1

    end

    if i < 6 and RC == "right"  then
        if gemsTable[i+1][j].isMarkedToDestroy == false and gemsTable[i][j].gemType == gemsTable[i+1][j].gemType then --right
            --print("==> right i:j",i..":"..j,gemsTable[i+1][j].gemType)
            gemsTable[i+1][j].isMarkedToDestroy = true
            checkdoubleRight(i+1,j,"right")
        else
            if j < 5 then
                checkdoubleRight(i,j,"under")
            end
            if j > 1 then --top
                checkdoubleRight(i,j,"top")
            end
        end
    elseif  j < 5 and RC == "under" then
        if gemsTable[i][j+1].isMarkedToDestroy == false and gemsTable[i][j].gemType == gemsTable[i][j+1].gemType then --under
           -- print("==> under i:j",i..":"..j,gemsTable[i][j+1].gemType)
            gemsTable[i][j+1]:setStrokeColor(140, 140 ,140)
            gemsTable[i][j+1].isMarkedToDestroy = true
            checkdoubleRight(i,j+1,"under")
        end
    elseif  i > 1 and RC == "left" then
        if gemsTable[i-1][j].isMarkedToDestroy == false and gemsTable[i][j].gemType == gemsTable[i-1][j].gemType then --left
           -- print("==> left i:j",i..":"..j,gemsTable[i-1][j].gemType)
            gemsTable[i-1][j].isMarkedToDestroy = true
            checkdoubleRight(i-1,j,"left")
        end
    elseif  j > 1 and RC == "top" then
        if gemsTable[i][j-1].isMarkedToDestroy == false and gemsTable[i][j].gemType == gemsTable[i][j-1].gemType then --top
           -- print("==> top i:j",i..":"..j,gemsTable[i][j-1].gemType)
            gemsTable[i][j-1].isMarkedToDestroy = true
            checkdoubleRight(i,j-1,"top")
        end
    end
end
function checkdoubleAll()
    for i = 1, gemX, 1 do --6
        for j = 1, gemY, 1 do  --5
            if gemsTable[i][j].isMarkedToDestroy == false then
                 markToDestroy(gemsTable[i][j], 0)
                 chkGruopGem2(gemsTable[i][j])
            end

        end
    end

    local overMin = 0
    for p = 1 , table.getn(picture), 1 do
        --print(p.." "..groupGem[p])
        if(groupGem[p] >= limitCountGem) then
            overMin = limitCountGem
        end
    end
    if overMin >= limitCountGem then
        destroyGems()
    else
        cleanUpGems()
    end
    timer.performWithDelay( 1000, enableGemTouch )
end


function onGemTouch( self, event )	-- was pre-declared
    local stHp, si =590, 20

    --if isGemTouchEnabled == true then


    if event.phase == "began" and isGemTouchEnabled == true then
        --     print("2 "..playerDB.charac_def[1])
        --     print("sss "..table.getn(playerDB.charac_def))
        --  print("chk "..gemsTable[1][1].i, gemsTable[1][1].j,gemsTable[1][1].color)
        for  i = 1 ,gemX, 1 do
            for  j = 1 , gemY, 1 do
                gemsTable[i][j].colorR = gemsTable[i][j].color   --- - -- - copy gem
                gemsTable[i][j].markX = gemsTable[i][j].x
                gemsTable[i][j].markY = gemsTable[i][j].y
            end
        end

        display.getCurrentStage():setFocus( self )
        self.isFocus = true

        if(gemsTable[self.i][self.j].isMarkedToDestroy == false ) then
            self:setFillColor(100)
        end

        widhtLineY, widhtLineX = 525, 620
        sizeLineStY, sizeLineStX = 695, 320

        lineY = display.newImageRect("img/other/bar_twin_v.png",100,widhtLineY)
        lineY.x, lineY.y = self.markX, sizeLineStY

        lineX = display.newImageRect("img/other/bar_twin_h.png", widhtLineX, 100)
        lineX.x, lineX.y = sizeLineStX, self.markY
        copyGem(self, event)

        --  local ftCilck = ""
    elseif self.isFocus then
        if event.phase == "moved" then
            local posX = (event.x - event.xStart) + self.markX
            local posY = (event.y - event.yStart) + self.markY

            local pathY = event.y-event.yStart
            local pathX = event.x-event.xStart

            --     print("posX ".. posX.." posY ".. posY.." pathX ".. pathX.." pathY ".. pathY )
            --     print ("event.xStart ".. event.xStart.. " event.x "..event.x.." self.markX ".. self.markX)
            local speedX = posX - self.markX
            if ( (posY == self.markY) or self.chkFtPosit == "x" ) then -- move X
                if(self.chkFtPosit == "y" ) then
                    posX = self.markX
                    posY = event.y

                    self.chkFtPosit ="y"
                else
                    posX = event.x
                    posY = self.markY

                    self.chkFtPosit ="x"
                end
                --       print( "posY == self.markY   moveX")
            elseif ( posX == self.markX or self.chkFtPosit == "y"  ) then -- move Y
                if(self.chkFtPosit == "x") then
                    posX = event.x
                    posY = self.markY

                    self.chkFtPosit ="x"
                else
                    posX = self.markX
                    posY = event.y

                    self.chkFtPosit ="y"
                end
                --          print( "posX == self.markX   moveY")
            else
                if (pathY < pathX  and self.chkFtPosit =="" ) then -- move X
                    posX = event.x
                    posY = self.markY
                    --       print("|xxxx"..pathY,pathX)
                    self.chkFtPosit ="x"
                    --                   local myText = display.newText(pathY.."!"..pathX, 0, 0, native.systemFont, 100)
                    --                    myText:setTextColor(0, 0, 0)

                else--if (pathY > pathX  and self.chkFtPosit =="") then
                    posX = self.markX-- move Y
                    posY = event.y
                    --        print("|yyyy"..pathY,pathX)
                    self.chkFtPosit ="y"
                --else
                    --          print("sssssssss sss sss s ss ")
                end

            end

            self.x, self.y = posX, posY
            --print("x:"..posX.."evX:"..self.x.." y:"..posY.."evY:"..self.y)
            --print("slide "..gemsTable[6][self.j].x)

            slideGem(self,event)  --- old
        elseif event.phase == "ended" or event.phase == "cancelled" then
           -- print("end phase".. self.chkFtPosit)

            pasteGem(self,event)
            lockGem(self,event)
            rndLock(self, event)


            self.chkFtPosit =""

            display.getCurrentStage():setFocus( nil )
            self.isFocus = false

            if(gemsTable[self.i][self.j].isMarkedToDestroy == false ) then
                self:setFillColor(255)
            else
                self:setFillColor(150)
            end

            for i = string.len(hpFull) ,1, -1 do
                if ( string.sub(hpFull, i, i) == "1") then
                    si =15
                else
                    si = 20
                end
                stHp = stHp -si
                numberToimg (string.sub(hpFull, i, i) ,stHp,si,i)
            end

            stHp = stHp - si
            numberBar.Width = si
            numberBar.x= stHp

            for i = string.len(hpPlayer), 1, -1 do
                if ( string.sub(hpPlayer, i, i) == "1") then
                    si =15
                else
                    si = 20
                end
                stHp = stHp -si
                numberToimg (string.sub(hpPlayer, i, i) ,stHp,si,string.len(hpPlayer)+ string.len(hpFull)-i+1)
            end

        end
    end
    return true
   -- end
end

function scene:createScene( event )
    --   print("before "..table.getn(playerDB.charac_def))
    ------------------------- connect REST serviced -------------------------
    groupGameLayer = display.newGroup()
    groupGameTop = display.newGroup()

    local group = self.view
    local background = display.newImageRect( "img/background/bg_puzzle_test.tga", _W, _H )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    groupGameLayer:insert ( background )

    ------------------------- gemsTable -------------------------
    for i = 1, gemX, 1 do --- x
        gemsTable[i] = {}
        for j = 1, gemY, 1 do --- y
            gemsTable[i][j] = newGem(i,j)

        end
    end
    --doubleToDestroy(0)
    checkdoubleAll(event)
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
    BGAnimation = display.newImageRect( image_sheet[BGsprite] , display.contentWidth, 425 )
    BGAnimation:setReferencePoint( display.CenterReferencePoint )
    BGAnimation.x, BGAnimation.y = _W*.5, _H*.2
    --Gdisplay:insert(BGAnimation)
    groupGameTop:insert ( BGAnimation )


    hpPlayer =  hpFull
    if hpPlayer == fullLineHP then
    else
    end


    lifeline_sh = display.newImageRect( "img/other/life_short.png",hpPlayer,20) -- full 550
    lifeline_sh:setReferencePoint( display.TopLeftReferencePoint )
    pointStart = _W*.08
    lifeline_sh.x, lifeline_sh.y =  pointStart, _H*.422

    groupGameTop:insert ( lifeline_sh )

    lifeline = display.newImageRect( "img/other/life_line.png", 600, 30) -- 490
    lifeline:setReferencePoint( display.TopLeftReferencePoint )
    lifeline.x, lifeline.y = _W*.05, _H*.418
    groupGameTop:insert ( lifeline )
    --            -------------------------- HP value -------------------------
    local stHp, si =590, 20

    for i = string.len(hpFull) ,1, -1 do
        if ( string.sub(hpFull, i, i) == "1") then
            si =15
        else
            si = 20
        end
        stHp = stHp -si
        numberToimg (string.sub(hpFull, i, i) ,stHp,si,i)
    end

    stHp = stHp - si
    numberBar =display.newImageRect("img/other/bar.png",si,25)
    numberBar:setReferencePoint( display.TopLeftReferencePoint )
    numberBar.x, numberBar.y = stHp, 400
    groupGameTop:insert ( numberBar )

    for i = string.len(hpPlayer), 1, -1 do
        if ( string.sub(hpPlayer, i, i) == "1") then
            si =15
        else
            si = 20
        end
        stHp = stHp -si
        numberToimg (string.sub(hpPlayer, i, i) ,stHp,si,string.len(hpPlayer)+ string.len(hpFull)-i+1)
    end



    createBackButton(event)
    createCharacter(event)
--    miniIconCharac_frame(event)
    miniIconCharac(event)

    --    groupGameLayer:insert ( lightWigth )
    groupGameTop:insert ( backButton )
    groupGameTop:insert(bntItem)

    groupGameLayer:insert(groupGameTop)
    group:insert(groupGameLayer)


end -- end for scene:createScene

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
end

function scene:destroyScene( event )
    local group = self.view
end
------- sample used ------- 
local function networkListener( event )
    --        print("address", event.address )
    --        print("isReachable", event.isReachable )
    --        print("isConnectionRequired", event.isConnectionRequired)
    --        print("isConnectionOnDemand", event.isConnectionOnDemand)
    --        print("IsInteractionRequired", event.isInteractionRequired)
    --        print("IsReachableViaCellular", event.isReachableViaCellular)
    --        print("IsReachableViaWiFi", event.isReachableViaWiFi)

    if ( event.isError ) then
        print ( "Network error1 - download failed" )
    else
        print("Connect good")
        --            event.target.alpha = 0
        --            transitionStash.newTransition = transition.to( event.target, { alpha = 1.0 } )
        print ( "RESPONSE: " .. event.response )

        local json = require "json"

        playerDB = json.decode(event.response)
    end
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

  

