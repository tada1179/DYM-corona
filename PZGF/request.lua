local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local alertMSN = require("alertMassage")
local json = require("json")
-----------------------
local typeFont = native.systemFontBold
local sizeFont = 20
local screenW, screenH = display.contentWidth, display.contentHeight
--------------------------------------------------------------------
local gdisplay
local function showFriendRequest(option)
    local sheetInfo = require("chara_icon")
--    local myImageSheet = graphics.newImageSheet( "img/character/chara_icon.png", sheetInfo:getSheet() )
    local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )

    local NamesizeFont =  23
    local frame = alertMSN.loadFramElement()

    local image_Caution = "img/background/sellBattle_Item/CAUTION_BACKGROUND_LAYOT.png"
    local image_btnOK= "img/background/button/OK_button.png"
    local image_btncancel = "img/background/button/as_butt_discharge_cancel.png"

    local oneItem = option.params
    local user_id = oneItem.user_id
    local friend_id = oneItem.friend_id
    local Friend_Lv = oneItem.Friend_Lv
    local Friend_name = oneItem.Friend_name
    local Friend_date = oneItem.Friend_date
    local charac_img = oneItem.charac_img
    local charac_id = oneItem.charac_id
    local charac_element = tonumber(oneItem.charac_element)
    local charac_Lv = oneItem.charac_Lv
    local friend_respont = oneItem.friend_respont

    local textMSN
    if friend_respont == 0 then
        textMSN = "Confirm to send Friend Request?"
    else
        textMSN = "This user is already on your friends list."
    end

    local function onshowFriend(event)
       menu_barLight.SEtouchButton()
        gdisplay.alpha = 0

        storyboard.removeScene( "player_list" )
        display.remove(gdisplay)
        gdisplay = nil

        local options =
        {
            effect = "crossFade",
            time = 100,
            params = {
                user_id = user_id
            }
        }
        local respont = 0 --add friend
        if event.target.id == "OK" then
            local ulrResetsert = "http://133.242.169.252/DYM/accepFriend.php"
            local characResetsert =  ulrResetsert.."?user_id="..user_id.."&friend="..friend_id.."&respont="..respont
            local complte = http.request(characResetsert)
            local allRow  = json.decode(complte)

            if complte then

                storyboard.gotoScene( "player_list",options )
            end
        elseif event.target.id == "OKBACk" then

            storyboard.gotoScene( "player_list" ,options )

        elseif event.target.id == "cancel" then

            storyboard.gotoScene( "player_list" ,options )
        end
    end
    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint( display.TopLeftReferencePoint )
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    gdisplay:insert(back_while)

    local backgroundCaution = display.newImageRect( image_Caution, screenW*.95,screenH*.6 )
    backgroundCaution:setReferencePoint( display.CenterReferencePoint )
    backgroundCaution.x = screenW *.5
    backgroundCaution.y = screenH*.55
    backgroundCaution.alpha = .9
    gdisplay:insert(backgroundCaution)

    local txtMSN = display.newText("MSN", screenW*.45, screenH*.4, typeFont, NamesizeFont)
    txtMSN:setFillColor(255, 255, 255)
    txtMSN.text =  string.format(textMSN)
    txtMSN.alpha = 1
    gdisplay:insert(txtMSN)

    if friend_respont == 0  then
        local ButtonOK = widget.newButton{
            defaultFile= image_btnOK,
            overFile=  image_btnOK,
            width= screenW*.26, height= screenH*.06,
            onRelease = onshowFriend	-- event listener function
        }
        ButtonOK.id="OK"
        ButtonOK:setReferencePoint( display.TopLeftReferencePoint )
        ButtonOK.x = screenW * .2
        ButtonOK.y = screenH *.68
        ButtonOK.alpha = 1
        gdisplay:insert(ButtonOK)
        -- ******** - -
        local ButtonCancel = widget.newButton{
            defaultFile= image_btncancel,
            overFile=  image_btncancel,
            width= screenW*.24, height= screenH*.06,
            onRelease = onshowFriend	-- event listener function
        }
        ButtonCancel.id="cancel"
        ButtonCancel:setReferencePoint( display.TopLeftReferencePoint )
        ButtonCancel.x = screenW * .55
        ButtonCancel.y = screenH *.68
        ButtonCancel.alpha = 1
        gdisplay:insert(ButtonCancel)
    else
        local ButtonOK = widget.newButton{
            defaultFile= image_btnOK,
            overFile=  image_btnOK,
            width= screenW*.26, height= screenH*.06,
            onRelease = onshowFriend	-- event listener function
        }
        ButtonOK.id="OKBACk"
        ButtonOK:setReferencePoint( display.TopLeftReferencePoint )
        ButtonOK.x = screenW * .38
        ButtonOK.y = screenH *.68
        ButtonOK.alpha = 1
        gdisplay:insert(ButtonOK)

        local ButtonCancel = widget.newButton{
            defaultFile= image_btncancel,
            overFile=  image_btncancel,
            width= screenW*.24, height= screenH*.06,
            onRelease = onshowFriend	-- event listener function
        }
        ButtonCancel.id="cancel"
        ButtonCancel:setReferencePoint( display.TopLeftReferencePoint )
        ButtonCancel.x = screenW * .55
        ButtonCancel.y = screenH *.68
        ButtonCancel.alpha = 0
        gdisplay:insert(ButtonCancel)
    end

    local imgCharacter = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(charac_img) , screenW*.18,screenH*.13 )
    imgCharacter:setReferencePoint( display.CenterReferencePoint )
    imgCharacter.x = screenW *.3
    imgCharacter.y = screenH*.55
    imgCharacter.alpha = 1
    gdisplay:insert(imgCharacter)

    local frmCharacter = display.newImageRect( frame[charac_element], screenW*.18,screenH*.13 )
    frmCharacter:setReferencePoint( display.CenterReferencePoint )
    frmCharacter.x = screenW *.3
    frmCharacter.y = screenH*.55
    frmCharacter.alpha = 1
    gdisplay:insert(frmCharacter)

    local NameCharacter = display.newText(Friend_name, screenW*.45, screenH*.49, typeFont, NamesizeFont)
    NameCharacter:setReferencePoint( display.TopLeftReferencePoint )
    NameCharacter:setFillColor(218, 165, 32)
    NameCharacter.text =  string.format(Friend_name)
    NameCharacter.alpha = 1
    gdisplay:insert(NameCharacter)

    local LvCharacter = display.newText(charac_Lv, screenW*.28, screenH*.6, typeFont, sizeFont)
    LvCharacter:setReferencePoint( display.TopLeftReferencePoint )
    LvCharacter:setFillColor(255, 255, 255)
    LvCharacter.text =  string.format("Lv."..charac_Lv)
    LvCharacter.alpha = 1
    gdisplay:insert(LvCharacter)

    local LvFriend = display.newText(Friend_Lv, screenW*.7, screenH*.49, typeFont, NamesizeFont)
    LvFriend:setReferencePoint( display.TopLeftReferencePoint )
    LvFriend:setFillColor(255, 255, 255)
    LvFriend.text =  string.format("Lv."..Friend_Lv)
    LvFriend.alpha = 1
    gdisplay:insert(LvFriend)

    local DateLogin = display.newText(Friend_date, screenW*.45, screenH*.55, typeFont, sizeFont)
    DateLogin:setReferencePoint( display.TopLeftReferencePoint )
    DateLogin:setFillColor(255, 0, 255)
    DateLogin.text =  string.format(Friend_date)
    DateLogin.alpha = 1
    gdisplay:insert(DateLogin)

end
local function NoDataInList()
    local image_ok = "img/background/button/OK_button.png"

    local function onNoDataInList(event)
        storyboard.removeScene( "player_list" )
        display.remove(gdisplay)
        gdisplay = nil

        if event.target.id == "okNoData" then
            storyboard.removeScene( "player_list" )
            storyboard.gotoScene( "player_list" ,"fade",100 )
        end
    end

    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint( display.TopLeftReferencePoint )
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    gdisplay:insert(back_while)

    local myRectangle = display.newRoundedRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2,7)
    myRectangle:setReferencePoint( display.TopLeftReferencePoint )
    myRectangle.strokeWidth = 2
    myRectangle:setStrokeColor(255,255,255)
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    gdisplay:insert(myRectangle)

    local SmachText = display.newText("No Friend Request", screenW*.35, screenH *.45,typeFont, sizeFont)
    SmachText:setReferencePoint( display.TopLeftReferencePoint )
    SmachText:setFillColor(255, 255, 255)
    gdisplay:insert(SmachText)

    --button ok profile
    local btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.2, height=screenH*.05,
        onRelease = onNoDataInList	-- event listener function
    }
    btn_OK.id="okNoData"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.5
    btn_OK.y = screenH*.55
    gdisplay:insert(btn_OK)

end
local function requestFriend()
    local image_ok = "img/background/button/OK_button.png"

    local function onrequestFriend(event)
        display.remove(gdisplay)
        gdisplay = nil

        if event.target.id == "ok" then
            storyboard.gotoScene( "player_list" ,"fade",100 )
        end
    end

    local back_while = display.newRect(0, 0, screenW, screenH)
    back_while:setReferencePoint( display.TopLeftReferencePoint )
    back_while.strokeWidth =0
    back_while.alpha = .5
    back_while:setFillColor(0, 0, 0)
    gdisplay:insert(back_while)

    local myRectangle = display.newRoundedRect(screenW*.1, screenH*.4, screenW*.8, screenH*.35,7)
    myRectangle:setReferencePoint( display.TopLeftReferencePoint )
    myRectangle.strokeWidth = 2
    myRectangle.alpha = .9
    myRectangle:setFillColor(0, 0, 0)
    gdisplay:insert(myRectangle)

    local SmachText = display.newText("!!Can't request friend id = your id", screenW*.18, screenH *.45,typeFont, sizeFont)
    SmachText:setReferencePoint( display.TopLeftReferencePoint )
    SmachText:setFillColor(0, 200, 0)
    gdisplay:insert(SmachText)

    local  btn_OK = widget.newButton{
        defaultFile=image_ok,
        overFile=image_ok,
        width=screenW*.3, height=screenH*.06,
        onRelease = onrequestFriend	-- event listener function
    }
    btn_OK.id="ok"
    btn_OK:setReferencePoint( display.CenterReferencePoint )
    btn_OK.x =screenW *.5
    btn_OK.y = screenH*.65
    gdisplay:insert(btn_OK)

end
function scene:createScene( event )
    gdisplay = display.newGroup()
    local group = self.view
    --local image_background = "img/background/background_1.jpg"

    local params = event.params
    if params then
        local txtfriend_id = params.friend_id
        local user_id = params.user_id

        if user_id == txtfriend_id then
            requestFriend()
        elseif txtfriend_id == "" then
            NoDataInList()
        else

            local LinkFriend = "http://133.242.169.252/DYM/playerID.php"
            local numberHold_character =  LinkFriend.."?friend="..txtfriend_id.."&user_id="..user_id
            local numberHold = http.request(numberHold_character)

            if numberHold == nil then
                print("No Dice")
            else
                local allRow  = json.decode(numberHold)
                local friendRow = allRow.friendRow

                if friendRow=="NODATA" then
                    NoDataInList()
                else
                    local friend_id = allRow.FRIEND[friendRow].Friend_id
                    local Friend_Lv = allRow.FRIEND[friendRow].Friend_Lv
                    local Friend_name = allRow.FRIEND[friendRow].Friend_name
                    local Friend_date =allRow.FRIEND[friendRow].Friend_date
                    local charac_img = allRow.FRIEND[friendRow].charac_img
                    local charac_id = allRow.FRIEND[friendRow].charac_id
                    local charac_element = allRow.FRIEND[friendRow].charac_element
                    local charac_Lv = allRow.FRIEND[friendRow].charac_Lv
                    local friend_respont = allRow.FRIEND[friendRow].friend_respont

                    local option = {
                        effect = "fade",
                        time = 100,
                        params = {
                            user_id = user_id,
                            friend_id = friend_id,
                            Friend_Lv = Friend_Lv,
                            Friend_name = Friend_name,
                            Friend_date = Friend_date,
                            charac_img = charac_img,
                            charac_id = charac_id,
                            charac_element = charac_element,
                            charac_Lv = charac_Lv,
                            friend_respont = friend_respont,
                        }
                    }

                    showFriendRequest(option)
                end
            end
        end
    end

    gdisplay:insert(menu_barLight.newMenubutton())
    group:insert(background)
    group:insert(gdisplay)
    --- ------------------------------------
end
function scene:enterScene( event )

    local group = self.view
    storyboard.purgeScene( "player_list" )
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
