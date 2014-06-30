local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = true
storyboard.isDebug = true
--------------------------------------------------
local option = nil
local gdisplay
local pageTeam  = nil
local screenW, screenH = display.contentWidth, display.contentHeight

function scene:createScene( event )
    gdisplay = display.newGroup()
    local params = event.params
    print("params.map_id team_select",params.map_id)

    if params then
        pageTeam = params.team_id

        option = {
            map_id = params.map_id ,
            mission_id = params.mission_id  ,
            mission_name = params.mission_name   ,
        }
--        print("params.map_id team_select",params.map_id)
    else
        pageTeam = 1
        option = 1
    end

    local USERLV = 1
    local USERID = 1
    local group = self.view

    local teamNumber = 3
    --    if teamNumber > 5 then
    --        teamNumber = 5
    --    end
    --   teamNumber = 5
    local mySlides = {}
    for i = 1,teamNumber,1 do
        mySlides[i] = "team_select"..i
        print("team_select : ",i)
    end

    gdisplay:insert(require("team_selectView").new(mySlides,nil, nil, nil ,pageTeam,USERID,USERLV,option))
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



