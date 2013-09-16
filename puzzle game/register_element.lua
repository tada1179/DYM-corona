local storyboard = require("storyboard")
storyboard.purgeOnSceneChange = true
storyboard.disableAutoPurge = true
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()

local widget = require "widget"
local http = require("socket.http")
local alertMSN = require("alertMassage")
local json = require("json")
-------------------------------------------------
local header
local user_name
-------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local gdisplay = display.newGroup()
-------------------------------------------
 local function saveRegisterRelease(event)

     local option = {
         effect = "fade",
         time = 100,
         params = {
             user_name =  user_name,
             type = event.target.id
         }
     }
     if event.target.id == "back" then
         storyboard.gotoScene( "register",option )
     else
         display.remove(gdisplay)
         gdisplay= nil

         local SysdeviceID = system.getInfo( "deviceID" ) -- deviceID IMEI Phone
         local Linkmission = "http://localhost/dym/register_User.php"

         local numberHold_character =  Linkmission.."?user_name="..user_name.."&type="..event.target.id.."&SysdeviceID="..SysdeviceID
         local numberHold = http.request(numberHold_character)

         storyboard.gotoScene( "map","fade",100 )
     end

 end
function scene:createScene( event )
    print("----- save element --- ")
    print("previous_scene_name",previous_scene_name)
    user_name = event.params.user_name
    local typeFont = native.systemFontBold
    local group = self.view
    local image_background1 = "img/background/background_a1.png"

    local background = display.newImageRect(image_background1,screenW,screenH)--contentWidth contentHeight
    background:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    background.x,background.y = 0,0
    gdisplay:insert(background)

    local image_title = "img/text/as_title_ally.png"
    local texttitle = display.newImageRect(image_title,screenW*.5,screenH*.04)--contentWidth contentHeight
    texttitle:setReferencePoint(display.CenterReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
    texttitle.x,texttitle.y = screenW*.5,screenH*.15
    gdisplay:insert(texttitle)

    local img_back = "img/background/button/Button_BACK.png"
    local btnback = widget.newButton{
        defaultFile = img_back,
        overFile = img_back,
        width= screenW*.13, height=screenH*.07,
        onRelease = saveRegisterRelease	-- event listener function
    }
    btnback.id = "back"--red
    btnback:setReferencePoint( display.TopLeftReferencePoint )
    btnback.x = screenW*.08
    btnback.y = screenH*.12
    gdisplay:insert(btnback)
    group:insert(gdisplay)

    local sizeImgX = screenW*.25
    local sizeImgY = screenH*.16
    local sizeNameX = screenW*.4
    local sizeNameY = screenH*.07

    local img_OK = "img/characterIcon/img/tgr_chfa-i201f.png"
    local btnOK = widget.newButton{
        defaultFile = img_OK,
        overFile = img_OK,
        width= sizeImgX, height=sizeImgY,
        onRelease = saveRegisterRelease	-- event listener function
    }
    btnOK.id = 1--red
    btnOK:setReferencePoint( display.TopLeftReferencePoint )
    btnOK.x = screenW*.18
    btnOK.y = screenH*.25
    gdisplay:insert(btnOK)
    group:insert(gdisplay)
    local img_Name1 = "img/background/register/as_butt_red.png"
    local btnOK1Name = widget.newButton{
        defaultFile = img_Name1,
        overFile = img_Name1,
        width= sizeNameX , height=sizeNameY,
        onRelease = saveRegisterRelease	-- event listener function
    }
    btnOK1Name.id = 1--blue
    btnOK1Name:setReferencePoint( display.TopLeftReferencePoint )
    btnOK1Name.x = screenW*.5
    btnOK1Name.y = screenH*.3
    gdisplay:insert(btnOK1Name)

    local img_OK2 = "img/characterIcon/img/machao-f101.png" --green
    local btnOK2 = widget.newButton{
        defaultFile = img_OK2,
        overFile = img_OK2,
        width= sizeImgX, height=sizeImgY,
        onRelease = saveRegisterRelease	-- event listener function
    }
    btnOK2.id = 2--green
    btnOK2:setReferencePoint( display.TopLeftReferencePoint )
    btnOK2.x = screenW*.18
    btnOK2.y = screenH*.45
    gdisplay:insert(btnOK2)
    local img_Name2 = "img/background/register/as_butt_green.png"
    local btnOK2Name = widget.newButton{
        defaultFile = img_Name2,
        overFile = img_Name2,
        width= sizeNameX, height=sizeNameY,
        onRelease = saveRegisterRelease	-- event listener function
    }
    btnOK2Name.id = 2--Green
    btnOK2Name:setReferencePoint( display.TopLeftReferencePoint )
    btnOK2Name.x = screenW*.5
    btnOK2Name.y = screenH*.5
    gdisplay:insert(btnOK2Name)

   --blue
    local img_Name3 = "img/background/register/as_butt_blue.png"
    local img_OK3 = "img/characterIcon/img/kautu-i101.png"
    local btnOK3 = widget.newButton{
        defaultFile = img_OK3,
        overFile = img_OK3,
        width= sizeImgX, height=sizeImgY,
        onRelease = saveRegisterRelease	-- event listener function
    }
    btnOK3.id = 3--blue
    btnOK3:setReferencePoint( display.TopLeftReferencePoint )
    btnOK3.x = screenW*.18
    btnOK3.y = screenH*.65
    gdisplay:insert(btnOK3)
    local btnOK3Name = widget.newButton{
        defaultFile = img_Name3,
        overFile = img_Name3,
        width= sizeNameX, height=sizeNameY,
        onRelease = saveRegisterRelease	-- event listener function
    }
    btnOK3Name.id = 3--blue
    btnOK3Name:setReferencePoint( display.TopLeftReferencePoint )
    btnOK3Name.x = screenW*.5
    btnOK3Name.y = screenH*.7
    gdisplay:insert(btnOK3Name)

    --------------------------------------------
    storyboard.removeAll()
    storyboard.purgeAll()

end
function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
    display.remove(gdisplay)
    gdisplay = nil

    storyboard.removeAll()
    storyboard.purgeAll()

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

