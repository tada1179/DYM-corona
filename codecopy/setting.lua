local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()
local widget = require( "widget" )

local screenW = display.contentWidth
local screenH = display.contentHeight
local gdisplay
local button1 = {}
local detailColor = {}
---------------------------------------
local function handleButtonEvent( event )
    display.remove(gdisplay)
    gdisplay = nil

    local options =
    {
        effect = "zoomInOutFade",
        time = 100,
        params = {
            color = event.target.id
        }
    }
     if event.target.id then
         storyboard.gotoScene("character",options)
     end

end
local function backNext()
     local function ButtonEventNB(event)

         print("back character")
         display.remove(gdisplay)
         gdisplay = nil
         storyboard.gotoScene("menu","slideRight",200)
     end

     local imgNB = "img/NextBack.png"
     local NB = 0
     local buttonBN ={}
     local textBTN = {"BACK" }
     local scrX = screenW*.1
     local scrXText = screenW*.1
     local rotation = 0
     for i=1,#textBTN,1 do
         NB = NB +1
         buttonBN[i] = widget.newButton
             {
                 left = scrX,
                 top = screenH*.2,
                 width = screenW*.15,
                 height = screenH*.06,
                 id = NB,
                 defaultFile = imgNB,
                 overFile = imgNB,
                 font = "CooperBlackMS",
                 fontSize = 25,
                 labelColor = {
                     default={ 1, 0, 1 },
                     over={ 0, 0, 0, 0.5 }
                 },
                 onEvent = ButtonEventNB
             }
         buttonBN[i].rotation = rotation
         buttonBN[i].anchorX = 1

         local texttitle = display.newText(textBTN[NB],scrXText,screenH*.24,"CooperBlackMS",23)
         texttitle.anchorX = 0.5
         texttitle.anchorY = 1

         gdisplay:insert(buttonBN[i])
         gdisplay:insert(texttitle)


         rotation = 180
         scrX = screenW*.75
         scrXText = screenW*.9
     end

end
function scene:createScene( event )
    local group = self.view
    gdisplay = display.newGroup()
    local img = "img/fill_bkg.png"
    local topImg = display.newImageRect(img,screenW,screenH*.2)
    topImg.x = screenW*.5
    topImg.y = 0
    topImg.anchorX = 0.5
    topImg.anchorY = 0
    gdisplay:insert(topImg)
    backNext()

    local text = display.newText("SETTING",screenW*.5,screenH*.2,"CooperBlackMS",45)
    text.anchorX = 0.5
    text.anchorY = 1

    gdisplay:insert(text)

    local img = "img/element/white.png"
    local scrY = screenH*.3
    local scrX = screenW*.2

    local scrTextY = screenH*.32
    local scrTextX = screenW*.4

    local color = 0
    for i=1,3,1 do
        button1[i] = {}
        detailColor[i] = {}
        for j=1,2,1 do
            color = color +1
            button1[i][j] = widget.newButton
                {
                    left = scrX,
                    top = scrY,
                    width = screenW*.15,
                    height = screenH*.1,
                    id = color,
                    defaultFile = img,
                    over = {148/255, 0 ,211/255},
                    onEvent = handleButtonEvent
                }
            button1[i][j].anchorX = 1
            gdisplay:insert(button1[i][j])
            detailColor[i][j] = display.newText("My name",scrTextX,scrTextY,"CooperBlackMS",25)
            detailColor[i][j].anchorX = 0.5
            detailColor[i][j].anchorY = 1
            gdisplay:insert(detailColor[i][j])
            if color == 1 then  --red
                button1[i][j]:setFillColor( 1,0,0 )
                detailColor[i][j]:setFillColor( 1,0,0 )
            elseif color == 2 then --green
                button1[i][j]:setFillColor( 0,1,0 )
                detailColor[i][j]:setFillColor( 0,1,0 )
            elseif color == 3 then --blue
                button1[i][j]:setFillColor( 0,0.7,1 )
                detailColor[i][j]:setFillColor( 0,0.7,1 )
            elseif color == 4 then --purple
                button1[i][j]:setFillColor( 148/255, 0 ,211/255 )
                detailColor[i][j]:setFillColor( 148/255, 0 ,211/255 )
            elseif color == 5 then --yellow
                button1[i][j]:setFillColor( 1,1,0 )
                detailColor[i][j]:setFillColor( 1,1,0 )
            elseif color == 6 then --pink
                button1[i][j]:setFillColor( 255/255, 192/255, 203/255 )
                detailColor[i][j]:setFillColor( 255/255, 192/255, 203/255 )
            end

            scrX = scrX + (screenW*.4)
            scrTextX = scrTextX + (screenW*.4)
        end

        scrX = screenW*.2
        scrTextX = screenW*.4

        scrY = scrY + (screenH*.15)
        scrTextY = scrTextY + (screenH*.15)
    end

    group:insert(gdisplay)
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