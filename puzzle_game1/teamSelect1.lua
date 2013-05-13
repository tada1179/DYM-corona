print("teamSelect1.lua")
module(..., package.seeall)
local widget = require "widget"
local util = require("util")
local sizeleaderW = display.contentWidth*.13
local sizeleaderH = display.contentHeight*.09
local pointY = display.contentHeight *.5
local sizetext = 18
function new()
    local g = display.newGroup()


    print("pointY"..pointY)
    local screenOffsetW = display.contentWidth -  display.viewableContentWidth
    local screenOffsetH = display.contentHeight - display.viewableContentHeight

    local picture = {}
    local leader = {}
    local limitteam = 6

    local imageName = "img/framCharacterIcon/as_cha_frm02.png"
    local imagePicture = "img/framCharacterIcon/as_cha_icon_test2001.png"
    local image_title = "img/background/team/as_team_icn_team01.png"
    local image_txtleader = "img/text/leader.png"

    local titleTeam = display.newImageRect(image_title,display.contentWidth*.8,display.contentHeight*.025)
    titleTeam:setReferencePoint( display.CenterReferencePoint )
    titleTeam.x = display.contentWidth *.48
    titleTeam.y = display.contentHeight
    g:insert(titleTeam)

    local txtleader = display.newImageRect(image_txtleader,display.contentWidth*.1,display.contentHeight*.015)
    txtleader:setReferencePoint( display.CenterReferencePoint )
    txtleader.x = display.contentWidth *.15
    txtleader.y = titleTeam.y  +  display.contentHeight *.03
    g:insert(txtleader)


    for i = 1, limitteam, 1 do
        picture[i] = display.newImageRect(imagePicture,sizeleaderW,sizeleaderH)
        picture[i]:setReferencePoint( display.CenterReferencePoint )
        picture[i].x = i * (display.contentWidth/7)
        picture[i].y = titleTeam.y  +  display.contentHeight *.09

        leader[i] = widget.newButton{
            default = imageName,
            over = imageName,
            width= sizeleaderW,
            height= sizeleaderH,
            --onRelease = selectLeader
        }
        leader[i].id="leader"..i
        leader[i].x = i * (display.contentWidth/7)
        leader[i].y = titleTeam.y  +  display.contentHeight *.09

        g:insert(picture[i])
        g:insert(leader[i])


    end

    local massageskill = "leader skill SKILL NAME\nBBBBBBB\nCdefghij"
    local message = util.wrappedText( massageskill, 39, sizetext, native.systemFont, {255,255,255} )
    message.x = display.contentWidth*0.1
    message.y = display.contentHeight + (display.contentHeight*.13)
    g:insert(message)


    function g:cleanUp()
        g:removeSelf()
    end

    return g
end
