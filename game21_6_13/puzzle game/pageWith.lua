print("pageWith")
-------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local team_id
local holddteam_no
local character_id
local user_id

function scene:createScene( event )
    local params = event.params

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

