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
        print("team 3 event.target.id == ",event.target.id,"PinData[event.target.id].pin_id === ",PinData[event.target.id].pin_id)
        local option = {
            team_no = 3,
            color = event.target.id,
            pin_id =  PinData[event.target.id].pin_id
        }
        require("info").PinSetting(option)
    end

    return true
end
function newTEAM(USERID)

    tapdisplay = display.newGroup()
    local num = 3
    local numColum = 2
    local pointX = -screenW*.23
    local pointY = -screenH*.32

    local pointXBall = -screenW*.315
    local pointYBall = -screenH*.31

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

    for AllPindata in db:nrows ("SELECT * FROM team WHERE team_no = '3';") do

        Rowdata = Rowdata + 1
        PinData[Rowdata] = {}
        PinData[Rowdata].team_id = AllPindata.team_id
        PinData[Rowdata].team_name = AllPindata.team_name
        PinData[Rowdata].pin_id = tonumber(AllPindata.pin_id)

        print("PinData[Rowdata].pin_id ============///========",PinData[Rowdata].pin_id)
        for MyPin in db:nrows ("SELECT * FROM pin WHERE pin_id = '"..PinData[Rowdata].pin_id.."';") do
            PinData[Rowdata].pin_imgmini = MyPin.pin_imgmini
            PinData[Rowdata].pin_name = MyPin.pin_name
            PinData[Rowdata].pin_no = MyPin.pin_no
        end
    end

    for i = 1,num,1 do
        picture[i] = {}
        for j = 1,numColum,1 do
            count = count + 1
            picture[i][j] = widget.newButton
                {
                    left = pointX,
                    top = pointY,
                    id = count,
                    defaultFile = image_background,
                    overFile = image_background,
                    onEvent = menuMode
                }
            picture[i][j].anchorX = 1
            tapdisplay:insert(picture[i][j])

            local IMGmini = display.newImageRect( PinData[count].pin_imgmini,96,96 )
            IMGmini.x = pointXBall
            IMGmini.y = pointYBall + screenH*.02
            IMGmini.anchorX = 0.5
            IMGmini.anchorY = 0
            tapdisplay:insert( IMGmini )

            if count == 3 then
                text = display.newText(PinData[count].pin_name,pointX ,pointY + screenH*.06,typeFont,30)
                text.anchorX = 0
                text.anchorY = 1
                tapdisplay:insert(text)
            else

                text = display.newText(PinData[count].pin_name,pointX+screenW*.01 ,pointY + screenH*.07,typeFont,30)
                text.anchorX = 0
                text.anchorY = 1
                tapdisplay:insert(text)
            end

            local text_no = display.newText("No."..PinData[count].pin_no,pointX+screenW*.01 ,pointY + screenH*.11,typeFont,30)
            text_no.anchorX = 0
            text_no.anchorY = 1
            tapdisplay:insert(text_no)

            pointX = pointX + screenW*.45
            pointXBall = pointXBall + screenW*.45
        end
        pointX = -screenW*.23
        pointY = pointY + screenH*.2

        pointXBall = -screenW*.315
        pointYBall = pointYBall + screenH*.2
    end


    ---------------------------

    function tapdisplay:cleanUp()
        tapdisplay:removeSelf()
    end


    return tapdisplay
end
