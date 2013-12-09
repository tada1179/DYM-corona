local storyboard = require("storyboard")
--storyboard.purgeOnSceneChange = true
--storyboard.disableAutoPurge = true
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()

local widget = require "widget"
local http = require("socket.http")
local json = require("json")
local sheetInfo = require("chara_icon")
-------------------------------------------------
local header
local user_name
local characterItem = {}
local dataTable
local Allcharacter
-------------------------------------------------
local screenW, screenH = display.contentWidth, display.contentHeight
local gdisplay
-------------------------------------------
local function loadCharacter()

    local Linkmission = "http://133.242.169.252/DYM/characterSetRegister.php"
    local numberHold = http.request(Linkmission)

    dataTable  = json.decode(numberHold)
    Allcharacter = tonumber(dataTable.chrAll)
    if Allcharacter == nil then
        print("ERROR")
    else
    local k = 1
        while k<= Allcharacter do
            characterItem[k] = {}
            characterItem[k].charac_id = dataTable.chracter[k].charac_id
            characterItem[k].charac_img = dataTable.chracter[k].charac_img
            characterItem[k].charac_element = tonumber(dataTable.chracter[k].charac_element)
            characterItem[k].charac_name = dataTable.chracter[k].charac_name
            k = k+1
        end

    end
end
 local function saveRegisterRelease(event)
     native.setActivityIndicator( true )
     local option = {
         effect = "fade",
         time = 100,
         params = {
             user_name =  user_name,
             type = event.target.id
         }
     }
     function stopload()
         display.remove(gdisplay)
         gdisplay= nil

        native.setActivityIndicator( false )
     end
     if event.target.id == "back" then
         stopload()
         storyboard.gotoScene( "register",option )
     else

        local function networkListener(event)
            if ( event.isError ) then
                sendData()
            else
                timer.performWithDelay( 100, stopload)
                require ("downloadData").newload()
                storyboard.gotoScene( "map","fade",100 )

            end

        end

        function sendData()

            local SysdeviceID = system.getInfo( "deviceID" ) -- deviceID IMEI Phone
            local Linkmission = "http://133.242.169.252/DYM/register_User.php"

            local numberHold_character =  Linkmission.."?user_name="..user_name.."&type="..event.target.id.."&SysdeviceID="..SysdeviceID
            --local numberHold = http.request(numberHold_character)
            network.request( numberHold_character, "GET", networkListener )
        end
         sendData()

     end

 end
function scene:createScene( event )
    user_name = event.params.user_name
    local typeFont = native.systemFontBold
    local group = self.view
    local frame = require("alertMassage").loadFramElement()
    gdisplay = display.newGroup()
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
    btnback.id = "back"
    btnback:setReferencePoint( display.TopLeftReferencePoint )
    btnback.x = screenW*.08
    btnback.y = screenH*.12
    gdisplay:insert(btnback)
    group:insert(gdisplay)

   local function loadScene()

        loadCharacter()
        if Allcharacter == nil then
            local txtleader = display.newText("ERROR !! can't connect to server", screenW*.12, screenH*.5, native.systemFontBold,30 )
            txtleader:setReferencePoint( display.TopLeftReferencePoint )
            txtleader:setTextColor(255, 255, 255)
            gdisplay:insert(txtleader)

            local img_back = "img/background/button/OK_button.png"
            local btnback = widget.newButton{
                defaultFile = img_back,
                overFile = img_back,
                width= screenW*.3, height=screenH*.07,
                onRelease = loadScene	-- event listener function
            }
            btnback.id = "back"
            btnback:setReferencePoint( display.CenterReferencePoint )
            btnback.x = screenW*.5
            btnback.y = screenH*.6
            gdisplay:insert(btnback)
            group:insert(gdisplay)
        else
        ------------load character img---------------------------
            local sizeImgX = screenW*.25
            local sizeImgY = screenH*.16
            local sizeNameX = screenW*.4
            local sizeNameY = screenH*.07

            local pointYimg = screenH*.25
            local pointYtext = screenH*.3

--            local myImageSheet = graphics.newImageSheet( "img/character/chara_icon.png", sheetInfo:getSheet() )
            local myImageSheet = graphics.newImageSheet( "chara_icon.png",system.DocumentsDirectory, sheetInfo:getSheet() )

            for i = 1,Allcharacter,1 do   --1=green,2=blue,3=red
                local btnOK = widget.newButton{
                    defaultFile = frame[characterItem[i].charac_element],
                    overFile = frame[characterItem[i].charac_element],
                    width= sizeImgX, height=sizeImgY,
                    onRelease = saveRegisterRelease	-- event listener function
                }
                btnOK.id = i
                btnOK:setReferencePoint( display.TopLeftReferencePoint )
                btnOK.x = screenW*.18
                btnOK.y = pointYimg


                local frameRed = display.newImageRect(myImageSheet , sheetInfo:getFrameIndex(characterItem[i].charac_img) ,sizeImgX,sizeImgY)--contentWidth contentHeight
                frameRed:setReferencePoint(display.TopLeftReferencePoint)-- setReferencePoint( display.TopLeftReferencePoint )
                frameRed.x,frameRed.y = screenW*.18,pointYimg
                gdisplay:insert(frameRed)
                gdisplay:insert(btnOK)
                group:insert(gdisplay)

                local img_Name1 = "img/background/button/as_butt_empty.png"
                local btnOK1Name = widget.newButton{
                    defaultFile = img_Name1,
                    overFile = img_Name1,
                    width= sizeNameX , height=sizeNameY,
                    label = characterItem[i].charac_name,
                    fontSize = 45,
                    default = { 255, 0, 255,255 },
                    over = { 255, 255, 0,0},
                    font = native.systemFontBold,
                    onRelease = saveRegisterRelease	-- event listener function
                }
                btnOK1Name.id = i
                btnOK1Name:setReferencePoint( display.TopLeftReferencePoint )
                btnOK1Name.x = screenW*.5
                btnOK1Name.y = pointYtext
                gdisplay:insert(btnOK1Name)

                pointYtext = pointYtext + screenH*.2
                pointYimg = pointYimg + screenH*.2
            end
        end

   end
    loadScene()
end
function scene:enterScene( event )
    local group = self.view
    storyboard.purgeScene( "map" )
    storyboard.purgeScene( "register" )
    storyboard.removeAll ()
    storyboard.purgeAll()
end

function scene:exitScene( event )
    local group = self.view
    display.remove(gdisplay)
    gdisplay = nil

    storyboard.removeAll()
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

