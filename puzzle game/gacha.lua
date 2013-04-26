print("main.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local json = require("json")
local widget = require "widget"
local topBoundary = display.screenOriginY
local bottomBoundary = display.screenOriginY
local scrollHight = 0
local scrollBar
local scrollBar_line


local background_1 = display.newImageRect("img/background/as_bg_main.png",display.contentWidth,display.contentHeight)
background_1:setReferencePoint( display.TopLeftReferencePoint  )
background_1.x,background_1.y = 0 , 0

local data = {}
local http = require("socket.http")
local _pointNextY

local btnBattle
local btnTeam
local btnGacha
local btnShop
local btnCommu
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
        storyboard.gotoScene( "gacha_main", "fade", 100 )
    elseif  event.target.id == "commu" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "commu_main", "fade", 100 )
    end
    --    storyboard.gotoScene( "title_page", "fade", 100 )
    return true	-- indicates successful touch
end

local scroller2 = widget.newScrollView{
    width = display.contentWidth *.7,
    height = display.contentHeight * .45,
    top = display.contentHeight *.35,
    left = display.contentWidth *.15,
    scrollWidth = 0,
    bottom = 0,
    scrollHeight = scrollHight,
    hideBackground = true,
    horizontalScrollDisabled = false ,
    verticalScrollDisabled = true ,
    hideScrollBar = false  ,

}

local function moveScrollBar(dydrag)
    print("moveScrollBar dydrag")
    if scrollBar.y  < scroller2.height then

        scrollBar.y = scrollBar.y + (dydrag*2)
        print("if scrollBar.y:"..scrollBar.y)
    else
        print("else scrollBar.y:"..scrollBar.y)
    end


    print("scroller2.width"..scroller2.width)
    print("scroller2.height"..scroller2.height)
    print("---")
end


local function addScrollBar()

    scrollBar_line = display.newImageRect("img/background/SCROLL_LINE.png",display.contentWidth*0.2,(display.contentHeight / 2) )
    scrollBar_line:setReferencePoint( display.TopLeftReferencePoint  )
    scrollBar_line.x = display.contentWidth - display.contentWidth*.25
    scrollBar_line.y = (display.contentHeight / 3)

    scrollBar = display.newImageRect("img/background/SCROLLER.png",display.contentWidth*0.2,(display.contentHeight *.095) )
    scrollBar:setReferencePoint( display.TopLeftReferencePoint  )
    scrollBar.x = display.contentWidth - display.contentWidth*.24
    scrollBar.y = (display.contentHeight *.39)
    --scroller2:insert(scrollBar)
end


-- event listener for button widget
local function onButtonEvent( event )
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
            scroller2:takeFocus( event )
            moveScrollBar(dy)
        end

    elseif event.phase == "release" then
        print(event.phase)
        print( "Button pushed." )
    end

    return true
end

for i = 1, 6 , 1 do
    local dataTable = {}
    URL =  "http://localhost/DYM/stones.php?ticket_id="..i
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        print("i"..i)
        dataTable = json.decode(response)
        data[i] = "ID:"..dataTable.ticket_id.."amound:"..dataTable.ticket_amound.."price:"..dataTable.ticket_price;
        data[i] = {}
        data[i].ticket_id = dataTable.ticket_id
        data[i].ticket_amound = dataTable.ticket_amound
        data[i].ticket_price = dataTable.ticket_price
        data[i].ticket_img = dataTable.ticket_img
    end

    local myticket_price = display.newText(data[i].ticket_price, 0, 0, native.systemFontBold, 20)
    myticket_price:setTextColor(0, 200, 0)
    myticket_price.x = math.floor(display.contentWidth*0.3)
    myticket_price.y = (i*90)-(display.contentHeight/20)
    scroller2:insert( myticket_price )

    local imageObject = display.newImageRect(data[i].ticket_img,display.contentWidth *.10 ,display.contentHeight *.07)
    imageObject:setReferencePoint( display.TopLeftReferencePoint  )
    imageObject.x = display.contentWidth - display.contentWidth *1
    imageObject.y = (i*90)-(display.contentHeight/8) + ((display.contentHeight *.07)/2)

    local backBtn = widget.newButton{
        default = "img/background/WOODEN_BOW_LAYOUT_21_22.png",
        over = "img/background/WOODEN_BOW_LAYOUT_21_22.png",
        width=display.contentWidth * .9 , height=(display.contentHeight *.14),
        top = (i*90)-(display.contentHeight/8),
        left = (display.contentWidth*.85) - display.contentWidth ,
        --label = data[i].ticket_price,
        onEvent = onButtonEvent
    }

    scrollHight = scrollHight + (i*90)-(display.contentHeight/8)
    scroller2:insert( backBtn )
    scroller2:insert( imageObject )
end

local background2 = display.newImageRect("img/background/as_frame_main_test_1.png",display.contentWidth,display.contentHeight)
background2:setReferencePoint( display.TopLeftReferencePoint  )
background2.x,background2.y = 0 , 0

addScrollBar()
local sizemenu = display.contentHeight*.1
--960*.1 = 96 size image = 96*96


btnBattle = widget.newButton{
    default = "img/menu/battle_dark.png",
    over = "img/menu/battle_light.png",
    width= sizemenu ,
    height= sizemenu,
    onRelease = onBtnRelease
}
btnBattle.id="battle"
btnBattle:setReferencePoint( display.CenterReferencePoint )
btnBattle.x =display.contentWidth-(display.contentWidth*.834)
btnBattle.y =  display.contentHeight-(display.contentHeight*.112)

btnTeam = widget.newButton{
    default="img/menu/team_dark.png",
    over="img/menu/team_light.png",
    width=sizemenu,
    height=sizemenu,
    onRelease = onBtnRelease	-- event listener function
}
btnTeam.id="team"
btnTeam:setReferencePoint( display.CenterReferencePoint )
btnTeam.x = display.contentWidth-(display.contentWidth*.667) -- 0.5 + .167
btnTeam.y = display.contentHeight-(display.contentHeight*.112)

btnShop = widget.newButton{
    default="img/menu/store_dark.png",
    over="img/menu/store_light.png",
    width=sizemenu, height=sizemenu,
    onRelease = onBtnRelease	-- event listener function
}
btnShop.id="shop"
btnShop:setReferencePoint( display.CenterReferencePoint )
btnShop.x = display.contentWidth-(display.contentWidth*.5)-- display center
btnShop.y = display.contentHeight-(display.contentHeight*.112)

btnGacha = widget.newButton{
    default="img/menu/gacha_dark.png",
    over="img/menu/gacha_light.png",
    width=sizemenu, height=sizemenu,
    onRelease = onBtnRelease	-- event listener function
}
btnGacha.id="gacha"
btnGacha:setReferencePoint( display.CenterReferencePoint )
btnGacha.x = display.contentWidth-(display.contentWidth*.333) -- 0.5 - .167
btnGacha.y = display.contentHeight-(display.contentHeight*.112)

btnCommu = widget.newButton{
    default="img/menu/commu_dark.png",
    over="img/menu/commu_light.png",
    width=sizemenu, height=sizemenu,
    onRelease = onBtnRelease	-- event listener function
}
btnCommu.id="commu"
btnCommu:setReferencePoint( display.CenterReferencePoint )
btnCommu.x = display.contentWidth-(display.contentWidth*.166)
btnCommu.y = display.contentHeight-(display.contentHeight*.112)

function scene:createScene( event )
    print("scene: createScene")
    local group = self.view
end

function scene:enterScene( event )
    local group = self.view
    print("scene: enterScene")
end

function scene:exitScene( event )
    local group = self.view
    print("scene: exitScene")
end

function scene:destroyScene( event )
    local group = self.view
    print("scene: destroy")
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
