print("firstpage")

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local http = require("socket.http")
local ltn12 = require("ltn12")
----------------------------------
local function showImage( i)
    native.setActivityIndicator( false )
    --testImage = display.newImage(i,system.DocumentsDirectory,screenW*.1,screenH*(i/4));
    --    testImage =display.newImageRect(system.pathForFile(i, system.DocumentsDirectory ), 100, 100 );

end
--
local function loadImage()
    -- Create local file for saving data
    local path = {}
    local myFile = {}
    for i=1,2,1 do
        if i == 1 then
            path[i] = system.pathForFile("img_back", system.DocumentsDirectory )
        elseif i == 2 then
            path[i] = system.pathForFile("img_map", system.DocumentsDirectory )
        end
        myFile[i] = io.open( path[i], "wb" )

        native.setActivityIndicator( true )		-- show busy

        -- Request remote file and save data to local file
        local link = {
            "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-ash3/1005125_10152000874063012_459307936_n.jpg",
            "https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-ash4/1044117_10152000973733012_2063618801_n.jpg"

        }

        http.request{
            --        url = "http://developer.anscamobile.com/demo/hello.png",
            url = link[i],
            sink = ltn12.sink.file(myFile[i]),
        }
        -- Call the showImage function after a short time dealy
        timer.performWithDelay( 400, showImage(i))

    end
    io.close()
end
function scene:createScene( event)
    local group = self.view
    loadImage()
--    local withing = native.setActivityIndicator( true )		-- show busy
--    group:insert(withing)
    storyboard.gotoScene( "map","fade",100)
end
function scene:enterScene( event )
    local group = self.view
    print("scene: enter")
end

function scene:exitScene( event )
    local group = self.view
    print("scene: exit")
    storyboard.removeAll ()
    scene:removeEventListener( "createScene", scene )
    scene:removeEventListener( "enterScene", scene )
    scene:removeEventListener( "destroyScene", scene )
    -----------------
end

function scene:destroyScene( event )
    local group = self.view

    print("scene: destroy")
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
return scene