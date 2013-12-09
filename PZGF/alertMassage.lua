
module(..., package.seeall)
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()
local widget = require "widget"
local http = require("socket.http")
local json = require("json")
local util = require("util")
local menu_barLight = require("menu_barLight")

local screenW = display.contentWidth
local screenH = display.contentHeight

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local sizetext = FontAndSize.fontGuest
local sizetextName = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead

-----------------------------------------------
function diamondFail(namepage,params)
    menu_barLight.SEAlertMSN()
    local groupView = display.newGroup()
    local sizetextName = sizetextName
    local back_while
    local myRectangle
    local btn_cancel
    local SmachText
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local function onTouchdiamondFail ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        menu_barLight.SEtouchButton()
        groupView.alpha   = 0
        display.remove(groupView)
        groupView = nil
        if event.target.id == "cancel" then

           -- storyboard.gotoScene( namepage,params )

        end
        return true
    end
    back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth = 3
    back_while.alpha = .5
    back_while:setStrokeColor(255,255,255)
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 3
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    SmachText = display.newText("You don't have diamond!! ", screenW*.3, screenH *.45,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    --button cancel profile
    btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.5
    btn_cancel.y = screenH*.55
    groupView:insert(btn_cancel)
    groupView.touch = onTouchdiamondFail
    groupView:addEventListener( "touch", groupView )

    return groupView
end
function staminaFull(namepage)
    menu_barLight.SEAlertMSN()
    local groupView = display.newGroup()
    local sizetextName = sizetextName
    local back_while
    local myRectangle
    local btn_cancel
    local SmachText
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local function onTouchstaminaFull ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        menu_barLight.SEtouchButton()
        groupView.alpha   = 0

        for i= groupView.numChildren,1,-1 do
            local child = groupView[i]
            child.parent:remove( child )
            child = nil
        end

        display.remove(groupView)
        groupView = nil
        if event.target.id == "cancel" then

            storyboard.gotoScene( namepage )

        end
        return true
    end
    back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth = 3
    back_while.alpha = .5
    back_while:setStrokeColor(255,255,255)
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 3
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    SmachText = display.newText("Stamina is full!! ", screenW*.35, screenH *.45,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    --button cancel profile
    btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.5
    btn_cancel.y = screenH*.55
    groupView:insert(btn_cancel)
    groupView.touch = onTouchstaminaFull
    groupView:addEventListener( "touch", groupView )

    menu_barLight.checkMemory()
    return groupView
end
function addSlot(params)
    menu_barLight.SEAlertMSN()
    local USERID = params.user_id
    local namepage = params.namepage
    if namepage == nil then
        namepage = "unit_box"
    end

    local sizetextName = 20
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"

    local groupView = display.newGroup()
    local myRectangle_S
    local back_while_S
    local imgslot_S
    local text_S
    local SmachText_S
    local btn_cancel_S

    local back_while
    local myRectangle
    local imgstamina
    local SmachText
    local btn_cancelT
    local btn_OK
    ---------------------------------------
    local function onTouchaddSlot ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function showSlot(namepage)
        local groupView = display.newGroup()
        local sizetextName = 20

        local function onBtncharacter_show(event)
            menu_barLight.SEtouchButton()
            display.remove(myRectangle_S)
            myRectangle_S = nil
            display.remove(back_while_S)
            back_while_S = nil
            display.remove(imgslot_S)
            imgslot_S = nil
            display.remove(text_S)
            text_S = nil
            display.remove(SmachText_S)
            SmachText_S = nil
            display.remove(btn_cancel_S)
            btn_cancel_S = nil

            for i= groupView.numChildren,1,-1 do
                local child = groupView[i]
                child.parent:remove( child )
                child = nil
            end
            groupView.alpha = 0
            display.remove(groupView)
            groupView = nil

            if event.target.id == "OK" then

                storyboard.gotoScene( "pageWith" )
                storyboard.removeScene( namepage )
                storyboard.gotoScene( namepage )
                storyboard.removeScene( "pageWith" )

            end
            return true
        end
        myRectangle_S = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle_S:setReferencePoint(display.TopLeftReferencePoint)
        myRectangle_S.strokeWidth = 0
        myRectangle_S:setStrokeColor(255,255,255)
        myRectangle_S.alpha = .8
        myRectangle_S:setFillColor(0, 0, 0)
        groupView:insert(myRectangle_S)

        local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
        back_while_S  = display.newImageRect( image_Caution, screenW*.98,screenH*.5 )
        back_while_S:setReferencePoint( display.CenterReferencePoint )
        back_while_S.x = screenW *.5
        back_while_S.y = screenH*.5
        back_while_S.alpha = .9
        groupView:insert(back_while_S)

        local imgslot_img = "img/background/shop/slot.png"
        imgslot_S  = display.newImageRect( imgslot_img, screenW*.15,screenH*.1 )
        imgslot_S:setReferencePoint( display.CenterReferencePoint )
        imgslot_S.x = screenW *.2
        imgslot_S.y = screenH*.45
        imgslot_S.alpha = .9
        groupView:insert(imgslot_S)

        local numAll= menu_barLight.slot()
        text_S = display.newText("Extend Inventory", screenW*.32, screenH *.4,typeFont, 27)
        text_S:setReferencePoint(display.TopLeftReferencePoint)
        SmachText_S = util.wrappedText("Extended 5 slots in your inventory\nYou can keep "..numAll.." cards now", screenW*.3, sizetextName,typeFont, {255, 255, 255})
        SmachText_S.x = screenW*.32
        SmachText_S.y = screenH*.45
        groupView:insert(SmachText_S)
        groupView:insert(text_S)

        --button cancel profile
        btn_cancel_S = widget.newButton{
            defaultFile=image_ok,
            overFile=image_ok,
            width=screenW*.2, height=screenH*.05,
            onRelease = onBtncharacter_show	-- event listener function
        }
        btn_cancel_S.id="OK"
        btn_cancel_S:setReferencePoint( display.CenterReferencePoint )
        btn_cancel_S.x =screenW *.5
        btn_cancel_S.y = screenH*.6
        groupView:insert(btn_cancel_S)

        groupView.touch = onTouchaddSlot
        groupView:addEventListener( "touch", groupView )
        menu_barLight.checkMemory()
        return groupView
    end

    local function onBtncharacter(event)
        menu_barLight.SEtouchButton()
        display.remove(back_while)
        back_while = nil
        display.remove(myRectangle)
        myRectangle = nil
        display.remove(imgstamina)
        imgstamina = nil
        display.remove(SmachText)
        SmachText = nil
        display.remove(btn_cancelT)
        btn_cancelT = nil
        display.remove(btn_OK)
        btn_OK = nil

        for i= groupView.numChildren,1,-1 do
            local child = groupView[i]
            child.parent:remove( child )
            child = nil
            groupView[i] = nil
        end
        display.remove(groupView)
        groupView = nil

        if event.target.id == "ok" then
            local numdiamond = tonumber(menu_barLight.diamond())

            if  numdiamond > 0 then
                local ulrResetsert = "http://133.242.169.252/DYM/addSlot.php"
                local characResetsert =  ulrResetsert.."?user_id="..USERID
                local complte = http.request(characResetsert)
                local newDatas = json.decode(complte)

                local path = system.pathForFile("datas.db", system.DocumentsDirectory)
                db = sqlite3.open( path )
                local tablefill ="UPDATE user SET 	user_deck = '"..newDatas.slot.."', user_diamond = '"..newDatas.Coin.."' WHERE user_id = '"..USERID.."';"
                db:exec( tablefill )
                db:close()
                require("menu").update_user()
--                require("menu").slot()
--                require("menu").diamond()
                showSlot(namepage)
            else
                diamondFail(namepage)
            end
        elseif event.target.id == "cancel" then

           -- storyboard.gotoScene( namepage  )

        end
    end

    back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth = 3
    back_while.alpha = .5
    back_while:setStrokeColor(255,255,255)
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.14, screenH*.3, screenW*.75, screenH*.35,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 3
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local image_Caution = "img/background/shop/slot.png"
    imgstamina  = display.newImageRect( image_Caution, screenW*.14,screenH*.1 )
    imgstamina:setReferencePoint( display.CenterReferencePoint )
    imgstamina.x = screenW *.5
    imgstamina.y = screenH*.4
    imgstamina.alpha = .9
    groupView:insert(imgstamina)

    SmachText = display.newText("Use 1 diamond to extend 5 slots in lnvontory", screenW*.15, screenH *.48,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    --button cancel profile
    btn_cancelT = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancelT.id="cancel"
    btn_cancelT:setReferencePoint( display.CenterReferencePoint )
    btn_cancelT.x =screenW *.65
    btn_cancelT.y = screenH*.58
    groupView:insert(btn_cancelT)

    --button ok profile
    btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.35
    btn_OK.y = screenH*.58
    groupView:insert(btn_OK)

    groupView.touch = onTouchaddSlot
    groupView:addEventListener( "touch", groupView )
    menu_barLight.checkMemory()
end

function stamina(params)
    menu_barLight.SEAlertMSN()
    local USERID = params.user_id
    local namepage = params.namepage
    if namepage == nil then
        namepage = "unit_box"
    end

    local sizetextName = sizetextName
    local back_while
    local myRectangle
    local btn_cancel
    local btn_OK
    local SmachText
    local imgstamina
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local groupView = display.newGroup()
    local function onTouchstamina ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function showStamina(namepage,params)
        local groupView = display.newGroup()

        local sizetextName = sizetextName
        local back_while_s
        local myRectangle_s
        local btn_cancel_s
        local SmachText_s
        local text_s
        local imgslot_s

        local function onBtncharacter_show(event)
            menu_barLight.SEtouchButton()
            display.remove(back_while_s)
            back_while_s = nil
            display.remove(myRectangle_s)
            myRectangle_s = nil
            display.remove(btn_cancel_s)
            btn_cancel_s = nil
            display.remove(SmachText_s)
            SmachText_s = nil
            display.remove(text_s)
            text_s = nil
            display.remove(imgslot_s)
            imgslot_s = nil

            groupView:removeEventListener( "touch", groupView )
            for i= groupView.numChildren,1,-1 do
                local child = groupView[i]
                child.parent:remove( child )
                child = nil
            end
            groupView.alpha   = 0
            display.remove(groupView)
            groupView = nil

            if event.target.id == "OK" then
               local option={
                   effect = "fade",
                   time = 100,
                   params =
                    {
                        mission_id = params.mission_id,
                        chapter_id = params.chapter_id,
                        map_id = params.map_id,
                        user_id = params.user_id
                    }
               }
                storyboard.gotoScene( "pageWith" )
                storyboard.removeScene( namepage )
                storyboard.gotoScene( namepage ,option)
                storyboard.removeScene( "pageWith" )

            end
            return true
        end
        myRectangle_s = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle_s:setReferencePoint(display.TopLeftReferencePoint)
        myRectangle_s.strokeWidth = 0
        myRectangle_s:setStrokeColor(255,255,255)
        myRectangle_s.alpha = .8
        myRectangle_s:setFillColor(0, 0, 0)
        groupView:insert(myRectangle_s)

        local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
        back_while_s  = display.newImageRect( image_Caution, screenW*.98,screenH*.5 )
        back_while_s:setReferencePoint( display.CenterReferencePoint )
        back_while_s.x = screenW *.5
        back_while_s.y = screenH*.5
        back_while_s.alpha = .9
        groupView:insert(back_while_s)

        local imgslot_img = "img/background/shop/stamina_heart.png"
        imgslot_s  = display.newImageRect( imgslot_img, screenW*.15,screenH*.1 )
        imgslot_s:setReferencePoint( display.CenterReferencePoint )
        imgslot_s.x = screenW *.2
        imgslot_s.y = screenH*.45
        imgslot_s.alpha = .9
        groupView:insert(imgslot_s)

        local numAll= menu_barLight.stamina()
        text_s = display.newText("Restore Stamina", screenW*.32, screenH *.4,typeFont, 27)
        text_s:setReferencePoint(display.TopLeftReferencePoint)
        SmachText_s = util.wrappedText("Stamina is fully restored.\nYou may continue you journey.", screenW*.3, sizetextName,typeFont, {255, 255, 255})
        SmachText_s.x = screenW*.32
        SmachText_s.y = screenH*.45
        groupView:insert(SmachText_s)
        groupView:insert(text_s)

        --button cancel profile
        btn_cancel_s = widget.newButton{
            defaultFile=image_ok,
            overFile=image_ok,
            width=screenW*.2, height=screenH*.05,
            onRelease = onBtncharacter_show	-- event listener function
        }
        btn_cancel_s.id="OK"
        btn_cancel_s:setReferencePoint( display.CenterReferencePoint )
        btn_cancel_s.x =screenW *.5
        btn_cancel_s.y = screenH*.6
        groupView:insert(btn_cancel_s)

        groupView.touch = onTouchstamina
        groupView:addEventListener( "touch", groupView )

        return groupView
    end

    local function onBtncharacter(event)
        menu_barLight.SEtouchButton()
        display.remove(back_while)
        back_while = nil
        display.remove(myRectangle)
        myRectangle = nil
        display.remove(btn_cancel)
        btn_cancel = nil
        display.remove(btn_OK)
        btn_OK = nil
        display.remove(SmachText)
        SmachText = nil
        display.remove(imgstamina)
        imgstamina = nil


        groupView:removeEventListener( "touch", groupView )
        groupView.alpha = 0
        for i= groupView.numChildren,1,-1 do
            local child = groupView[i]
            child.parent:remove( child )
            child = nil
        end
        display.remove(groupView)
        groupView = nil


        if event.target.id == "ok" then
            local maxStatmina = tonumber(menu_barLight.stamina())
            local numdiamond = tonumber(menu_barLight.diamond())
            if numdiamond > 0 then
                local ulrResetsert = "http://133.242.169.252/DYM/addStamina.php"
                local characResetsert =  ulrResetsert.."?user_id="..USERID.."&maxStatmina="..maxStatmina
                local complte = http.request(characResetsert)
                local newDatas = json.decode(complte)

                local path = system.pathForFile("datas.db", system.DocumentsDirectory)
                db = sqlite3.open( path )
                local tablefill ="UPDATE user SET 	user_power = '"..newDatas.stamina.."', user_diamond = '"..newDatas.Coin.."' WHERE user_id = '"..USERID.."';"
                db:exec( tablefill )
--                require("menu").power_STAMINA()
--                require("menu").diamond()
                require("menu").update_user()
                showStamina(namepage,params)
            else
                diamondFail(namepage,params)
            end

        elseif event.target.id == "cancel" then

          --  storyboard.gotoScene( namepage ,params )

        end
        return true
    end

    back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth = 3
    back_while.alpha = .5
    back_while:setStrokeColor(255,255,255)
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.14, screenH*.3, screenW*.75, screenH*.35,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 3
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local image_Caution = "img/background/shop/stamina_heart.png"
    imgstamina  = display.newImageRect( image_Caution, screenW*.15,screenH*.1 )
    imgstamina:setReferencePoint( display.CenterReferencePoint )
    imgstamina.x = screenW *.5
    imgstamina.y = screenH*.4
    imgstamina.alpha = .9
    groupView:insert(imgstamina)

    SmachText = display.newText("Use 1 diamond to fully restore Stamina", screenW*.2, screenH *.48,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    --button cancel profile
    btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.65
    btn_cancel.y = screenH*.58
    groupView:insert(btn_cancel)

    --button ok profile
    btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.35
    btn_OK.y = screenH*.58
    groupView:insert(btn_OK)

    groupView.touch = onTouchstamina
    groupView:addEventListener( "touch", groupView )

    return groupView
end

function resetCharacter(id,holddteam_no,team_id,USERID,g)
    menu_barLight.SEAlertMSN()
    local sizetextName = sizetextName
    local character_id =  id
    local Cholddteam_no =  holddteam_no
    local Cteam_id =  team_id
    local USER_id =  USERID
    local back_while
    local myRectangle
    local btn_cancel
    local btn_OK
    local SmachText
    local function onTouchresetCharacter( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local options =
    {
        effect = "crossFade",
        time = 100,
        params = {
            character_id =character_id ,
            holddteam_no =  Cholddteam_no,
            team_id =  Cteam_id ,
            user_id = USER_id
        }
    }

    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local groupView = display.newGroup()


    local function onBtncharacter(event)
        menu_barLight.SEtouchButton()
        groupView:removeEventListener( "touch", groupView )
        groupView.alpha = 0
        for i= groupView.numChildren,1,-1 do
            local child = groupView[i]
            child.parent:remove( child )
            child = nil
            groupView[i] = nil
        end
        display.remove(groupView)
        groupView = nil

        if event.target.id == "ok" then
            display.remove(g)
            g = nil
            local ulrResetsert = "http://133.242.169.252/DYM/resetTeam.php"
            local characResetsert =  ulrResetsert.."?team_no="..team_id.."&user_id="..USERID
            local complte = http.request(characResetsert)

            if complte then
                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene( "team_main" )
                storyboard.gotoScene( "team_main",options )
                storyboard.removeScene( "pageWith" )
            end

        elseif event.target.id == "cancel" then
            display.remove(g)
            g = nil
           menu_barLight.checkMemory()
           -- storyboard.gotoScene( "team_main" ,options )

        end
        return true
    end

    back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth = 3
    back_while.alpha = .5
    back_while:setStrokeColor(255,255,255)
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 3
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    SmachText = display.newText("Confirm to Reset your Team?", screenW*.27, screenH *.45,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    --button cancel profile
    btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.65
    btn_cancel.y = screenH*.55
    groupView:insert(btn_cancel)

    --button ok profile
    btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.35
    btn_OK.y = screenH*.55
    groupView:insert(btn_OK)

    groupView.touch = onTouchresetCharacter
    groupView:addEventListener( "touch", groupView )

    menu_barLight.checkMemory()
    return groupView
end

function confrimDischarge(countCHNo,characterAll,numCoin,user_id,domain)
    menu_barLight.SEAlertMSN()
    local previous_scene_name = storyboard.getPrevious()
    local sizetext = 16
    local sizetextName = sizetextName
    local sizeleaderW = display.contentWidth*.135
    local sizeleaderH = display.contentWidth*.135

    local back_while
    local myRectangle
    local btn_cancel
    local btn_OK
    local SmachText
    local options
    local Coin = numCoin
    local domain = domain or nil

    local groupView = display.newGroup()
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local frame = loadFramElement()

    options =
    {
        effect = "crossFade",
        time = 100,
        params = {
            countCHNo =countCHNo ,
            numCoin =  numCoin,
            user_id = user_id
        }
    }
    local function onTouchconfrimDischarge( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        menu_barLight.SEtouchButton()
        local characterChoose = {}
        local LinkDischarge = "http://133.242.169.252/DYM/discharge.php"

        groupView:removeEventListener( "touch", groupView )
        groupView.alpha = 0
        groupView = nil

        local complte

        if event.target.id == "ok" then
            display.remove(groupView)
            groupView = nil

            options =
            {
                effect = "crossFade",
                time = 100,
                params = {
                    countCHNo =0 ,
                    numCoin =  0,
                    user_id = user_id
                }
            }

            local user_coin = menu_barLight.user_coin()
            local mynumCoin = user_coin + numCoin

            local characResetsert =  LinkDischarge.."?user_id="..user_id.."&countCHNo="..countCHNo.."&coin="..mynumCoin
            for i = 1,countCHNo,1 do
                characResetsert = characResetsert.."&character"..i.."="..characterAll[i]
            end
            complte = http.request(characResetsert)
            local newDatas = json.decode(complte)

            if complte then
                local path = system.pathForFile("datas.db", system.DocumentsDirectory)
                db = sqlite3.open( path )
                local tablefill ="UPDATE user SET user_coin = '"..newDatas.Coin.."' WHERE user_id = '"..user_id.."';"
                db:exec( tablefill )
--                menu_barLight.user_coin()
                require("menu").update_user()
                if domain ~= nil then
                    storyboard.gotoScene( "pageWith" )
                    storyboard.removeScene( domain )
                    storyboard.gotoScene( domain )
                    storyboard.removeScene( "pageWith" )
                else
                    storyboard.gotoScene( "pageWith" )
                    storyboard.removeScene( "discharge_main" )
                    storyboard.gotoScene( "discharge_main",options )
                    storyboard.removeScene( "pageWith" )
                end
            end

            return true
        elseif event.target.id == "cancel" then
            if domain ~= nil then
                storyboard.gotoScene( domain )
            else
                storyboard.gotoScene( "discharge_main",options )
            end
            return false
        end
    end
    local characterChoose = {}
    local LinkOneCharac = "http://133.242.169.252/DYM/Onecharacter.php"
    local j = 1

    back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth = 3
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.1, screenH*.35, screenW*.8, screenH*.5,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 3
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local LeaderpointX = screenW *.15
    local LeaderpointX2 = 0
    local LeaderpointY = screenH*.42
    local LeaderpointY2 = screenH*.52

    local LVpointX = screenW*.2
    local LVpointX2 = screenW*.2  - screenW*.14
    local LVpointY = screenH*.47

    local sheetInfo = require("chara_icon")
--    local myImageSheet = graphics.newImageSheet( "img/character/chara_icon.png", sheetInfo:getSheet() )
    local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )
    for i = 1,countCHNo,1 do
        characterChoose[i] = characterAll[i]
        local characterID =  LinkOneCharac.."?character="..characterChoose[i].."&user_id="..user_id
        local characterImg = http.request(characterID)
        local characterSelect
        local character_type
        local character_name
        local character_DEF
        local character_ATK
        local character_HP
        local character_LV
        local FrameCharacter
        local ImageCharacter

        if characterImg == nil then
            print("No Dice")
        else
            characterSelect  = json.decode(characterImg)
            character_type = "smach"
            character_name = characterSelect.chracter[1].charac_name
            character_DEF = characterSelect.chracter[1].charac_def
            character_ATK = characterSelect.chracter[1].charac_atk
            character_HP = characterSelect.chracter[1].charac_hp
            character_LV = characterSelect.chracter[1].charac_lv
            ImageCharacter = characterSelect.chracter[1].charac_img_mini
            FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)

            local framImage = display.newImageRect(frame[FrameCharacter] ,sizeleaderW, sizeleaderH)
            framImage:setReferencePoint( display.TopLeftReferencePoint )
            framImage.x = LeaderpointX
            framImage.y = LeaderpointY

            local characImage = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(ImageCharacter)  ,sizeleaderW, sizeleaderH)
            characImage:setReferencePoint( display.TopLeftReferencePoint )
            characImage.x = LeaderpointX
            characImage.y = LeaderpointY
            groupView:insert(characImage)
            groupView:insert(framImage)

            local textLV = display.newText("Lv."..character_LV, LVpointX,LVpointY,typeFont, sizetext)
            textLV:setReferencePoint(display.TopLeftReferencePoint)
            textLV:setFillColor(255, 255, 255)
            groupView:insert(textLV)

        end

        if i > 4 then
            LeaderpointX2 = LeaderpointX2 + (screenW*.14)
            LeaderpointX = LeaderpointX2

            LeaderpointY = LeaderpointY2
            LVpointX2 =  LVpointX2 + (screenW*.14)
            LVpointX =  LVpointX2

            LVpointY =  screenH*.57
        else
            LeaderpointX = LeaderpointX + (screenW*.14)
            LVpointX =  LVpointX + (screenW*.14)
        end
    end

    SmachText = display.newText("Discharge your Character", screenW*.3, screenH *.38,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    local CoinText = display.newText("Confirm", screenW*.45, screenH *.7,typeFont, sizetextName)
    CoinText.text = string.format("Confirm to Discharge your Character?")
    CoinText:setReferencePoint(display.TopLeftReferencePoint)
    CoinText:setFillColor(255, 255, 255)
    groupView:insert(CoinText)

    local txtSMS = display.newText("Coin : "..Coin, screenW*.16, screenH *.62,typeFont, sizetextName)
    --    txtSMS.text = string.format("Coin :", Coin )
    txtSMS:setReferencePoint(display.TopLeftReferencePoint)
    txtSMS:setFillColor(255, 255, 255)
    groupView:insert(txtSMS)

    --button cancel profile
    btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.65
    btn_cancel.y = screenH*.77
    groupView:insert(btn_cancel)

    --button ok profile
    btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.35
    btn_OK.y = screenH*.77
    groupView:insert(btn_OK)

    groupView.touch = onTouchconfrimDischarge
    groupView:addEventListener( "touch", groupView )



    return groupView
end

function confrimSellItem(option)
    menu_barLight.SEAlertMSN()
    local itemNum = nil
    local gdisplay = display.newGroup()
    local sizeFont =  sizetextName
    local NamesizeFont =  25
    local frame =loadFramElement()
    local image_minus = "img/background/button/as_butt_sell_minus.png"
    local image_plus = "img/background/button/as_butt_sell_plus.png"

    local image_massage = "img/text/CAUTION_ARE_SURE_TO_SELL_THIS_ITEM.png"
    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local image_btnsell= "img/background/button/SELL.png"
    local image_btncancel = "img/background/button/as_butt_discharge_cancel.png"

    local backgroundCaution
    local TextMassage
    local ButtonCancel
    local ButtonSell
    local imgPlus
    local imgiMinus

    local oneItem = option.params
    local user_id = oneItem.user_id
    local img_item = oneItem.img_item
    local item_name = oneItem.item_name
    local holditem_id = oneItem.holditem_id --use item id
    local amount = oneItem.amount
    local element_item = oneItem.element_item
    local coin_item = oneItem.coin_item
    local NumCoin = nil
    local function onTouchconfrimSellItem( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    --**--
    local imgitemsell = display.newImageRect( img_item, screenW*.18,screenH*.13 )
    imgitemsell:setReferencePoint( display.CenterReferencePoint )
    imgitemsell.x = screenW *.3
    imgitemsell.y = screenH*.55
    imgitemsell.alpha = 1

    local frmitemsell = display.newImageRect( frame[element_item], screenW*.18,screenH*.13 )
    frmitemsell:setReferencePoint( display.CenterReferencePoint )
    frmitemsell.x = screenW *.3
    frmitemsell.y = screenH*.55
    frmitemsell.alpha = 1

    local NameItem = display.newText(item_name, screenW*.44, screenH*.49, typeFont, NamesizeFont)
    NameItem:setReferencePoint(display.TopLeftReferencePoint)
    NameItem:setFillColor(218, 165, 32)
    NameItem.text =  string.format(item_name)
    NameItem.alpha = 1

    local CoinItem = display.newText(coin_item, screenW*.29, screenH*.68, typeFont, sizeFont)
    CoinItem:setReferencePoint(display.TopLeftReferencePoint)
    CoinItem:setFillColor(218, 165, 32)
    CoinItem.text =  string.format("COIN : "..coin_item)
    CoinItem.alpha = 1

    local amountItem = display.newText(amount, screenW*.52, screenH*.54, typeFont, sizeFont)
    amountItem:setReferencePoint(display.TopLeftReferencePoint)
    amountItem:setFillColor(255, 255, 255)
    amountItem.text =  string.format("AMOUNT : "..amount)
    amountItem.alpha = 1

    local txtSELL = display.newText("ITEM SELL", screenW*.25, screenH*.632, typeFont, sizeFont)
    txtSELL:setReferencePoint(display.TopLeftReferencePoint)
    txtSELL:setFillColor(255, 255, 255)
    txtSELL.text =  string.format("ITEM SELL : ")
    txtSELL.alpha = 1

    itemNum = 1
    local ItemNumSELL = display.newText(itemNum, screenW*.59, screenH*.625, typeFont, NamesizeFont)
    ItemNumSELL:setReferencePoint(display.TopLeftReferencePoint)
    ItemNumSELL:setFillColor(255, 0, 255)
    ItemNumSELL.text =  string.format(itemNum)
    ItemNumSELL.alpha = 1
    --**--


    local function onbtnPlusItem(event)
        menu_barLight.SEtouchButton()
        if event.target.id == "plus" then
            if itemNum < amount then
                itemNum = itemNum + 1
                NumCoin = coin_item * itemNum
                ItemNumSELL.text =  string.format(itemNum)
                CoinItem.text =  string.format("COIN : "..NumCoin)
            end

        elseif event.target.id == "minus" then
            if itemNum > 1  then
                itemNum = itemNum - 1
                NumCoin = coin_item * itemNum
                ItemNumSELL.text =  string.format(itemNum)
                CoinItem.text =  string.format("COIN : "..NumCoin)
            end
        end

    end

    local function onBtncharacter(event)
        menu_barLight.SEtouchButton()
        backgroundCaution.alpha       = 0
        TextMassage.alpha  = 0
        ButtonCancel.alpha = 0
        ButtonSell.alpha = 0
        imgitemsell.alpha = 0
        frmitemsell.alpha = 0
        CoinItem.alpha = 0
        amountItem.alpha = 0
        txtSELL.alpha = 0
        NameItem.alpha = 0
        imgiMinus.alpha = 0
        imgPlus.alpha = 0
        ItemNumSELL.alpha = 0


        local options =
        {
            effect = "crossFade",
            time = 100,
            params = {
                user_id = user_id
            }
        }

        if event.target.id == "sellItem" then
            local ulrResetsert = "http://133.242.169.252/DYM/sell_item.php"
            local characResetsert =  ulrResetsert.."?holditem="..holditem_id.."&user_id="..user_id.."&numDeleteItem="..itemNum
            local complte = http.request(characResetsert)

            if complte then
                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene(  "sell_item" )
                storyboard.removeScene(  "item_setting" )
                storyboard.gotoScene(  "sell_item",options )
                storyboard.removeScene( "pageWith" )
            end

        elseif event.target.id == "cancel" then

            storyboard.gotoScene( "sell_item" ,options )

        end
    end
    backgroundCaution = display.newImageRect( image_Caution, screenW*.95,screenH*.7 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = screenW *.5
    backgroundCaution.y = screenH*.55
    backgroundCaution.alpha = .9

    TextMassage =  display.newImageRect( image_massage, screenW*.35,screenH*.13 )
    TextMassage:setReferencePoint( display.CenterReferencePoint )
    TextMassage.x = screenW *.5
    TextMassage.y = screenH*.4
    TextMassage.alpha = 1

    -- -- -- -- -  -- --
    imgPlus = widget.newButton{
        defaultFile= image_plus,
        overFile=  image_plus,
        width= screenW*.06, height= screenH*.04,
        onRelease = onbtnPlusItem	-- event listener function
    }
    imgPlus.id="plus"
    imgPlus:setReferencePoint( display.TopLeftReferencePoint )
    imgPlus.x = screenW * .68
    imgPlus.y = screenH *.625
    imgPlus.alpha = 1

    imgiMinus = widget.newButton{
        defaultFile= image_minus,
        overFile=  image_minus,
        width= screenW*.06, height= screenH*.04,
        onRelease = onbtnPlusItem	-- event listener function
    }
    imgiMinus.id="minus"
    imgiMinus:setReferencePoint( display.TopLeftReferencePoint )
    imgiMinus.x = screenW * .48
    imgiMinus.y = screenH *.625
    imgiMinus.alpha = 1



    -- ******** - -
    ButtonSell = widget.newButton{
        defaultFile= image_btnsell,
        overFile=  image_btnsell,
        width= screenW*.26, height= screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    ButtonSell.id="sellItem"
    ButtonSell:setReferencePoint( display.TopLeftReferencePoint )
    ButtonSell.x = screenW * .2
    ButtonSell.y = screenH *.75
    ButtonSell.alpha = 1

    -- ******** - -
    ButtonCancel = widget.newButton{
        defaultFile= image_btncancel,
        overFile=  image_btncancel,
        width= screenW*.24, height= screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    ButtonCancel.id="cancel"
    ButtonCancel:setReferencePoint( display.TopLeftReferencePoint )
    ButtonCancel.x = screenW * .55
    ButtonCancel.y = screenH *.75
    ButtonCancel.alpha = 1
    ---------------------------------------------

    gdisplay:insert(backgroundCaution)
    gdisplay:insert(ButtonSell)
    gdisplay:insert(ButtonCancel)
    gdisplay:insert(TextMassage)

    gdisplay:insert(ItemNumSELL)
    gdisplay:insert(imgiMinus)
    gdisplay:insert(imgPlus)
    gdisplay:insert(NameItem)
    gdisplay:insert(imgitemsell)
    gdisplay:insert(frmitemsell)
    gdisplay:insert(CoinItem)
    gdisplay:insert(amountItem)
    gdisplay:insert(txtSELL)

    gdisplay.touch = onTouchconfrimSellItem
    gdisplay:addEventListener( "touch", gdisplay )
end

function resetItem(user_id)
    menu_barLight.SEAlertMSN()
    local sizetextName = sizetextName
    local user_id =  user_id
    local back_while
    local myRectangle
    local btn_cancel
    local btn_OK
    local SmachText

    local options =
    {
        effect = "crossFade",
        time = 100,
        params = {
            user_id = user_id
        }
    }

    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local groupView = display.newGroup()
    local function onTouchresetItem( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end

    local function onBtncharacter(event)
        btn_cancel.alpha   = 0
        btn_OK.alpha       = 0
        myRectangle.alpha  = 0
        SmachText.alpha = 0
        back_while.alpha = 0
        menu_barLight.SEtouchButton()
        if event.target.id == "ok" then
            local ulrResetsert = "http://133.242.169.252/DYM/reset_item.php"
            local characResetsert =  ulrResetsert.."?user_id="..user_id
            local complte = http.request(characResetsert)

            if complte then
                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene( "item_setting" )
                storyboard.gotoScene( "item_setting",options )
                storyboard.removeScene( "pageWith" )
            end

        elseif event.target.id == "cancel" then

            storyboard.gotoScene( "item_setting" ,options )

        end
    end

    back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth = 3
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 3
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    SmachText = display.newText("Confirm to Reset your Item?", screenW*.27, screenH *.45,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    --button cancel profile
    btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.65
    btn_cancel.y = screenH*.55
    groupView:insert(btn_cancel)

    --button ok profile
    btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.35
    btn_OK.y = screenH*.55
    groupView:insert(btn_OK)



    groupView.touch = onTouchresetItem
    groupView:addEventListener( "touch", groupView )

    return groupView
end

function accepFriend(option)
    menu_barLight.SEAlertMSN()
    local groupView = display.newGroup()
    local itemNum = nil
    local sizeFont =  20
    local NamesizeFont =  25
    local frame =loadFramElement()

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local image_btnACCEPT= "img/background/button/ACCEPT.png"
    local image_btnIGNORE= "img/background/button/IGNORE.png"
    local image_btncancel = "img/background/button/as_butt_discharge_cancel.png"

    local onefriend = option.params

    local user_id = onefriend.user_id
    local charac_id = onefriend.charac_id
    local friend_id = onefriend.friend_id
    local friend_name = onefriend.friend_name
    local charac_img = onefriend.charac_img
    local dateModify = onefriend.dateModify
    local element = onefriend.element
    local charac_lv = onefriend.charac_lv
    local friend_lv = onefriend.friend_lv
    local function onTouchaccepFriend( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        menu_barLight.SEtouchButton()
        groupView:removeEventListener( "touch", groupView )
       display.remove(groupView)
       groupView = nil

        local options =
        {
            effect = "crossFade",
            time = 100,
            params = {
                user_id = user_id
            }
        }


        local ulrResetsert = "http://133.242.169.252/DYM/accepFriend.php"

        if event.target.id == "ACCEPT" then

            local characResetsert =  ulrResetsert.."?user_id="..user_id.."&friend="..friend_id.."&respont=1"
            local numberHold = http.request(characResetsert)
            local allRow  = json.decode(numberHold)
            if allRow then
                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene(  "request_list" )
                storyboard.gotoScene(  "request_list",options )
                storyboard.removeScene( "pageWith" )
            end
        elseif event.target.id == "IGNORE" then

            local characResetsert =  ulrResetsert.."?user_id="..user_id.."&friend="..friend_id.."&respont=2"
            local complte = http.request(characResetsert)

            if complte then
                storyboard.gotoScene( "pageWith",options )
                storyboard.removeScene(  "request_list" )
                storyboard.gotoScene(  "request_list",options )
                storyboard.removeScene( "pageWith" )
            end

        elseif event.target.id == "cancel" then

            --storyboard.gotoScene( "request_list" ,options )

        end
    end


    local NumCoin = nil
    --**--
    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    local backgroundCaution = display.newImageRect( image_Caution, screenW*.95,screenH*.6 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = screenW *.5
    backgroundCaution.y = screenH*.5
    backgroundCaution.alpha = .9
    groupView:insert(backgroundCaution)

    local textMSN = "You want to respond to a friend."
    local TextMassage = display.newText(textMSN, screenW*.18, screenH*.4, typeFont, NamesizeFont)
    TextMassage:setReferencePoint(display.TopLeftReferencePoint)
    TextMassage:setFillColor(255, 255, 255)
    TextMassage.text =  string.format(textMSN)
    TextMassage.alpha = 1
    groupView:insert(TextMassage)

    local imgFriend = display.newImageRect( charac_img, screenW*.18,screenH*.13 )
    imgFriend:setReferencePoint( display.CenterReferencePoint )
    imgFriend.x = screenW *.3
    imgFriend.y = screenH*.55
    imgFriend.alpha = 1
    groupView:insert(imgFriend)

    local frmFriend = display.newImageRect( frame[element], screenW*.18,screenH*.13 )
    frmFriend:setReferencePoint( display.CenterReferencePoint )
    frmFriend.x = screenW *.3
    frmFriend.y = screenH*.55
    frmFriend.alpha = 1
    groupView:insert(frmFriend)

    local LVCharacter = display.newText(charac_lv, screenW*.7, screenH*.49, typeFont, NamesizeFont)
    LVCharacter:setReferencePoint(display.TopLeftReferencePoint)
    LVCharacter:setFillColor(200, 200, 200)
    LVCharacter.text =  string.format("Lv."..charac_lv)
    LVCharacter.alpha = 1
    groupView:insert(LVCharacter)

    local NameFriend = display.newText(friend_name, screenW*.44, screenH*.49, typeFont, NamesizeFont)
    NameFriend:setReferencePoint(display.TopLeftReferencePoint)
    NameFriend:setFillColor(218, 165, 32)
    NameFriend.text =  string.format(friend_name)
    NameFriend.alpha = 1
    groupView:insert(NameFriend)

    local LVFriend = display.newText(friend_lv, screenW*.29, screenH*.6, typeFont, sizeFont)
    LVFriend:setReferencePoint(display.TopLeftReferencePoint)
    LVFriend:setFillColor(200, 0, 200)
    LVFriend.text =  string.format("Lv."..friend_lv)
    LVFriend.alpha = 1
    groupView:insert(LVFriend)

    local dateTime = display.newText(dateModify, screenW*.45, screenH*.55, typeFont, sizeFont)
    dateTime:setReferencePoint(display.TopLeftReferencePoint)
    dateTime:setFillColor(200, 100, 200)
    dateTime.text =  string.format(dateModify)
    dateTime.alpha = 1
    groupView:insert(dateTime)

    -- ******** - -
    local ButtonAccep = widget.newButton{
        defaultFile= image_btnACCEPT,
        overFile=  image_btnACCEPT,
        width= screenW*.2, height= screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    ButtonAccep.id="ACCEPT"
    ButtonAccep:setReferencePoint( display.TopLeftReferencePoint )
    ButtonAccep.x = screenW * .15
    ButtonAccep.y = screenH *.65
    ButtonAccep.alpha = 1
    groupView:insert(ButtonAccep)

    -- ******** - -
    local ButtonIgnore = widget.newButton{
        defaultFile= image_btnIGNORE,
        overFile=  image_btnIGNORE,
        width= screenW*.2, height= screenH*.045,
        onRelease = onBtncharacter	-- event listener function
    }
    ButtonIgnore.id="IGNORE"
    ButtonIgnore:setReferencePoint( display.TopLeftReferencePoint )
    ButtonIgnore.x = screenW * .38
    ButtonIgnore.y = screenH *.655
    ButtonIgnore.alpha = 1
    groupView:insert(ButtonIgnore)

    -- ******** - -
    local ButtonCancel = widget.newButton{
        defaultFile= image_btncancel,
        overFile=  image_btncancel,
        width= screenW*.2, height= screenH*.05,
        onRelease = onBtncharacter	-- event listener function
    }
    ButtonCancel.id="cancel"
    ButtonCancel:setReferencePoint( display.TopLeftReferencePoint )
    ButtonCancel.x = screenW * .6
    ButtonCancel.y = screenH *.65
    ButtonCancel.alpha = 1
    groupView:insert(ButtonCancel)
    ---------------------------------------------

    groupView.touch = onTouchaccepFriend
    groupView:addEventListener( "touch", groupView )
    menu_barLight.checkMemory()
end
function Nonetwork(namepage)
    menu_barLight.SEAlertMSN()
    print("previous_scene_name = ",namepage)
    local groupView = display.newGroup()
    local sizetextName = 20
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local function ontouchNoDataInList ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function okNoDataInList(event)
        menu_barLight.SEtouchButton()
        display.remove(groupView)
        groupView = nil
        local noNetwork = 1
        if event.target.id == "okNoDataInList" then
            menu_barLight.SEtouchButton()
            -- storyboard.gotoScene(namepage )
            storyboard.gotoScene( "pageWith")
            storyboard.removeScene( namepage )
            storyboard.gotoScene( namepage,"fade",100 )
            storyboard.removeScene( "pageWith" )
        end
    end

    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    local myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 2
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    local SmachText = display.newText("Can't connect to server!", screenW*.31, screenH *.45,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    --button ok profile
    local btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = okNoDataInList	-- event listener function
    }
    btn_OK.id="okNoDataInList"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.5
    btn_OK.y = screenH*.55
    groupView:insert(btn_OK)

    groupView.touch = ontouchNoDataInList
    groupView:addEventListener( "touch", groupView )
    menu_barLight.checkMemory()

end
function NoDataInList()
    menu_barLight.SEAlertMSN()
    local groupView = display.newGroup()
    local sizetextName = 20
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local function ontouchNoDataInList ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function okNoDataInList(event)
        menu_barLight.SEtouchButton()
       display.remove(groupView)
       groupView = nil

        if event.target.id == "okNoDataInList" then
            menu_barLight.SEtouchButton()
           -- storyboard.gotoScene( "commu_main","fade",100 )
        end
    end

    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    local myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 2
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    local SmachText = display.newText("No Friend Request", screenW*.35, screenH *.45,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    --button ok profile
    local btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = okNoDataInList	-- event listener function
    }
    btn_OK.id="okNoDataInList"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.5
    btn_OK.y = screenH*.55
    groupView:insert(btn_OK)

    groupView.touch = ontouchNoDataInList
    groupView:addEventListener( "touch", groupView )
    menu_barLight.checkMemory()

end
function NohaveCoin()
    menu_barLight.SEAlertMSN()
    local groupView = display.newGroup()
    local sizetextName = 20
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local function ontouchNoDataInList ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function okNoDataInList(event)
        menu_barLight.SEtouchButton()
       display.remove(groupView)
       groupView = nil

        if event.target.id == "okNoDataInList" then
            menu_barLight.SEtouchButton()
           -- storyboard.gotoScene( "commu_main","fade",100 )
        end
    end

    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    local myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 2
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    local SmachText = display.newText("No Have Coin Request!", screenW*.35, screenH *.45,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    --button ok profile
    local btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = okNoDataInList	-- event listener function
    }
    btn_OK.id="okNoDataInList"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.5
    btn_OK.y = screenH*.55
    groupView:insert(btn_OK)

    groupView.touch = ontouchNoDataInList
    groupView:addEventListener( "touch", groupView )
    menu_barLight.checkMemory()

end

function NoFriendPoint()
    menu_barLight.SEAlertMSN()
    local groupView = display.newGroup()
    local sizetextName = 20
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local function ontouchNoDataInList ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function okNoDataInList(event)
        menu_barLight.SEtouchButton()
        display.remove(groupView)
        groupView = nil

        if event.target.id == "okNoDataInList" then
            menu_barLight.SEtouchButton()
            -- storyboard.gotoScene( "commu_main","fade",100 )
        end
    end

    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    local myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 2
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    local SmachText = display.newText("Not enough Friend Points", screenW*.30, screenH *.45,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)

    --button ok profile
    local btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = okNoDataInList	-- event listener function
    }
    btn_OK.id="okNoDataInList"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.5
    btn_OK.y = screenH*.55
    groupView:insert(btn_OK)

    groupView.touch = ontouchNoDataInList
    groupView:addEventListener( "touch", groupView )
    menu_barLight.checkMemory()

end
function NoDiamondPoint()
    menu_barLight.SEAlertMSN()
    local groupView = display.newGroup()
    local sizetextName = 20
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local function ontouchNoDataInList ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function okNoDataInList(event)
        menu_barLight.SEtouchButton()
        display.remove(groupView)
        groupView = nil

        if event.target.id == "OKBuy" then
            menu_barLight.SEtouchButton()
            storyboard.gotoScene( "ticket_shop","fade",100 )
        end
    end

    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    local myRectangle = display.newRoundedRect(screenW*.15, screenH*.35, screenW*.73, screenH*.3,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 2
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)

    local SmachText_T = util.wrappedText("  Not enoungh Golds.Do you \nwant to buy Golds?", screenW*.28, 30,typeFont, {255, 255, 255})
    SmachText_T:setReferencePoint(display.TopLeftReferencePoint)
    SmachText_T.x = screenW*.18
    SmachText_T.y = screenH*.40
    groupView:insert(SmachText_T)

    --button ok profile
    local btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = okNoDataInList	-- event listener function
    }
    btn_OK.id="OKBuy"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.35
    btn_OK.y = screenH*.6
    groupView:insert(btn_OK)

    local btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = okNoDataInList	-- event listener function
    }
    btn_cancel.id="cancelBuy"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.65
    btn_cancel.y = screenH*.6
    groupView:insert(btn_cancel)

end

function NoHaveSlot(page)
    menu_barLight.SEAlertMSN()
    local groupView = display.newGroup()
    local sizetextName = 20
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local function ontouchNoDataInList ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function NoslotInList(event)
        menu_barLight.SEtouchButton()
        display.remove(groupView)
        groupView = nil
        local params = {
               namepage = page,
                user_id = menu_barLight.user_id()
        }
        if event.target.id == "OKBuy" then
            addSlot(params)
        end
    end

    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    back_while.touch = ontouchNoDataInList
    back_while:addEventListener( "touch", back_while )

    groupView:insert(back_while)

    local myRectangle = display.newRoundedRect(screenW*.13, screenH*.35, screenW*.77, screenH*.5,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 2
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.touch = ontouchNoDataInList
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    myRectangle:addEventListener( "touch", myRectangle )
    groupView:insert(myRectangle)

    local all = menu_barLight.characterAll() +1
    local SmachText_1 = display.newText("Inventory limit reached",0 , 0,native.systemFontBold,30)
    SmachText_1:setReferencePoint( display.CenterReferencePoint )
    SmachText_1.x = screenW*.5
    SmachText_1.y = screenH*.40
    SmachText_1:setFillColor(255, 255 ,255)
    groupView:insert(SmachText_1)

    local imgslot = display.newImageRect("img/background/shop/slot.png", screenW*.12, screenH*.08 )
    imgslot:setReferencePoint( display.CenterReferencePoint )
    imgslot.x, imgslot.y = screenW*.5, screenH*.5
    groupView:insert(imgslot)

    local SmachText_num = display.newText(all,0 , 0,native.systemFontBold,55)
    SmachText_num:setReferencePoint( display.CenterReferencePoint )
    SmachText_num.x = screenW*.45
    SmachText_num.y = screenH*.59
    SmachText_num:setFillColor(255, 0 ,139)
    groupView:insert(SmachText_num)

    local SmachText_num2 = display.newText("/"..menu_barLight.slot(),0 , 0,native.systemFontBold,28)
    SmachText_num2:setReferencePoint( display.CenterReferencePoint )
    SmachText_num2.x = SmachText_num.x + 60
    SmachText_num2.y = screenH*.6
    SmachText_num2:setFillColor(255, 255 ,139)
    groupView:insert(SmachText_num2)

    local SmachText_T = util.wrappedText("Inventory limit reached,unable to enter\nanother battle or get new cards.\nUse 1 diamond to extend 5 slots of inventory", screenW*.28, 20,typeFont, {255, 255, 255})
    SmachText_T:setReferencePoint(display.TopLeftReferencePoint)
    SmachText_T.x = screenW*.15
    SmachText_T.y = screenH*.65
    groupView:insert(SmachText_T)

    --button ok profile
    local btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = NoslotInList	-- event listener function
    }
    btn_OK.id="OKBuy"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.35
    btn_OK.y = screenH*.79
    groupView:insert(btn_OK)

    local btn_cancel = widget.newButton{
        defaultFile=image_cancel,
        overFile=image_cancel,
        width=screenW*.2, height=screenH*.05,
        onRelease = NoslotInList	-- event listener function
    }
    btn_cancel.id="cancelBuy"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =screenW *.65
    btn_cancel.y = screenH*.79
    groupView:insert(btn_cancel)

end

function confrimLeaveTicket(option)
    menu_barLight.SEAlertMSN()
    local params = option.params
    local useTicket = params.useTicket
    local NumDiamond = params.NumDiamond
    local NumCoin = params.NumCoin
    local NumEXP = params.NumEXP
    local NumFlag = params.NumFlag
    local user_id = params.user_id
    local getCharac_id = {}
    getCharac_id = params.getCharac_id
    local sizetext = fontsizeHead
    local groupView = display.newGroup()
    local function onTouchconfrimLeaveTicket( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function ButtouRelease (event)
        menu_barLight.SEtouchButton()
        groupView:removeEventListener( "touch", groupView )
        groupView.alpha = 0
        groupView = nil
        if event.target.id == "OK" then
           -- groupView.alpha = 0

            if useTicket == 1 then      -- 1 :Use ,0:No use
                local LinkURL = "http://133.242.169.252/DYM/leaveTicket.php"
                local characResetsert =  LinkURL.."?user_id="..user_id.."&NumFlag="..NumFlag.."&NumDiamond="..NumDiamond.."&NumCoin="..NumCoin.."&NumEXP="..NumEXP

                 for i=1,NumFlag,1 do
                     characResetsert = characResetsert.."$charac"..i.."="..getCharac_id[i]
                 end

                local complte = http.request(characResetsert)
                local newDatas = json.decode(complte)

                local path = system.pathForFile("datas.db", system.DocumentsDirectory)
                db = sqlite3.open( path )
                local tablefill ="UPDATE user SET 	user_exp = '"..newDatas.exp.."' ,user_coin = '"..newDatas.coin.."', user_diamond = '"..newDatas.ticket.."' WHERE user_id = '"..user_id.."';"
                db:exec( tablefill )
                db:close()

                require("menu").update_user()
                require("menu").ShowDisplay()
                storyboard.gotoScene( "map","fade",100 )
            else
                --storyboard.removeScene( "game-scene")
                require("menu").ShowDisplay()
                storyboard.gotoScene( "map","fade",100)
            end

        elseif event.target.id == "cancel" then
            groupView.alpha = 0
        end

    end

    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.alpha = .8
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    --local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local backcolor =  display.newRoundedRect(screenW*.1, screenH*.4, screenW*.8, screenH*.3,7)
    backcolor:setReferencePoint(display.TopLeftReferencePoint)
    backcolor.strokeWidth = 2
    backcolor:setStrokeColor(255,255,255)
    backcolor.alpha = .8
    backcolor:setFillColor(0, 0, 0)
    groupView:insert(backcolor)

    local txtMSN = display.newText("EXP", screenW*.45, screenH*.45, typeFont, sizetext)
    txtMSN:setReferencePoint(display.TopLeftReferencePoint)
    txtMSN:setFillColor(0, 200, 0)
    txtMSN.text =  string.format("Comfrim You Retreat?")
    txtMSN.alpha = 1
    groupView:insert(txtMSN)

    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        defaultFile = img_OK,
        overFile = img_OK,
        width=screenW*.3, height= screenH*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnOK.id = "OK"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.alpha = 1
    btnOK.x = screenW*.3
    btnOK.y = screenH*.63
    groupView:insert(btnOK)

    local img_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local btnucancel = widget.newButton{
        defaultFile = img_cancel,
        overFile = img_cancel,
        width=screenW*.3, height= screenH*.07,
        onRelease = ButtouRelease	-- event listener function
    }
    btnucancel.id = "cancel"
    btnucancel:setReferencePoint( display.CenterReferencePoint )
    btnucancel.alpha = 1
    btnucancel.x = screenW*.68
    btnucancel.y = screenH*.63
    groupView:insert(btnucancel)

    groupView.touch = onTouchconfrimLeaveTicket
    groupView:addEventListener( "touch", groupView )

    return groupView

end

function shortProfile(option)
    menu_barLight.SEAlertMSN()
    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local imgCharacter = display.newImageRect(image_Caution, screenW*.7,screenH*.2 )
    imgCharacter:setReferencePoint( display.CenterReferencePoint )
    imgCharacter.x = screenW *.5
    imgCharacter.y = screenH*.55
    imgCharacter.alpha = .9
end

function teamLock(page)
    menu_barLight.SEAlertMSN()
    local sizetextName = sizetextName
    local back_while
    local myRectangle
    local btn_OK
    local SmachText
    local numunlock = tonumber((page-1)*10)
    local textMSN = "Unlock when level "..numunlock.." reached"
    local options =
    {
        effect = "zoomOutInFade",
        time = 200,
    }
    local function onTouchteamLock( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local groupView = display.newGroup()

    back_while = display.newRect(0, 0, screenW, screenH*.5)
    back_while:setReferencePoint(display.TopLeftReferencePoint)
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle:setReferencePoint(display.TopLeftReferencePoint)
    myRectangle.strokeWidth = 2
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    SmachText = display.newText(textMSN, screenW*.25, screenH *.45,typeFont, sizetextName)
    SmachText:setReferencePoint(display.TopLeftReferencePoint)
    SmachText:setFillColor(255, 255, 255)
    groupView:insert(SmachText)


    groupView.touch = onTouchteamLock
    groupView:addEventListener( "touch", groupView )

    return groupView
end

function sprite_fight()
    menu_barLight.SEAlertMSN()
    require "sprite"
    --local uma = sprite.newSpriteSheetFromData( "uma.png", require("uma").getSpriteSheetData() )
--    local uma = sprite.newSpriteSheetFromData( "img/sprite/yellow.png", require("sheet_fight").getSpriteSheetData() )
--    local uma = sprite.newSpriteSheetFromData( "img/sprite/green.png", require("sheet_green").getSpriteSheetData() )
--    local uma = sprite.newSpriteSheetFromData( "img/sprite/Light.png", require("sheet_fight").getSpriteSheetData() )
    local uma = sprite.newSpriteSheetFromData( "img/sprite/Light.png", require("sheet_yellow").getSpriteSheetData() )

    local spriteSet = sprite.newSpriteSet(uma,1,38)

    sprite.add(spriteSet,"uma",1,38,2000,0)

    local spriteInstance = sprite.newSprite(spriteSet)

    spriteInstance.x = screenW*.4
    spriteInstance.y = screenH*.2

    spriteInstance:prepare("uma")
    spriteInstance:play()

end

function sprite_sheet(characterAll,num,color,pointX,pointY)
    local characterAll = characterAll+1
    local sheetdata_light = {
        {width = 512/2, height = 535/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4280/2 }  ,
        {width = 512/1.6, height = 535/1.6,numFrames = 40, sheetContentWidth =2560/1.6 ,sheetContentHeight =4280/1.6 }  ,
        {width = 512/2, height = 578/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4624/2 }  ,
        {width = 512/2, height = 504/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4032/2 }  ,
        {width = 512/2, height = 520/2,numFrames = 40, sheetContentWidth =2560/2 ,sheetContentHeight =4160/2 }  ,

    }
    local image_sheet = {
        "img/sprite/element/Fire.png",
        "img/sprite/element/Earth.png",
        "img/sprite/element/Water.png",
        "img/sprite/element/Dark.png",
        "img/sprite/element/Light.png",
    }
    local sheet_light = graphics.newImageSheet( image_sheet[color], sheetdata_light[color] )
    local sequenceData = {
        { name="sheet", sheet=sheet_light, start=1, count=40, time=600, loopCount=1 }
    }

    local poinx = pointX
    local poiny = pointY
    local myAnimationSheet
    local timerIMG

    myAnimationSheet = display.newSprite( sheet_light, sequenceData )
    myAnimationSheet:setReferencePoint( display.BottomCenterReferencePoint)
    myAnimationSheet.x = poinx

    if color == 1 then
        myAnimationSheet.y = poiny + display.contentHeight*.05

    elseif color == 2 then
        myAnimationSheet.y = poiny + display.contentHeight*.065

    elseif color == 3 then
        myAnimationSheet.y = poiny + display.contentHeight*.03

    elseif color == 4 then
        myAnimationSheet.y = poiny

    elseif color == 5 then
        myAnimationSheet.y = poiny+ display.contentHeight*.03
    end

    local function swapSheet()
        myAnimationSheet:setSequence( "sheet" )
        myAnimationSheet:play()
        timerIMG = nil

    end
    timerIMG = timer.performWithDelay( 50, swapSheet )

    menu_barLight.checkMemory()
    return true
end

function loadFramElement()
    local framele = {
        "img/characterIcon/frame_element/fire.png",
        "img/characterIcon/frame_element/earth.png",
        "img/characterIcon/frame_element/water.png",
        "img/characterIcon/frame_element/dark.png",
        "img/characterIcon/frame_element/light.png",
        "img/characterIcon/frame_element/white.png"
    }
    return framele
end

function loadBallElement()
    local framele = {
        "img/element/red.png",
        "img/element/green.png",
        "img/element/blue.png",
        "img/element/purple.png",
        "img/element/yellow.png",
    }
    return framele
end
