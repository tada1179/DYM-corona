print("team2.lua")
module(..., package.seeall)
local widget = require "widget"
function new()
    local g = display.newGroup()
    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09
    local pointY = display.contentHeight /2.5
    local pointYPicture = display.contentHeight /2.5

    local picture = {}
    local leader = {}

    local imageName = "img/framCharacterIcon/as_cha_frm02.png"
    local imagePicture = "img/framCharacterIcon/as_cha_icon_test2001.png"

    leader[1] = widget.newButton{
        default = imageName,
        over = imageName,
        width = sizeleaderW ,
        height= sizeleaderH,
        --onRelease = selectLeader
    }
    leader[1].id="header"
    leader[1]:setReferencePoint( display.CenterReferencePoint )
    leader[1].x = display.contentWidth - (display.contentWidth*.93)
    leader[1].y = pointY

    picture[1] = display.newImageRect(imagePicture,sizeleaderW,sizeleaderH)
    picture[1]:setReferencePoint( display.CenterReferencePoint )
    picture[1].x = display.contentWidth - (display.contentWidth*.93)
    picture[1].y = pointYPicture

    g:insert(picture[1])
    g:insert(leader[1])

    leader[2] = widget.newButton{
        default = imageName,
        over = imageName,
        width= sizeleaderW,
        height= sizeleaderH,
        --onRelease = selectLeader
    }
    leader[2].id="leader1"
    leader[2]:setReferencePoint( display.CenterReferencePoint )
    leader[2].x = 2*(display.contentWidth/7)
    leader[2].y = pointY
    g:insert(leader[2])


    for i = 3, 5, 1 do
        --local imageName = "as_cha_frm0"..i..".png"
        --local imageName = "as_cha_frm02.png"
        leader[i] = widget.newButton{
            default = imageName,
            over = imageName,
            width= sizeleaderW,
            height= sizeleaderH,
            --onRelease = selectLeader
        }
        leader[i].id="leader"..i
        leader[i]:setReferencePoint( display.CenterReferencePoint )
        leader[i].x = i * (display.contentWidth/7)
        leader[i].y = pointY
        g:insert(leader[i])
    end


    local message = display.newText("team 2/5", 0, 0, native.systemFontBold, 16)
    message:setTextColor(255, 255, 255)
    message.x = display.contentWidth*0.5
    message.y = display.contentHeight*0.5
    g:insert(message)


    function g:cleanUp()
        g:removeSelf()
    end

    return g
end
