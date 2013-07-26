module(..., package.seeall)
function newTEAM(USERID)
    local storyboard = require( "storyboard" )
    storyboard.purgeOnSceneChange = true
    local scene = storyboard.newScene()
    -----------------------------------------------------------------
    local screenW = display.contentWidth
    local screenH = display.contentHeight
    local widget = require "widget"
    local g = display.newGroup()

    local SysdeviceID
    local data = {}
    local maxCharac = 5
    local teamNumber = 5
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
    local pointY = screenH *1.1
    local itemImg = 1

    local sizeleaderW = screenW*.13
    local sizeleaderH = screenH*.09

    local rowCharac
    local leader = {}
    local picture = {}
    local dataTable
    local imagePicture = {}
    local imagefrm = {}
    local team_no = {}
    local txtLV
    local txtcost

    local tap_coler = display.newImageRect(image_tapcoler_status,screenW*.43,screenH*.13,true)
    local tap_status = display.newImageRect(image_tapstatus,screenW*.78,screenH*.028,true)
    local txtHP = display.newText("HP", screenW*0.1, pointY*1.115,typetxt,sizetxt )
    local txtHPplus = display.newText(All_HP, screenW*0.22,  pointY*1.115, typetxt,sizetxt )
    local txtgreen = display.newText(ATK_e2,  screenW*0.22, pointY*1.15, typetxt,sizetxt )
    local txtred = display.newText(ATK_e1, screenW*0.22, pointY*1.19, typetxt,sizetxt )
    local txtblue = display.newText(ATK_e3, screenW*0.22, pointY*1.23, typetxt,sizetxt )
    local txtCost = display.newText("COST", screenW*0.45, pointY*1.115, typetxt,sizetxt )
    local txtCostplus = display.newText("txtCOS", screenW*0.6, pointY*1.115, typetxt,sizetxt )
    local txtyellow = display.newText(ATK_e5, screenW*0.6, pointY*1.15, typetxt,sizetxt )
    local txtpurple = display.newText(ATK_e4, screenW*0.6, screenH*1.31, typetxt,sizetxt )
    local txtpink = display.newText(All_DEF, screenW*0.6, pointY*1.23, typetxt,sizetxt )
    local txtleader = display.newText("LEADER NAME:", screenW*.01, pointY*1.27, typetxt,sizetxt )

    -- **** connect database

    local http = require("socket.http")
    local LinkURL = "http://localhost/DYM/team_setting.php"
    local URL =  LinkURL.."?user_id="..USERID.."&team_no="..teamNumber
    local response = http.request(URL)
    local json = require("json")
    if response == nil then
        print("No Dice")

    else
        dataTable = json.decode(response)
        rowCharac = dataTable.chrAll

        local m = 1
        while m <= rowCharac do
            if dataTable.chracter ~= nil then

                imagePicture[m] = dataTable.chracter[m].imgMini
                imagefrm[m] = tonumber(dataTable.chracter[m].element)
                team_no[m] = tonumber(dataTable.chracter[m].team_no)
                All_DEF = All_DEF + tonumber(dataTable.chracter[m].def)
                All_HP = All_HP + tonumber(dataTable.chracter[m].hp)
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
    -- ****  ****  ****
    local function selectLeader(event)

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

        rowCharac = nil
        leader = nil

        picture = nil
        dataTable = nil

        display.remove(txtLV)
        txtLV = nil

        display.remove(txtcost)
        txtcost = nil

        display.remove(tap_coler)
        tap_coler = nil
        display.remove(tap_status)
        tap_status = nil

        display.remove(g)
        g = nil

        storyboard.purgeAll()
        storyboard.removeAll ()
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

    end
    local poinLVX = screenW*0.03
    if team_no[1] == 1 then
        picture[1] = display.newImageRect(imagePicture[1],sizeleaderW,sizeleaderH)
        picture[1]:setReferencePoint( display.CenterReferencePoint )
        g:insert(picture[1])
        picture[1].x = screenW - (screenW*.93)
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
        leader[1].x = screenW - (screenW*.93)
        leader[1].y = pointY

        txtLV = display.newText("Lv."..5, poinLVX, pointY*1.03,typetxt,sizetxt )
        txtLV:setTextColor(255, 255, 255)
        g:insert(txtLV)

        txtcost = display.newText("cost."..10, poinLVX, pointY*1.055,typetxt,sizetxt )
        txtcost:setTextColor(255, 255, 255)
        g:insert(txtcost)
        poinLVX = poinLVX + (screenW*0.2)

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
        leader[1].x = screenW - (screenW*.93)
        leader[1].y = pointY

    end


    local poinLVX2 = screenW*0.24
    local poinimg = screenW*0.28
    for i = 2, maxCharac, 1 do
        if team_no[itemImg] == i then
            picture[i] = display.newImageRect(imagePicture[itemImg],sizeleaderW,sizeleaderH)
            picture[i]:setReferencePoint( display.CenterReferencePoint )
            g:insert(picture[i])
            picture[i].x = poinimg
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
            leader[i].x = poinimg
            leader[i].y = pointY
            txtLV = display.newText("Lv."..10, poinLVX2, pointY*1.03,typetxt,sizetxt )
            txtLV:setTextColor(255, 255, 255)
            g:insert(txtLV)

            txtcost = display.newText("cost."..10, poinLVX2, pointY*1.055,typetxt,sizetxt )
            txtcost:setTextColor(255, 255, 255)
            g:insert(txtcost)
            poinLVX2 = poinLVX2 + (screenW*0.145)

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
            leader[i].x = poinimg
            leader[i].y = pointY

        end
        poinimg = poinimg + (screenW*0.145)
    end

    g:insert(tap_coler)
    tap_coler.x = screenW *.305
    tap_coler.y = pointY * 1.2

    g:insert(tap_status)
    tap_status.x = screenW * .38
    tap_status.y = pointY * 1.095
    -------------------------


    txtHP:setTextColor(255, 255, 255)
    g:insert(txtHP)

    txtHPplus.text = All_HP
    txtHPplus:setTextColor(255, 255, 255)
    g:insert(txtHPplus)

    txtgreen.text = ATK_e2
    txtgreen:setTextColor(255, 255, 255)
    g:insert(txtgreen)

    txtred.text = ATK_e1
    txtred:setTextColor(255, 255, 255)
    g:insert(txtred)

    txtblue.text = ATK_e3
    txtblue:setTextColor(255, 255, 255)
    g:insert(txtblue)

    ----- *** ------
    txtCost.text = "COST"
    txtCost:setTextColor(255, 255, 255)
    g:insert(txtCost)

    txtCostplus.text = "txtCOS"
    txtCostplus:setTextColor(255, 255, 255)
    g:insert(txtCostplus)

    txtyellow.text = ATK_e5
    txtyellow:setTextColor(255, 255, 255)
    g:insert(txtyellow)

    txtpurple.text = ATK_e4
    txtpurple:setTextColor(255, 255, 255)
    g:insert(txtpurple)

    txtpink.text = All_DEF
    txtpink:setTextColor(255, 255, 255)
    g:insert(txtpink)

    txtleader.text = "LEADER NAME:"
    txtleader:setTextColor(255, 255, 255)
    g:insert(txtleader)

    local lotsOfText = "LEADER NAME:\nAaaaAAA \nCCaabbbbb"
    local txtleaderSkill = require("util").wrappedText( lotsOfText, 39, sizetxt, native.systemFont, {200,0,200} )
    txtleaderSkill.x = screenW*.01
    txtleaderSkill.y = pointY*1.28
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
