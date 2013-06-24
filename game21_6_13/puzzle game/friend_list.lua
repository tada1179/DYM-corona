print("friend_list.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
local charac_scene = require("character_scene")
local includeFUN = require("includeFunction")
-------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight

local backButton
local scrollView
local Allcharacter

local charac_id ={}
local friend_userid ={}
local friend_id ={}
local friend_name ={}
local charac_img ={}
local element ={}
local level ={}
local dateModify ={}


local user_id

local function BackRelease(event)
    if event.target.id == "back" then -- back button
        print( "event: "..event.target.id)
        storyboard.gotoScene( "commu_main" ,"fade", 100 )
    end
    return true	-- indicates successful touch
end

local function createBackButton()
    local img_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        default= img_btnback,
        over= img_btnback,
        width= screenW/10, height= screenH/21,
        onRelease = BackRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW - (screenW *.845)
    backButton.y = screenH - (screenH *.7)
end

local function onBtnRelease(event)
    print("onBtnRelease charac_id ",charac_id[event.target.id])
    print("onBtnRelease friend_userid ",friend_userid[event.target.id])
    print("onBtnRelease friend_name ",friend_name[event.target.id])

    charac_scene.characterFriend_remove(charac_id[event.target.id],friend_userid[event.target.id],user_id)


end

local function scrollViewList()
    user_id = includeFUN.USERIDPhone()
    local img_framelist = "img/characterIcon/framelist.png"
    local frame = {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }



    local LinkFriend = "http://localhost/DYM/friend_list.php"
    local numberHold_character =  LinkFriend.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)

    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        Allcharacter = allRow.All
        print("Allcharacter",Allcharacter)

        local k = 1
        while(k <= Allcharacter) do
            charac_id[k] = allRow.chracter[k].charac_id
            friend_userid[k] = allRow.chracter[k].friend_userid

            friend_id[k] = allRow.chracter[k].friend_id
            print("charac_id[k]",charac_id[k])
            print("friend_userid[k]",friend_userid[k])

            friend_name[k] = allRow.chracter[k].friend_name
            charac_img[k] = allRow.chracter[k].friend_img_mini
            print("friend_name[k] :",friend_name[k])
            print("charac_img[k] :",charac_img[k])
            dateModify[k] = allRow.chracter[k].friend_modify
            element[k] = tonumber(allRow.chracter[k].friend_element)
            level[k] = tonumber(allRow.chracter[k].friend_lv)
            k = k + 1
        end
    end

    local function onButtonEvent(event)
        print(event.phase)

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
            print(event.target.id)
            print( "Button pushed." )
            onBtnRelease(event)

        end

        return true
    end

    scrollView = widget.newScrollView{
        width = screenW*.75,
        height = screenH* .62,
        top = screenH* .2,
        left = screenW*.1,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true
    }

    local pointtapList = 0
    local d = tonumber(os.date())
    for i = 1, Allcharacter, 1 do
        local listCharacter = {}
        local typeFont = native.systemFontBold
        local sizetext = 18
        local imgFrame
        local imgCharac = {}
        local img_list = "img/characterIcon/framelist.png"
        local img_charac = "img/characterIcon/img/icon_test1001.png"
        local sizecharacH =  screenH*.09
        local sizecharacW =  screenW*.137

        local pointFrameX = screenW*.02
        local pointFrameY = (screenH*.05)+(i*95)

        local pointLVX = screenW*.06
        local pointLVY = (screenH*.118)+(i*95)

        local pointNameX = screenW*.2
        local pointNameY = (screenH*.05)+(i*95)

        local pointDateX = screenW*.6
        local pointDateY = (screenH*.05)+(i*95)

        listCharacter[i] = widget.newButton{
            default=img_list,
            --over="img/background/character/BLOCK_NEW_LAYOUT_2.png",
            width= screenW * .75 ,
            height= screenH *.09,
            top = pointFrameY,
            left = pointFrameX,
            onEvent = onButtonEvent	-- event listener function
        }
        listCharacter[i].id = i
        scrollView:insert(listCharacter[i])

        imgCharac[i] = display.newImageRect(charac_img[i] , sizecharacW, sizecharacH)
        imgCharac[i]:setReferencePoint( display.TopLeftReferencePoint )
        imgCharac[i].x = pointFrameX
        imgCharac[i].y = pointFrameY
        scrollView:insert(imgCharac[i])

        imgFrame = display.newImageRect(frame[element[i]] , sizecharacW, sizecharacH)
        imgFrame:setReferencePoint( display.TopLeftReferencePoint )
        imgFrame.x = pointFrameX
        imgFrame.y = pointFrameY
        scrollView:insert(imgFrame)

        local playday = dateModify[i]
        local countDate
        print("to day:",d,"playday:",playday)

        local showLV = display.newText("Lv."..level[i], pointLVX, pointLVY,typeFont, sizetext)
        showLV:setTextColor(255, 0, 255)
        local showName = display.newText(friend_name[i], pointNameX, pointNameY,typeFont, sizetext)
        showName:setTextColor(255, 255, 255)
        local showDate = display.newText(level[i], pointDateX, pointDateY,typeFont, sizetext)
        showDate:setTextColor(0, 0, 255)

        scrollView:insert(showLV)
        scrollView:insert(showName)
        scrollView:insert(showDate)

    end

end


function scene:createScene( event )
    local group = self.view
    local gdisplay = display.newGroup()
    local image_background = "img/background/background_1.jpg"
    local image_text = "img/text/FRIEND_SELECT.png"

    local background = display.newImageRect( image_background, screenW, screenH )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local titleText = display.newImageRect( image_text, screenW/3.4, screenH/32 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH /3.1

    createBackButton()
    scrollViewList()
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
