print("item1.lua")
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

local pointY = screenH*.5

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
    local navBar = display.newGroup()
    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09

    local leader = {}
    local picture = {}
    local imageName = "img/framCharacterIcon/as_cha_frm01.png"
    local imagePicture = "img/framCharacterIcon/as_cha_icon_test1001.png"

    local function selectLeader(event)
        if event.target.id == "leader1" then
            print("event: "..event.target.id)
            storyboard.gotoScene( "battle_item", "fade", 100 )

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


    for i = 1, 5, 1 do
        leader[i] = widget.newButton{
            default = imageName,
            over = imageName,
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

--
--    local tap_team = display.newImageRect(image_tapteam,screenW*.55,screenH*.028)
--    g:insert(tap_team)
--    tap_team.x = screenW *.48
--    tap_team.y = pointY * .05


    function g:cleanUp()
        g:removeSelf()
    end




    return g
end
