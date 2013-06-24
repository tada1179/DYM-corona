
print("team_item.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"
local menu_barLight = require ("menu_barLight")
local includeFUN = require("includeFunction")
local character_scene = require("character_scene")
local http = require("socket.http")
local json = require("json")
-----------------------------------------------------------------------------------------
local groupGameLayer
local listCharacter = {}
local backButton
--local LinkURL = "http://localhost/DYM/hold_character.php"
local LinkURL = "http://localhost/DYM/useCharacter.php"

local countID = 0
local user_id
local Allcharacter
local countCharac = 0
local numRow
local numColum
local allRow = {}

local team_id
local holddteam_no
local dataTable = {}
local charactID = {}
local element = {}
local level = {}
local use = {}
local holdcharac_id = {}
local txtInuse = "In-use"

local scrollView
local  options

local typeFont = native.systemFontBold
local sizetext = 20

local sizeleaderW = display.contentWidth*.135
local sizeleaderH = display.contentWidth*.135

local maxfram = 5
local frame = {
    "img/characterIcon/as_cha_frm01.png",
                "img/characterIcon/as_cha_frm02.png",
                "img/characterIcon/as_cha_frm03.png",
                "img/characterIcon/as_cha_frm04.png",
                "img/characterIcon/as_cha_frm05.png"
}


local function LoadTeam()
    print("user_id:"..user_id)

    local numberHold_character =  LinkURL.."?user_id="..user_id.."&team_id="..team_id
    local numberHold = http.request(numberHold_character)

    if numberHold == nil then
        print("No Dice")
    else
        allRow  = json.decode(numberHold)
        Allcharacter = allRow.chrAll
        numColum = 5
        numRow = math.ceil( Allcharacter / 5)

        local k = 1
        while(k <= Allcharacter) do
           holdcharac_id[k] = allRow.chracter[k].holdcharac_id
           dataTable[k] = allRow.chracter[k].charac_img_mini
           charactID[k] = allRow.chracter[k].charac_id
           element[k] = allRow.chracter[k].charac_element
           level[k] = allRow.chracter[k].charac_lv
           use[k] = allRow.chracter[k].use_id

            k = k + 1
        end
    end
end
local function BackButton(event)

    options =
    {
        effect = "fade",
        time = 100,
        params = {
            character_id = 1 ,
            holddteam_no =  holddteam_no  ,
            team_id =  team_id ,
            user_id = user_id
        }
    }
        print( "11 event: "..event.target.id)
        storyboard.gotoScene( "team_main", options )
        storyboard.disableAutoPurge = true
    return true	-- indicates successful touch
end

local function selectLeader(event)
--    local options =
--    {
--        effect = "fade",
--        time = 100,
--        params =
--        {
--            holddteam_no = holddteam_no ,
--            team_id = team_id
--        }
--    }
    print("options leader:"..options.params.holddteam_no)

    if event.target.id == "leader1" then
        print("event: "..event.target.id)
        storyboard.gotoScene( "character", "fade", 100 )
    elseif event.target.id == "leader2" then

        print("event: "..event.target.id)
    elseif event.target.id == "leader3" then

        print("event: "..event.target.id)
    elseif event.target.id == "leader4" then

        print("event: "..event.target.id)
    elseif event.target.id == "leader5" then

        print("event: "..event.target.id)
    end

end



local function scrollViewList ()
    local LeaderpointX
    local LeaderpointY

    local LVpointX
    local LVpointY

    local InusepointY
    local InusepointX

    local backcharacter
    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end

    function onButtonEvent(event)
        print(event.phase)

        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
            local scrollBar = self.scrollBar
        elseif event.phase == "moved" then


            print("----///event.y:"..event.y)

            if event.markY ~= event.y and event.markX == event.x then
                print("if mark")
            else
                print("else mark")
            end

            local dy = math.abs( event.y - event.yStart )
            print("dy",dy)
            -- if finger drags button more than 5 pixels, pass focus to scrollView
            if  dy > 5 then
                scrollView:takeFocus( event )
                --moveScrollBar(dy)
            end

        elseif event.phase == "release" then
            print("Character:"..event.target.id)
            character_scene.character(event.target.id,holddteam_no,team_id,user_id)
            --(select touch,holddteam_no,team_id)

        end

        return true
    end

    scrollView = widget.newScrollView{
        width = display.contentWidth *.75,
        height = display.contentHeight * .45,
        top = display.contentHeight *.35,
        left = display.contentWidth *.15,
        scrollWidth = 0,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true

    }
    local groupView = display.newGroup()

    for i = 1, numRow , 1 do  -- create colum
        for j = 1, numColum, 1 do --create row
            LeaderpointX = display.contentWidth *(-0.15+(i*0.15))
            LeaderpointY = display.contentHeight *(-0.12+(j*0.1))

            LVpointX = display.contentWidth *(-0.045+(i*0.15))
            LVpointY = display.contentHeight *(-0.1+(j*0.1))

            InusepointX = display.contentWidth *(-0.09+(i*0.15))
            InusepointY = display.contentHeight *(-0.11+(j*0.1))

            if countCharac < Allcharacter then
                countID = countID + 1

            listCharacter[countID] = widget.newButton{
                default= dataTable[countID],
                width=sizeleaderW , height=sizeleaderH,
                top = LeaderpointX,
                left = LeaderpointY,
                onEvent = onButtonEvent	-- event listener function
            }

            listCharacter[countID].id = holdcharac_id[countID]
            scrollView:insert(listCharacter[countID])

                for m = 1, maxfram,1 do
                   numele =  tonumber(element[countID])
                    if m == numele  then
                       -- print("m:"..m,"frame::"..frame[m])
                        local framImage = display.newImageRect(frame[m] ,sizeleaderW, sizeleaderH)
                        framImage:setReferencePoint( display.TopLeftReferencePoint )
                        framImage.x = LeaderpointY
                        framImage.y = LeaderpointX
                        scrollView:insert(framImage)
                    end

                end
            local textLV = display.newText("Lv."..level[countID], LVpointY,LVpointX,typeFont, sizetext)
            textLV:setTextColor(255, 255, 255)
            scrollView:insert(textLV)

            if use[countID] then
                print("charactID[countID]:"..charactID[countID])
                local backcharacter = display.newRect(LeaderpointY, LeaderpointX, sizeleaderW, sizeleaderH)
                backcharacter.strokeWidth = 1
                backcharacter.alpha = 0.8
                backcharacter:setFillColor(0, 0, 0)
                scrollView:insert(backcharacter)

                groupView:insert(backcharacter)
                groupView.touch = onTouchGameOverScreen
                groupView:addEventListener( "touch", groupView )
                scrollView:insert(groupView)

                local textInuse = display.newText(txtInuse, InusepointY,InusepointX,typeFont, sizetext)
                textInuse:setTextColor(200, 0, 200)
                groupView:insert(textInuse)



            else
                print("NULL")
            end


                 countCharac = countCharac + 1
            end
        end

    end
end

local function createBackButton()
    local image_btnback = "img/background/button/Button_BACK.png"
    backButton = widget.newButton{
        default= image_btnback,
        over= image_btnback,
        width=display.contentWidth/10, height=display.contentHeight/21,
        onRelease = BackButton	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = display.contentWidth - (display.contentWidth *.845)
    backButton.y = display.contentHeight - (display.contentHeight *.7)
end

function scene:createScene( event )
    print("--------------team_item----------------")
    local group = self.view

    local image_background = "img/background/background_1.jpg"
    groupGameLayer = display.newGroup()
    local gdisplay = display.newGroup()
    user_id = includeFUN.USERIDPhone()
    print("SystemPhone::"..user_id)


    local params = event.params
    if params then
        holddteam_no = params.holddteam_no
        team_id = params.team_id
    else
        holddteam_no = params.holddteam_no
        team_id = params.team_id
    end

    LoadTeam()

    print("team_item holddteam_no:"..holddteam_no)
    print("team_item team_id:"..team_id)

--    local background = display.newImageRect( "img/background/team/TEMPLATE_unit.jpg", display.contentWidth, display.contentHeight )
    local background = display.newImageRect(image_background , display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    scrollViewList()
    --group:insert(scrollView)


    local titleText = display.newImageRect( "img/text/UNIT_BOX.png", display.contentWidth/4.5, display.contentHeight/34 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = display.contentWidth /2
    titleText.y = display.contentHeight /3.14

    local BLOCK_BOX = display.newImageRect( "img/background/character/BLOCK_BOX_EXTENTION_LAYOUT_13.png", display.contentWidth*.9, display.contentHeight*.13 )
    BLOCK_BOX:setReferencePoint( display.CenterReferencePoint )
    BLOCK_BOX.x = display.contentWidth *.5
    BLOCK_BOX.y = display.contentHeight *.8

    createBackButton()

    print("countID:"..countID)
    groupGameLayer:insert(scrollView)
    menu_barLight = menu_barLight.newMenubutton()
    gdisplay:insert(menu_barLight)



    group:insert(background)
    group:insert(groupGameLayer)
    group:insert(backButton)
    group:insert(titleText)
    group:insert(BLOCK_BOX)
    group:insert(gdisplay)
    --group:insert(character_scene)
--    groupGameLayer:insert(scrollView)
--
    ------------- other scene ---------------
    storyboard.removeScene( "team1" )
    storyboard.removeScene( "team2" )
    storyboard.removeScene( "team3" )
    storyboard.removeScene( "team4" )
    storyboard.removeScene( "team5" )
    storyboard.removeScene( "team_main" )
    storyboard.removeScene( "character_scene" )
    storyboard.removeScene( "characterprofile" )
end

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
