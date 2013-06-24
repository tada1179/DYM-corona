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


local function onBtnRelease(event)
    -- print("onBtnRelease event id",event.id)
    if event.target.id == "battle" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map", "fade", 100 )
        --storyboard.gotoScene( "game-scene", "fade", 100 ) --game-scene
    elseif  event.target.id == "team" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_main", "fade", 100 )
    elseif  event.target.id == "shop" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_main", "fade", 100 )
    elseif  event.target.id == "gacha" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "gacha", "fade", 100 )
    elseif  event.target.id == "commu" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "commu_main", "fade", 100 )


    elseif event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "shop_money" ,"fade", 100 )
    end
    --    storyboard.gotoScene( "title_page", "fade", 100 )
    return true	-- indicates successful touch
end


local function scrollViewList()
    local function onButtonEvent( event )
        print(event.phase)

        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
            local scrollBar = self.scrollBar
        elseif event.phase == "moved" then
            --local dx = math.abs( event.x - event.xStart )
            local dy = math.abs( event.y - event.yStart )
            print("dy",dy)
            -- if finger drags button more than 5 pixels, pass focus to scrollView
            if  dy > 5 then
                scrollView:takeFocus( event )
                moveScrollBar(dy)
            end

        elseif event.phase == "release" then
            print(event.phase)
            print( "Button pushed." )
        end

        return true
    end

    local maxList = nil
    local URL =  "http://localhost/DYM/stones.php"
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
        height = screenH* .48,
        top = screenH *.35,
        left = screenW *.13,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = scrollHight,
        hideBackground = true,
        horizontalScrollDisabled = false,
        verticalScrollDisabled = true,
        hideScrollBar = false ,
        isLocked = false

    }

    local pointFrmLisY = 0
    local pointIMG = screenH *.005
    local pointTicket = screenH *.015
    for i = 1, maxList , 1 do
        local myticket_price = {}
        myticket_price[i] = display.newText(ticket_price[i], 0, 0, native.systemFontBold, 20)
        myticket_price[i]:setTextColor(0, 200, 0)
        myticket_price[i].x = screenW*.62
        myticket_price[i].y = pointTicket

        local imageObject = {}
        imageObject[i] = display.newImageRect(ticket_img[i],screenW *.10 ,screenH*.07)
        imageObject[i]:setReferencePoint( display.TopLeftReferencePoint  )
        imageObject[i].x = screenW*.015
        imageObject[i].y = pointIMG

        local BtnImage = {}
        BtnImage[i] = widget.newButton{
            default = "img/background/sellBattle_Item/framelist_sell.png",
            width= screenW * .7 , height= screenH *.08,
            top = pointFrmLisY,
            left = 0,
            --label = data[i].ticket_price,
            onEvent = onButtonEvent
        }
        BtnImage[i].id = "BtnImage"..i
        scrollView:insert( myticket_price[i] )
        scrollView:insert( BtnImage[i] )
        scrollView:insert( imageObject[i] )

        pointFrmLisY = pointFrmLisY + (screenH*.09)
        pointIMG = pointIMG + (screenH*.09)
        pointTicket = pointTicket + (screenH*.09)
    end
end

local function moveScrollBar(dydrag)
    print("moveScrollBar dydrag")
    if scrollBar.y  < scrollView.height then

        scrollBar.y = scrollBar.y + (dydrag*2)
        print("if scrollBar.y:"..scrollBar.y)
    else
        print("else scrollBar.y:"..scrollBar.y)
    end


    print("scrollView.width"..scrollView.width)
    print("scrollView.height"..scrollView.height)
    print("---")
end


local function addScrollBar()

    scrollBar_line = display.newImageRect("img/background/SCROLL_LINE.png",screenW *0.2,(screenH / 2) )
    scrollBar_line:setReferencePoint( display.TopLeftReferencePoint  )
    scrollBar_line.x = screenW- screenW*.25
    scrollBar_line.y = screenH / 3

    scrollBar = display.newImageRect("img/background/SCROLLER.png",screenW *0.2,(screenH *.095) )
    scrollBar:setReferencePoint( display.TopLeftReferencePoint  )
    scrollBar.x = screenW- screenW*.24
    scrollBar.y = (screenH*.39)
    --scrollView:insert(scrollBar)
end


local function createBackButton()
    backButton = widget.newButton{
        default="img/background/button/Button_BACK.png",
        over="img/background/button/Button_BACK.png",
        width= screenW/10, height= screenH/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW - (screenW *.845)
    backButton.y = screenH - (screenH*.7)
end

function scene:createScene( event )
    print("scene: createScene")
    local group = self.view
    local gdisplay = display.newGroup()

    local background = display.newImageRect("img/background/background_1.jpg",screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint  )
    background.x,background.y = 0 , 0

    local titleText = display.newImageRect( "img/text/TICKET_SHOP.png", screenW/3.25, screenH/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.1

    scrollViewList()
    createBackButton()
    addScrollBar()


    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)


    group:insert(background)
    group:insert(scrollBar_line)
    group:insert(scrollBar)
    group:insert(scrollView)
    group:insert(backButton)
    group:insert(titleText)
    group:insert(gdisplay)


    ------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "team_main" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha_main" )
    storyboard.removeScene( "commu_main" )
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

