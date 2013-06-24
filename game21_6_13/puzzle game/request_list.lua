print("request_list.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
local includeFUN = require("includeFunction")
local alertMSN = require("alertMassage")
---------------------------------------------------------------


local screenW, screenH = display.contentWidth, display.contentHeight
local backButton
local scrollView
local maxlistFriend

local function BackRelease(event)
    if event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "commu_main" ,"fade", 100 )
    end
    return true	-- indicates successful touch
end

local function createBackButton()
    backButton = widget.newButton{
        default="img/background/button/Button_BACK.png",
        over="img/background/button/Button_BACK.png",
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = BackRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
end

local function scrollViewList()
    local charac_id ={}
    local friend_id ={}
    local friend_name ={}
    local charac_img ={}
    local element ={}
    local charac_lv ={}
    local friend_lv ={}
    local dateModify ={}

    local img_frmList = "img/background/sellBattle_Item/frame.png"
    local user_id = includeFUN.USERIDPhone()
    local function onButtonEvent(event)

        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
            local scrollBar = self.scrollBar
        elseif event.phase == "moved" then


            print("----///event.y:"..event.y)

            if event.markY ~= event.y and event.markX == event.x then
                print("if mark")
            else
                print("else mark")
            end

            --local dx = math.abs( event.x - event.xStart )
            local dy = math.abs( event.y - event.yStart )
            print("dy",dy)
            -- if finger drags button more than 5 pixels, pass focus to scrollView
            if  dy > 5 then
                scrollView:takeFocus( event )
                --moveScrollBar(dy)
            end

        elseif event.phase == "release" then

            local option = {
                effect = "fade",
                time = 100,
                params = {
                    user_id = user_id,
                    charac_id = charac_id[event.target.id],
                    friend_id = friend_id[event.target.id],
                    friend_name = friend_name[event.target.id],
                    charac_img = charac_img[event.target.id],
                    dateModify = dateModify[event.target.id],
                    element = element[event.target.id],
                    charac_lv = charac_lv[event.target.id],
                    friend_lv = friend_lv[event.target.id],
                }
            }
            print(event.target.id)
            print( "Button pushed." )
            --onBtnRelease(event)
            alertMSN.accepFriend(option)

        end

        return true
    end


    local LinkFriend = "http://localhost/DYM/request_list.php"
    local numberHold_character =  LinkFriend.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)

    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        maxlistFriend = allRow.All
        print("Allcharacter",maxlistFriend)

        local k = 1
        while(k <= maxlistFriend) do
            charac_id[k] = allRow.chracter[k].charac_id
            friend_id[k] = allRow.chracter[k].friend_id
            friend_name[k] = allRow.chracter[k].friend_name
            charac_img[k] = allRow.chracter[k].charac_img_mini
            dateModify[k] = allRow.chracter[k].team_lastuse
            element[k] = tonumber(allRow.chracter[k].charac_element)
            charac_lv[k] = tonumber(allRow.chracter[k].charac_lv)
            friend_lv[k] = tonumber(allRow.chracter[k].friend_lv)
            k = k + 1
        end
    end


    scrollView = widget.newScrollView{
        width = screenW *.9,
        height = screenH * .48,
        top = screenH *.35,
        left = 0,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true,
        horizontalScrollDisabled = true ,--slide
        verticalScrollDisabled = false ,--up
    }
    local frame =
    {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }

    local sizeleaderW = screenW*.15
    local sizeleaderH = screenH*.1
    local imagePicture = "img/characterIcon/img/icon_test1001.png"

    local pointLVtxtY = screenH*.09
    local pointNametxtY = screenH*.01
    local pointFrameY = screenH*.01
    local pointFrameY_ing = screenH*.06
    local pointFrameX_ing = screenW*.17

    local typeFont = native.systemFontBold
    local sizetextName = 22
    local sizetextdata = 18

    for i = 1, maxlistFriend, 1 do
        local listCharacter = {}
        local picture = {}
        local imgFrm = {}

        listCharacter[i] = widget.newButton{
            default= img_frmList,
            width= screenW * .75 ,
            height= screenH *.1,
            top = pointFrameY,
            left = screenW*.1 ,
            onEvent = onButtonEvent	-- event listener function
        }
        listCharacter[i].id = i
        scrollView:insert(listCharacter[i])

        picture[i] = display.newImageRect(charac_img[i],sizeleaderW,sizeleaderH)
        picture[i]:setReferencePoint( display.CenterReferencePoint )
        picture[i].x = pointFrameX_ing
        picture[i].y = pointFrameY_ing
        scrollView:insert(picture[i])

        imgFrm[i] = display.newImageRect(frame[element[i]],sizeleaderW,sizeleaderH)
        imgFrm[i]:setReferencePoint( display.CenterReferencePoint )
        imgFrm[i].x = pointFrameX_ing
        imgFrm[i].y = pointFrameY_ing
        scrollView:insert(imgFrm[i])

        local NameText = display.newText(friend_name[i], screenW*.3, pointNametxtY,typeFont, sizetextName)
        NameText:setTextColor(200, 200, 200)
        scrollView:insert(NameText)

        local LVCharacter = display.newText("Lv."..charac_lv[i], screenW*.13, pointLVtxtY,typeFont, sizetextName)
        LVCharacter:setTextColor(200, 200, 200)
        scrollView:insert(LVCharacter)

        local LVFriend = display.newText("Lv."..friend_lv[i], screenW*.7, pointNametxtY,typeFont, sizetextName)
        LVFriend:setTextColor(200, 200, 200)
        scrollView:insert(LVFriend)

        local dateText = display.newText(dateModify[i], screenW*.3, pointLVtxtY-(screenH*.008),typeFont, sizetextdata)
        dateText:setTextColor(200, 200, 200)
        scrollView:insert(dateText)


        pointLVtxtY = pointLVtxtY + (screenH*.11)
        pointNametxtY = pointNametxtY + (screenH*.11)
        pointFrameY = pointFrameY + (screenH*.11)
        pointFrameY_ing = pointFrameY_ing + (screenH*.11)
    end

end


function scene:createScene( event )
    local image_background = "img/background/background_1.jpg"
    local image_text = "img/text/REQUEST_LIST_TXT.png"

    local group = self.view
    local gdisplay = display.newGroup()
    local background = display.newImageRect( image_background, screenW, screenH )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local titleText = display.newImageRect( image_text, display.contentWidth/3.4, display.contentHeight/32 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.1

    createBackButton()
    scrollViewList()
    if maxlistFriend == 0 then
        --alert MSN  NO have list Request
        alertMSN.NoDataInList()
    end

    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)


    group:insert(background)
    group:insert(scrollView)
    group:insert(titleText)
    group:insert(backButton)
    group:insert(gdisplay)

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
