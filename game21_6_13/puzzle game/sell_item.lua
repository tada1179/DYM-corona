
-----------------------------------------------------------------------------------------

print("sell_item.lua")

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local alertMSN = require ("alertMassage")
local includeFN = require ("includeFunction")
local http = require("socket.http")
local json = require("json")
-----------------------------------------------------------------------------------------

local user_id
local image_listItem = "img/characterIcon/img/icon_test5001.png"


local screenW, screenH = display.contentWidth, display.contentHeight
local sizeleaderW = screenW*.15
local sizeleaderH = screenH*.1
local maxfram = 5
local frame =
{
    "img/characterIcon/as_cha_frm01.png",
    "img/characterIcon/as_cha_frm02.png",
    "img/characterIcon/as_cha_frm03.png",
    "img/characterIcon/as_cha_frm04.png",
    "img/characterIcon/as_cha_frm05.png"
}

local rowCharac
--------- icon event -------------
local backButton
local gdisplay
local scrollView

local backgroundCaution
local TextMassage
local ButtonSell
local ButtonCancel

local function showGameOver ()
    print("backgroundCaution")
    backgroundCaution.alpha = 0
    ButtonCancel.alpha = 0
    ButtonSell.alpha = 0
    TextMassage.alpha = 0

end
local function onBtnRelease(event)
    local option =
    {
        effect = "slideRight",
        time = 100,
        params = {
            user_id = 1
        }
    }
    if event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "item_setting","crossFade", 100 )

    elseif event.target.id == "discharge" then
        print( "event: "..event.target.id)
        showGameOver ()
        storyboard.gotoScene( "item_setting" ,"crossFade", 100 )

    elseif event.target.id == "cancel" then
        print( "event: "..event.target.id)
        showGameOver()
    end
    --    storyboard.gotoScene( "title_page", "fade", 100 )
    return true	-- indicates successful touch
end

local function createBackButton()
    local image_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        default=image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth * .15
    backButton.y = display.contentHeight - (display.contentHeight *.7)


end

local function scrollViewList()
    local typeFont = native.systemFontBold
    local sizeFont =  18

    local useitem_id = {}
    local holditem_id = {}
    local item_name = {}
    local holditem_amount = {}
    local element = {}
    local picture = {}
    local imagePicture = {}
    local FRleader = {}
    local imagefrm = {}
    local excoin={}
    local ticket={}

    local LinkItem = "http://localhost/DYM/battle_item.php"
    local URL =  LinkItem.."?user_id="..user_id
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        local dataTable = json.decode(response)

        rowCharac = dataTable.All
        --AllItem = dataTable.AllItem

        local m = 1
        while m <= rowCharac do
            if dataTable.chracter ~= nil then

--                useitem_id[m] = dataTable.chracter[m].useitem_id
                holditem_id[m] = dataTable.chracter[m].holditem_id
                item_name[m] = dataTable.chracter[m].item_name
                holditem_amount[m] = tonumber(dataTable.chracter[m].holditem_amount)
                imagePicture[m] = dataTable.chracter[m].img
                imagefrm[m] = tonumber(dataTable.chracter[m].element)
                excoin[m] = tonumber(dataTable.chracter[m].excoin)
                ticket[m] = tonumber(dataTable.chracter[m].ticket)
            end
            m = m+1
        end

    end

    local function onButtonEvent(event)

        local option = {
            effect = "slideRight",
            time = 100,
            params = {
                user_id = user_id,
                holditem_id = holditem_id[event.target.id],
                item_name = item_name[event.target.id],
                img_item = imagePicture[event.target.id],
                amount = holditem_amount[event.target.id],
                element_item = imagefrm[event.target.id],
                coin_item = excoin[event.target.id]

            }
        }
        print(event.phase)

        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
            local scrollBar = self.scrollBar
        elseif event.phase == "moved" then


            print("----///event.y:"..event.y)

            if event.markY ~= event.y and event.markX == event.x then
                print("if mark")
            else
                print("else mark")
            end

            --local dx = math.abs( event.x - event.xStart )
            local dy = math.abs( event.y - event.yStart )
            print("dy",dy)
            -- if finger drags button more than 5 pixels, pass focus to scrollView
            if  dy > 5 then
                scrollView:takeFocus( event )
                --moveScrollBar(dy)
            end

        elseif event.phase == "release" then
            print(event.target.id)
            print( "Button pushed." )
            alertMSN.confrimSellItem(option)

        end

        return true
    end

    scrollView = widget.newScrollView{
        width = display.contentWidth *.6,
        height = display.contentHeight * .45,
        top = display.contentHeight *.37,
        left = display.contentWidth *.33,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true,
        horizontalScrollDisabled = true ,--slide
        verticalScrollDisabled = false ,--up
    }
    local listCharacter = {}
    local characELE = {}
    local frameElE = {}
    local image_Framelist = "img/background/sellBattle_Item/framesell_set.png"
    for i = 1, rowCharac, 1 do
        listCharacter[i] = widget.newButton{
            default= image_Framelist,
            width=display.contentWidth * .75 ,
            height= sizeleaderH ,
            top = (i*screenH*.11)-(screenH*.11),
            left = (display.contentWidth*.8) - display.contentWidth ,
            onEvent = onButtonEvent	-- event listener function
        }listCharacter[i].id = i

        frameElE[i] = widget.newButton{
            default=  frame[imagefrm[i]],
            width=sizeleaderW ,
            height=sizeleaderH,
            top = (i*screenH*.11)-(screenH*.11),
            left = (display.contentWidth*.8) - display.contentWidth ,
            onEvent = onButtonEvent	-- event listener function
        }frameElE[i].id = i

        characELE[i] = display.newImageRect( imagePicture[i],sizeleaderW,sizeleaderH )
        characELE[i] :setReferencePoint( display.CenterReferencePoint )
        characELE[i].x =  (screenW*.875) - screenW
        characELE[i].y =  (i*screenH*.11)-(screenH*.06)

        local NameItem = display.newText(item_name[i], screenW*.7, screenH*.5, typeFont, sizeFont)
        NameItem:setTextColor(255, 255, 255)
        NameItem.text =  string.format(item_name[i])
        NameItem.x = screenW*.1
        NameItem.y = (i*screenH*.11)-(screenH*.098)

        local amountItem = display.newText(holditem_amount[i], screenW*.7, screenH*.5, typeFont, sizeFont)
        amountItem:setTextColor(255, 255, 255)
        amountItem.text =  string.format(holditem_amount[i])
        amountItem.x = screenW*.45
        amountItem.y =(i*screenH*.11)-(screenH*.098)



        scrollView:insert(amountItem)
        scrollView:insert(NameItem)
        scrollView:insert(listCharacter[i])
        scrollView:insert(characELE[i])
        scrollView:insert(frameElE[i])
    end

end


function onTouchGameOverScreen ( self, event )
    if event.phase == "began" then

        display.getCurrentStage():setFocus( self )
        self.isFocus = true

    elseif self.isFocus then
        if event.phase == "moved" then

            print( "moved phase" )

        elseif event.phase == "ended" or event.phase == "cancelled" then

            display.getCurrentStage():setFocus( nil )
            self.isFocus = false
        end
    end
    return true
end

function scene:createScene( event )
    local image_txtbattle = "img/text/SELL_ITEM.png"
    local image_txttype = "img/text/TYPE.png"
    local image_background = "img/background/background_1.jpg"
    local group = self.view
    gdisplay = display.newGroup()
    local param = event.params
    if param then
        user_id =  param. user_id
    else
        user_id = includeFN.USERIDPhone()
    end


    local background = display.newImageRect( image_background, display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local titleText = display.newImageRect( image_txtbattle, display.contentWidth*.25, display.contentHeight/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth *.5
    titleText.y = display.contentHeight /3.1

    local titleTexttype = display.newImageRect( image_txttype, display.contentWidth*.1, display.contentHeight*.02 )
    titleTexttype:setReferencePoint( display.CenterReferencePoint )
    titleTexttype.x = display.contentWidth *.8
    titleTexttype.y = display.contentHeight /3.1

    scrollViewList()
    createBackButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background)


    group:insert(scrollView)
    group:insert(titleText)
    group:insert(titleTexttype)
    group:insert(backButton)
    group:insert(gdisplay)

    storyboard.removeScene( "battle_item" )
    storyboard.removeScene( "unit_main" )
    storyboard.removeScene( "character_scene" )
    storyboard.removeScene( "characterprofile" )
    storyboard.removeScene( "team_item" )

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


