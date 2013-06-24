-----------------------------------------------------------------------------------------
print("guest.lua")
-----------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local json = require("json")
local http = require("socket.http")
local includeFUN = require("includeFunction")
--------- icon event -------------
local backButton
local screenW, screenH = display.contentWidth, display.contentHeight
local maxguest = 5
local rowfriend
local groupViewfriend = display.newGroup()

local friend_id = {}
local friend_name = {}
local friend_Lv = {}
local friend_date = {}
local friend_element = {}
local friend_img = {}
local friend_atk = {}
local friend_hp = {}
local friend_def = {}
local friend_mark = {}
local friend_img_mini = {}
local charac_lv = {}

local function onBtnRelease(event)
   if event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "misstion" ,"fade", 100 )


    elseif event.target.id == "listCharacter1" then
        print( "event: "..event.target.id)
        storyboard.gotoScene( "team_select" ,"fade", 100 )
    end
    return true
end

local function createBackButton()
    local img_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        default=img_btnback,
        over=img_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
end


local function scrollViewList()
    local user_id = includeFUN.USERIDPhone()
    local LinkGuest = "http://localhost/DYM/guest.php"
    local numberHold_character =  LinkGuest.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)


    if numberHold == nil then
        print("111 No Dice")
    else
        local allRow  = json.decode(numberHold)
        rowfriend =allRow.All
        print("222 rowfriend",rowfriend)
        print("111 numberHold",numberHold)
        local k = 1
        while k <= rowfriend do
            friend_id[k] = allRow.chracter[k].friend_id
            friend_name[k] = allRow.chracter[k].friend_name
            friend_Lv[k] = allRow.chracter[k].friend_lv
            friend_date[k] = allRow.chracter[k].friend_date
            friend_element[k] = tonumber(allRow.chracter[k].friend_element)
            friend_atk[k] = allRow.chracter[k].friend_atk
            friend_img_mini[k] = allRow.chracter[k].friend_img_mini
            friend_def[k] = allRow.chracter[k].friend_def
            friend_hp[k] = allRow.chracter[k].friend_hp
            friend_mark[k] = allRow.chracter[k].friend_mark
            charac_lv[k] = allRow.chracter[k].charac_lv
            k = k +1
        end


    end

    local maxfram = 5
    local frame = {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }

    local pointFrameY = screenH*.35
    local pointNameY = screenH*.35
    local pointLvY = screenH*.35
    local typeFont = native.systemFontBold
    local sizetext = 18

    for i = 1, rowfriend, 1 do
        local listCharacter = {}
        local imgFrame
        local imgCharac = {}
        local img_list = "img/characterIcon/framelist.png"
        local img_charac = "img/characterIcon/img/icon_test1001.png"
        local sizecharacH =  screenH*.09
        local sizecharacW =  screenW*.137
        local pointFrameX = screenW*.13

        listCharacter[i] = widget.newButton{
            default=img_list,
            --over="img/background/character/BLOCK_NEW_LAYOUT_2.png",
            width= screenW * .75 ,
            height= screenH *.09,
            top = pointFrameY,
            left = screenW*.13,
            onEvent = onBtnRelease	-- event listener function
        }
        listCharacter[i].id = "listCharacter"..i
        groupViewfriend:insert(listCharacter[i])

        imgCharac[i] = display.newImageRect(friend_img_mini[i] , sizecharacW, sizecharacH)
        imgCharac[i]:setReferencePoint( display.TopLeftReferencePoint )
        imgCharac[i].x = pointFrameX
        imgCharac[i].y = pointFrameY
        groupViewfriend:insert(imgCharac[i])

        imgFrame = display.newImageRect(frame[friend_element[i]] , sizecharacW, sizecharacH)
        imgFrame:setReferencePoint( display.TopLeftReferencePoint )
        imgFrame.x = pointFrameX
        imgFrame.y = pointFrameY
        groupViewfriend:insert(imgFrame)

        local textName = display.newText(friend_name[i], screenW*.3, pointNameY,typeFont, sizetext)
        textName:setTextColor(255, 0, 255)
        groupViewfriend:insert(textName)

        local txtFriendMark
        if friend_mark[i] == 1 then
            txtFriendMark = "My Friend"
        else
            txtFriendMark = "My guest"
        end
        local textmyFriend = display.newText(txtFriendMark, screenW*.5, pointNameY+(screenH*.05),typeFont, sizetext)
        textmyFriend:setTextColor(200, 200, 0)
        groupViewfriend:insert(textmyFriend)

        local textfriendLV = display.newText("Lv."..friend_Lv[i], screenW*.73, pointNameY,typeFont, sizetext)
        textfriendLV:setTextColor(200, 200, 200)
        groupViewfriend:insert(textfriendLV)

        local textCharacLV = display.newText("Lv."..charac_lv[i], screenW*.3, pointNameY+(screenH*.05),typeFont, sizetext)
        textCharacLV:setTextColor(100, 255, 255)
        groupViewfriend:insert(textCharacLV)

        local textdate = display.newText(friend_date[i], screenW*.3, pointNameY+(screenH*.03),typeFont, sizetext)
        textdate:setTextColor(100, 255, 255)
        groupViewfriend:insert(textdate)

        local textPointData = display.newText("Point:5", screenW*.71, pointNameY+(screenH*.03),typeFont, sizetext)
        textPointData:setTextColor(100, 0, 255)
        groupViewfriend:insert(textPointData)

        pointNameY = pointNameY + (screenH*.098)
        pointFrameY = pointFrameY + (screenH*.098)
    end
    return true
end

function scene:createScene( event )
    local group = self.view
    local gdisplay = display.newGroup()
    local  img_back = "img/background/background_1.jpg"
    local  img_text= "img/text/GUEST_SELECT.png"

    local background = display.newImageRect( img_back, display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    local titleText = display.newImageRect( img_text, display.contentWidth/2.65, display.contentHeight/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    scrollViewList()
    createBackButton()
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)

    group:insert(background)

    group:insert(backButton)
    group:insert(titleText)
    group:insert(groupViewfriend)
    group:insert(gdisplay)

    ------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "team_setting" )
    storyboard.removeScene( "mission" )
    storyboard.removeScene( "character_scene" )
    storyboard.removeScene( "characterprofile" )
    storyboard.removeScene( "unit_main" )
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


