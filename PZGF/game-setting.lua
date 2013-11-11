
local storyboard = require("storyboard")
local scene = storyboard.newScene()
local menu_barLight = require ("menu_barLight")
local widget = require "widget"
local current = storyboard.getCurrentSceneName()
local previous_scene_name = storyboard.getPrevious()--page call befor
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

local FontAndSize ={}
FontAndSize = menu_barLight.TypeFontAndSizeText()
local typeFont = FontAndSize.typeFont
local fontsize = FontAndSize.fontSize
local fontsizeHead = FontAndSize.fontSizeHead
local image_frame = "img/background/frame/iconbox.png"
local titleText

-------------------------------------
local function onBtnRelease(event)
    menu_barLight.SEtouchButton()
	if(event.target.id == "back")then
		storyboard.gotoScene( "map", "fade", 100 )
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

local screenW, screenH = display.contentWidth, display.contentHeight

local prevTime = 0
local pointListY =0
local listener
local scrollView
-------------------------------------

-------------------------------------

local function scrollViewList()
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
            if event.target.id == "gallery" then
                storyboard.gotoScene( "gallery", "fade", 100 )

            elseif event.target.id == "announcement" then
                --storyboard.gotoScene( "announcement", "fade", 100 )

            elseif event.target.id == "editname" then
                require ("menu").removeDisplay()
                local user_name = menu_barLight.user_name()
                local user_id = menu_barLight.user_id()
                local namepage =  current
                local option = {
                    effect = "fade",
                    time = 100,
                    params =
                    {
                       user_name = user_name,
                        user_id = user_id,
                        namepage = namepage,
                    }
                }
                storyboard.gotoScene( "register", option)

            elseif event.target.id == "contactus" then
                storyboard.gotoScene( "contact-us", "fade", 100 )

            elseif event.target.id == "gamecenter" then
                storyboard.gotoScene( "game-center", "fade", 100 )

            elseif event.target.id == "help" then
                storyboard.gotoScene( "help", "fade", 100 )

            elseif event.target.id == "privacy" then
                -- storyboard.gotoScene( "privacy", "fade", 100 )

            end

        end

        return true
    end

    local id
    local imgFrmList
    local maxChapter = 7
    for i = 1, maxChapter do


        if i == 1 then
            imgFrmList = "GALLERY"
            text = "gallery"
        elseif i == 2 then
            imgFrmList = "ANNOUNCEMENT"
            text = "announcement"
        elseif i == 3 then
            imgFrmList = "EDIT NAME"
            text = "editname"
        elseif i == 4 then
            imgFrmList = "CONTACT US"
            text = "contactus"
        elseif i == 5 then
            imgFrmList = "GAME CENTER"
            text = "gamecenter"
        elseif i == 6 then
            imgFrmList = "HELP"
            text = "help"
        elseif i == 7 then
            imgFrmList = "PRIVACY POLICY"
            text = "privacy"
        end

        listCharacter[i] = widget.newButton{
            defaultFile = image_frame,
            overFile = image_frame,
            width= screenW*.7 ,
            height= screenH*.1,
            onEvent = onButtonEvent   ,
            label = imgFrmList,
            labelColor = {
                default = { 255, 255, 255, 255 },
                over = {  255, 255, 255, 255 },
            }
        }
        listCharacter[i].id= text
        listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
        listCharacter[i].x =0
        listCharacter[i].y =pointListY
        pointListY = pointListY + (screenH*.105)
        scrollView:insert(listCharacter[i])
        --scrollView:insert(backButton)
    end

end
function scene:createScene( event )
    local group = self.view
    groupView = display.newGroup()
    groupView:insert(background)

    titleText = display.newText("OTHER", 0, screenH*.3,typeFont, fontsizeHead)
    titleText.x = screenW*.5
    titleText:setReferencePoint( display.TopLeftReferencePoint )
    titleText:setTextColor(255, 255, 255)

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
    storyboard.purgeScene( "map" )
    storyboard.purgeScene( "gallery" )
    storyboard.purgeScene( "register" )
    storyboard.purgeScene( "contact-us" )
    storyboard.purgeScene( "game-center" )
    storyboard.purgeScene( "help" )
    storyboard.removeAll ()
    storyboard.purgeAll()
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
