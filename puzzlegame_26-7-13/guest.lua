local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local json = require("json")
local http = require("socket.http")
--------- icon event -------------
local screenW, screenH = display.contentWidth, display.contentHeight
local rowfriend = nil
local gdisplay = display.newGroup()

local characterItem = {}
local background
local titleText
local listCharacter = {}
local imgCharac
local imgFrame
local textName
local textmyFriend
local textfriendLV
local textCharacLV
local textdate
local textPointData
local backButton
------------------------------------------------------------
local function onBtnRelease(event)
     menu_barLight = nil
     display.remove(background)
     background = nil
     display.remove(titleText)
     titleText= nil
     display.remove(imgCharac)
     imgCharac= nil
     display.remove(imgFrame)
     imgFrame= nil
     display.remove(textName)
     textName= nil
     display.remove(textmyFriend)
     textmyFriend= nil
     display.remove(textfriendLV)
     textfriendLV= nil
     display.remove(textCharacLV)
     textCharacLV= nil
     display.remove(textdate)
     textdate= nil
     display.remove(textPointData)
     textPointData = nil
     display.remove(backButton)
     backButton= nil

    for i=1,#listCharacter do
        table.remove( listCharacter[i] )
        listCharacter[i] = nil
    end
    for i=1,#characterItem do
        table.remove( characterItem[i] )
        characterItem[i] = nil
    end

    for i=gdisplay.numChildren,1,-1 do
        local child = gdisplay[i]
        child.parent:remove( child )
        child = nil
    end

   if event.target.id == "back11" then -- back button
        storyboard.gotoScene( "misstion" ,"fade", 100 )

    else --if event.target.id == 1 then
       local option = {
           params = {
               mission = "CODE KWANTA",
               battle = "1/5",

               -- 1 : ON
               -- 2 : OFF
               BGM = 1,
               SFX = 1,
               SKL = 1,
               BTN = 1,
               checkOption = 1,
           }
       }
--       storyboard.gotoScene( "game-scene" ,option )
       storyboard.gotoScene( "team_select"  )
   end

    return true
end

local function loadcharacter()
    local user_id = menu_barLight.user_id()
    local LinkGuest = "http://localhost/DYM/guest.php"
    local numberHold_character =  LinkGuest.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)

    if numberHold == nil then
        print("111 No Dice")
    else
        local allRow  = json.decode(numberHold)
        rowfriend =tonumber(allRow.All)

        local k = 1
       -- while k <= rowfriend do
            characterItem[k] = {}
            characterItem[k].friend_id = allRow.chracter[k].friend_id
            characterItem[k].friend_name = allRow.chracter[k].friend_name
            characterItem[k].friend_Lv = allRow.chracter[k].friend_lv
            characterItem[k].friend_date = allRow.chracter[k].friend_date
            characterItem[k].friend_element = tonumber(allRow.chracter[k].friend_element)
            characterItem[k].friend_atk = allRow.chracter[k].friend_atk
            characterItem[k].friend_img_mini = allRow.chracter[k].friend_img_mini
            characterItem[k].friend_def = allRow.chracter[k].friend_def
            characterItem[k].friend_hp = allRow.chracter[k].friend_hp
            characterItem[k].friend_mark = allRow.chracter[k].friend_mark
            characterItem[k].charac_lv = allRow.chracter[k].charac_lv
            k = k +1

      -- end

    end
    return true
end
local function scrollViewList()
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

    rowfriend = 1
    for i = 1, rowfriend, 1 do
        local img_list = "img/characterIcon/framelist.png"
        local img_charac = "img/characterIcon/img/icon_test1001.png"
        local sizecharacH =  screenH*.09
        local sizecharacW =  screenW*.137
        local pointFrameX = screenW*.13

        listCharacter[i] = widget.newButton{
            default = img_list,
            over    = img_list,
            width   = screenW * .75 ,
            height  = screenH *.09,
            top     = pointFrameY,
            left    = screenW*.13,
            onEvent = onBtnRelease	-- event listener function
        }
        listCharacter[i].id = i
        gdisplay:insert(listCharacter[i])

        imgCharac = display.newImageRect(characterItem[i].friend_img_mini , sizecharacW, sizecharacH)
        imgCharac:setReferencePoint( display.TopLeftReferencePoint )
        imgCharac.x = pointFrameX
        imgCharac.y = pointFrameY
        gdisplay:insert(imgCharac)

        imgFrame = display.newImageRect(frame[characterItem[i].friend_element] , sizecharacW, sizecharacH)
        imgFrame:setReferencePoint( display.TopLeftReferencePoint )
        imgFrame.x = pointFrameX
        imgFrame.y = pointFrameY
        gdisplay:insert(imgFrame)

        textName = display.newText(characterItem[i].friend_name, screenW*.3, pointNameY,typeFont, sizetext)
        textName:setTextColor(255, 0, 255)
        gdisplay:insert(textName)

        local txtFriendMark
        if characterItem[i].friend_mark == 1 then
            txtFriendMark = "My Friend"
        else
            txtFriendMark = "My guest"
        end
        textmyFriend = display.newText(txtFriendMark, screenW*.5, pointNameY+(screenH*.05),typeFont, sizetext)
        textmyFriend:setTextColor(200, 200, 0)
        gdisplay:insert(textmyFriend)

        textfriendLV = display.newText("Lv."..characterItem[i].friend_Lv, screenW*.73, pointNameY,typeFont, sizetext)
        textfriendLV:setTextColor(200, 200, 200)
        gdisplay:insert(textfriendLV)

        textCharacLV = display.newText("Lv."..characterItem[i].charac_lv, screenW*.3, pointNameY+(screenH*.05),typeFont, sizetext)
        textCharacLV:setTextColor(100, 255, 255)
        gdisplay:insert(textCharacLV)

        textdate = display.newText(characterItem[i].friend_date, screenW*.3, pointNameY+(screenH*.03),typeFont, sizetext)
        textdate:setTextColor(100, 255, 255)
        gdisplay:insert(textdate)

        textPointData = display.newText("Point:5", screenW*.71, pointNameY+(screenH*.03),typeFont, sizetext)
        textPointData:setTextColor(100, 0, 255)
        gdisplay:insert(textPointData)

        pointNameY = pointNameY + (screenH*.098)
        pointFrameY = pointFrameY + (screenH*.098)
    end

    local img_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        default=img_btnback,
        over=img_btnback,
        width=screenW*.1, height=screenH*.05,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back11"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW*.15
    backButton.y = screenH*.3
    gdisplay:insert(backButton)

    return true
end

function scene:createScene( event )
    print("--: guest :--")
    local group = self.view
    local  img_text= "img/text/GUEST_SELECT.png"
    local  img_back= "img/background/background_11.png"

    background = display.newImageRect( img_back,screenW,screenH )
--    local background = display.newImageRect( "img_back", system.DocumentsDirectory,screenW,screenH)
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    gdisplay:insert(background)

    titleText = display.newImageRect( img_text,screenW/2.65,screenH/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x =screenW /2
    titleText.y =screenH /3.1
    gdisplay:insert(titleText)


    loadcharacter()
    scrollViewList()
    gdisplay:insert(menu_barLight.newMenubutton())
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
--    menu_barLight = nil
--    display.remove(background)
--    background = nil
--    display.remove(titleText)
--    titleText= nil
--    display.remove(imgCharac)
--    imgCharac= nil
--    display.remove(imgFrame)
--    imgFrame= nil
--    display.remove(textName)
--    textName= nil
--    display.remove(textmyFriend)
--    textmyFriend= nil
--    display.remove(textfriendLV)
--    textfriendLV= nil
--    display.remove(textCharacLV)
--    textCharacLV= nil
--    display.remove(textdate)
--    textdate= nil
--    display.remove(textPointData)
--    textPointData = nil
--    display.remove(backButton)
--    backButton= nil

    for i=1,#listCharacter do
        table.remove( listCharacter[i] )
        listCharacter[i] = nil
    end
    for i=1,#characterItem do
        table.remove( characterItem[i] )
        characterItem[i] = nil
    end

    for i=gdisplay.numChildren,1,-1 do
        local child = gdisplay[i]
        child.parent:remove( child )
        child = nil
    end
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


