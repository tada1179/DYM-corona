---------------------------------------------------------------
print("item_setting")
local storyboard = require("storyboard")
local scene = storyboard.newScene()
local widget = require "widget"
local itemView = require("itemView")
local http = require("socket.http")
local json = require("json")
local menu_barLight = require ("menu_barLight")
local includeFN = require ("includeFunction")
local alertMSN = require ("alertMassage")
---------------------------------------------------------------
local screenW = display.contentWidth
local screenH = display.contentHeight
local pointY = display.contentHeight * .45
local groupItem = display.newGroup()

local AllItem
local rowCharac
local user_id
local maxCharac = 5
local itemNumber = 1

local function onBtnRelease(event)

    if event.target.id == "back" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "unit_main" ,"fade", 100 )
    end
    return true
end
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end

local function createButton()
    local image_btnback = "img/background/button/Button_BACK.png"
    local image_reset = "img/background/button/as_team_reset.png"
    local image_sell = "img/background/button/SELL.png"
    local image_choose = "img/background/button/CHOOSE_CARD.png"

    function onbtnreset(event)
        local option = {
            effect = "slideRight",
            time = 100,
            params = {
                holditem = "choose",
                user_id  = user_id
            }
        }
        print("event:",event.target.id )
        if event.target.id == "SELL" then
            storyboard.gotoScene( "sell_item", option)

        elseif event.target.id == "choose1" then
            storyboard.gotoScene( "battle_item", option )

        elseif event.target.id == "Reset" then
            print("RESET")
            alertMSN.resetItem(user_id)
        end
    end
    local function onTouchGameOverScreen ( self, event )
         print("phase:",event.phase )
        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
    groupItem:insert(backButton)

    if rowCharac ==  0  then
        local backreset = display.newRect(screenW*.7, screenH*.3, screenW*.12, screenH*.05)
        backreset.alpha = .8
        backreset:setFillColor(0 , 0, 0)
        local btnreset = widget.newButton{
            default= image_reset,
            over= image_reset,
            width=display.contentWidth/9, height=display.contentHeight/21,
            --onRelease = onbtnreset	-- event listener function
        }
        btnreset.id= "Reset"
        btnreset:setReferencePoint( display.TopLeftReferencePoint )
        btnreset.x = screenW*.7
        btnreset.y = screenH*.3
        groupItem:insert(btnreset)
        groupItem:insert(backreset)
    else
        local btnreset = widget.newButton{
            default= image_reset,
            over= image_reset,
            width=display.contentWidth/9, height=display.contentHeight/21,
            onRelease = onbtnreset	-- event listener function
        }
        btnreset.id= "Reset"
        btnreset:setReferencePoint( display.TopLeftReferencePoint )
        btnreset.x = screenW*.7
        btnreset.y = screenH*.3
        groupItem:insert(btnreset)
    end

    -- ** SELL BUTTON
    local btnsell = widget.newButton{
        default= image_sell,
        over= image_sell,
        width=screenW*.3, height=screenH*.06,
        onRelease = onbtnreset	-- event listener function
    }
    btnsell.id="SELL"
    btnsell:setReferencePoint( display.TopLeftReferencePoint )
    btnsell.x = screenW*.6
    btnsell.y = screenH*.73
    groupItem:insert(btnsell)

    if rowCharac >=  maxCharac  then
        local backchoose = display.newRect(screenW*.6, screenH*.57, screenW*.25, screenH*.05)
        backchoose.alpha = 0.8
        backchoose:setFillColor(0 , 0, 0)


        local btnchoose = widget.newButton{
            default= image_choose,
            over= image_choose,
            width=screenW*.25, height=screenH*.05,
            --onRelease = onbtnreset	-- event listener function
        }
        btnchoose.id= "choose1"
        btnchoose:setReferencePoint( display.TopLeftReferencePoint )
        btnchoose.x = screenW*.6
        btnchoose.y = screenH*.57
        groupItem:insert(btnchoose)
        groupItem:insert(backchoose)
    else
        local btnchoose = widget.newButton{
            default= image_choose,
            over= image_choose,
            width=screenW*.25, height=screenH*.05,
            onRelease = onbtnreset	-- event listener function
        }
        btnchoose.id= "choose1"
        btnchoose:setReferencePoint( display.TopLeftReferencePoint )
        btnchoose.x = screenW*.6
        btnchoose.y = screenH*.57
        groupItem:insert(btnchoose)
    end

end
local function newitem()
    local SysdeviceID
    local data = {}

    -- *** ---- ***
    local maxelement = 5
    local typetxt = native.systemFontBold
    local sizetxt =  18
    local imageName = "img/characterIcon/as_cha_frm00.png"
    local frame0 = "img/characterIcon/as_cha_frm00.png"
    local image_tapteam = "img/background/tapitem_team/as_team_icn_iem01.png"
    local frame = {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }


    user_id = includeFN.USERIDPhone()

    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09


    local useitem_id = {}
    local holditem_id = {}
    local item_name = {}
    local holditem_amount = {}
    local element = {}
    local picture = {}
    local imagePicture = {}
    local FRleader = {}
    local imagefrm = {}
    local excoin = {}
    local ticket = {}

    local LinkItem = "http://133.242.169.252/DYM/item.php"
    local URL =  LinkItem.."?user_id="..user_id
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        local dataTable = json.decode(response)

        rowCharac = dataTable.All
        AllItem = dataTable.AllItem

        local m = 1
        while m <= rowCharac do
            if dataTable.chracter ~= nil then

                useitem_id[m] = dataTable.chracter[m].useitem_id
                holditem_id[m] = dataTable.chracter[m].holditem_id
                item_name[m] = dataTable.chracter[m].item_name
                imagePicture[m] = dataTable.chracter[m].img
                imagefrm[m] = tonumber(dataTable.chracter[m].element)

            else
                -- print("ELSE ELSE dataTable.chracter::"..dataTable.chracter)
                imagePicture[m] = imageName
                imagefrm[m] = frame0

            end

            m = m + 1
        end
    end

    local function selectItem(event)
        --local leaderNo = event.target.id
        local options =
        {
            effect = "fade",
            time = 100,
            params =
            {
                holditem = event.target.id,
                holditem_last = event.target.id,
                user_id = user_id
            }
        }
--        print("phase",event.phase)
--        print("target id",event.target.id)

        if event.phase then
            storyboard.gotoScene( "battle_item", options )
        else

            print("else phase")print("target id",event.target.id)
        end

       -- storyboard.gotoScene( "Itemprofile", options )  --no work

    end

    for i = 1, maxCharac, 1 do
        if i <= rowCharac  then
            picture[i] = display.newImageRect(imagePicture[i],sizeleaderW,sizeleaderH)
            picture[i]:setReferencePoint( display.CenterReferencePoint )
            groupItem:insert(picture[i])
            picture[i].x = i * (display.contentWidth/6)
            picture[i].y = pointY

            FRleader[i] = widget.newButton{
                default = frame[imagefrm[i]],
                over = frame[imagefrm[i]],
                width= sizeleaderW,
                height= sizeleaderH,
                onRelease = selectItem
            }
            FRleader[i].id= useitem_id[i]
            FRleader[i]:setReferencePoint( display.CenterReferencePoint )
            groupItem:insert(FRleader[i])
            FRleader[i].x = i * (display.contentWidth/6)
            FRleader[i].y = pointY
        else
            FRleader[i] = widget.newButton{
                default = frame0,
                over = frame0,
                width= sizeleaderW,
                height= sizeleaderH,
                -- onRelease = selectItem
            }
            FRleader[i].id= i
            FRleader[i]:setReferencePoint( display.CenterReferencePoint )
            groupItem:insert(FRleader[i])
            FRleader[i].x = i * (display.contentWidth/6)
            FRleader[i].y = pointY
        end


    end

    local tap_team = display.newImageRect(image_tapteam,screenW*.78,screenH*.028)
    tap_team:setReferencePoint( display.TopLeftReferencePoint )
    tap_team.x = screenW *.1
    tap_team.y = screenW * .55
    groupItem:insert(tap_team)


   -- return g
end

function scene:createScene( event )

    local sizeFont = 20
    local typeFont = native.systemFontBold

    local image_txtItem = "img/text/Item_Itembox.png"
    local image_text = "img/text/ITEM_SETTING.png"
    local image_background1 = "img/background/background_1.jpg"
    local group = self.view
    local gdisplay = display.newGroup()
    local groupGameLayer = display.newGroup()
    local user_id = includeFN.USERIDPhone()


    local background1 = display.newImageRect(image_background1,display.contentWidth,display.contentHeight)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0


    local titleText = display.newImageRect(image_text,display.contentWidth/3,display.contentHeight/35)--contentWidth contentHeight
    titleText:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    titleText.x = display.contentWidth/2
    titleText.y = display.contentHeight/3.15

    newitem()
    createButton()
    local txtITEM = rowCharac
    local txtITEM_Box = AllItem

    local backcharacter = display.newRect(screenW*.1, screenH*.725, screenW*.8, screenH*.07)
    backcharacter:setReferencePoint(display.TopLeftReferencePoint)
    backcharacter.alpha = 0.8
    backcharacter:setFillColor(130 , 130, 130)

    local txtItem = display.newImageRect(image_txtItem, screenW*.16, screenH*.05)

    txtItem:setReferencePoint(display.TopLeftReferencePoint)
    txtItem.x = screenW*.25
    txtItem.y = screenH*.76

    local textITEM = display.newText(txtITEM, screenW*.45, screenH*.73, typeFont, sizeFont)
    textITEM:setReferencePoint(display.TopLeftReferencePoint)
    textITEM:setTextColor(255, 255, 255)


    local textITEM_Box = display.newText(txtITEM_Box, screenW*.45, screenH*.76, typeFont, sizeFont)
    textITEM_Box:setReferencePoint(display.TopLeftReferencePoint)
    textITEM_Box:setTextColor(255, 255, 255)


    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background1)
    group:insert(groupGameLayer)
    group:insert(backcharacter)
    group:insert(textITEM_Box)
    group:insert(textITEM)
    group:insert(txtItem)

    group:insert(groupItem)
    group:insert(titleText)
    group:insert(gdisplay)

    storyboard.removeAll ()
end
function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()

end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

