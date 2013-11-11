local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
local menu_barLight = require ("menu_barLight")
storyboard.isDebug = true
--------------------------------------------------
local gdisplay
local pageTeam  = nil

local titleText
function scene:createScene( event )
    gdisplay = display.newGroup()
    local screenW, screenH = display.contentWidth, display.contentHeight
    local image_text = "img/text/TEAM_SETTING.png"
    local params = event.params
    if params then
        pageTeam = params.team_id
    else
        pageTeam = 1
    end

    local USERLV = menu_barLight.userLevel()
    local USERID = menu_barLight.user_id()
    local group = self.view

    gdisplay:insert(background)

    titleText = display.newImageRect(image_text, screenW/3, screenH/35 )
    titleText:setReferencePoint( display.CenterReferencePoint )
    titleText.x = screenW /2
    titleText.y = screenH /3.1
    gdisplay:insert(titleText)

    local teamNumber = math.floor(USERLV/10) + 1
    if teamNumber > 5 then
        teamNumber = 5
    end
   -- teamNumber = 5
    local mySlides = {}
    for i = 1,teamNumber,1 do
        mySlides[i] = "team"..i
    end
    local pagelock = 5-teamNumber
    if pagelock ~=0 then
        for k = 1,pagelock,1 do
            mySlides[teamNumber+k] = "teamLock"
        end
    end

    gdisplay:insert(require("teamView").new(mySlides,nil, nil, nil ,pageTeam,USERID,USERLV))
    gdisplay:insert(menu_barLight.newMenubutton())
   group:insert(gdisplay)

    ----------------------
    menu_barLight.checkMemory()

end

function scene:enterScene( event )
    local group = self.view
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view

    display.remove (titleText)
    titleText = nil
    for i= gdisplay.numChildren,1,-1 do
        local child = gdisplay[i]
        child.parent:remove( child )
        child = nil
    end
    display.remove (gdisplay)
    gdisplay = nil

    storyboard.removeAll ()
    storyboard.purgeAll()

end

function scene:destroyScene( event )
    local group = self.view

    display.remove (titleText)
    titleText = nil
    display.remove (gdisplay)
    gdisplay = nil
end

scene:addEventListener( "createScene", scene)
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene



