
local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.isDebug = true
local scene = storyboard.newScene()
local menu_barLight = require ("menu_barLight")
local widget = require "widget"
-- ------------------------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local groupView

local btnBox
local btnTeam
local btnPower
local btnUpgrade
local btnDischarge

local btnBack
local btnGallery
local btnAnnouncement
local btnEditname
local btnGameCenter
local btnContactUs

local image_text = "img/setting/OTHER.png"
local titleText
local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local fontsize = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead

local prevTime = 0
local pointListY =0
local listener
local scrollView
-------------------------------------
local function onBtnRelease(event)
    menu_barLight.SEtouchButtonBack()
    if(event.target.id == "back")then
        storyboard.gotoScene( "help", "fade", 100 )
    end

end

local function createBackButton()
    local imgBnt = "img/background/button/Button_BACK.png"
    local backButton = widget.newButton{
        defaultFile= imgBnt,
        overFile= imgBnt,
        width=screenW*.1, height=screenH*.05,
        onRelease = onBtnRelease	-- event listener function
    }
    backButton.id="back"
    backButton:setReferencePoint( display.TopLeftReferencePoint )
    backButton.x = screenW*.15
    backButton.y = screenH*.3
    groupView:insert(backButton)
end


local function scrollViewList()
    local text = {}
    scrollView = widget.newScrollView{
        width = screenW *.77,
        height = screenH * .45,
        top = 0,
        left = screenW *.15,
        scrollWidth = 10,
        bottom = 0,
        scrollHeight = 0,
        hideBackground = true ,
        horizontalScrollDisabled = false
    }

    local SCROLL_LINE
    local scrollBar
    local listCharacter = {}
    local backButton
    local txtbattle
    local pointListX = screenW *.1
    pointListY =  0
    scrollView.y = screenH*.35
    -------------------------------------------------------


    -- event listener for button widget
    local function onButtonEvent( event )

        if event.phase == "moved" then
            local dx = math.abs( event.x - event.xStart )
            local dy = math.abs( event.y - event.yStart )

            -- if finger drags button more than 5 pixels, pass focus to scrollView
            if dx > 5 or dy > 5 then
                scrollView:takeFocus( event )
            end

        elseif event.phase == "ended" then
            menu_barLight.SEtouchButton()
            local option = {
                effect = "fade",
                time = 100,
                params =
                {
                    num =  event.target.id,
                    text =  text[event.target.id]
                }
            }
                storyboard.gotoScene( "CharacterRulesSup", option)

        end

        return true
    end

    local id
    local imgFrmList
    local maxChapter = 4
    local pointListTxtY = screenH*.03
    for i = 1, maxChapter do
        text[i]={}
        imgFrmList = "img/setting/iconbox.png"
        if i == 1 then
            text[i] = "Ally"
        elseif i == 2 then
            text[i] = "Level Up & Evolve"
        elseif i == 3 then
            text[i] = "Monster Skill Level"
        elseif i == 4 then
            text[i] = "level UP Bonus"
        end

        listCharacter[i] = widget.newButton{
            defaultFile = imgFrmList,
            overFile = imgFrmList,
            width= screenW*.7 ,
            height= screenH*.1,
            onEvent = onButtonEvent
        }
        listCharacter[i].id= i
        listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
        listCharacter[i].x =0
        listCharacter[i].y =pointListY
        local NameMission = display.newText(text[i], 0, pointListTxtY,typeFont, fontsizeHead)

        NameMission:setReferencePoint( display.CenterReferencePoint )
        NameMission.x = screenW*.35
        NameMission:setFillColor(200, 200, 200)
        scrollView:insert(NameMission)

        pointListTxtY = pointListTxtY + (screenH*.105)
        pointListY = pointListY + (screenH*.105)

        scrollView:insert(listCharacter[i])
        --scrollView:insert(backButton)
    end

end
function scene:createScene( event )
    local group = self.view
    groupView = display.newGroup()
    groupView:insert(background)

    titleText  = display.newText("CHARACTER RULES", 0, screenH*.30,typeFont, fontsizeHead)
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.5
    titleText:setFillColor(255, 255, 255)

    createBackButton()
    scrollViewList()
    groupView:insert(scrollView)
    groupView:insert(titleText)
    groupView:insert(menu_barLight.newMenubutton())


    group:insert(groupView)
    menu_barLight.checkMemory()
    --------------------------
end
function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "help" )
    storyboard.purgeAll()
    storyboard.removeAll ()
end

function scene:exitScene( event )
    local group = self.view

    storyboard.removeAll ()
    storyboard.purgeAll()

end

function scene:destroyScene( event )
    local group = self.view
    display.remove(btnBox)
    btnBox = nil
    display.remove(btnTeam)
    btnTeam = nil
    display.remove(btnPower)
    btnPower = nil
    display.remove(btnUpgrade)
    btnUpgrade = nil
    display.remove(btnDischarge)
    btnDischarge = nil

    display.remove(titleText)
    titleText = nil

    --    for i= groupView.numChildren,1,-1 do
    --        local child = groupView[i]
    --        child.parent:remove( child )
    --        child = nil
    --    end
    display.remove(groupView)
    groupView = nil
    --storyboard:removeScene("unit_main")
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene
