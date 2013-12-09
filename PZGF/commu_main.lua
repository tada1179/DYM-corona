local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
-----------------------------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local gdisplay
local titleText
local btnplayer
local btnfriend
local btnrequest

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local sizetext = FontAndSize.fontGuest
local sizetextName = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead
------------------------------------
local function onBtnRelease(event)

    menu_barLight.SEtouchButton()
    if  event.target.id == 2 then
         display.remove(titleText)
         titleText = nil

         for i=gdisplay.numChildren,1,-1 do
             local child = gdisplay[i]
             child.parent:remove( child )
             child = nil
             gdisplay[i] = nil
         end
         display.remove(gdisplay)
         gdisplay = nil

         storyboard.gotoScene( "friend_list", "fade", 100 )

    elseif  event.target.id == 1 then

        display.remove(titleText)
        titleText = nil

        for i=gdisplay.numChildren,1,-1 do
            local child = gdisplay[i]
            child.parent:remove( child )
            child = nil
            gdisplay[i] = nil
        end
        display.remove(gdisplay)
        gdisplay = nil
        storyboard.gotoScene( "player_list", "fade", 100 )

    elseif  event.target.id == 3 then
        local numfriend = menu_barLight.numFriend()

        if numfriend == 0 then
             require("alertMassage").NoDataInList()
        else

            display.remove(titleText)
            titleText = nil


            for i=gdisplay.numChildren,1,-1 do
                local child = gdisplay[i]
                child.parent:remove( child )
                child = nil
                gdisplay[i] = nil
            end
            display.remove(gdisplay)
            gdisplay = nil

             storyboard.gotoScene( "request_list", "fade", 100 )
        end
    end

    return true	-- indicates successful touch
end

local function list_community()

    local pointY = screenH*.4
    local listid = 3
    local text
    for i = 1,listid, 1 do
        if i==1 then
            text = "PLAYER'S ID"

        elseif i==2 then
            text = "FRIEND LIST"

        elseif i==3 then
            text = "REQUEST LIST"

        end
        local iconbox = "img/background/iconbox.png"
        local btnOK = widget.newButton{
            defaultFile = iconbox,
            overFile = iconbox,
            width=  screenW*.62, height= screenH*.08,
            onRelease = onBtnRelease,	-- event listener function
            label = text  ,
            labelColor = {
                default = { 255, 255, 255, 255},
                over = { 255, 255, 255, 255 },
            }         ,
            font = typeFont,
            fontSize = sizetextName,
        }
        btnOK.id = i --ok
        btnOK:setReferencePoint( display.CenterReferencePoint )
        btnOK.alpha = 1
        btnOK.x = screenW*.5
        btnOK.y = pointY
        gdisplay:insert(btnOK)

        pointY = pointY + screenH*.1

    end

end

function scene:createScene( event )
    native.setActivityIndicator( false )
    local image_text = "img/text/COMMUNITY.png"
    local group = self.view
    gdisplay = display.newGroup()
    gdisplay:insert(background)

    titleText = display.newImageRect( image_text, screenW*.35,screenH*.027 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.1
    gdisplay:insert(titleText)

    list_community()
    gdisplay:insert(menu_barLight.newMenubutton())
    gdisplay:insert(require("menu").newrequestList())
    group:insert(gdisplay)

    menu_barLight.checkMemory()
------------- other scene ---------------
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "friend_list" )
    storyboard.purgeScene( "player_list" )
    storyboard.purgeScene( "request_list" )
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

    display.remove(titleText)
    titleText = nil

    display.remove(btnplayer)
    btnplayer  = nil

    display.remove(btnfriend)
    btnfriend = nil

    display.remove(btnrequest)
    btnrequest = nil

    display.remove(gdisplay)
    gdisplay = nil

end
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
