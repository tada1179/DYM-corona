local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.disableAutoPurge = true
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()

local widget = require "widget"
local http = require("socket.http")
local alertMSN = require("alertMassage")
local json = require("json")
-------------------------------------------------
local character_id
local user_id
-------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight

-------------------------------------------

function scene:createScene( event )
    local gdisplay = display.newGroup()
    local typeFont = native.systemFontBold
    local textFont = native.newFont( native.systemFont )
    local user_name_ch = nil
    local user_name = nil
    local requestID
    local group = self.view
    local image_background1 = "img/background/background_a1.png"
    local image_baseunit = "img/background/powerup/BASE_UNIT.png"
    local image_inputname = "img/text/as_title_name.png"


    local function OverCancelRelease(event,self)
        print("SEND")
      if event.target.id == "SEND" then -- back button

            if user_name ~= nil then
                print("SEND 2")
                display.remove(gdisplay)
                gdisplay= nil
                local option = {
                    effect = "fade",
                    time = 100,
                    params = {
                        user_name =  user_name
                    }
                }
                storyboard.gotoScene( "register_element" ,option )
            else

            end
        end
    end
    local function textListener(event)
        print("touch")
        if event.phase == "began" then
            if user_name_ch then
                native.setKeyboardFocus( requestID )
            end


        elseif event.phase == "ended" or event.phase == "submitted" then
            user_name = event.target.text
            user_name_ch = nil
        elseif event.phase == "editing" then
            if event.startPosition > 15  then
                native.setKeyboardFocus( requestID )
            end
        end

    end
    local background = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    gdisplay:insert(background)
    local txtinputname = display.newImageRect(image_inputname,screenW*.7,screenH*.04)--contentWidth contentHeight
    txtinputname:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    txtinputname.x,txtinputname.y = screenW*.5,screenH*.15
    gdisplay:insert(txtinputname)

    requestID = native.newTextField( 0,0, screenW*.65, 50 )
    requestID.x = screenW*.5
    requestID.y =  screenH*.25
    requestID.font = textFont
    requestID.size = 20
    requestID.inputType = "default"
    requestID.align = "center"

    requestID:addEventListener( "userInput", textListener )
    gdisplay:insert(requestID)
    if event.params  then
        requestID.text = event.params.user_name
        user_name = event.params.user_name
        user_name_ch = event.params.user_name

    end
    local img_OK = "img/background/button/OK_button.png"
    local btnOK = widget.newButton{
        defaultFile = img_OK,
        overFile = img_OK,
        width=screenW*.3, height= screenH*.07,
        onRelease = OverCancelRelease	-- event listener function
    }
    btnOK.id = "SEND"
    btnOK:setReferencePoint( display.CenterReferencePoint )
    btnOK.x = screenW*.5
    btnOK.y = screenH*.35
    gdisplay:insert(btnOK)
    group:insert(gdisplay)

    --------------------------------------------
    storyboard.removeAll()
    storyboard.purgeAll()

end
function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    display.remove(gdisplay)
    gdisplay = nil

    storyboard.removeAll()
    storyboard.purgeAll()

    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )
end

function scene:destroyScene( event )
    local group = self.view


end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

