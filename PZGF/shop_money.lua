local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local alertMSN = require ("alertMassage")
-----------------------------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local rowmenu = 5

local user_id
local idMenu = {
    "ticket","stamina","slot",
    --"weapon",
    --"armour"
}
local imageMenu = {
    "img/background/shop/ticket_shop.png",
    "img/background/shop/stamina_recivery.png",
    "img/background/shop/slot_extension.png",
    --"img/background/shop/weapon_shop_money.png",
    --"img/background/shop/armour_shop_money.png"
 }
local gdisplay
local titleText
local backButton
local btnmenu = {}

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local sizetext = FontAndSize.fontGuest
local sizetextName = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead
------------------------------------
local function onBtnRelease(event)
    local namepage =  "shop_money"

    if event.target.id == "stamina" then
        menu_barLight.SEtouchButton()
        local maxStatmina = tonumber(menu_barLight.stamina())
        local numstamina = maxStatmina - tonumber(menu_barLight.power_STAMINA())
        if  numstamina > 0 then --add stamina
            alertMSN.stamina{user_id = user_id,namepage = namepage}
        else
            alertMSN.staminaFull(namepage)
        end

    elseif event.target.id == "slot" then
        menu_barLight.SEtouchButton()
        alertMSN.addSlot{user_id = user_id,namepage = namepage }

    else
        menu_barLight.SEtouchButtonBack()

        display.remove(titleText)
        titleText = nil

        display.remove(backButton)
        backButton = nil

        for i = #btnmenu,1,-1 do
            table.remove(btnmenu[i])
            btnmenu[i] = nil
        end

        if event.target.id == "back" then
            storyboard.gotoScene( "shop_main" ,"fade", 100 )

        elseif event.target.id == "ticket" then
            storyboard.gotoScene( "ticket_shop" ,"fade", 100 )

        elseif event.target.id == "weapon" then
            storyboard.gotoScene( "ticket_shop" ,"fade", 100 )

        elseif event.target.id == "armour" then
            storyboard.gotoScene( "ticket_shop" ,"fade", 100 )

        end
    end

    return true
end

function scene:createScene( event )
    native.setActivityIndicator( false )
    gdisplay = display.newGroup()
    local group = self.view

    --local image_background = "img/background/background_1.jpg"
    local image_text = "img/text/SHOP_MONEY.png"
    user_id = menu_barLight.user_id()

    gdisplay:insert(background)

    titleText = display.newImageRect(image_text,screenW*.35, screenH*.027 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.5
    titleText.y = screenH /3.15
    gdisplay:insert(titleText)

    local image_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        defaultFile= image_btnback,
        overFile= image_btnback,
        width=screenW*.12, height=screenH*.05,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW*.15
    backButton.y = screenH *.3
    gdisplay:insert(backButton)

    local img_team = "img/background/iconbox.png"
    for i = 1, #imageMenu ,1 do
        btnmenu[i] = widget.newButton{
            defaultFile= imageMenu[i],
            overFile= imageMenu[i],
            width=screenW*.56, height=screenH*.086,
            onRelease = onBtnRelease,	-- event listener function
        }
        btnmenu[i].id = idMenu[i]
        btnmenu[i]:setReferencePoint( display.CenterReferencePoint )
        btnmenu[i].x = screenW*.5
        btnmenu[i].y = i*(screenH*.09)+(screenH*.313)
        gdisplay:insert(btnmenu[i])
    end

    gdisplay:insert(menu_barLight.newMenubutton())
    group:insert(gdisplay)
    ------------- other scene ---------------
    menu_barLight.checkMemory()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "shop_main" )
    storyboard.purgeScene( "ticket_shop" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )
    local group = self.view
    --storyboard.purgeAll()
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

