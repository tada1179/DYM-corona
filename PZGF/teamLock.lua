module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()



local teamInfo = require("team")
local myImageteam = graphics.newImageSheet( "team.png",system.DocumentsDirectory, teamInfo:getSheet() )
-----------------------------------------------------------------
function newTEAM(pageteam)


    local SysdeviceID
    local data = {}
    local maxCharac = 5
    local teamNumber = 1
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
    local locker_closed = "locker_closed"
    local frame0 = "img/characterIcon/as_cha_frm00.png"
    local frame = {
        "img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png"
    }

    local image_tapteam = "as_team_icn_team01"
    local image_tapcoler_status = "as_team_status"
    local image_tapstatus = "as_team_icn_teamsta"
    local screenW = display.contentWidth
    local screenH = display.contentHeight

    local pointY = display.contentHeight *1.1
    local itemImg = 1
    local g = display.newGroup()
    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09
    local leader = {}
    local tap_coler = display.newImageRect(myImageteam , teamInfo:getFrameIndex(image_tapcoler_status),screenW*.43,screenH*.13,true)
    local tap_status  = display.newImageRect(myImageteam , teamInfo:getFrameIndex(image_tapstatus),screenW*.78,screenH*.028,true)
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
    local locker_closed = display.newImageRect(myImageteam , teamInfo:getFrameIndex(locker_closed),screenW*.7,screenH*.45,true)
    --------------------------------------------
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

        leader = nil

        display.remove(tap_coler)
        tap_coler = nil
        display.remove(tap_status)
        tap_status = nil
        display.remove(txtHP)
        txtHP = nil
        display.remove(txtHPplus)
        txtHPplus = nil
        display.remove(txtgreen)
        txtgreen =nil
        display.remove(txtred)
        txtred=nil
        display.remove(txtblue)
        txtblue=nil
        display.remove(txtCost)
        txtCost=nil
        display.remove(txtCostplus)
        txtCostplus =nil
        display.remove(txtyellow)
        txtyellow =nil
        display.remove(txtpurple)
        txtpurple =nil
        display.remove(txtpink)
        txtpink =nil
        display.remove(txtleader)
        txtleader =nil
        display.remove(locker_closed)
        locker_closed =nil

        display.remove(g)
        g = nil
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




    local poinLVX2 = screenW*0.24
    local poinimg = screenW*0.28
    for i = 2, maxCharac, 1 do

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


    txtHPplus:setTextColor(255, 255, 255)
    g:insert(txtHPplus)


    txtgreen:setTextColor(255, 255, 255)
    g:insert(txtgreen)


    txtred:setTextColor(255, 255, 255)
    g:insert(txtred)


    txtblue:setTextColor(255, 255, 255)
    g:insert(txtblue)

    ----- *** ------

    txtCost:setTextColor(255, 255, 255)
    g:insert(txtCost)


    txtCostplus:setTextColor(255, 255, 255)
    g:insert(txtCostplus)


    txtyellow:setTextColor(255, 255, 255)
    g:insert(txtyellow)


    txtpurple:setTextColor(255, 255, 255)
    g:insert(txtpurple)



    txtpink:setTextColor(255, 255, 255)
    g:insert(txtpink)


    txtleader:setTextColor(255, 255, 255)
    g:insert(txtleader)



    g:insert(locker_closed)
    locker_closed.x = screenW * .38
    locker_closed.y = pointY * 1.15

    function g:cleanUp()
        g:removeSelf()
    end


    return g
end
