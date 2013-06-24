print("INCLUDEFUNCTION.LUA")
module(..., package.seeall)
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local json = require("json")
local http = require("socket.http")
local includeFUN = require("includeFunction")
--------------------------------------------------
local LinkuserID = "http://localhost/DYM/deviceID.php?SysdeviceID="

local screenW = display.contentWidth
local screenH = display.contentHeight
--------------------------------
function DriverIDPhone()
    local SysdeviceID = system.getInfo( "deviceID" ) -- deviceID IMEI Phone
    --print("System deviceID:"..SysdeviceID)
    return  SysdeviceID
end

function USERIDPhone()
    local SysdeviceID = system.getInfo( "deviceID" ) -- deviceID IMEI Phone
    local URL =  LinkuserID..SysdeviceID
    local response = http.request(URL)
    local USERID
    if response == nil then
        print("fail ! can't select user id")
    else
       -- print("includeFunction USER")
        local dataTable = json.decode(response)
        USERID = dataTable.deviceID1.user_id
        -- frist reccord select
    end
    return USERID
end
function pageWith()
    print("function pageWith")
    local typeFont = native.systemFontBold
    local sizetextName = 20
    local character_id =  id
    local Cholddteam_no =  holddteam_no
    local Cteam_id =  team_id
    local USER_id =  USERID
    local back_while
    local myRectangle
    local btn_cancel
    local btn_OK
    local SmachText

    local options =
    {
        effect = "fade",
        time = 100,
        params = {
            character_id =character_id ,
            holddteam_no =  Cholddteam_no,
            team_id =  Cteam_id ,
            user_id = USER_id
        }
    }

    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_ok = "img/background/button/OK_button.png"
    local groupView = display.newGroup()
    local groupEnd = display.newGroup()

    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        myRectangle.alpha  = 0
        SmachText.alpha = 0
        back_while.alpha = 0

        print( "infunction reset event: "..event.target.id)

        if event.target.id == "ok" then
            --print("reset team_id="..team_id,"user ="..USERID)
            local ulrResetsert = "http://localhost/DYM/resetTeam.php"
            local characResetsert =  ulrResetsert.."?team_no="..team_id.."&user_id="..USERID
            local complte = http.request(characResetsert)

            if complte then
                print("compleate",complte)
                storyboard.loadScene( "team_main",true ,options )
            end
        elseif event.target.id == "cancel" then

            storyboard.gotoScene( "team_main" ,options )
        end
    end

    myRectangle = display.newRect(screenW*.2, screenH*.4, screenW*.6, screenH*.2)
    myRectangle.strokeWidth = 3
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)
    groupView:insert(myRectangle)


    SmachText = display.newText("Just moment !", screenW*.27, screenH *.45,typeFont, sizetextName)
    SmachText:setTextColor(255, 255, 255)
    groupView:insert(SmachText)

    back_while = display.newRect(0, 0, screenW, screenH)
    back_while.strokeWidth = 3
    back_while.alpha = .1
    back_while:setFillColor(0, 0, 0)
    groupView:insert(back_while)

    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )

    return groupView
end

