
local storyboard = require("storyboard")
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
    menu_barLight.SEtouchButton()
    if(event.target.id == "back")then
        storyboard.gotoScene( "contact-us", "fade", 100 )
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
local function scrollviewFN()
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


    titleText  = display.newText("DYM (THAILAND) CO.,LTD", 0, 0,typeFont, fontsizeHead)
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.35
    titleText:setTextColor(255, 255, 255)
    scrollView:insert(titleText)

    titleText  = display.newText("Programmer", 0, screenH*.18,typeFont, fontsizeHead)
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.35
    titleText:setTextColor(255, 255, 255)
    scrollView:insert(titleText)

    local text ="Mr.Eric Hlaing \n Ms.Kwanta Yusoh"
    local SmachText_s = util.wrappedText(text, screenW*.28, fontsize,typeFont, {255, 255, 255})
    SmachText_s:setReferencePoint( display.CenterReferencePoint )
    SmachText_s.x = screenW*.35
    SmachText_s.y = screenH*.25
    scrollView:insert(SmachText_s)

    titleText  = display.newText("Graphics Design", 0, screenH*.32,typeFont, fontsizeHead)
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.35
    titleText:setTextColor(255, 255, 255)
    scrollView:insert(titleText)

    local text ="Mr.Cheewin Tasaso \n Mr.Purich Pidroo \n Ms.Arina Arskaya"
    local SmachText_s = util.wrappedText(text, screenW*.28, fontsize,typeFont, {255, 255, 255})
    SmachText_s:setReferencePoint( display.CenterReferencePoint )
    SmachText_s.x = screenW*.35
    SmachText_s.y = screenH*.4
    scrollView:insert(SmachText_s)

    titleText  = display.newText("Adviser", 0, screenH*.05,typeFont, fontsizeHead)
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.35
    titleText:setTextColor(255, 255, 255)
    scrollView:insert(titleText)

    local text ="Mr.Takehiro Torii "
    local SmachText_s = util.wrappedText(text, screenW*.28, fontsize,typeFont, {255, 255, 255})
    SmachText_s:setReferencePoint( display.CenterReferencePoint )
    SmachText_s.x = screenW*.35
    SmachText_s.y = screenH*.10
    scrollView:insert(SmachText_s)


end
function scene:createScene( event )
    local group = self.view
    groupView = display.newGroup()
    groupView:insert(background)

    local titleText = display.newText("DEVELOPER", screenW*.38, screenH*.3,typeFont, fontsizeHead)

    titleText:setReferencePoint( display.TopLeftReferencePoint )
    titleText:setTextColor(255, 255, 255)
    groupView:insert(titleText)

    createBackButton()
    scrollviewFN()
    groupView:insert(scrollView)
    groupView:insert(menu_barLight.newMenubutton())


    group:insert(groupView)
    menu_barLight.checkMemory()
    --------------------------
end
function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "contact-us" )
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
