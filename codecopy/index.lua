local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local screenW = display.contentWidth
local screenH = display.contentHeight
require( "top_name" )

-----------------------------------------
function scene:createScene( event )
    require( "menu" ).createScene()
end

function scene:enterScene( event )
local group = self.view
storyboard.purgeAll()
storyboard.removeAll ()
end

function scene:exitScene( event )
local group = self.view
storyboard.purgeAll()
storyboard.removeAll ()
end

function scene:destroyScene( event )
local group = self.view
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene