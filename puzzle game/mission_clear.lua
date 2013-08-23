local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local util = require ("util")
local http = require("socket.http")
local json = require("json")
----------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight

local image_btnback = "img/background/button/Button_BACK.png"
local image_btnnext = "img/background/button/Button_NEXT.png"
local image_text = "img/text/MISSION_CLEAR.png"

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

local sizeFream_imageH = screenH*.09
local sizeFream_imageW = screenW*.14

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
local user_id
local myItem = {}
local allItem
------------------------------------------------------------------------------
------------------------------------------------------------------------------
local function oncheckItemFull(event)

    local holdcharac_id = { 16,32,23 }

    local Linkmission = "http://localhost/dym/Onecharacter.php"
    local numberHold_character =  Linkmission.."?user_id="..user_id.."&character=32"
    local numberHold = http.request(numberHold_character)


    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        allItem = allRow.All

        local k = 1
        while(k <= allItem) do
            myItem[k] = {}
            myItem[k].holdcharac_id = allRow.chracter[k].holdcharac_id
            myItem[k].charac_id = allRow.chracter[k].charac_id
            myItem[k].charac_name = allRow.chracter[k].charac_name
            myItem[k].element = tonumber(allRow.chracter[k].element)
            myItem[k].charac_img_mini = allRow.chracter[k].charac_img_mini
            print("myItem[k].charac_id,myItem[k].holdcharac_id::",myItem[k].charac_id,myItem[k].holdcharac_id)
            k = k + 1

        end
    end

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

    else
    local option = {
        effect = "fade",
        time = 100,
        params = {
            character_id = myItem[1].holdcharac_id,
            user_id = user_id ,
        }

    }
        storyboard.gotoScene( "characterprofile" ,option)
    end
    return true
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

    local pointxTREA  = screenW*.15
    local pointxTREAfrm  = screenW*.12


    for i = 1, limitTrea ,1 do
        treasure[i] = widget.newButton{
            default= image_layout,
            over= image_layout,
            width=sizeFream_imageW, height=sizeFream_imageH,
            onRelease = onBtnonclick	-- event listener function
        }
        treasure[i].id="treasure"..i
        treasure[i]:setReferencePoint( display.TopLeftReferencePoint )
        treasure[i].x = pointxTREAfrm
        treasure[i].y = screenH *.515

        treasurePic[i] = display.newImageRect(image_picTrea,sizeimageW,sizeimageH)
        treasurePic[i]:setReferencePoint( display.TopLeftReferencePoint )
        treasurePic[i].x =  pointxTREA
        treasurePic[i].y = screenH *.534

        pointxTREAfrm = pointxTREAfrm + screenW*.15
        pointxTREA = pointxTREA + screenW*.15

    end

    local pointxFLAG = screenW*.13
    local pointxFLAGfrm = screenW*.13

    for i = 1, limitFlag ,1 do
        flag[i] = widget.newButton{
            default= myItem[1].charac_img_mini,
            over= myItem[1].charac_img_mini,
            width=sizeFream_imageW, height=sizeFream_imageH,
            onRelease = onBtnonclick	-- event listener function
        }
        flag[i].id= myItem[1].charac_id
        flag[i]:setReferencePoint( display.TopLeftReferencePoint )
        flag[i].x = pointxFLAGfrm
        flag[i].y = screenH *.69

--        flagPic[i] = display.newImageRect(image_picFlag,sizeimageW,sizeimageH)
--        flagPic[i] = display.newImageRect(myItem[1].charac_img_mini ,sizeimageW,sizeimageH)
--        flagPic[i]:setReferencePoint( display.TopLeftReferencePoint )
--        flagPic[i].x = pointxFLAG
--        flagPic[i].y = screenH *.69

        pointxFLAGfrm = pointxFLAGfrm + screenW*.15
        pointxFLAG = pointxFLAG + screenW*.15
    end
end


function scene:createScene( event )
    local group = self.view
    local gdisplay = display.newGroup()
    local img_bg = "img/background/background_1.jpg"
    user_id = menu_barLight.user_id()
    local background1 = display.newImageRect(img_bg,screenW,screenH)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0

    local titleText = display.newImageRect(image_text,screenW*.356,screenH*.028)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = display.contentWidth*.5
    titleText.y = display.contentHeight*.325

    --text name mission
    local txtNamemission = display.newText(missionName, 0, 0, typeFont, sizetextmissionName)
    txtNamemission:setTextColor(0, 0, 255)
    txtNamemission.x = screenW*.48
    txtNamemission.y = screenH*.38

    local txtsEXP = display.newText("EXP  "..strEXP, 0, 0, typeFont, sizetext)
    txtsEXP:setTextColor(255, 150, 0)
    txtsEXP.x = screenW *.53
    txtsEXP.y = screenH *.435

    local txtcoin = display.newText("COIN  "..strCoin, 0, 0,typeFont, sizetext)
    txtcoin:setTextColor(255, 0, 255)
    txtcoin.x = screenW *.53
    txtcoin.y = screenH *.475

    local txt_treasure = display.newText("TREASURE", 0, 0, typeFont, 22)
    txt_treasure:setTextColor(255, 255, 255)
    txt_treasure.x = screenW*.2
    txt_treasure.y = screenH*.51

    local txt_flag = display.newText("FLAG", 0, 0, typeFont, 20)
    txt_flag:setTextColor(255, 255, 255)
    txt_flag.x = screenW*.15
    txt_flag.y = screenH*.67

    oncheckItemFull()
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
    group:insert(txt_treasure)
    group:insert(txt_flag)

    for i = 1 ,limitFlag,1 do
        group:insert(flag[i])

    end

    for i = 1 ,limitTrea,1 do
        group:insert(treasurePic[i])
        group:insert(treasure[i])

    end

    group:insert(gdisplay)
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
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

