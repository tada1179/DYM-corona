local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
function scene:createScene( event )
    print("Page with")
    local group = self.view
--    local page = event.params.page
--    local user_score = event.params.user_score

--    local options =
--    {
--        effect = "zoomInOutFade",
--        time = 100,
--        params = {
--            page = page ,
--            user_score = user_score
--        }
--    }
    --storyboard.gotoScene(page,options)
end

function scene:enterScene( event )
    local group = self.view
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view

    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:destroyScene( event )
    local group = self.view

end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene