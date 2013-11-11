print("itemselect1.lua")
module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local http = require("socket.http")
local json = require("json")
local includeFUN = require("includeFunction")
-----------------------------------------------
local data = {}
local ItemNumber = 1
local LinkURL = "http://133.242.169.252/DYM/setTeam.php"
local image_tapteam = "img/background/team/as_team_icn_team01.png"
local image_tapcoler_status = "img/background/team/as_team_status.png"
local image_tapstatus = "img/background/team/as_team_icn_teamsta.png"
local screenW = display.contentWidth
local screenH = display.contentHeight

local limititem = 5
local pointY = screenH *.1

function new()
    local USERID = includeFUN.USERIDPhone()
    print("team main USERID:"..USERID)

    local g = display.newGroup()
    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09

    local leader = {}
    local picture = {}
    local imageName = "img/characterIcon/as_cha_frm01.png"
    local imagePicture = "img/characterIcon/img/icon_test1001.png"
    local image_title = "img/background/tapitem_team/as_team_icn_iem01.png"

    local titleTeam = display.newImageRect(image_title,display.contentWidth*.8,display.contentHeight*.025)
    titleTeam:setReferencePoint( display.CenterReferencePoint )
    titleTeam.x = display.contentWidth *.48
    titleTeam.y = display.contentHeight *.03
    g:insert(titleTeam)

    local function selectLeader(event)
        local options =
        {
            effect = "fade",
            time = 100,
            params =
            {
                holddteam_no = event.target.id ,
                character_id = event.target.id  ,
                item_id = ItemNumber ,
                user_id = USERID
            }
        }
        print("event: "..event.target.id)
        if event.target.id == "leader1" then
            storyboard.gotoScene( "battle_item", "fade", 100 )

        elseif event.target.id == "leader2" then
            storyboard.gotoScene( "character", "fade", 100 )

        elseif event.target.id == "leader3" then
            storyboard.gotoScene( "game-scene", "fade", 100 )

        elseif event.target.id == "leader4" then

        elseif event.target.id == "leader5" then

        end
        --g:removeSelf()

    end


    for i = 1, limititem, 1 do
        leader[i] = widget.newButton{
            defaultFile = imageName,
            overFile = imageName,
            width= sizeleaderW,
            height= sizeleaderH,
            onRelease = selectLeader
        }
        leader[i].id="leader"..i
        leader[i]:setReferencePoint( display.CenterReferencePoint )
        leader[i].x = i * (display.contentWidth/7)
        leader[i].y = pointY

        picture[i] = display.newImageRect(imagePicture,sizeleaderW,sizeleaderH)
        picture[i]:setReferencePoint( display.CenterReferencePoint )
        picture[i].x = leader[i].x
        picture[i].y = pointY

        g:insert(picture[i])
        g:insert(leader[i])
    end

    function g:cleanUp()
        g:removeSelf()
    end




    return g
end
