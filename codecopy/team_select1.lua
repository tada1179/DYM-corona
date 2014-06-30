module(..., package.seeall)
local storyboard = require( "storyboard" )
local sqlite3 = require( "sqlite3" )
storyboard.purgeOnSceneChange = true
-----------------------------------------------------------------
local screenW = display.contentWidth
local screenH = display.contentHeight
local widget = require "widget"
local typeFont = "CooperBlackMS"
local tapdisplay

local Rowdata
local PinData

local function menuMode(event)
    if "ended" == event.phase   then
        print("team 1 event.target.id == ",event.target.id,"PinData[event.target.id].pin_id === ",PinData[event.target.id].pin_id)
        local option = {
            team_no = 1,
            color = event.target.id,
            pin_id =  PinData[event.target.id].pin_id
        }
        require("info").PinSetting(option)
    end

    return true
end
function newTEAM(USERID)

    tapdisplay = display.newGroup()
    local num = 2
    local numColum = 3
    local pointX = -screenW*.35
    local pointY = -screenH*.24

    local pointXBall = -screenW*.25
    local pointYBall = -screenH*.245
    local image_background = "img/clear_frame/frm_pintag.png"
    local picture = {}
    local name_pin = {
        "FIRE",
        "WOOD",
        "WATER",
        "DARK",
        "CURE",
        "BOLT",
    }
    local count = 0
    local text

    Rowdata = 0
    PinData = {}

    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    for AllPindata in db:nrows ("SELECT * FROM team WHERE team_no = '1';") do

        Rowdata = Rowdata + 1
        PinData[Rowdata] = {}
        PinData[Rowdata].team_id = AllPindata.team_id
        PinData[Rowdata].team_name = AllPindata.team_name
        PinData[Rowdata].pin_id = tonumber(AllPindata.pin_id)

        for MyPin in db:nrows ("SELECT * FROM pin WHERE pin_id = '"..PinData[Rowdata].pin_id.."';") do
            PinData[Rowdata].pin_imgmini = MyPin.pin_imgmini
            PinData[Rowdata].pin_name = MyPin.pin_name
            PinData[Rowdata].pin_no = MyPin.pin_no
        end
    end

    local imgBar = "img/ally_frame/frm_allytag_all.png"
    local navBarGraphic = display.newImage(imgBar )
    --    navBarGraphic:setReferencePoint( display.TopLeftReferencePoint )
    navBarGraphic.anchorX = 0
    navBarGraphic.anchorY = 0
    navBarGraphic.y = pointY
    navBarGraphic.x = pointX
    tapdisplay:insert(navBarGraphic)

    for i = 1,num,1 do
        picture[i] = {}
        for j = 1,numColum,1 do
            count = count + 1

            local IMGmini = display.newImageRect( PinData[count].pin_imgmini,96,96 )
            IMGmini.x = pointXBall
            IMGmini.y = pointYBall + screenH*.02
            IMGmini.anchorX = 0.5
            IMGmini.anchorY = 0
            tapdisplay:insert( IMGmini )

            pointXBall = pointXBall + screenW*.255
        end
        pointXBall = -screenW*.25
        pointYBall = pointYBall + screenH*.157
    end
    ---------------------------

    function tapdisplay:cleanUp()
        tapdisplay:removeSelf()
    end


    return tapdisplay
end
