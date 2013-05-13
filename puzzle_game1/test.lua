local storyboard = require "storyboard"

-- background should appear behind all scenes
local background = display.newImage( "img/background/test2.jpg" )

-- tab bar image should appear above all scenes
local tabBar = display.newImage( "img/background/battle_light.png" )
tabBar:setReferencePoint( display.BottomLeftReferencePoint )
tabBar.x, tabBar.y = 0, display.contentHeight

-- put everything in the right order
local display_stage = display.getCurrentStage()
display_stage:insert( background )
display_stage:insert( storyboard.stage )
display_stage:insert( tabBar )

-- go to the first scene
storyboard.gotoScene( "map", "fade", 300 )

