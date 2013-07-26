print("pageWith")
-------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()
local team_id
local holddteam_no
local character_id
local user_id

function scene:createScene( event )

end

function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    storyboard.removeAll ()
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )

end

function scene:destroyScene( event )
    local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene

