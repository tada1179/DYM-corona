local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local screenW, screenH = display.contentWidth, display.contentHeight
---------------------------------------------------------------------
function scene:createScene( event )
    local group = self.view
    local ch_name = event.params.ch_name
    local ch_no = event.params.ch_no
    local ch_exp = event.params.ch_exp
    local ch_lv = event.params.ch_lv
    local ch_def = event.params.ch_def
    local ch_atk = event.params.ch_atk
    local ch_lvmax = event.params.ch_lvmax
    group:insert(background)
    local skillText = display.newImageRect(image_skill, screenW*.095, screenH*.093 )
    skillText:setReferencePoint( display.CenterReferencePoint )
    skillText.x = screenW*.2
    skillText.y = screenH*.734
end

function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene(previous_scene_name)
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

