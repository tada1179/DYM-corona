local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
-----------------------------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local gdisplay = display.newGroup()
local titleText
local background
local btnplayer
local btnfriend
local btnrequest
------------------------------------
local function onBtnRelease(event)


    if  event.target.id == "friend" then
         display.remove(background)
         background = nil
         display.remove(titleText)
         titleText = nil

         btnplayer:removeSelf(btnplayer)
         btnplayer  = nil

         btnfriend:removeSelf(btnfriend)
         btnfriend = nil

         btnrequest:removeSelf(btnrequest)
         btnrequest = nil

         for i=gdisplay.numChildren,1,-1 do
             local child = gdisplay[i]
             child.parent:remove( child )
             child = nil
             gdisplay[i] = nil
         end
         display.remove(gdisplay)
         gdisplay = nil

         storyboard.gotoScene( "friend_list", "fade", 100 )

    elseif  event.target.id == "player" then
        display.remove(background)
        background = nil
        display.remove(titleText)
        titleText = nil

        btnplayer:removeSelf(btnplayer)
        btnplayer  = nil

        btnfriend:removeSelf(btnfriend)
        btnfriend = nil

        btnrequest:removeSelf(btnrequest)
        btnrequest = nil

        for i=gdisplay.numChildren,1,-1 do
            local child = gdisplay[i]
            child.parent:remove( child )
            child = nil
            gdisplay[i] = nil
        end
        display.remove(gdisplay)
        gdisplay = nil
        storyboard.gotoScene( "player_list", "fade", 100 )

    elseif  event.target.id == "request" then
        local numfriend = menu_barLight.numFriend()

        if numfriend == 0 then
             require("alertMassage").NoDataInList()
        else
            display.remove(background)
            background = nil
            display.remove(titleText)
            titleText = nil

            btnplayer:removeSelf(btnplayer)
            btnplayer  = nil

            btnfriend:removeSelf(btnfriend)
            btnfriend = nil

            btnrequest:removeSelf(btnrequest)
            btnrequest = nil

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
    local image_friend = "img/background/community/FRIEND_LIST.png"
    local image_player = "img/background/community/PLAYERS_ID.png"
    local image_request = "img/background/community/REQUEST_LIST.png"

    local sizemenuH = screenH *.08
    local sizemenuW = screenW *.4

    btnplayer = widget.newButton{
        default = image_player,
        over = image_player,
        width= sizemenuW ,
        height= sizemenuH,
        onRelease = onBtnRelease
    }
    btnplayer.id="player"
    btnplayer:setReferencePoint( display.CenterReferencePoint )
    btnplayer.x = screenW *.5
    btnplayer.y =  screenH *.41
    gdisplay:insert(btnplayer)


    btnfriend = widget.newButton{
        default = image_friend,
        over = image_friend,
        width= sizemenuW ,
        height= sizemenuH,
        onRelease = onBtnRelease
    }
    btnfriend.id="friend"
    btnfriend:setReferencePoint( display.CenterReferencePoint )
    btnfriend.x = screenW *.5
    btnfriend.y =  screenH*.5
    gdisplay:insert(btnfriend)

    btnrequest = widget.newButton{
        default = image_request,
        over = image_request,
        width= sizemenuW ,
        height= sizemenuH,
        onRelease = onBtnRelease
    }
    btnrequest.id="request"
    btnrequest:setReferencePoint( display.CenterReferencePoint )
    btnrequest.x = screenW *.5
    btnrequest.y = screenH*.59
    gdisplay:insert(btnrequest)
end

function scene:createScene( event )
    print("-- ** commu_main **--")
    local image_text = "img/text/COMMUNITY.png"
    local group = self.view
    local image_background = "img/background/background_1.jpg"
    background = display.newImageRect(  image_background, screenW, screenH )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    gdisplay:insert(background)

    titleText = display.newImageRect( image_text, screenW/3.5, screenH/33 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.1
    gdisplay:insert(titleText)

    list_community()
    gdisplay:insert(menu_barLight.newMenubutton())
    gdisplay:insert(menu_barLight.newrequestList())
    group:insert(gdisplay)

    menu_barLight.checkMemory()
------------- other scene ---------------
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:enterScene( event )
    local group = self.view	
end

function scene:exitScene( event )
    local group = self.view

end

function scene:destroyScene( event )
    local group = self.view

    display.remove(background)
    background = nil
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
