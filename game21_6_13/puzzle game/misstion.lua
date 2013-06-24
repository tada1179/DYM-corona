
print("misstion.lua")

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local http = require("socket.http")
local json = require("json")
local includeFUN = require("includeFunction")
-----------------------------------------------------------------------------------------

local screenW, screenH = display.contentWidth, display.contentHeight

local backButton
local scrollView

local user_Lv
local user_id
local rowMission
local state_id = {}
local mission_name = {}
local mission_pass = {}
local mission_img = {}
local mission_lv = {}
local mission_amount = {}
local mission_no = {}
local ID_clear = {}

local function onBtnRelease(event)
    print( "event: "..event.target.id)

   if event.target.id == "back" then -- back button
        storyboard.gotoScene( "map" ,"fade", 100 )
    else
        storyboard.gotoScene( "guest" ,"fade", 100 )
   end

    return true
end

local function createBackButton()
    backButton = widget.newButton{
        default="img/background/button/Button_BACK.png",
        over="img/background/button/Button_BACK.png",
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
end

local function scrollViewList()
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

            local dy = math.abs( event.y - event.yStart )
            print("dy",dy)

            if  dy > 5 then
                scrollView:takeFocus( event )
            end

        elseif event.phase == "release" then
            print(event.target.id)
            print( "Button pushed." )
            onBtnRelease(event)

        end

        return true
    end

    local Linkmission = "http://localhost/dym/mission_list.php"
    local numberHold_character =  Linkmission.."?user_id="..user_id.."&user_Lv="..user_Lv
    local numberHold = http.request(numberHold_character)

    if numberHold == nil then
        print("No Dice")
    else
        local allRow  = json.decode(numberHold)
        rowMission = allRow.All

        local k = 1
        while(k <= rowMission) do
            state_id[k] = allRow.state[k].mission_id
            mission_name[k] = allRow.state[k].mission_name
            mission_img[k] = allRow.state[k].mission_img
            mission_lv[k] = allRow.state[k].mission_lv
            mission_amount[k] = tonumber(allRow.state[k].mission_amount)
            mission_no[k] = tonumber(allRow.state[k].mission_no)
            ID_clear[k] = allRow.state[k].ID_clear
            print("ID_clear[k]",ID_clear[k])
            k = k + 1
        end
    end

    scrollView = widget.newScrollView{
        width = screenW *.9,
        height = screenH * .52,
        top = screenH*.31,
        left = screenW*.01,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true

    }
    local pointListY = 0
    local pointNameY = screenH*.06
    local pointbattleY = screenH*.1
    local typeFont = native.systemFontBold

    print("rowMission",rowMission)
    for i = 1, rowMission, 1 do
        local listCharacter = {}
        local imgFrmList =
        {

            "img/background/frame/Frame_mission_new.png",
            "img/background/frame/Frame_mission_clear.png"
        }

        listCharacter[i] = widget.newButton{
            default = imgFrmList[ID_clear[i]],
            width = screenW * 1 , height= screenH *.2,
            top = pointListY,
            left = 0,

            onEvent = onButtonEvent	-- event listener function
        }
        listCharacter[i].id = i
        scrollView:insert(listCharacter[i])

        local NameMission = display.newText(mission_name[i], screenW*.18, pointNameY,typeFont, 20)
        NameMission:setTextColor(255, 0, 255)
        scrollView:insert(NameMission)

        local txtbattle = display.newText("Battle "..mission_amount[i], screenW*.68, pointbattleY,typeFont, 20)
        txtbattle:setTextColor(200, 200, 200)
        scrollView:insert(txtbattle)

        local txtstamina = display.newText("stamina "..mission_amount[i], screenW*.68, pointNameY,typeFont, 20)
        txtstamina:setTextColor(0, 0, 255)
        scrollView:insert(txtstamina)

        pointbattleY = pointbattleY + (screenH*.11)
        pointNameY = pointNameY + (screenH*.11)
        pointListY = pointListY + (screenH*.11)
    end

end
function scene:createScene( event )
    print("--------------createScene----------------")
    local group = self.view
    local gdisplay = display.newGroup()
    local img_back = "img/background/background_1.jpg"
    local img_text =  "img/text/MISSION_SELECT.png"
    user_id = includeFUN.USERIDPhone()
    user_Lv = menu_barLight.userLevel()

    local background = display.newImageRect(img_back , screenW, screenH )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0

    local titleText = display.newImageRect(img_text,screenW/2.65,screenH/35.5 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW/2
    titleText.y = screenH /3.1

    scrollViewList()
    createBackButton()

    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)


    group:insert(background)

    group:insert(scrollView)
    group:insert(backButton)
    group:insert(titleText)
    group:insert(gdisplay)

    ------------- other scene ---------------
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "map" )

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


