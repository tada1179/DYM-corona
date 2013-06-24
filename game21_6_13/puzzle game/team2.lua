print("team2.lua")
module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local http = require("socket.http")
local json = require("json")
local includeFUN = require("includeFunction")
-----------------------------------------------------------------
local SysdeviceID
local data = {}
local maxCharac = 5
local teamNumber = 2
local itemImg = 1
local LinkURL = "http://localhost/DYM/team_setting.php"

-- *** ---- ***
local All_HP = 0
local All_DEF=0
local ATK_e1 = 0--atk element green
local ATK_e2 = 0 -- red
local ATK_e3 = 0 -- blue
local ATK_e4 = 0 -- yellow
local ATK_e5 = 0 -- purple
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

local image_tapteam = "img/background/tapitem_team/as_team_icn_team02.png"
local image_tapcoler_status = "img/background/team/as_team_status.png"
local image_tapstatus = "img/background/team/as_team_icn_teamsta.png"
local screenW = display.contentWidth
local screenH = display.contentHeight

local pointY = display.contentHeight * 1.12

function newTEAM()
    local SystemPhone = includeFUN.DriverIDPhone()
    local USERID = includeFUN.USERIDPhone()
    print("team main USERID:"..USERID)

    local g = display.newGroup()
    local group = display.newGroup()
    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09

    local rowCharac
    local leader = {}
    local picture = {}
    local dataTable
    local imagePicture = {}
    local imagefrm = {}
    local team_no = {}

    -- **** connect database
    local URL =  LinkURL.."?user_id="..USERID.."&team_no="..teamNumber
    local response = http.request(URL)
    if response == nil then
        print("No Dice")
    else
        dataTable = json.decode(response)
        --            print("No response:"..response)
        rowCharac = dataTable.chrAll
        --            local All_HP
        --            local All_DEF
        --            local ATK_e1 --atk element red
        --            local ATK_e2  -- green
        --            local ATK_e3  -- blue
        --            local ATK_e4  -- purple
        --            local ATK_e5  -- yellow

        local m = 1
        while m <= rowCharac do
            if dataTable.chracter ~= nil then

                imagePicture[m] = dataTable.chracter[m].imgMini
                imagefrm[m] = tonumber(dataTable.chracter[m].element)
                team_no[m] = tonumber(dataTable.chracter[m].team_no)

                All_DEF = All_DEF + tonumber(dataTable.chracter[m].def)
                All_HP = All_HP + tonumber(dataTable.chracter[m].hp)

                print("imagefrm[m]:"..imagefrm[m])
                if imagefrm[m] == 1 then
                    ATK_e1 = ATK_e1 + tonumber(dataTable.chracter[m].atk)
                elseif imagefrm[m] == 2 then
                    ATK_e2 = ATK_e2 + tonumber(dataTable.chracter[m].atk)
                elseif imagefrm[m] == 3 then
                    ATK_e3 = ATK_e3 + tonumber(dataTable.chracter[m].atk)
                elseif imagefrm[m] == 4 then
                    ATK_e4 = ATK_e4 + tonumber(dataTable.chracter[m].atk)
                elseif imagefrm[m] == 5 then
                    ATK_e5 = ATK_e5 + tonumber(dataTable.chracter[m].atk)
                end

            else
                -- print("ELSE ELSE dataTable.chracter::"..dataTable.chracter)
                imagePicture[m] = imageName
                imagefrm[m] = frame0
                team_no[m] = 0

                All_DEF = 0
                All_HP = 0

                ATK_e1 = 0
                ATK_e2 = 0
                ATK_e3 = 0
                ATK_e4 = 0
                ATK_e5 = 0
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
                holddteam_no =event.target.id ,
                team_id = teamNumber
            }
        }
        print("event: "..event.target.id)
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
            onRelease = selectLeader
        }
        leader[1].id= 1
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
            onRelease = selectLeader
        }
        leader[1].id= 1
        leader[1]:setReferencePoint( display.CenterReferencePoint )
        g:insert(leader[1])
        leader[1].x = display.contentWidth - (display.contentWidth*.93)
        leader[1].y = pointY

    end



    for i = 2, maxCharac, 1 do
        if team_no[itemImg] == i then
            picture[i] = display.newImageRect(imagePicture[itemImg],sizeleaderW,sizeleaderH)
            picture[i]:setReferencePoint( display.CenterReferencePoint )
            g:insert(picture[i])
            picture[i].x = i * (display.contentWidth/7)
            picture[i].y = pointY

            leader[i] = widget.newButton{
                default = frame[imagefrm[itemImg]],
                over = frame[imagefrm[itemImg]],
                width= sizeleaderW,
                height= sizeleaderH,
                onRelease = selectLeader
            }
            leader[i].id= i
            leader[i]:setReferencePoint( display.CenterReferencePoint )
            g:insert(leader[i])
            leader[i].x = i * (display.contentWidth/7)
            leader[i].y = pointY

            itemImg = itemImg + 1
        else
            leader[i] = widget.newButton{
                default = frame0,
                over = frame0,
                width= sizeleaderW,
                height= sizeleaderH,
                onRelease = selectLeader
            }
            leader[i].id= i
            leader[i]:setReferencePoint( display.CenterReferencePoint )
            g:insert(leader[i])
            leader[i].x = i * (display.contentWidth/7)
            leader[i].y = pointY

        end

    end

    local tap_coler = display.newImageRect(image_tapcoler_status,screenW*.43,screenH*.13,true)
    g:insert(tap_coler)
    tap_coler.x = screenW *.305
    tap_coler.y = pointY * 1.2


    local tap_status = display.newImageRect(image_tapstatus,screenW*.78,screenH*.028,true)
    g:insert(tap_status)
    tap_status.x = screenW * .38
    tap_status.y = pointY * 1.095


    local tap_team = display.newImageRect(image_tapteam,screenW*.78,screenH*.028)
    tap_team:setReferencePoint( display.CenterReferencePoint )
    g:insert(tap_team)
    tap_team.x = screenW *.38
    tap_team.y = pointY * .92
    -------------------------
    -------------------------

    local txtHP = display.newText("HP", screenW*0.1, pointY*1.115,typetxt,sizetxt )
    txtHP:setTextColor(255, 255, 255)
    g:insert(txtHP)

    local txtHPplus = display.newText(All_HP, screenW*0.22,  pointY*1.115, typetxt,sizetxt )
    txtHPplus:setTextColor(255, 255, 255)
    g:insert(txtHPplus)

    local txtgreen = display.newText(ATK_e2,  screenW*0.22, pointY*1.15, typetxt,sizetxt )
    txtgreen:setTextColor(255, 255, 255)
    g:insert(txtgreen)

    local txtred = display.newText(ATK_e1, screenW*0.22, pointY*1.19, typetxt,sizetxt )
    txtred:setTextColor(255, 255, 255)
    g:insert(txtred)

    local txtblue = display.newText(ATK_e3, screenW*0.22, pointY*1.23, typetxt,sizetxt )
    txtblue:setTextColor(255, 255, 255)
    g:insert(txtblue)

    ----- *** ------
    local txtCost = display.newText("COST", screenW*0.45, pointY*1.115, typetxt,sizetxt )
    txtCost:setTextColor(255, 255, 255)
    g:insert(txtCost)

    local txtCostplus = display.newText("txtCOS", screenW*0.6, pointY*1.115, typetxt,sizetxt )
    txtCostplus:setTextColor(255, 255, 255)
    g:insert(txtCostplus)

    local txtyellow = display.newText(ATK_e5, screenW*0.6, pointY*1.15, typetxt,sizetxt )
    txtyellow:setTextColor(255, 255, 255)
    g:insert(txtyellow)

    local txtpurple = display.newText(ATK_e4, screenW*0.6, screenH*1.33, typetxt,sizetxt )
    txtpurple:setTextColor(255, 255, 255)
    g:insert(txtpurple)


    local txtpink = display.newText(All_DEF, screenW*0.6, pointY*1.23, typetxt,sizetxt )
    txtpink:setTextColor(255, 255, 255)
    g:insert(txtpink)



    ---------------------------
    ---------------------------

    function g:cleanUp()
        g:removeSelf()
    end


    return g
end
