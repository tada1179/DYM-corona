local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local loadImageSprite = require ("downloadData").loadImageSprite_element1()
local loadImageSprite2 = require ("downloadData").loadImageSprite_element2()
local menu_barLight = require ("menu_barLight")
local widget = require("widget")
local loadImage = require ("downloadData").loadImage()
function scene:createScene( event )

    local screenW, screenH = display.contentWidth, display.contentHeight

    -----------------------------------------------------------------------------------------
    menu_barLight.mainsound()
    local user_state = nil
    local SysdeviceID = require("includeFunction").DriverIDPhone()
    local transitionStash = {}
    local TimersST = {}

    local groupok = nil
    local group = self.view
    local previous_scene_name = storyboard.getCurrentSceneName()

    local image_background = "img/background/background_a1.png"
    background = display.newImageRect(image_background,screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0,0
    group:insert(background)
    local net = 1
    local noNetwork = 1
    function loaddata ()
        if groupok then
            display.remove(groupok)
            groupok = nil
        end
        native.setActivityIndicator( true )
        local function networkListener( event )
           -- print("event.response",event.response)
            if ( event.isError ) then
                timer.performWithDelay( 400, stopSpin)

            else
                if event.response == "OLD" then
                    user_state = "OLD"
                else
                    user_state = "NEW"
                end
                    net = net + 1
                timer.performWithDelay( 400, stopSpin)
            end
        end

        -- Access Google over SSL:
        local NewUserCheck = "http://133.242.169.252/DYM/checkuser.php?deviceID="..SysdeviceID
        network.request( NewUserCheck, "GET", networkListener )

    end


    local image_background1 = "img/background/title.png"
    local background1 = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background1:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background1.x,background1.y = 0,0
    group:insert(background1)


    local function onStartTouch(event)
        native.setActivityIndicator( true )


        menu_barLight.SEtouchButton()

        if user_state ~= "NEW" then
            require ("downloadData").newload()
            require ("menu").ShowDisplay()
            storyboard.gotoScene( "map", "crossFade", 100 )
            native.setActivityIndicator( false )
        else

            storyboard.gotoScene( "register", "crossFade", 100 )
            native.setActivityIndicator( false )
        end

        return true
    end
    function stopSpin()
        native.setActivityIndicator( false )
      if transitionStash.spinner then
        transition.cancel(transitionStash.spinner)
        transitionStash.spinner = nil
      end
      if TimersST.myTimer then
          timer.cancel(TimersST.myTimer)
          TimersST.myTimer = nil
      end
      if net == 1 then

          require("alertMassage").Nonetwork(previous_scene_name)
      end


        if user_state then

            local imgPic = "img/text/asset_touch.png"
            local touchtext =  display.newImageRect( imgPic, screenW*.45,screenH*.03)
            touchtext:setReferencePoint( display.CenterReferencePoint )
            touchtext.x = screenW*.5
            touchtext.y = screenH*.5
            group:insert(touchtext)
            group:addEventListener( "touch", onStartTouch ) -- touch togo mainpage
        end

    end
    loaddata()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "register" )
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene















