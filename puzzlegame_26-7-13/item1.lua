print("call fN item1.lua")
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
local pointY = display.contentHeight * .71
local pointY_tab = display.contentHeight * .63

function newitem(user_id)
    local SysdeviceID
    local data = {}
    local maxCharac = 5
    local groupItem = display.newGroup()
    -- *** ---- ***
    local typetxt = native.systemFontBold
    local sizetxt =  18
    local imageName = "img/characterIcon/as_cha_frm00.png"
    local frame0 = "img/characterIcon/as_cha_frm00.png"
    local image_tapteam = "img/background/tapitem_team/as_team_icn_iem01.png"
    local frame = {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }

    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09


    local useitem_id = {}
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
    local rowCharac
    local AllItem

    local LinkItem = "http://localhost/DYM/item.php"
    local URL =  LinkItem.."?user_id="..user_id
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        local dataTable = json.decode(response)

        rowCharac = dataTable.All
        print("rowCharac111144444",rowCharac)
        AllItem = dataTable.AllItem

        local m = 1
        while m <= rowCharac do
            if dataTable.chracter ~= nil then

                useitem_id[m] = dataTable.chracter[m].useitem_id
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

    local function selectItem(event)
        --local leaderNo = event.target.id
        local options =
        {
            effect = "fade",
            time = 100,
            params =
            {
                holditem = event.target.id,
                holditem_last = event.target.id,
                user_id = user_id
            }
        }
        --        print("phase",event.phase)
        --        print("target id",event.target.id)

        if event.phase then
            storyboard.gotoScene( "battle_item", options )
        else

            print("else phase")print("target id",event.target.id)
        end

        -- storyboard.gotoScene( "Itemprofile", options )  --no work

    end

    local pointitemX = screenW*.2
    for i = 1, maxCharac, 1 do
        if i <= rowCharac  then
            picture[i] = display.newImageRect(imagePicture[i],sizeleaderW,sizeleaderH)
            picture[i]:setReferencePoint( display.CenterReferencePoint )
            groupItem:insert(picture[i])
            picture[i].x = pointitemX
            picture[i].y = pointY

            FRleader[i] = widget.newButton{
                default = frame[imagefrm[i]],
                over = frame[imagefrm[i]],
                width= sizeleaderW,
                height= sizeleaderH,
                onRelease = selectItem
            }
            FRleader[i].id= useitem_id[i]
            FRleader[i]:setReferencePoint( display.CenterReferencePoint )
            groupItem:insert(FRleader[i])
            FRleader[i].x = pointitemX
            FRleader[i].y = pointY
        else
            FRleader[i] = widget.newButton{
                default = frame0,
                over = frame0,
                width= sizeleaderW,
                height= sizeleaderH,
                -- onRelease = selectItem
            }
            FRleader[i].id= i
            FRleader[i]:setReferencePoint( display.CenterReferencePoint )
            groupItem:insert(FRleader[i])
            FRleader[i].x = pointitemX
            FRleader[i].y = pointY
        end
        pointitemX = pointitemX + (screenW*.15)


    end

    local tap_team = display.newImageRect(image_tapteam,screenW*.78,screenH*.028)
    tap_team:setReferencePoint( display.TopLeftReferencePoint )
    tap_team.x = screenW *.1
    tap_team.y = pointY_tab
    groupItem:insert(tap_team)


     return groupItem
end