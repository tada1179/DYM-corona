local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
storyboard.isDebug = true
--------------------------------------------------
local gdisplay
local pageTeam  = nil
local screenW, screenH = display.contentWidth, display.contentHeight

function scene:createScene( event )
    gdisplay = display.newGroup()

    local params = event.params
    if params then
        pageTeam = params.map_id
    else
        pageTeam = 1
    end

    local USERLV = 1
    local USERID = 1
    local group = self.view

    local teamNumber = 3
    local mySlides = {}
    for i = 1,teamNumber,1 do
        mySlides[i] = "team"..i
    end

    gdisplay:insert(require("teamView").new(mySlides,nil, nil, nil ,pageTeam,USERID,USERLV))
   group:insert(gdisplay)


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

scene:addEventListener( "createScene", scene)
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene



