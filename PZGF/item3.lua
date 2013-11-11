print("item3.lua")
module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local http = require("socket.http")
local json = require("json")
local includeFUN = require("includeFunction")
-----------------------------------------------------------------

local screenW = display.contentWidth
local screenH = display.contentHeight
local pointY = display.contentHeight * 1.12

function newitem()
    local SysdeviceID
    local data = {}
    local maxCharac = 5
    local itemNumber = 3
    local LinkURL = "http://133.242.169.252/DYM/item.php"

    -- *** ---- ***
    local maxelement = 5
    local typetxt = native.systemFontBold
    local sizetxt =  18
    local imageName = "img/characterIcon/as_cha_frm00.png"
    local frame0 = "img/characterIcon/as_cha_frm00.png"
    local image_tapteam = "img/background/tapitem_team/as_team_icn_iem03.png"
    local frame = {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }


    local user_id = includeFUN.USERIDPhone()
    local g = display.newGroup()
    local group = display.newGroup()
    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09

    local rowCharac
    local holditem_id = {}
    local item_name = {}
    local holditem_amount = {}
    local element = {}
    local picture = {}
    local imagePicture = {}
    local FRleader = {}
    local imagefrm = {}
    local excoin = {}
    local ticket = {}

    -- **** connect database
    local URL =  LinkURL.."?user_id="..user_id.."&holditem="..itemNumber
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        local dataTable = json.decode(response)
        rowCharac = dataTable.All

        local m = 1
        while m <= rowCharac do
            if dataTable.chracter ~= nil then

                holditem_id[m] = dataTable.chracter[m].holditem_id
                item_name[m] = dataTable.chracter[m].item_name
                imagePicture[m] = dataTable.chracter[m].img
                imagefrm[m] = tonumber(dataTable.chracter[m].element)

            else
                -- print("ELSE ELSE dataTable.chracter::"..dataTable.chracter)
                imagePicture[m] = imageName
                imagefrm[m] = frame0

            end

            m = m + 1
        end
    end

    local function selectLeader(event)
        --local leaderNo = event.target.id
        local options =
        {
            effect = "fade",
            time = 100,
            params =
            {
                holditem = itemNumber
            }
        }
        print("1111 event: "..event.target.id)
        if event.target.id == 1 then
            storyboard.gotoScene( "team_item", options )

        elseif event.target.id == 2 then
            storyboard.gotoScene( "team_item", options )

        elseif event.target.id == 3 then
            storyboard.gotoScene( "team_item", options )

        elseif event.target.id == 4 then
            storyboard.gotoScene( "team_item", options)

        elseif event.target.id == 5 then
            storyboard.gotoScene( "team_item", options )

        end
        --g:removeSelf()

    end
    --print("team_no[1]:"..team_no[1])

    for i = 1, maxCharac, 1 do
        if i <= rowCharac  then
            picture[i] = display.newImageRect(imagePicture[i],sizeleaderW,sizeleaderH)
            --            picture[i]:setReferencePoint( display.CenterReferencePoint )
            g:insert(picture[i])
            picture[i].x = i * (display.contentWidth/7.5)
            picture[i].y = pointY

            FRleader[i] = widget.newButton{
                default = frame[imagefrm[i]],
                over = frame[imagefrm[i]],
                width= sizeleaderW,
                height= sizeleaderH,
                onRelease = selectLeader
            }
            FRleader[i].id= i
            FRleader[i]:setReferencePoint( display.CenterReferencePoint )
            g:insert(FRleader[i])
            FRleader[i].x = i * (display.contentWidth/7.5)
            FRleader[i].y = pointY

        else
            FRleader[i] = widget.newButton{
                default = frame0,
                over = frame0,
                width= sizeleaderW,
                height= sizeleaderH,
                onRelease = selectLeader
            }
            FRleader[i].id= i
            FRleader[i]:setReferencePoint( display.CenterReferencePoint )
            g:insert(FRleader[i])
            FRleader[i].x = i * (display.contentWidth/7.5)
            FRleader[i].y = pointY

        end

    end


    local tap_team = display.newImageRect(image_tapteam,screenW*.78,screenH*.028)
    tap_team:setReferencePoint( display.CenterReferencePoint )
    g:insert(tap_team)
    tap_team.x = screenW *.4
    tap_team.y = pointY * .92
    -------------------------
    -------------------------

    function g:cleanUp()
        g:removeSelf()
    end


    return g
end
