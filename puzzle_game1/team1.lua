print("team1.lua")
module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local http = require("socket.http")
local json = require("json")
local data = {}
local teamNumber = 1
local LinkURL = "http://localhost/DYM/setTeam.php"
local image_tapteam = "img/background/team/as_team_icn_team01.png"
local image_tapcoler_status = "img/background/team/as_team_status.png"
local image_tapstatus = "img/background/team/as_team_icn_teamsta.png"
local screenW = display.contentWidth
local screenH = display.contentHeight

local pointY = display.contentHeight * 1.12
--
--local function LoadTeam()
--    local dataTable
--    local URL =  LinkURL.."?teamNumber="..teamNumber
--    local response = http.request(URL)
--    if response == nil then
--        print("No Dice")
--    else
--        print("i"..i)
--        dataTable = json.decode(response)
--        data[i] = "ID:"..dataTable.ticket_id.."amound:"..dataTable.ticket_amound.."price:"..dataTable.ticket_price;
--        data[i] = {}
--        data[i].ticket_id = dataTable.ticket_id
--        data[i].ticket_amound = dataTable.ticket_amound
--        data[i].ticket_price = dataTable.ticket_price
--        data[i].ticket_img = dataTable.ticket_img
--    end
--end
--
local function selectLeader(event)
    if event.target.id == "leader1" then
        print("event: "..event.target.id)
        storyboard.gotoScene( "character", "fade", 100 )
    elseif event.target.id == "leader2" then

        print("event: "..event.target.id)
        storyboard.gotoScene( "character", "fade", 100 )

    elseif event.target.id == "leader3" then

        print("event: "..event.target.id)
    elseif event.target.id == "leader4" then

        print("event: "..event.target.id)
    elseif event.target.id == "leader5" then

        print("event: "..event.target.id)
    end
    --g:removeSelf()

end

function new()
    local g = display.newGroup()
    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09

    local leader = {}
    local picture = {}
    local imageName = "img/framCharacterIcon/as_cha_frm01.png"
    local imagePicture = "img/framCharacterIcon/as_cha_icon_test1001.png"

    local function selectLeader(event)
        if event.target.id == "leader1" then
            print("event: "..event.target.id)
            storyboard.gotoScene( "team_item", "fade", 100 )
        elseif event.target.id == "leader2" then

            print("event: "..event.target.id)
            storyboard.gotoScene( "character", "fade", 100 )

        elseif event.target.id == "leader3" then

            print("event: "..event.target.id)
            storyboard.gotoScene( "game-scene", "fade", 100 )

        elseif event.target.id == "leader4" then

            print("event: "..event.target.id)
        elseif event.target.id == "leader5" then

            print("event: "..event.target.id)
        end
        --g:removeSelf()

    end
    picture[1] = display.newImageRect(imagePicture,sizeleaderW,sizeleaderH)
    picture[1]:setReferencePoint( display.CenterReferencePoint )
    g:insert(picture[1])
    picture[1].x = display.contentWidth - (display.contentWidth*.93)
    picture[1].y = pointY

    leader[1] = widget.newButton{
        default = imageName,
        over = imageName,
        width = sizeleaderW ,
        height= sizeleaderH,
        onRelease = selectLeader
    }
    leader[1].id="leader1"
    leader[1]:setReferencePoint( display.CenterReferencePoint )
    g:insert(leader[1])
    leader[1].x = display.contentWidth - (display.contentWidth*.93)
    leader[1].y = pointY

    leader[2] = widget.newButton{
        default = imageName,
        over = imageName,
        width= sizeleaderW,
        height= sizeleaderH,
        onRelease = selectLeader
    }
    leader[2].id="leader2"
    leader[2]:setReferencePoint( display.CenterReferencePoint )
    g:insert(leader[2])
    leader[2].x = 2*(display.contentWidth/7)
    leader[2].y = pointY

    for i = 3, 5, 1 do
        leader[i] = widget.newButton{
            default = imageName,
            over = imageName,
            width= sizeleaderW,
            height= sizeleaderH,
            onRelease = selectLeader
        }
        leader[i].id="leader"..i
        leader[i]:setReferencePoint( display.CenterReferencePoint )
        g:insert(leader[i])
        leader[i].x = i * (display.contentWidth/7)
        leader[i].y = pointY

    end

    local tap_coler = display.newImageRect(image_tapcoler_status,screenW*.43,screenH*.13,true)
    g:insert(tap_coler)
    tap_coler.x = screenW *.305
    tap_coler.y = pointY * 1.2


    local tap_status = display.newImageRect(image_tapstatus,screenW*.78,screenH*.028,true)
    g:insert(tap_status)
    tap_status.x = screenW * .38
    tap_status.y = pointY * 1.095


    local tap_team = display.newImageRect(image_tapteam,screenW*.55,screenH*.028)
    g:insert(tap_team)
    tap_team.x = screenW *.48
    tap_team.y = pointY * .92
    -------------------------
    -------------------------

    local txtHP = display.newText("HP", 0, 0, native.systemFontBold, 18)
    txtHP:setTextColor(255, 255, 255)
    g:insert(txtHP)
    txtHP.x = screenW*0.12
    txtHP.y = pointY*1.125

    local txtHPplus = display.newText("HP000", 0, 0, native.systemFontBold, 18)
    txtHPplus:setTextColor(255, 0, 255)
    g:insert(txtHPplus)
    txtHPplus.x = screenW*0.26
    txtHPplus.y = pointY*1.125

    local txtgreen = display.newText("GRE00", 0, 0, native.systemFontBold, 18)
    txtgreen:setTextColor(255, 255, 0)
    g:insert(txtgreen)
    txtgreen.x = screenW*0.26
    txtgreen.y = pointY*1.16

    local txtred = display.newText("red00", 0, 0, native.systemFontBold, 18)
    txtred:setTextColor(200, 0, 200)
    g:insert(txtred)
    txtred.x = screenW*0.26
    txtred.y = pointY*1.2

    local txtblue = display.newText("blu00", 0, 0, native.systemFontBold, 18)
    txtblue:setTextColor(0, 255, 255)
    g:insert(txtblue)
    txtblue.x = screenW*0.26
    txtblue.y = pointY*1.24

    ----- *** ------
    local txtCost = display.newText("COST", 0, 0, native.systemFontBold, 18)
    txtCost:setTextColor(255, 255, 255)
    g:insert(txtCost)
    txtCost.x = screenW*0.515
    txtCost.y = pointY*1.125


    local txtCostplus = display.newText("txtCOS", 0, 0, native.systemFontBold, 18)
    txtCostplus:setTextColor(255, 0, 255)
    g:insert(txtCostplus)
    txtCostplus.x = screenW*0.64
    txtCostplus.y = pointY*1.125

    local txtyellow = display.newText("yellow", 0, 0, native.systemFontBold, 18)
    txtyellow:setTextColor(255, 255, 255)
    g:insert(txtyellow)
    txtyellow.x = screenW*0.64
    txtyellow.y = pointY*1.16

    local txtpurple = display.newText("purp", 0, 0, native.systemFontBold, 18)
    txtpurple:setTextColor(255, 255, 255)
    g:insert(txtpurple)
    txtpurple.x = screenW*0.64
    txtpurple.y = screenH*.92
--    txtpurple.y = pointY*1.2


    local txtpink = display.newText("pink0", 0, 0, native.systemFontBold, 18)
    txtpink:setTextColor(255, 255, 255)
    g:insert(txtpink)
    txtpink.x = screenW*0.64
    txtpink.y = pointY*1.24





    ---------------------------
    ---------------------------

    function g:cleanUp()
        g:removeSelf()
    end




    return g
end
