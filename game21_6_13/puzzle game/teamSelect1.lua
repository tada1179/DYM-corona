print("teamselect1.lua")
module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local http = require("socket.http")
local json = require("json")
local includeFUN = require("includeFunction")
-----------------------------------------------------------------
local data = {}
local maxCharac = 5
local teamNumber = 1
local itemImg = 1
local LinkURL = "http://localhost/DYM/team_setting.php"

local maxelement = 5
------
local typetxt = native.systemFontBold
local sizetxt =  18
local imageName = "img/characterIcon/as_cha_frm00.png"
local frame0 = "img/characterIcon/as_cha_frm00.png"
local frame = {
    "img/characterIcon/as_cha_frm01.png",
    "img/characterIcon/as_cha_frm02.png",
    "img/characterIcon/as_cha_frm03.png",
    "img/characterIcon/as_cha_frm04.png",
    "img/characterIcon/as_cha_frm05.png"
}

local image_tapteam = "img/background/tapitem_team/as_team_icn_team01.png"
local screenW = display.contentWidth
local screenH = display.contentHeight

local pointY = display.contentHeight * 1.12

function newTEAM()
    local USERID = includeFUN.USERIDPhone()
    print("team main USERID:"..USERID)

    local g = display.newGroup()
    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09


    local leader = {}
    local picture = {}

    local character_id = {}
    local imagePicture = {}
    local imagefrm = {}
    local team_no = {}

    -- **** connect database
    local URL =  LinkURL.."?user_id="..USERID.."&team_no="..teamNumber
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        local dataTable = json.decode(response)
        local rowCharac = dataTable.chrAll

        local m = 1
        while m <= rowCharac do
            if dataTable.chracter ~= nil then
                character_id[m] = dataTable.chracter[m].holdcharac_id
                imagePicture[m] = dataTable.chracter[m].imgMini
                imagefrm[m] = tonumber(dataTable.chracter[m].element)
                team_no[m] = tonumber(dataTable.chracter[m].team_no)
            else
                imagePicture[m] = imageName
                imagefrm[m] = frame0
                team_no[m] = 0
            end

            m = m + 1
        end
    end

    local function selectLeader(event)
        local options =
        {
            effect = "fade",
            time = 100,
            params =
            {
                holddteam_no = event.target.id ,
                character_id = event.target.id  ,
                team_id = teamNumber ,
                user_id = USERID
            }
        }
        print("event: "..event.target.id)
        if event.target.id == "Character" then
          --  storyboard.gotoScene( "team_item", options )

        else
            storyboard.gotoScene( "characterprofile", options )

        end

    end
    if team_no[1] == 1 then
        picture[1] = display.newImageRect(imagePicture[1],sizeleaderW,sizeleaderH)
        picture[1]:setReferencePoint( display.CenterReferencePoint )
        g:insert(picture[1])
        picture[1].x = display.contentWidth - (display.contentWidth*.93)
        picture[1].y = pointY

        leader[1] = widget.newButton{
            default = frame[imagefrm[1]],
            over = frame[imagefrm[1]],
            width = sizeleaderW ,
            height= sizeleaderH,
            --onRelease = selectLeader
        }
        leader[1].id= character_id[1]
        leader[1]:setReferencePoint( display.CenterReferencePoint )
        g:insert(leader[1])
        leader[1].x = display.contentWidth - (display.contentWidth*.93)
        leader[1].y = pointY

        itemImg = itemImg + 1
    else
        leader[1] = widget.newButton{
            default = frame0,
            over = frame0,
            width = sizeleaderW ,
            height= sizeleaderH,
            --onRelease = selectLeader
        }
        leader[1].id= "Character"
        leader[1]:setReferencePoint( display.CenterReferencePoint )
        g:insert(leader[1])
        leader[1].x = display.contentWidth - (display.contentWidth*.93)
        leader[1].y = pointY

    end

    local pointleader = leader[1].x
    for i = 2, maxCharac, 1 do
        if team_no[itemImg] == i then
            picture[i] = display.newImageRect(imagePicture[itemImg],sizeleaderW,sizeleaderH)
            picture[i]:setReferencePoint( display.CenterReferencePoint )
            picture[i].x = pointleader +  (screenW*.135)
            picture[i].y = pointY
            g:insert(picture[i])

            leader[i] = widget.newButton{
                default = frame[imagefrm[itemImg]],
                over = frame[imagefrm[itemImg]],
                width= sizeleaderW,
                height= sizeleaderH,
                --onRelease = selectLeader
            }
            leader[i].id= character_id[i]
            leader[i]:setReferencePoint( display.CenterReferencePoint )
            leader[i].x = pointleader +  (screenW*.135)--i * (display.contentWidth*.105)
            leader[i].y = pointY
            g:insert(leader[i])

            itemImg = itemImg + 1
        else
            leader[i] = widget.newButton{
                default = frame0,
                over = frame0,
                width= sizeleaderW,
                height= sizeleaderH,
               -- onRelease = selectLeader
            }
            leader[i].id=  "Character"
            leader[i]:setReferencePoint( display.CenterReferencePoint )
            leader[i].x = pointleader + (screenW*.135)
            leader[i].y = pointY
            g:insert(leader[i])
        end

        pointleader = leader[i].x

    end
    picture[maxCharac+1] = display.newImageRect(frame[2],sizeleaderW,sizeleaderH)
    picture[maxCharac+1]:setReferencePoint( display.CenterReferencePoint )
    picture[maxCharac+1].x = pointleader +  (screenW*.135)
    picture[maxCharac+1].y = pointY
    g:insert(picture[maxCharac+1])

    leader[maxCharac+1] = widget.newButton{
        default = frame[2],
        over = frame[2],
        width= sizeleaderW,
        height= sizeleaderH,
        onRelease = selectLeader
    }
    leader[maxCharac+1].id= character_id[maxCharac+1]
    leader[maxCharac+1]:setReferencePoint( display.CenterReferencePoint )
    leader[maxCharac+1].x = pointleader +  (screenW*.135)--i * (display.contentWidth*.105)
    leader[maxCharac+1].y = pointY
    g:insert(leader[maxCharac+1])
    ------------ ----------- ----------- -------------- ----------- --------------

    local tap_team = display.newImageRect(image_tapteam,screenW*.78,screenH*.028)
    tap_team:setReferencePoint( display.CenterReferencePoint )
    g:insert(tap_team)
    tap_team.x = screenW *.38
    tap_team.y = pointY * .92

    function g:cleanUp()
        g:removeSelf()
    end
    return g
end
