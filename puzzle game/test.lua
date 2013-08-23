local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local screenW, screenH = display.contentWidth, display.contentHeight
--******************************************************************

function scene:createScene( event)
--   local frameChar = display.newImageRect("img/characterIcon/as_cha_frm03.png",screenW*.5,screenH*.4)
   local frameChar = display.newImageRect("img/character/character_Alina/FEMALE_CHARACTER.png",screenW*.5,screenH*.5)
   frameChar:setReferencePoint( display.TopLeftReferencePoint )
   frameChar:setFillColor(255, 255, 255) --white
--   frameChar:setFillColor(34 ,139 ,34 ) --green
--   frameChar:setFillColor(135, 206, 250) --blue
--   frameChar:setFillColor(255, 0 ,0  ) --red
--   frameChar:setFillColor(148, 0 ,211 ) --DarkViolet
--   frameChar:setFillColor(255, 215 ,0 ) --yellow
   frameChar.x=0
   frameChar.y=0

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