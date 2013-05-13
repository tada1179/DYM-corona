--
-- Created by IntelliJ IDEA.
-- User: APPLE
-- Date: 5/3/13
-- Time: 2:07 PM
-- To change this template use File | Settings | File Templates.
--
print("power_up_main")

local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local util = require ("util")

local screenW, screenH = display.contentWidth, display.contentHeight


local image_btnback = "img/background/button/Button_BACK.png"
local image_text = "img/text/POWER_UP.png"

--local image_background1 = "img/background/pageBackground_JPG/power_up.psd"
local image_background1 = "img/background/background_1.png"
local image_background2 = "img/background/background_2.png"
local image_baseunit = "img/background/powerup/BASE_UNIT.png"
local image_enchant = "img/background/powerup/ENCHANT_UNIT.png"
local image_btnenchant = "img/background/button/ENCHANT.png"
local image_btnCHOOSE_CARD = "img/background/button/CHOOSE_CARD.png"
local image_freamset = "img/background/powerup/FRAME_SET.png"
local image_leaderChar = "img/framCharacterIcon/as_cha_frm00.png"

local image_txtHPLV = "img/text/HP,LV,ATC,DEF.png"
local image_txtLV_NEXT = "img/text/LV_NEXT.png"
local image_txtEXPGAIN = "img/text/EXPGAIN.png"

local image_tappower = "img/background/powerup/line_transparent.png"
local image_tapred = "img/background/powerup/line_red.png"
local image_tapyellow = "img/background/powerup/line_yellow.png"

local image_SKL = "img/background/button/SKL.png"
local image_LSKL = "img/background/button/LSKL.png"

local strcoin = "0000"
local strname = "tada yusoh"
local strsmash = "SMASH ATTACK"
local strHP = "1000"
local strLV = "1000"
local strATC = "1000"
local strDEF = "1000"
local sizetextname = 20
local sizetxtHPLV = 16
local typeFont = native.systemFontBold
local strAll = strHP.."\n"..strLV.."\n"..strATC.."\n"..strDEF

local tapPowerredW = 0
local tapPowerredH = screenH*.012

local tapPoweryellow = 0
local tapPoweryelloH = screenH*.012

local backButton
local btnenchant
local btnchoose
local btnleader
local btnSKL
local btnLSKL
local character = {}

local function onBtnonclick(event)
    print( "event: "..event.target.id)
    if event.target.id == "back" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map" ,"fade", 100 )

    elseif event.target.id == "choose" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_item" ,"fade", 100 )

    elseif event.target.id == "enchant" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "unit_main" ,"fade", 100 )

    elseif event.target.id == "leader" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "characterprofile" ,"fade", 100 )

    elseif event.target.id == "character1" then
        print( "event: "..event.target.id)
        --storyboard.gotoScene( "characterprofile" ,"fade", 100 )
    end
    return true
end
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end
local function createButton()
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

    -- charecter leader
    btnleader = widget.newButton{
        default= image_leaderChar,
        over= image_leaderChar,
        width=screenW*.165, height=screenH*.115,
        onRelease = onBtnonclick	-- event listener function
    }
    btnleader.id="leader"
    btnleader:setReferencePoint( display.TopLeftReferencePoint )
    btnleader.x = screenW *.185
    btnleader.y = screenH *.395

    for i = 1, 5 ,1 do
        character[i] = widget.newButton{
            default= image_freamset,
            over= image_freamset,
            width=screenW*.115, height=screenH*.08,
            onRelease = onBtnonclick	-- event listener function
        }
        character[i].id="character"..i
        character[i]:setReferencePoint( display.TopLeftReferencePoint )
        character[i].x = i*(screenW*.135) + (screenW *.05)
        character[i].y = screenH *.672
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
    local group = self.view
    local gdisplay = display.newGroup()
    local background1 = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0

    local background2 = display.newImageRect(image_background2,screenW,screenH)--contentWidth contentHeight
    background2:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background2.x,background2.y = 0,0

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

    local txtcoin = display.newText(strcoin, 0, 0, native.systemFontBold, 18)
    txtcoin:setTextColor(255, 0, 255)
    txtcoin.x = screenW*.79
    txtcoin.y = screenH*.641

    --text name character
    local txtNamecharacter = display.newText(strname, 0, 0, typeFont, sizetextname)
    txtNamecharacter:setTextColor(0, 0, 255)
    txtNamecharacter.x = screenW*.48
    txtNamecharacter.y = screenH*.4
    local txtsmash = display.newText(strsmash, 0, 0, typeFont, sizetxtHPLV)
    txtsmash:setTextColor(0, 150, 0)
    txtsmash.x = screenW*.49
    txtsmash.y = screenH*.428
    local txttitleName = util.wrappedText( strAll, 39, sizetxtHPLV, typeFont, {200,0,0} )
    txttitleName.x = screenW*.48
    txttitleName.y = screenH*.43



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

    group:insert(txtLVNEXT)
    group:insert(txtEXPGAIN)

    group:insert(powerLine)
    group:insert(powerred)
    group:insert(poweryellow)

    group:insert(titleText)
    group:insert(txtNamecharacter)
    group:insert(txtsmash)
    group:insert(txttitleName)

    group:insert(character[1])
    group:insert(character[2])
    group:insert(character[3])
    group:insert(character[4])
    group:insert(character[5])

    group:insert(background2)
    group:insert(gdisplay)
    checkMemory()
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

