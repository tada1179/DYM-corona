local storyboard = require( "storyboard" )
--storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local json = require("json")
local alertMSN = require("alertMassage")
local loadImageSprite = require ("downloadData").loadImageSprite_Victory_Warning1()
local http = require("socket.http")

local sheetInfo = require("chara_icon")
--    local myImageSheet = graphics.newImageSheet( "img/character/chara_icon.png", sheetInfo:getSheet() )
local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )
--------- icon event -------------
local screenW, screenH = display.contentWidth, display.contentHeight
local rowfriend = nil
local gdisplay

local characterItem = {}
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
local friendPoint= {}
--
local user_id
local chapter_id
local map_id
local mission_id
local mission_stamina

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local sizetext = FontAndSize.fontGuest
local sizetextName = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead
------------------------------------------------------------
local function loadcharacter()
    local LinkGuest = "http://133.242.169.252/DYM/guest.php"
    local numberHold_character =  LinkGuest.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)

    if numberHold == nil then
        print("111 No Dice")
    else
    --print("numberHold == ",numberHold)
        local allRow  = json.decode(numberHold)
        rowfriend =tonumber(allRow.All)
        rowfriend = rowfriend - 1
        local k = 1

        while k <= rowfriend do
            characterItem[k] = {}
            characterItem[k].holdcharac_id = allRow.chracter[k].holdcharac_id
        
            characterItem[k].friend_userid = allRow.chracter[k].friend_userid
            characterItem[k].friend_id = allRow.chracter[k].friend_id
            characterItem[k].friend_name = allRow.chracter[k].friend_name
            characterItem[k].friend_Lv = allRow.chracter[k].friend_lv
            characterItem[k].friend_date = allRow.chracter[k].friend_date
            characterItem[k].friend_element = tonumber(allRow.chracter[k].friend_element)
            characterItem[k].friend_atk = allRow.chracter[k].friend_atk
            characterItem[k].friend_img_mini = allRow.chracter[k].friend_img_mini
--            characterItem[k].friend_img_mini = "tgr_fa-i101w.png"
            characterItem[k].friend_def = allRow.chracter[k].friend_def
            characterItem[k].friend_hp = allRow.chracter[k].friend_hp
            characterItem[k].friend_mark = tonumber(allRow.chracter[k].friend_mark)
            characterItem[k].charac_lv = allRow.chracter[k].charac_lv
            k = k +1

        end

    end
    return true
end
local function onBtnRelease(event)

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


    for i=gdisplay.numChildren,1,-1 do
        local child = gdisplay[i]
        child.parent:remove( child )
        child = nil
    end
     if event.target.id == "back" then -- back button
         menu_barLight.SEtouchButtonBack()
       local option = {
           effect = "fade",
           time = 100,
           params =
           {
               chapter_id = chapter_id,
               map_id = map_id,
               user_id = user_id

           }
       }
        storyboard.gotoScene( "misstion" ,option )

    else --if event.target.id == 1 then
         menu_barLight.SEtouchButton()
       local option = {
           effect = "fade",
           time = 100,
           params =
           {
               friend_id = characterItem[event.target.id].holdcharac_id ,
               mission_stamina = mission_stamina,
               mission_id = mission_id,
               friendPoint = friendPoint[event.target.id],
               chapter_id = chapter_id,
               map_id = map_id,
               user_id = user_id,

           }
       }
--       storyboard.gotoScene( "game-scene" ,option )
       storyboard.gotoScene( "team_select",option  )
   end

    return true
end


local function scrollViewList()


    local frame =  alertMSN.loadFramElement()

    local pointFrameY = screenH*.35
    local pointNameY = screenH*.346
    local pointLvY = screenH*.35

    --rowfriend = 1
    local img_list = "img/characterIcon/framelist.png"
    local img_charac = "img/characterIcon/img/icon_test1001.png"
    local sizecharacH =  screenH*.09
    local sizecharacW =  screenW*.137
    local pointFrameX = screenW*.13

    for i = 1, rowfriend, 1 do

        listCharacter[i] = widget.newButton{
            defaultFile = img_list,
            overFile    = img_list,
            width   = screenW * .75 ,
            height  = screenH *.09,
            top     = pointFrameY,
            left    = screenW*.13,
            onEvent = onBtnRelease	-- event listener function
        }
        listCharacter[i].id =  i
        gdisplay:insert(listCharacter[i])

        print(i.."characterItem[i].friend_img_mini = ",characterItem[i].friend_img_mini)
        imgCharac = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[i].friend_img_mini) , sizecharacW, sizecharacH)
        imgCharac:setReferencePoint( display.TopLeftReferencePoint )
        imgCharac.x = pointFrameX
        imgCharac.y = pointFrameY
        gdisplay:insert(imgCharac)

        imgFrame = display.newImageRect(frame[characterItem[i].friend_element] , sizecharacW, sizecharacH)
        imgFrame:setReferencePoint( display.TopLeftReferencePoint )
        imgFrame.x = pointFrameX
        imgFrame.y = pointFrameY
        gdisplay:insert(imgFrame)

        textName = display.newText(characterItem[i].friend_name, screenW*.3, pointNameY,typeFont, sizetextName)
        textName:setReferencePoint(display.TopLeftReferencePoint)
        textName:setFillColor(255, 0, 255)
        gdisplay:insert(textName)

        local txtFriendMark
--        print("characterItem[i].friend_mark",characterItem[i].friend_mark)
        if characterItem[i].friend_mark == 1 then
            txtFriendMark = "My Friend"
            friendPoint[i] = 10
        else
            txtFriendMark = "My guest"
            friendPoint[i] = 5
        end
        textmyFriend = display.newText(txtFriendMark, screenW*.5, pointNameY+(screenH*.055),typeFont, sizetext)
        textmyFriend:setReferencePoint(display.TopLeftReferencePoint)
        textmyFriend:setFillColor(200, 200, 0)
        gdisplay:insert(textmyFriend)

        textfriendLV = display.newText("Lv."..characterItem[i].friend_Lv, screenW*.73, pointNameY,typeFont, sizetext)
        textfriendLV:setReferencePoint(display.TopLeftReferencePoint)
        textfriendLV:setFillColor(200, 200, 200)
        gdisplay:insert(textfriendLV)

        textCharacLV = display.newText("Lv."..characterItem[i].charac_lv, screenW*.3, pointNameY+(screenH*.055),typeFont, sizetext)
        textCharacLV:setReferencePoint(display.TopLeftReferencePoint)
        textCharacLV:setFillColor(100, 255, 255)
        gdisplay:insert(textCharacLV)

        textdate = display.newText(characterItem[i].friend_date, screenW*.3, pointNameY+(screenH*.035),typeFont, sizetext)
        textdate:setReferencePoint(display.TopLeftReferencePoint)
        textdate:setFillColor(100, 255, 255)
        gdisplay:insert(textdate)

        textPointData = display.newText("Point:"..friendPoint[i], screenW*.71, pointNameY+(screenH*.035),typeFont, sizetext)
        textPointData:setReferencePoint(display.TopLeftReferencePoint)
        textPointData:setFillColor(100, 0, 255)
        gdisplay:insert(textPointData)

        pointNameY = pointNameY + (screenH*.098)
        pointFrameY = pointFrameY + (screenH*.098)
    end

    local img_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        defaultFile=img_btnback,
        overFile=img_btnback,
        width=screenW*.1, height=screenH*.05,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW*.15
    backButton.y = screenH*.3
    gdisplay:insert(backButton)

    return true
end

function scene:createScene( event )
    native.setActivityIndicator( false )
    gdisplay = display.newGroup()
    local group = self.view
     user_id = event.params.user_id
     chapter_id =  event.params.chapter_id
     map_id =  event.params.map_id
     mission_id = event.params.mission_id
    mission_stamina = event.params.mission_stamina

    local  img_text= "img/text/GUEST_SELECT.png"

    gdisplay:insert(background)

    titleText = display.newImageRect( img_text,screenW/2.65,screenH/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x =screenW /2
    titleText.y =screenH /3.1
    gdisplay:insert(titleText)
    loadcharacter()
    scrollViewList()

    group:insert(gdisplay)

    menu_barLight.checkMemory()
    ------------- other scene ---------------
--    storyboard.removeAll ()
--    storyboard.purgeAll()
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "mission" )
    storyboard.purgeScene( "team_select" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view

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


