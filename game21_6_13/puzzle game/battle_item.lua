--#item1,..item5.lua
-----------------------------------------------------------------------------------------
print("battle_item.lua")

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
local includeFUN = require("includeFunction")
-----------------------------------------------------------------------------------------

local image_listItem = "img/characterIcon/img/icon_test5001.png"


local screenW, screenH = display.contentWidth, display.contentHeight
local sizeleaderW = screenW*.128
local sizeleaderH = screenH*.08


--------- icon event -------------
local backButton
local scrollView
local user_id
local rowCharac
local holditem
local holditem_last

local function onBtnRelease(event)
    local option =
    {
        effect = "fade",
        time = 100,
        params = {
            user_id = user_id
        }
    }
    if event.target.id == "back" then -- back button
        storyboard.gotoScene(previous_scene_name,option )

    else
        print("5555 holditem",holditem)
        if holditem == "choose" then
            local linkstate = "http://localhost/dym/choosebattle_item.php"
            local response = http.request(linkstate.."?user_id="..user_id.."&chooseitem_id="..event.target.id)
        else
            local linkstate = "http://localhost/dym/update_item.php"
            local response = http.request(linkstate.."?user_id="..user_id.."&chooseitem_id="..holditem_last.."&newitem_id="..event.target.id)
        end
        storyboard.gotoScene( "item_setting" ,option )
    end
    return true
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
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
end

local function scrollViewList()
    local typeFont = native.systemFontBold
    local sizeFont =  18
    local image_Framelist = "img/background/sellBattle_Item/framesell_set.png"
    local maxfram = 5
    local frame =
    {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }
    local function onButtonEvent(event)
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
            onBtnRelease(event)

        end

        return true
    end

    local holditem_id={}
    local item_name={}
    local holditem_amount={}
    local imagePicture={}
    local imagefrm={}
    local excoin={}
    local ticket={}

    local LinkURL = "http://localhost/dym/battle_item.php"
    local response = http.request(LinkURL.."?user_id="..user_id.."&holditem="..holditem)
    if response == nil then
        print("No Dice")
    else
        local dataTable = json.decode(response)
        rowCharac = dataTable.All
        local m = 1
        while m <= rowCharac do
            if dataTable.chracter ~= nil then

                holditem_id[m] = dataTable.chracter[m].holditem_id
                item_name[m] = dataTable.chracter[m].item_name
                holditem_amount[m] = dataTable.chracter[m].holditem_amount
                imagePicture[m] = dataTable.chracter[m].img
                imagefrm[m] = tonumber(dataTable.chracter[m].element)
                excoin[m] = tonumber(dataTable.chracter[m].excoin)
                ticket[m] = tonumber(dataTable.chracter[m].ticket)
            end
            m = m + 1
        end
    end



    scrollView = widget.newScrollView{
        width = screenW *.6,
        height = screenH * .45,
        top = screenH *.39,
        left = screenW *.35,
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
    local NameItem = {}
    local CountItem = {}

    for i = 1, rowCharac, 1 do
        listCharacter[i] = widget.newButton{
            default= image_Framelist,
            width=display.contentWidth * .7 ,
            height=(display.contentHeight *.08),
            top = (i*screenH*.085)-(screenH*.085),
            left = (display.contentWidth*.8) - display.contentWidth ,
            onEvent = onButtonEvent	-- event listener function
        }listCharacter[i].id = holditem_id[i]

        frameElE[i] = widget.newButton{
            default=  frame[imagefrm[i]],
            width=sizeleaderW ,
            height=sizeleaderH,
            top = (i*screenH*.085)-(screenH*.085),
            left = (display.contentWidth*.8) - display.contentWidth ,
            onEvent = onButtonEvent	-- event listener function
        }frameElE[i].id = holditem_id[i]

        characELE[i] = display.newImageRect( imagePicture[i],sizeleaderW,sizeleaderH )
        characELE[i] :setReferencePoint( display.CenterReferencePoint )
        characELE[i].x = (screenW*.864) - screenW
        characELE[i].y =  (i*screenH*.085)-(screenH*.045)

        local NameItem = display.newText(item_name[i], screenW*.7, screenH*.5, typeFont, sizeFont)
        NameItem:setTextColor(255, 255, 255)
        NameItem.text =  string.format(item_name[i])
        NameItem.x = screenW*.03
        NameItem.y = (i*screenH*.085)-(screenH*.075)

        local CountItem = display.newText(holditem_amount[i], screenW*.7, screenH*.5, typeFont, sizeFont)
        CountItem:setTextColor(255, 255, 255)
        CountItem.text =  string.format(holditem_amount[i])
        CountItem.x = screenW*.4
        CountItem.y = (i*screenH*.085)-(screenH*.075)



        scrollView:insert(CountItem)
        scrollView:insert(NameItem)
        scrollView:insert(listCharacter[i])
        scrollView:insert(characELE[i])
        scrollView:insert(frameElE[i])

    end

end

function scene:createScene( event )
    local image_background = "img/background/background_1.jpg"
    local image_txtbattle = "img/text/BATTLE_ITEM.png"
    print("--- battle_item ---")
    local group = self.view
    local gdisplay = display.newGroup()
    user_id = includeFUN.USERIDPhone()
    local params = event.params
    if params then
        holditem = params.holditem
        holditem_last = params.holditem_last
        print("include holditem",holditem,holditem_last)
    end


    local background = display.newImageRect( image_background, display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local titleText = display.newImageRect( image_txtbattle, display.contentWidth*.3, display.contentHeight/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    scrollViewList()
    createBackButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)




    group:insert(background)

    group:insert(scrollView)
    group:insert(backButton)
    group:insert(titleText)
    group:insert(gdisplay)

    ------------- other scene ---------------
    storyboard.removeScene( "sell_item" )
    storyboard.removeScene( "item_setting" )
    storyboard.removeScene( "map" )
    storyboard.removeScene( "unit_main" )
    storyboard.removeScene( "gacha_main" )
    storyboard.removeScene( "item_setting" )
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


