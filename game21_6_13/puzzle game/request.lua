print("request.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local alertMSN = require("alertMassage")
local http = require("socket.http")
local json = require("json")
local alertMSN = require("alertMassage")
-----------------------
local screenW, screenH = display.contentWidth, display.contentHeight
function scene:createScene( event )
    local group = self.view
    local gdisplay = display.newGroup()
    local gplay = display.newGroup()
--    local image_background = "img/background/MAP_Chinese-ornament-frame.jpg"
    local image_background = "img/background/background_1.jpg"

    local background = display.newImageRect( image_background, screenW, screenH )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local friendRow
    local params = event.params
    if params then
        local txtfriend_id = params.friend_id
        local user_id = params.user_id

        if user_id == txtfriend_id then
            alertMSN.requestFriend()
        else
        print("friend_id",txtfriend_id)
            local LinkFriend = "http://localhost/DYM/playerID.php"
            local numberHold_character =  LinkFriend.."?friend="..txtfriend_id.."&user_id="..user_id
            local numberHold = http.request(numberHold_character)

            if numberHold == nil then
                print("No Dice")
            else
                print("numberHold numberHold",numberHold)
                local allRow  = json.decode(numberHold)
                friendRow = allRow.friendRow

                if friendRow=="NODATA" then
                    alertMSN.NoDataInList()
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

                    print("friend_id aaa",friend_id)

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

                    alertMSN.showFriendRequest(option)
                end
            end
        end
        print("friend_id:",txtfriend_id,"user_id",user_id)
    end

    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background)
    group:insert(gdisplay)
    --- ------------------------------------
    storyboard.removeScene( "player_list" )
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
