module(..., package.seeall)
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local alertMSN = require("alertMassage")
local menu_barLight = require("menu_barLight")
-----------------------------------------------------------------
local screenW = display.contentWidth
local screenH = display.contentHeight
local widget = require "widget"
local sheetInfo = require("chara_icon")
local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )

local teamInfo = require("team")
local myImageteam = graphics.newImageSheet( "team.png",system.DocumentsDirectory, teamInfo:getSheet() )
function newTEAM(USERID)

    local g = display.newGroup()

    local SysdeviceID
    local data = {}
    local maxCharac = 5
    local teamNumber = 4
    -- *** ---- ***
    local All_Cost = 0
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
    local frame =  alertMSN.loadFramElement()

    local image_tapcoler_status = "as_team_status"
    local image_tapstatus = "as_team_icn_teamsta"
    local pointY = screenH *1.1
    local itemImg = 1

    local sizeleaderW = screenW*.13
    local sizeleaderH = screenH*.09

    local rowCharac
    local leader = {}
    local picture = {}
    local dataTable

    local characterItem ={}

    local txtLV
    local txtcost
    local pointYSet = - screenH*.05

    local tap_coler = display.newImageRect(myImageteam , teamInfo:getFrameIndex(image_tapcoler_status),screenW*.43,screenH*.13)
    local tap_status = display.newImageRect(myImageteam , teamInfo:getFrameIndex(image_tapstatus),screenW*.78,screenH*.028)
    local txtHP = display.newText("HP", - screenW*.35, pointYSet,typetxt,sizetxt )
    local txtHPplus = display.newText(All_HP, -screenW*.25,  pointYSet, typetxt,sizetxt )
    local txtgreen = display.newText(ATK_e2,  -screenW*0.25, screenH*0, typetxt,sizetxt )
    local txtred = display.newText(ATK_e1, -screenW*0.25, screenH*0.05, typetxt,sizetxt )
    local txtblue = display.newText(ATK_e3, -screenW*0.25, screenH*0.1, typetxt,sizetxt )
    local txtCost = display.newText("COST",0, pointYSet, typetxt,sizetxt )
    local txtCostplus = display.newText(All_Cost, screenW*0.15, pointYSet, typetxt,sizetxt )
    local txtyellow = display.newText(ATK_e5, screenW*0.15, screenH*0, typetxt,sizetxt )
    local txtpurple = display.newText(ATK_e4, screenW*0.15, screenH*0.05, typetxt,sizetxt )
    local txtpink = display.newText(All_DEF, screenW*0.15, screenH*.1, typetxt,sizetxt )
    --    local txtleader = display.newText("LEADER NAME:", screenW*.16, screenH*.8, typetxt,sizetxt )
    local txtleader = display.newText("LEADER NAME:",-screenW*.35, screenH*.15, typetxt,sizetxt )

    -- **** connect database

    local http = require("socket.http")
    local LinkURL = "http://133.242.169.252/DYM/team_setting.php"
    local URL =  LinkURL.."?user_id="..USERID.."&team_no="..teamNumber
    local response = http.request(URL)
    local json = require("json")

    --print("response = ",response)
    dataTable = json.decode(response)
    rowCharac = tonumber(dataTable.chrAll)

    local m = 1
    while m <= maxCharac do
        characterItem[m]={}

        if rowCharac ~= 0 and dataTable.chracter[m] ~= nil then
            characterItem[m].imagePicture = dataTable.chracter[m].imgMini
            characterItem[m].imagefrm = tonumber(dataTable.chracter[m].element)
            characterItem[m].team_no = tonumber(dataTable.chracter[m].team_no)
            characterItem[m].charac_cost = tonumber(dataTable.chracter[m].cost)
            characterItem[m].charac_name = dataTable.chracter[m].charac_name
            characterItem[m].holdcharac_lv = tonumber(dataTable.chracter[m].holdcharac_lv)
            characterItem[m].charac_leader = dataTable.chracter[m].charac_leader
            characterItem[m].charac_skill = dataTable.chracter[m].charac_skill
            characterItem[m].skill_id = tonumber(dataTable.chracter[m].skill_id)
            characterItem[m].leader_id = tonumber(dataTable.chracter[m].leader_id)

            All_DEF = All_DEF + tonumber(dataTable.chracter[m].def)
            All_HP = All_HP + tonumber(dataTable.chracter[m].hp)
            All_Cost = All_Cost + tonumber(dataTable.chracter[m].cost)

            if characterItem[m].imagefrm == 1 then
                ATK_e1 = ATK_e1 + tonumber(dataTable.chracter[m].atk)
            elseif characterItem[m].imagefrm == 2 then
                ATK_e2 = ATK_e2 + tonumber(dataTable.chracter[m].atk)
            elseif characterItem[m].imagefrm == 3 then
                ATK_e3 = ATK_e3 + tonumber(dataTable.chracter[m].atk)
            elseif characterItem[m].imagefrm == 4 then
                ATK_e4 = ATK_e4 + tonumber(dataTable.chracter[m].atk)
            elseif characterItem[m].imagefrm == 5 then
                ATK_e5 = ATK_e5 + tonumber(dataTable.chracter[m].atk)
            end

        else
            characterItem[m].imagePicture = imageName
            characterItem[m].imagefrm = imageName
            characterItem[m].team_no = 0
            characterItem[m].charac_name = "No name"
            characterItem[m].holdcharac_lv = 0
            characterItem[m].charac_cost = 0
            characterItem[m].charac_leader = 0
            characterItem[m].charac_skill = 0
        end
        m = m + 1
    end

    -- ****  ****  ****
    local function selectLeader(event)
        menu_barLight.SEtouchButton()
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


        display.remove(g)
        g = nil

        storyboard.purgeAll()
        storyboard.removeAll ()
        if event.target.id  then

            storyboard.gotoScene( "team_item", options )

        end

    end

    local poinLVX = - screenW*0.32
    local poinImg1X = - screenW*0.35
    if characterItem[1].team_no== 1 then
        picture[1] = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[1].imagePicture),sizeleaderW,sizeleaderH)
        --        picture[1]:setReferencePoint( display.CenterReferencePoint )
        picture[1]:setReferencePoint( display.TopLeftReferencePoint )
        g:insert(picture[1])
        picture[1].x = poinImg1X
        picture[1].y = pointY

        leader[1] = widget.newButton{
            defaultFile = frame[characterItem[1].imagefrm],
            overFile = frame[characterItem[1].imagefrm],
            width = sizeleaderW ,
            height= sizeleaderH,
            onRelease = selectLeader
        }
        leader[1].id= 1
        leader[1]:setReferencePoint( display.TopLeftReferencePoint )
        g:insert(leader[1])
        --        leader[1].x = screenW - (screenW*.93)
        --        leader[1].y = pointY

        leader[1].x = poinImg1X
        leader[1].y = pointY

        txtLV = display.newText("Lv."..characterItem[1].holdcharac_lv, poinLVX, pointY*.683,typetxt,sizetxt )
        --        txtLV:setReferencePoint( display.TopLeftReferencePoint )
        txtLV:setReferencePoint( display.TopLeftReferencePoint )
        txtLV:setFillColor(255, 255, 255)
        g:insert(txtLV)

        --print("charac_cost[1] =",characterItem[1].charac_cost)
        txtcost = display.newText("cost."..characterItem[1].charac_cost, poinLVX, pointY*.585,typetxt,sizetxt )
        txtcost:setReferencePoint( display.TopLeftReferencePoint )
        txtcost:setFillColor(255, 255, 255)
        g:insert(txtcost)
        poinLVX = poinLVX + (screenW*0.2)

        itemImg = itemImg + 1
    else
        leader[1] = widget.newButton{
            defaultFile = frame0,
            overFile = frame0,
            width = sizeleaderW ,
            height= sizeleaderH,
            onRelease = selectLeader
        }
        leader[1].id= 1
        leader[1]:setReferencePoint( display.TopLeftReferencePoint )
        g:insert(leader[1])
        leader[1].x = poinImg1X
        leader[1].y = pointY

    end


    local poinLVX2 = -screenW*0.12
    local poinimg = - screenW*0.15
    for i = 2, maxCharac, 1 do
        if characterItem[itemImg].team_no == i then
            picture[i] = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[itemImg].imagePicture),sizeleaderW,sizeleaderH)
            picture[i]:setReferencePoint( display.TopLeftReferencePoint )
            g:insert(picture[i])
            picture[i].x = poinimg
            picture[i].y = pointY

            leader[i] = widget.newButton{
                defaultFile = frame[characterItem[itemImg].imagefrm],
                overFile = frame[characterItem[itemImg].imagefrm],
                width= sizeleaderW,
                height= sizeleaderH,
                onRelease = selectLeader
            }
            leader[i].id= i
            leader[i]:setReferencePoint( display.TopLeftReferencePoint )
            g:insert(leader[i])
            leader[i].x = poinimg
            leader[i].y = pointY
            txtLV = display.newText("Lv."..characterItem[itemImg].holdcharac_lv, poinLVX2, pointY*.683,typetxt,sizetxt )
            txtLV:setReferencePoint( display.TopLeftReferencePoint )
            txtLV:setFillColor(255, 255, 255)
            g:insert(txtLV)

            txtcost = display.newText("cost."..characterItem[itemImg].charac_cost, poinLVX2, pointY*.585,typetxt,sizetxt )
            txtcost:setReferencePoint( display.TopLeftReferencePoint )
            txtcost:setFillColor(255, 255, 255)
            g:insert(txtcost)
            poinLVX2 = poinLVX2 + (screenW*0.145)

            itemImg = itemImg + 1
        else
            leader[i] = widget.newButton{
                defaultFile = frame0,
                overFile = frame0,
                width= sizeleaderW,
                height= sizeleaderH,
                onRelease = selectLeader
            }
            leader[i].id= i
            leader[i]:setReferencePoint( display.TopLeftReferencePoint )
            g:insert(leader[i])
            leader[i].x = poinimg
            leader[i].y = pointY

        end
        poinimg = poinimg + (screenW*0.145)
    end

    g:insert(tap_coler)
    tap_coler.x = -screenW *.13
    tap_coler.y = screenH*.05

    g:insert(tap_status)
    tap_status.x = -screenW * .02
    tap_status.y = pointY * .3
    -------------------------


    txtHP:setReferencePoint( display.TopLeftReferencePoint )
    txtHP:setFillColor(255, 255, 255)
    g:insert(txtHP)

    txtHPplus.text = All_HP
    txtHPplus:setReferencePoint( display.TopLeftReferencePoint )
    txtHPplus:setFillColor(255, 255, 255)
    g:insert(txtHPplus)

    txtgreen.text = ATK_e2
    txtgreen:setReferencePoint( display.TopLeftReferencePoint )
    txtgreen:setFillColor(255, 255, 255)
    g:insert(txtgreen)

    txtred.text = ATK_e1
    txtred:setReferencePoint( display.TopLeftReferencePoint )
    txtred:setFillColor(255, 255, 255)
    g:insert(txtred)

    txtblue.text = ATK_e3
    txtblue:setReferencePoint( display.TopLeftReferencePoint )
    txtblue:setFillColor(255, 255, 255)
    g:insert(txtblue)

    ----- *** ------
    txtCost.text = "COST"
    txtCost:setReferencePoint( display.TopLeftReferencePoint )
    txtCost:setFillColor(255, 255, 255)
    g:insert(txtCost)

    txtCostplus.text = All_Cost
    txtCostplus:setReferencePoint( display.TopLeftReferencePoint )
    txtCostplus:setFillColor(255, 255, 255)
    g:insert(txtCostplus)

    txtyellow.text = ATK_e5
    txtyellow:setReferencePoint( display.TopLeftReferencePoint )
    txtyellow:setFillColor(255, 255, 255)
    g:insert(txtyellow)

    txtpurple.text = ATK_e4
    txtpurple:setReferencePoint( display.TopLeftReferencePoint )
    txtpurple:setFillColor(255, 255, 255)
    g:insert(txtpurple)

    txtpink.text = All_DEF
    txtpink:setReferencePoint( display.TopLeftReferencePoint )
    txtpink:setFillColor(255, 255, 255)
    g:insert(txtpink)

    txtleader.text = "LEADER NAME: "..characterItem[1].charac_name
    txtleader:setReferencePoint( display.TopLeftReferencePoint )
    txtleader:setFillColor(255, 255, 255)
    g:insert(txtleader)

    local lotsOfText = "LEADER SKILL: "..characterItem[1].charac_leader.." \nSKILL: "..characterItem[1].charac_skill
    local txtleaderSkill = require("util").wrappedText( lotsOfText, 39, sizetxt, native.systemFont, {255, 222, 173} )
    txtleaderSkill:setReferencePoint( display.TopLeftReferencePoint )
    txtleaderSkill.x = -screenW*.35
    txtleaderSkill.y = screenH *.18
    g:insert(txtleaderSkill)


    require("menu_barLight").checkMemory()
    ---------------------------
    storyboard.removeAll ()
    storyboard.purgeAll()
    ---------------------------

    function g:cleanUp()
        g:removeSelf()
    end


    return g
end
