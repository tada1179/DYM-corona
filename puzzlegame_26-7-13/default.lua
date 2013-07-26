print("default")

local storyboard = require "storyboard"
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()

function scene:createScene( event )

    local params = event.params
    storyboard.gotoScene(params.page,event)


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


