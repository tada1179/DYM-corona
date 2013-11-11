
local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.isDebug = true
local scene = storyboard.newScene()
local menu_barLight = require ("menu_barLight")
local util = require ("util")
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
        storyboard.gotoScene( "BattleRules", "fade", 100 )
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

function scene:createScene( event )
    local group = self.view
    local num = event.params.num
    local textHead = event.params.text
    groupView = display.newGroup()
    local text = {
        "    Every summoner can obtain a maximun \nof 5 teams.Each team consists of 5 \nmonsters at maximun \n   if you find it to defeat the enemy,\nyou are encouraged to edit you team again \nto from a stronger one.",
        "    Attributes are exclusive in nature.\nWater extinguishes file;fire incinerates earth;\nearth absords water;while light and \ndark are mutually exclusive.\n   attack will be more effective \nwhen dissolving runestones of the opposing \nnature.",
        "    CD is the number of remaining turns\nuntil the enemies attack you.It is show above \neach enemy.",
        "    Dissolving heart runestones can recover HP",
        "    It can be initiated by dissolving 5 \nrunestones at a time",
        "    Special battles can be found in \nthe Lost Relic at the top left corner \nof the world map .\nYou will receive unique rewards for defeating \nbosses in the special battle.",
        "    It is a type of special battle,\nin which summoners will be rewarded with\nrare monsters.Instant battle are available \nfor only an hour a day.Don't miss them!",
        "    Finishing battles will reward you \nwith Exp.\n   When you Exp reaches a specific level,\nyou will level up with an increase in \nstamina and team size.Once you reach \nsummoner le el 10,20,30, & 40,1 more \nbarrack will be unlocked.",
        "    Coin can be used to level up and \nevole your monsters.\n    Ticket can be used to restore your stamina,\nsummon cards,increase limits for variouse\n extensions and resume the battle when defeates.",
        "    Friend points can be used to summon \ncards,while diamonds can be used to summon \nrare cards."
    }
    groupView:insert(background)

    titleText  = display.newText(textHead, 0, screenH*.30,typeFont, fontsizeHead)
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW*.5
    titleText:setTextColor(255, 255, 255)


    local SmachText_s = util.wrappedText(text[num], screenW*.28, fontsize,typeFont, {200, 200, 200})
    SmachText_s.x = screenW*.1
    SmachText_s.y = screenH*.38
    createBackButton()
    groupView:insert(SmachText_s)
    groupView:insert(titleText)
    groupView:insert(menu_barLight.newMenubutton())


    group:insert(groupView)
    menu_barLight.checkMemory()
    --------------------------

end
function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "BattleRules" )
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
