
-----------------------------------------------------------------------------------------
--
-- team_main.lua
--
-- ##ref
--
-- Map
-----------------------------------------------------------------------------------------
print("discharge_main.lua")
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"


--------- icon event -------------
local listCharacter = {}
local backButton
local LinkURL = "http://localhost/DYM/hold_character.php"
local numberURL = "http://localhost/DYM/hold_character_number.php"  --count row  hold_character  for user_id
local data= {}

local countID = 0
local user_id = 1


local http = require("socket.http")
local json = require("json")
local dataTable = {}
local scrollView

local sizeleaderW = display.contentWidth*.135
local sizeleaderH = display.contentWidth*.135

local frame = {"img/framCharacterIcon/as_cha_frm01.png",
    "img/framCharacterIcon/as_cha_frm02.png",
    "img/framCharacterIcon/as_cha_frm03.png",
    "img/framCharacterIcon/as_cha_frm04.png",
    "img/framCharacterIcon/as_cha_frm05.png"}

local function LoadTeam()

    --    local URLimage =  LinkURL.."?user_id="..user_id
    --    local response = http.request(URLimage)

    local numberHold_character =  numberURL.."?user_id="..user_id
    local numberHold = http.request(numberHold_character)


    if numberHold == nil then
        print("No Dice")
    else
        print("numberHold"..numberHold)
        local allRow  = json.decode(numberHold)
        while(allRow.num_row > 0) do
            print("11 allRow:",allRow.num_row)
            local URLimage =  LinkURL.."?user_id="..user_id
            local response = http.request(URLimage)
            dataTable[allRow.num_row].charac_id = response.charac_id
            print("dataTable[allRow.num_row].charac_id",dataTable[allRow.num_row].charac_id)
            allRow.num_row = allRow.num_row - 1
        end
    end
end


local function BackButton(event)
    --    if event.target.id == "character" then
    print( "event: "..event.target.id)
    storyboard.gotoScene( "team_main", "fade", 100 )
    --    elseif  event.target.id == "team" then
    --        print( "event: "..event.target.id)
    --        storyboard.gotoScene( "team_main", "fade", 100 )
    --    elseif  event.target.id == "shop" then
    --        print( "event: "..event.target.id)
    --        storyboard.gotoScene( "shop_main", "fade", 100 )
    --    elseif  event.target.id == "gacha" then
    --        print( "event: "..event.target.id)
    --        storyboard.gotoScene( "gacha", "fade", 100 )
    --    elseif  event.target.id == "commu" then
    --        print( "event: "..event.target.id)
    --        storyboard.gotoScene( "commu_main", "fade", 100 )
    --
    --    elseif event.target.id == "back" then -- back button
    --        print( "event: "..event.target.id)
    --        storyboard.gotoScene( "team_main" ,"fade", 100 )
    --    end
    --    storyboard.gotoScene( "title_page", "fade", 100 )
    return true	-- indicates successful touch
end
local function checkMemory()
    collectgarbage( "collect" )
    local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end

local function selectLeader(event)
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

    local function onButtonEvent(event)
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
            print(event.target.id)
            print( "Button pushed." )
            --            onBtnRelease(event)
            storyboard.gotoScene( "character", "fade", 100 )
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
        hideBackground = false

    }

    for i = 1, 7, 1 do  -- create colum
        for j = 1, 5, 1 do --create row
            LeaderpointX = display.contentWidth *(-0.15+(i*0.15))
            LeaderpointY = display.contentHeight *(-0.12+(j*0.1))
            countID = countID + 1
            listCharacter[countID] = widget.newButton{
                default=frame[i],
                width=sizeleaderW , height=sizeleaderH,
                top = LeaderpointX,
                left = LeaderpointY,
                onEvent = onButtonEvent	-- event listener function
            }

            listCharacter[countID].id = "Character"..countID
            scrollView:insert(listCharacter[countID])
        end

    end
end

local function createBackButton()
    backButton = widget.newButton{
        default="img/background/button/Button_BACK.png",
        over="img/background/button/Button_BACK.png",
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
    checkMemory()
    groupGameLayer = display.newGroup()

    --    local background = display.newImageRect( "img/background/team/TEMPLATE_unit.jpg", display.contentWidth, display.contentHeight )
    local background = display.newImageRect( "img/background/background_1.png", display.contentWidth, display.contentHeight )
    background:setReferencePoint( display.TopLeftReferencePoint )
    background.x, background.y = 0, 0
    scrollViewList()
    --group:insert(scrollView)
    local background2 = display.newImageRect( "img/background/background_2.png", display.contentWidth, display.contentHeight )
    background2:setReferencePoint( display.TopLeftReferencePoint )
    background2.x, background2.y = 0, 0

    local titleText = display.newImageRect( "img/text/DISCHARGE.png", display.contentWidth/4.5, display.contentHeight/36 )
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

    group:insert(background)
    group:insert(groupGameLayer)
    group:insert(background2)
    group:insert(backButton)
    group:insert(titleText)
    group:insert(BLOCK_BOX)
    --    groupGameLayer:insert(scrollView)
    --
    ------------- other scene ---------------
    storyboard.removeScene( "map" )
    storyboard.removeScene( "title_page" )
    storyboard.removeScene( "map_substate" )
    storyboard.removeScene( "shop_main" )
    storyboard.removeScene( "gacha_main" )
    storyboard.removeScene( "commu_main" )
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
