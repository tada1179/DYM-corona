--
-- Created by IntelliJ IDEA.
-- User: APPLE
-- Date: 5/3/13
-- Time: 1:04 PM
-- To change this template use File | Settings | File Templates.
--

print("mission_clear")


local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local util = require ("util")

local screenW, screenH = display.contentWidth, display.contentHeight


local image_btnback = "img/background/button/Button_BACK.png"
local image_btnnext = "img/background/button/Button_NEXT.png"
local image_text = "img/text/MISSION_CLEAR.png"

--local image_background1 = "img/background/pageBackground_JPG/misclear.jpg"
--local image_background1 = "img/background/background_1.png"
local image_background1 = "img/background/misstion/backmission6.jpg"
local image_background2 = "img/background/background_2.png"
local image_layout = "img/background/misstion/FRAME_LAYOUT_CLEAR.png"
local image_picTrea = "img/background/misstion/DIAMOND.png"
local image_picFlag = "img/background/misstion/FLAG.png"


local missionName = "tada yusoh"
local strEXP = "1000"
local strCoin = "2000"

local sizetext = 20
local sizetextmissionName = 25
local typeFont = native.systemFontBold

local sizeFream_imageH = screenH*.12
local sizeFream_imageW = screenW*.17

local sizeimageH = screenH *.09
local sizeimageW = screenW *.125


local limitFlag = 5
local limitTrea = 5

local backButton
local nextButton

local treasure = {}
local treasurePic = {}

local flag = {}
local flagPic = {}

local function oncheckItemFull()


end

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

   --next button
    nextButton = widget.newButton{
        default= image_btnnext,
        over= image_btnnext,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnonclick	-- event listener function
    }
    nextButton.id="next"
    nextButton:setReferencePoint( display.TopLeftReferencePoint )
    nextButton.x = display.contentWidth *.73
    nextButton.y = display.contentHeight - (display.contentHeight *.7)

    --local gdisplay = display.newGroup()

    for i = 1, limitTrea ,1 do
        treasure[i] = widget.newButton{
            default= image_layout,
            over= image_layout,
            width=sizeFream_imageW, height=sizeFream_imageH,
            onRelease = onBtnonclick	-- event listener function
        }
        treasure[i].id="treasure"..i
        treasure[i]:setReferencePoint( display.TopLeftReferencePoint )
        treasure[i].x =  i*(screenW*.14)
        treasure[i].y = screenH *.515

        treasurePic[i] = display.newImageRect(image_picTrea,sizeimageW,sizeimageH)
        treasurePic[i]:setReferencePoint( display.TopLeftReferencePoint )
        treasurePic[i].x =  (i*screenW*.148)
        treasurePic[i].y = screenH *.534

    end

    for i = 1, limitFlag ,1 do
        flag[i] = widget.newButton{
            default= image_layout,
            over= image_layout,
            width=sizeFream_imageW, height=sizeFream_imageH,
            onRelease = onBtnonclick	-- event listener function
        }
        flag[i].id="flag"..i
        flag[i]:setReferencePoint( display.TopLeftReferencePoint )
        flag[i].x = i*(screenW*.14)
        flag[i].y = screenH *.672

        flagPic[i] = display.newImageRect(image_picFlag,sizeimageW,sizeimageH)
        flagPic[i]:setReferencePoint( display.TopLeftReferencePoint )
        flagPic[i].x = flag[i].x
        flagPic[i].y = flag[i].y
    end
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

    local titleText = display.newImageRect(image_text,screenW*.356,screenH*.028)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = display.contentWidth*.5
    titleText.y = display.contentHeight*.325



    --text name mission
    local txtNamemission = display.newText(missionName, 0, 0, typeFont, sizetextmissionName)
    txtNamemission:setTextColor(0, 0, 255)
    txtNamemission.x = screenW*.48
    txtNamemission.y = screenH*.38

    local txtsEXP = display.newText(strEXP, 0, 0, typeFont, sizetext)
    txtsEXP:setTextColor(255, 150, 0)
    txtsEXP.x = screenW *.55
    txtsEXP.y = screenH *.435

    local txtcoin = display.newText(strCoin, 0, 0,typeFont, sizetext)
    txtcoin:setTextColor(255, 0, 255)
    txtcoin.x = screenW *.55
    txtcoin.y = screenH *.475



    createButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background1)

    group:insert(backButton)
    group:insert(nextButton)
    group:insert(txtcoin)

    group:insert(titleText)
    group:insert(txtNamemission)
    group:insert(txtsEXP)

    for i = 1 ,limitFlag,1 do

        group:insert(flagPic[i])
        group:insert(flag[i])

    end

    for i = 1 ,limitTrea,1 do
        group:insert(treasurePic[i])
        group:insert(treasure[i])

    end

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

