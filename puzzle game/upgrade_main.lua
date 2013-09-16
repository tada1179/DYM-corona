local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local util = require ("util")

local screenW, screenH = display.contentWidth, display.contentHeight

---------------------------------------------------------------------
local sizetextname = 20
local sizetext = 18
local typeFont = native.systemFontBold

local strcoin = "0000"
local strname = "KWANTA yusoh"
local strHP = "10HP"
local strLV = "10LV"
local strATC = "10AT"
local strDEF = "10DE"
local strBasecard = strLV.."\n"..strHP.."\n"..strATC.."\n"..strDEF

local strUPname = "tada yusoh"
local strUPHP = "10HP"
local strUPLV = "10LV"
local strUPATC = "10AT"
local strUPDEF = "10DE"
local strUpcard = strUPLV.."\n"..strUPHP.."\n"..strUPATC.."\n"..strUPDEF
local gdisplay = display.newGroup()
------------------------------------
local function onBtnonclick(event)
    display.remove(gdisplay)
    gdisplay = nil

    if event.target.id == "back" then
        storyboard.gotoScene( "unit_main" ,"fade", 100 )

    elseif event.target.id == "choose" then
        storyboard.gotoScene( "team_item" ,"fade", 100 )

    elseif event.target.id == "enchant" then
        storyboard.gotoScene( "unit_main" ,"fade", 100 )

    elseif event.target.id == "leader" then
        storyboard.gotoScene( "characterprofile" ,"fade", 100 )

    elseif event.target.id == "character1" then
        --storyboard.gotoScene( "characterprofile" ,"fade", 100 )
    end
    return true
end
local function createButton()

    local image_btnback = "img/background/button/Button_BACK.png"
    local image_leaderChar = "img/characterIcon/as_cha_frm00.png"
    local image_btnTUNEUP = "img/background/button/tune_up.png"
    local image_freamset = "img/background/powerup/FRAME_SET.png"

    local backButton = widget.newButton{
        defaultFile= image_btnback,
        overFile= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnonclick	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
    gdisplay:insert(backButton)

    -- button TUNE UP
    local btnTUNEUP = widget.newButton{
        defaultFile= image_btnTUNEUP,
        overFile= image_btnTUNEUP,
        width=screenW*.2, height=screenH*.045,
        onRelease = onBtnonclick	-- event listener function
    }
    btnTUNEUP.id="TUNEUP"
    btnTUNEUP:setReferencePoint( display.CenterReferencePoint )
    btnTUNEUP.x = screenW *.5
    btnTUNEUP.y = screenH *.65
    gdisplay:insert(btnTUNEUP)

    -- charecter leader
    local btnleader = widget.newButton{
        defaultFile= image_leaderChar,
        overFile= image_leaderChar,
        width=screenW*.16, height=screenH*.11,
        onRelease = onBtnonclick	-- event listener function
    }
    btnleader.id="leader"
    btnleader:setReferencePoint( display.TopLeftReferencePoint )
    btnleader.x = screenW *.16
    btnleader.y = screenH *.35
    gdisplay:insert(btnleader)

    local btnchoose = {}
    for i = 1, 5 ,1 do
        btnchoose[i] = widget.newButton{
            defaultFile= image_freamset,
            overFile= image_freamset,
            width=screenW*.115, height=screenH*.08,
            onRelease = onBtnonclick	-- event listener function
        }
        btnchoose[i].id="character"..i
        btnchoose[i]:setReferencePoint( display.TopLeftReferencePoint )
        btnchoose[i].x = i*(screenW*.13) + (screenW *.05)
        btnchoose[i].y = screenH *.54
        gdisplay:insert(btnchoose[i])
    end



    local character = widget.newButton{
        defaultFile= image_freamset,
        overFile= image_freamset,
        width=screenW*.16, height=screenH*.11,
        onRelease = onBtnonclick	-- event listener function
    }
    character.id="character"
    character:setReferencePoint( display.TopLeftReferencePoint )
    character.x = screenW*.16
    character.y = screenH *.68
    gdisplay:insert(character)

    local image_SKL = "img/background/button/SKL.png"
    local image_LSKL = "img/background/button/LSKL.png"
    -- button SKL
    local btnSKL = widget.newButton{
        defaultFile= image_SKL,
        overFile= image_SKL,
        width=screenW*.085, height=screenH*.03,
        onRelease = onBtnonclick	-- event listener function
    }
    btnSKL.id="SKL"
    btnSKL:setReferencePoint( display.TopLeftReferencePoint )
    btnSKL.x = screenW *.16
    btnSKL.y = screenH *.465
    gdisplay:insert(btnSKL)
    -- button LSKL



    local btnLSKL = widget.newButton{
        defaultFile= image_LSKL,
        overFile= image_LSKL,
        width=screenW*.085, height=screenH*.03,
        onRelease = onBtnonclick	-- event listener function
    }
    btnLSKL.id="LSKL"
    btnLSKL:setReferencePoint( display.TopLeftReferencePoint )
    btnLSKL.x = screenW *.25
    btnLSKL.y = screenH *.465
    gdisplay:insert(btnLSKL)
    --*************************
    -- button SKL
    local btnupSKL = widget.newButton{
        defaultFile= image_SKL,
        overFile= image_SKL,
        width=screenW*.085, height=screenH*.03,
        onRelease = onBtnonclick	-- event listener function
    }
    btnupSKL.id="upSKL"
    btnupSKL:setReferencePoint( display.TopLeftReferencePoint )
    btnupSKL.x = screenW *.16
    btnupSKL.y = screenH *.793
    gdisplay:insert(btnupSKL)

    -- button LSKL
    local btnupLSKL = widget.newButton{
        defaultFile= image_LSKL,
        overFile= image_LSKL,
        width=screenW*.085, height=screenH*.03,
        onRelease = onBtnonclick	-- event listener function
    }
    btnupLSKL.id="upLSKL"
    btnupLSKL:setReferencePoint( display.TopLeftReferencePoint )
    btnupLSKL.x = screenW *.25
    btnupLSKL.y = screenH *.793
    gdisplay:insert(btnupLSKL)

end


function scene:createScene( event )
    local image_text = "img/text/UPGRADE.png"
    local image_txtbasecard = "img/text/base_card.png"
    local image_txtupcard = "img/text/upgrade_card.png"
    local image_background1 = "img/background/background_1.jpg"

    local image_txtHPLV = "img/text/HP,LV,ATC,DEF.png"
    local image_enchant = "img/background/powerup/TUNE_UP_UNIT.png"
    local group = self.view

    local background1 = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0
    gdisplay:insert(background1)

    local titleText = display.newImageRect(image_text,screenW*.22,screenH*.028)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = screenW*.5
    titleText.y = screenH*.311
    gdisplay:insert(titleText)

    local titleTUNEUP = display.newImageRect(image_enchant,screenW*.65,screenH*.027)--contentWidth contentHeight
    titleTUNEUP:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleTUNEUP.x = screenW*.49
    titleTUNEUP.y = screenH*.52
    gdisplay:insert(titleTUNEUP)

    -- text HP,LV,ATC,DEF
    local titletxtHPLV = display.newImageRect(image_txtHPLV,screenW*.05,screenH*.08)--contentWidth contentHeight
    titletxtHPLV:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titletxtHPLV.x = screenW*.38
    titletxtHPLV.y = screenH*.44
    gdisplay:insert(titletxtHPLV)

    local titletxtHPLV2 = display.newImageRect(image_txtHPLV,screenW*.05,screenH*.08)--contentWidth contentHeight
    titletxtHPLV2:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titletxtHPLV2.x = screenW*.38
    titletxtHPLV2.y = screenH*.78
    gdisplay:insert(titletxtHPLV2)

    -- massage
    local txtbasecard = display.newImageRect(image_txtbasecard,screenW*.165,screenH*.015)--contentWidth contentHeight
    txtbasecard:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    txtbasecard.x = screenW*.438
    txtbasecard.y = screenH*.355
    gdisplay:insert(txtbasecard)

    local txtupcard = display.newImageRect(image_txtupcard,screenW*.23,screenH*.015)--contentWidth contentHeight
    txtupcard:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    txtupcard.x = screenW*.47
    txtupcard.y = screenH*.69
    gdisplay:insert(txtupcard)
     --


    local txtcoin = display.newText(strcoin, 0, 0, native.systemFontBold, 18)
    txtcoin:setTextColor(255, 0, 255)
    txtcoin.x = screenW*.77
    txtcoin.y = screenH*.52
    gdisplay:insert(txtcoin)

    -- name character base
    local txtNamecharacter = display.newText(strname, 0, 0, typeFont, sizetextname)
    txtNamecharacter:setTextColor(0, 0, 255)
    txtNamecharacter:setReferencePoint(display.CenterReferencePoint)
    txtNamecharacter.x = screenW*.47
    txtNamecharacter.y = screenH*.38
    gdisplay:insert(txtNamecharacter)

    local txttitleName = util.wrappedText( strBasecard, 39, 17, typeFont, {200,0,0} )
    txttitleName.x = screenW*.45
    txttitleName.y = screenH*.38
    gdisplay:insert(txttitleName)

    -- name character upgrade
    local upgradeNamecharacter = display.newText(strUPname, 0, 0, typeFont, sizetextname)
    upgradeNamecharacter:setTextColor(0, 0, 255)
    upgradeNamecharacter.x = screenW*.45
    upgradeNamecharacter.y = screenH*.72
    gdisplay:insert(upgradeNamecharacter)

    local upgradeName = util.wrappedText( strUpcard, 39, 17, typeFont, {200,0,0} )
    upgradeName.x = screenW*.45
    upgradeName.y = screenH*.72
    gdisplay:insert(upgradeName)


    createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)
    group:insert(gdisplay)
    -------------------------------------
    storyboard.removeAll ()
    storyboard.purgeAll()

end
function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
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

