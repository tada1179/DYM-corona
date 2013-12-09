local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
-- ---------------------------------------------- --
local stringfLenght = 390
local sizeStringInput = 20
local sizeString = 30
local sizeField = 50
local textFont = native.newFont( native.systemFont )
local screenW, screenH = display.contentWidth, display.contentHeight

local user_id
local friend_id
local requestID
local gdisplay
local titleText

local function createBackButton()
    local image_btnback = "img/background/button/Button_BACK.png"
    local image_btnrequest = "img/background/button/SEND_REQUEST.png"
    local backButton
    local REQUESTButton

    local function textListener( event )
        --
        if event.phase == "began" then
            --                native.setKeyboardFocus( requestID )
            -- user begins editing textField

        elseif event.phase == "ended" or event.phase == "submitted" then
            friend_id = event.target.text

        elseif event.phase == "editing" then
            if event.startPosition > 8  then
                native.setKeyboardFocus( requestID )
                --requestID.text = ""
            end

        end

        return true
    end
    local function requestRelease(event)
--        requestID:removeEventListener( "userInput", textListener )
--        requestID.alpha = 0
--        requestID.text = ""
--        requestID:removeSelf()
--        requestID = nil


        menu_barLight.SEtouchButton()
        local option = {
            effect = "fade",
            time = 100,
            params = {
                friend_id =  friend_id ,
                user_id = user_id
            }
        }
        if event.target.id == "back" then -- back button
            display.remove(gdisplay)
            gdisplay= nil
            storyboard.gotoScene( "commu_main" ,"fade", 100 )

        elseif event.target.id == "REQUEST" then -- back button
            if friend_id ~= nil then
                display.remove(gdisplay)
                gdisplay= nil
                storyboard.gotoScene( "request" ,option )
            else

            end
        end
        return true	-- indicates successful touch
    end
    backButton = widget.newButton{
        defaultFile= image_btnback,
        overFile= image_btnback,
        width= screenW/10, height= screenH/21,
        onRelease = requestRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW - (screenW*.845)
    backButton.y = screenH- (screenH*.7)
    gdisplay:insert(backButton)
    -- ** SEND REGUEST **
    REQUESTButton = widget.newButton{
        defaultFile= image_btnrequest,
        overFile= image_btnrequest,
        width=screenW*.32, height=screenH*.056,
        onRelease = requestRelease	-- event listener function
    }
    REQUESTButton.id="REQUEST"
    REQUESTButton:setReferencePoint( display.CenterReferencePoint )
    REQUESTButton.x = screenW*.5
    REQUESTButton.y = screenH*.67
    gdisplay:insert(REQUESTButton)


    requestID = native.newTextField( screenW*.2, screenH*.56, stringfLenght, sizeField )
--    requestID.text = ""
    requestID:setReferencePoint(display.TopLeftReferencePoint)
    requestID.font = textFont
    requestID.size = sizeStringInput
    requestID.inputType = "number"
    requestID.align = "center"

    requestID:addEventListener( "userInput", textListener )
    gdisplay:insert(requestID)

end

function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()
    local image_player = "img/text/PLAYER'S_ID.png"

    local image_txtYourID = "img/text/YOUR_ID_ENTER_THE_ID.png"
    local image_freamID = "img/background/player/as_friend_icn_id.png"

    user_id = menu_barLight.user_id()
    local centerID = string.len(user_id)
    local pointcenterID = (screenW*.48) -((centerID*sizeString)/4)

    gdisplay:insert(background)

    local titleText = display.newImageRect( image_player, screenW/3.4, screenH/32 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1
    gdisplay:insert(titleText)

    local titleYouID = display.newImageRect( image_txtYourID, screenW*.45, screenH*.15 )
    titleYouID:setReferencePoint( display.CenterReferencePoint )
    titleYouID.x = screenW*.5
    titleYouID.y = screenH*.47
    gdisplay:insert(titleYouID)

    local freamyouID = display.newImageRect( image_freamID, screenW*.6, screenH*.05 )
    freamyouID:setReferencePoint( display.CenterReferencePoint )
    freamyouID.x = screenW*.5
    freamyouID.y = screenH*.45
    gdisplay:insert(freamyouID)

    local yourID =  display.newText(user_id,pointcenterID, screenH*.43,textFont,sizeString)
    yourID:setReferencePoint(display.TopLeftReferencePoint)
    gdisplay:insert(yourID)

    createBackButton()
    group:insert(gdisplay)

    -------------------------------------
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "commu_main" )
    storyboard.purgeScene( "request" )
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
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene


