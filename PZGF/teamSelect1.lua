
module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local http = require("socket.http")
local json = require("json")
local includeFUN = require("includeFunction")
local frame = require("alertMassage").loadFramElement()

local sheetInfo = require("chara_icon")
local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )

local teamInfo = require("team")
local myImageteam = graphics.newImageSheet( "team.png",system.DocumentsDirectory, teamInfo:getSheet() )
-----------------------------------------------------------------
function newTEAM(id)

    local data = {}
    local maxTeamNo = nil
    local maxCharac = 5
    local teamNumber = 1
    local itemImg = 1
    local LinkURL = "http://133.242.169.252/DYM/team_setting.php"

    ------
    local typetxt = native.systemFontBold
    local sizetxt =  18
    local imageName = "img/characterIcon/as_cha_frm00.png"
    local frame0 = "img/characterIcon/as_cha_frm00.png"

    local image_tapteam = "as_team_icn_team01"
    local screenW = display.contentWidth
    local screenH = display.contentHeight

    local pointY = display.contentHeight * 1.12
    local USERID = includeFUN.USERIDPhone()

    local g = display.newGroup()
    local sizeleaderW = display.contentWidth*.13
    local sizeleaderH = display.contentHeight*.09


    local leader = {}
    local picture = {}

    local character_id = {}
    local imagePicture = {}
    local imagefrm = {}
    local team_no = {}
    local rowCharac
    -- **** connect database
    local URL =  LinkURL.."?user_id="..USERID.."&team_no="..teamNumber
    local response = http.request(URL)
    local characterItem = {}
    if response == nil then
        print("No Dice")
    else
        local dataTable = json.decode(response)
        rowCharac = dataTable.chrAll
       -- print("response ",response)
        local m = 1
        while m <= rowCharac do
            if dataTable.chracter ~= nil then
                characterItem[m] = {}
                characterItem[m].holdcharac_id = dataTable.chracter[m].holdcharac_id
                characterItem[m].imgMini = dataTable.chracter[m].imgMini
                characterItem[m].element = tonumber(dataTable.chracter[m].element)
                characterItem[m].teamno = tonumber(dataTable.chracter[m].team_no)
            else
                imagePicture[m] = imageName
                imagefrm[m] = frame0
                team_no[m] = 0
            end
            if m == rowCharac then
                maxTeamNo = characterItem[m].teamno
            end

            m = m + 1
        end
--
        characterItem[6] = {}
        local url = "http://133.242.169.252/DYM/holdcharacter.php?charac_id="
        local character =   url..id
        local response = http.request(character)
        local Data_character = json.decode(response)
        if Data_character then
            characterItem[6].holdcharac_id =  Data_character[1].holdcharac_id
            characterItem[6].imgMini =  Data_character[1].charac_img_mini
            characterItem[6].element =  tonumber(Data_character[1].charac_element)
            characterItem[6].teamno  = 6
        end


    end


    local function selectLeader(event)
        local options =
        {
            effect = "fade",
            time = 100,
            params =
            {
                holddteam_no = event.target.id ,
                character_id = event.target.id  ,
                team_id = teamNumber ,
                user_id = USERID
            }
        }
        if event.target.id == "Character" then
          --  storyboard.gotoScene( "team_item", options )

        else
            storyboard.gotoScene( "characterprofile", options )

        end

    end
    if characterItem[itemImg].teamno == 1 then
        picture[1] = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[itemImg].imgMini),sizeleaderW,sizeleaderH)
        picture[1]:setReferencePoint( display.CenterReferencePoint )
        g:insert(picture[1])
        picture[1].x = display.contentWidth - (display.contentWidth*.93)
        picture[1].y = pointY

        leader[1] = widget.newButton{
            defaultFile = frame[characterItem[itemImg].element],
            overFile = frame[characterItem[itemImg].element],
            width = sizeleaderW ,
            height= sizeleaderH,
            --onRelease = selectLeader
        }
        leader[1].id= character_id[1]
        leader[1]:setReferencePoint( display.CenterReferencePoint )
        g:insert(leader[1])
        leader[1].x = display.contentWidth - (display.contentWidth*.93)
        leader[1].y = pointY

        itemImg = itemImg + 1
    else
        leader[1] = widget.newButton{
            defaultFile = frame0,
            overFile = frame0,
            width = sizeleaderW ,
            height= sizeleaderH,
            --onRelease = selectLeader
        }
        leader[1].id= "Character"
        leader[1]:setReferencePoint( display.CenterReferencePoint )
        g:insert(leader[1])
        leader[1].x = display.contentWidth - (display.contentWidth*.93)
        leader[1].y = pointY

    end

    local pointleader = leader[1].x

    for i = 2, maxCharac, 1 do
        if maxTeamNo >= i then
            if characterItem[itemImg].teamno == i  then
                picture[i] = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[itemImg].imgMini),sizeleaderW,sizeleaderH)
                picture[i]:setReferencePoint( display.CenterReferencePoint )
                picture[i].x = pointleader +  (screenW*.135)
                picture[i].y = pointY
                g:insert(picture[i])

                leader[i] = widget.newButton{
                    defaultFile= frame[characterItem[itemImg].element],
                    overFile = frame[characterItem[itemImg].element],
                    width= sizeleaderW,
                    height= sizeleaderH,
                    --onRelease = selectLeader
                }
                leader[i].id= character_id[i]
                leader[i]:setReferencePoint( display.CenterReferencePoint )
                leader[i].x = pointleader +  (screenW*.135)--i * (display.contentWidth*.105)
                leader[i].y = pointY
                g:insert(leader[i])

                itemImg = itemImg + 1
            else
                leader[i] = widget.newButton{
                    defaultFile = frame0,
                    overFile = frame0,
                    width= sizeleaderW,
                    height= sizeleaderH,
                   -- onRelease = selectLeader
                }
                leader[i].id=  "Character"
                leader[i]:setReferencePoint( display.CenterReferencePoint )
                leader[i].x = pointleader + (screenW*.135)
                leader[i].y = pointY
                g:insert(leader[i])
            end
        else
            leader[i] = widget.newButton{
                defaultFile = frame0,
                overFile = frame0,
                width= sizeleaderW,
                height= sizeleaderH,
                -- onRelease = selectLeader
            }
            leader[i].id=  "Character"
            leader[i]:setReferencePoint( display.CenterReferencePoint )
            leader[i].x = pointleader + (screenW*.135)
            leader[i].y = pointY
            g:insert(leader[i])
        end


        pointleader = leader[i].x

    end
    picture[maxCharac+1] = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[6].imgMini) ,sizeleaderW,sizeleaderH)
    picture[maxCharac+1]:setReferencePoint( display.CenterReferencePoint )
    picture[maxCharac+1].x = pointleader +  (screenW*.135)
    picture[maxCharac+1].y = pointY
    g:insert(picture[maxCharac+1])

    leader[maxCharac+1] = widget.newButton{
        defaultFile = frame[characterItem[maxCharac+1].element],
        overFile = frame[characterItem[maxCharac+1].element],
        width= sizeleaderW,
        height= sizeleaderH,
        --onRelease = selectLeader
    }
    leader[maxCharac+1].id= character_id[maxCharac+1]
    leader[maxCharac+1]:setReferencePoint( display.CenterReferencePoint )
    leader[maxCharac+1].x = pointleader +  (screenW*.135)--i * (display.contentWidth*.105)
    leader[maxCharac+1].y = pointY
    g:insert(leader[maxCharac+1])
    ------------ ----------- ----------- -------------- ----------- --------------

    local tap_team = display.newImageRect(myImageteam , teamInfo:getFrameIndex(image_tapteam),screenW*.78,screenH*.028)
    tap_team:setReferencePoint( display.CenterReferencePoint )
    g:insert(tap_team)
    tap_team.x = screenW *.38
    tap_team.y = pointY * .92
     --------------------------------
--    storyboard.removeAll ()
--    storyboard.purgeAll()
     --------------------------------
    function g:cleanUp()
        g:removeSelf()
        g = nil
    end
    return g
end
