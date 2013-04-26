print("gacha.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local json = require("json")
local widget = require "widget"
local topBoundary = display.screenOriginY
local bottomBoundary = display.screenOriginY
local scrollHight = 0
local scrollBar
local scrollBar_line
local scrollView
local backButton
local backBtn


local btnBattle
local btnTeam
local btnGacha
local btnShop
local btnCommu

local data = {}
local http = require("socket.http")
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
        storyboard.gotoScene( "gacha_main", "fade", 100 )
    elseif  event.target.id == "commu" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "commu_main", "fade", 100 )


    elseif event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "map" ,"fade", 100 )
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
    scrollView = widget.newScrollView{
        width = display.contentWidth *.7,
        height = display.contentHeight * .45,
        top = display.contentHeight *.35,
        left = display.contentWidth *.15,
        scrollWidth = 2000,
        bottom = 0,
        scrollHeight = scrollHight,
        hideBackground = true,
        horizontalScrollDisabled = false,
        verticalScrollDisabled = true,
        hideScrollBar = false ,
        isLocked = false

    }

    for i = 1, 6 , 1 do
        local dataTable
        local URL =  "http://localhost/DYM/stones.php?ticket_id="..i
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

        local myticket_price = {}
        myticket_price[i] = display.newText(data[i].ticket_price, 0, 0, native.systemFontBold, 20)
        myticket_price[i]:setTextColor(0, 200, 0)
        myticket_price[i].x = math.floor(display.contentWidth*0.3)
        myticket_price[i].y = (i*90)-(display.contentHeight/20)

        local imageObject = {}
        imageObject[i] = display.newImageRect(data[i].ticket_img,display.contentWidth *.10 ,display.contentHeight *.07)
        imageObject[i]:setReferencePoint( display.TopLeftReferencePoint  )
        imageObject[i].x = display.contentWidth - display.contentWidth *1
        imageObject[i].y = (i*90)-(display.contentHeight/8) + ((display.contentHeight *.07)/2)

        local BtnImage = {}
        BtnImage[i] = widget.newButton{
            default = "img/background/WOODEN_BOW_LAYOUT_21_22.png",
            over = "img/background/WOODEN_BOW_LAYOUT_21_22.png",
            width=display.contentWidth * .9 , height=(display.contentHeight *.14),
            top = (i*90)-(display.contentHeight/8),
            left = (display.contentWidth*.85) - display.contentWidth ,
            --label = data[i].ticket_price,
            onEvent = onButtonEvent
        }
        BtnImage[i].id = "BtnImage"..i

        scrollHight = scrollHight + (i*90)-(display.contentHeight/8)

        scrollView:insert( myticket_price[i] )
        scrollView:insert( BtnImage[i] )
        scrollView:insert( imageObject[i] )
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

    scrollBar_line = display.newImageRect("img/background/SCROLL_LINE.png",display.contentWidth*0.2,(display.contentHeight / 2) )
    scrollBar_line:setReferencePoint( display.TopLeftReferencePoint  )
    scrollBar_line.x = display.contentWidth - display.contentWidth*.25
    scrollBar_line.y = (display.contentHeight / 3)

    scrollBar = display.newImageRect("img/background/SCROLLER.png",display.contentWidth*0.2,(display.contentHeight *.095) )
    scrollBar:setReferencePoint( display.TopLeftReferencePoint  )
    scrollBar.x = display.contentWidth - display.contentWidth*.24
    scrollBar.y = (display.contentHeight *.39)
    --scrollView:insert(scrollBar)
end


-- event listener for button widget




local function createMENU()
    local sizemenu = display.contentHeight*.1
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

end

local function createBackButton()
    backButton = widget.newButton{
        default="img/background/button/Button_BACK.png",
        over="img/background/button/Button_BACK.png",
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
end

function scene:createScene( event )
    print("scene: createScene")
    local group = self.view
    local background = display.newImageRect("img/background/background_1.png",display.contentWidth,display.contentHeight)
    background:setReferencePoint( display.TopLeftReferencePoint  )
    background.x,background.y = 0 , 0

    local background2 = display.newImageRect("img/background/background_2.png",display.contentWidth,display.contentHeight)
    background2:setReferencePoint( display.TopLeftReferencePoint  )
    background2.x,background2.y = 0 , 0


    local titleText = display.newImageRect( "img/text/MISSION_SELECT.png", display.contentWidth/2.65, display.contentHeight/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    scrollViewList()
    createMENU()
    createBackButton()
    addScrollBar()

    group:insert(background)
    group:insert(scrollBar_line)
    group:insert(scrollBar)
    group:insert(scrollView)
    group:insert(backButton)
    group:insert(titleText)
    group:insert(background2)





    group:insert(btnBattle)
    group:insert(btnCommu)
    group:insert(btnGacha)
    group:insert(btnShop)
    group:insert(btnTeam)

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
