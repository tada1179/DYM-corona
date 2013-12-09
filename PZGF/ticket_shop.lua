--
print("ticket_shop.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local json = require("json")
local widget = require "widget"
local menu_barLight = require ("menu_barLight")

local http = require("socket.http")
-----------------------------------------------
local topBoundary = display.screenOriginY
local bottomBoundary = display.screenOriginY
local scrollHight = 0
local scrollBar
local scrollBar_line
local scrollView
local backButton
local backBtn
local screenW, screenH = display.contentWidth, display.contentHeight

local ticket_img = {}
local ticket_id = {}
local ticket_amound = {}
local ticket_price = {}

local _pointNextY
local gdisplay
local numberTarget = 0

local function onBtnRelease(event)
    local previous_scene_name = storyboard.getPrevious()
    menu_barLight.SEtouchButton()
    if event.target.id == "battle" then
        storyboard.gotoScene( "map", "fade", 100 )
        --storyboard.gotoScene( "game-scene", "fade", 100 ) --game-scene
    elseif  event.target.id == "team" then

        storyboard.gotoScene( "team_main", "fade", 100 )
    elseif  event.target.id == "shop" then

        storyboard.gotoScene( "shop_main", "fade", 100 )
    elseif  event.target.id == "gacha" then

        storyboard.gotoScene( "gacha", "fade", 100 )
    elseif  event.target.id == "commu" then

        storyboard.gotoScene( "commu_main", "fade", 100 )


    elseif event.target.id == "back" then -- back button

        storyboard.gotoScene( previous_scene_name ,"fade", 100 )
    end
    --    storyboard.gotoScene( "title_page", "fade", 100 )
    return true	-- indicates successful touch
end

local function onComplete( event )
    if "clicked" == event.action then
        print(" numberTarget = ", numberTarget)
        local i = event.index
        if 1 == i then --"Buy"
            -- Do nothing; dialog will simply dismiss
        elseif 2 == i then  -- "Cencel"
            system.openURL( "http://www.coronalabs.com" )
        end
    end
end

local function scrollViewList()
    local function onButtonEvent( event )
        numberTarget = 0
        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
            local scrollBar = self.scrollBar

        elseif event.phase == "moved" then
            --local dx = math.abs( event.x - event.xStart )
            local dy = math.abs( event.y - event.yStart )
            -- if finger drags button more than 5 pixels, pass focus to scrollView
            if  dy > 5 then
                scrollView:takeFocus( event )
            end

        elseif event.phase == "ended" then
            
            menu_barLight.SEtouchButton()
            numberTarget = event.target.id
            local alert = native.showAlert( "Confirm You In-App Purchase", "Do you want to buy Gold for $"..ticket_price[numberTarget], { "Buy", "Cencel" }, onComplete )
        end

        return true
    end

    local maxList = nil
    local URL =  "http://133.242.169.252/DYM/stones.php"
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        local dataTable = json.decode(response)
        maxList =  dataTable.ticketALL

        local m = 1
        while m <= maxList do
            ticket_id[m] = dataTable.ticket[m].ticket_id
            ticket_amound[m] = dataTable.ticket[m].ticket_amound
            ticket_price[m] = dataTable.ticket[m].ticket_price
            ticket_img[m] = dataTable.ticket[m].ticket_img
            m = m + 1
        end

    end
    scrollView = widget.newScrollView{
        width = screenW *.75,
        height = screenH* .45,
        top = screenH *.35,
        left = screenW *.13,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = scrollHight,
        hideBackground = true,
        horizontalScrollDisabled = false,
--        verticalScrollDisabled = true,
--        hideScrollBar = false ,
--        isLocked = true

    }

    local pointFrmLisY = 0
    local pointIMG = screenH *.005
    local pointTicket = screenH *.015
    for i = 1, maxList , 1 do
        local myticket_price = {}
        myticket_price[i] = display.newText(ticket_price[i].."$", 0, 0, native.systemFontBold, 20)
        myticket_price[i]:setReferencePoint( display.TopLeftReferencePoint )
        myticket_price[i]:setFillColor(0, 200, 0)
        myticket_price[i].x = screenW*.62
        myticket_price[i].y = pointTicket

        local imageObject = {}
        imageObject[i] = display.newImageRect(ticket_img[i],screenW *.10 ,screenH*.07)
        imageObject[i]:setReferencePoint( display.TopLeftReferencePoint  )
        imageObject[i].x = screenW*.015
        imageObject[i].y = pointIMG

        local BtnImage = {}
        BtnImage[i] = widget.newButton{
            defaultFile = "img/background/sellBattle_Item/framelist_sell.png",
            width= screenW * .7 , height= screenH *.08,
            top = pointFrmLisY,
            left = 0,
            label = ticket_amound[i].." Diamonds",
            labelColor = {
                 default = { 255, 255, 255, 255 },
                 over = { 120, 53, 128, 255 },
            },
            onEvent = onButtonEvent
        }
        BtnImage[i]:setReferencePoint( display.TopLeftReferencePoint )
        BtnImage[i].id = i
        --BtnImage[i]:labelColor(0,200,0)
        scrollView:insert( myticket_price[i] )
        scrollView:insert( BtnImage[i] )
        scrollView:insert( imageObject[i] )

        pointFrmLisY = pointFrmLisY + (screenH*.09)
        pointIMG = pointIMG + (screenH*.09)
        pointTicket = pointTicket + (screenH*.09)
    end
end

function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()

    local titleText = display.newImageRect( "img/text/TICKET_SHOP.png", screenW/3.25, screenH/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.1

    backButton = widget.newButton{
        defaultFile="img/background/button/Button_BACK.png",
        overFile="img/background/button/Button_BACK.png",
        width= screenW/10, height= screenH/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW - (screenW *.845)
    backButton.y = screenH - (screenH*.7)

    scrollViewList()
    gdisplay:insert(menu_barLight.newMenubutton())


    gdisplay:insert(background)
    gdisplay:insert(scrollView)
    gdisplay:insert(backButton)
    gdisplay:insert(titleText)
    group:insert(gdisplay)


    ------------- other scene ---------------
    storyboard.removeAll ()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene("map")
    storyboard.purgeAll()
    storyboard.removeAll ()
end

function scene:exitScene( event )
    local group = self.view
    storyboard.purgeAll()
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

