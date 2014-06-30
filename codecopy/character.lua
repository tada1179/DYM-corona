local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local previous_scene_name = storyboard.getPrevious()
local widget = require( "widget" )

local screenW = display.contentWidth
local screenH = display.contentHeight
local color_id
local gdisplay
local button1 = {}
local scrollView
---------------------------------------
local function onButtonEvent(event)

    if event.phase == "begen" then
        event.markX = event.x
        event.markY = event.y
    elseif event.phase == "moved" then

        local dy = math.abs( event.y - event.yStart )
        if  dy > 5 then
            scrollView:takeFocus( event )
        end

    elseif  event.phase == "ended" then
    end
end
local function backNext()
    local function ButtonEventNB(event)
        print("back character")
        display.remove(gdisplay)
        gdisplay = nil
        storyboard.gotoScene(previous_scene_name,"slideRight",200)
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
    color_id = event.params.color
    local group = self.view
    gdisplay = display.newGroup()
    local img = "img/fill_bkg.png"
    local topImg = display.newImageRect(img,screenW,screenH*.2)
    topImg.x = screenW*.5
    topImg.y = 0
    topImg.anchorX = 0.5
    topImg.anchorY = 0
    gdisplay:insert(topImg)
    local text = display.newText("CHARACTER",screenW*.5,screenH*.1,"CooperBlackMS",45)
    text.anchorX = 0.5
    text.anchorY = 1
    gdisplay:insert(text)
    backNext()

    local scrY = 0
    local scrX = screenW*.2
    local color = 0
    local sizeFramW = screenW*.8
    local sizeFramH = screenH*.1
    local img = "img/Frame_mission_clear.png"

    local clearBox = display.newImageRect( img, sizeFramW,sizeFramH )
    clearBox.anchorX = 0.51
    clearBox.anchorY = 0
    clearBox.x, clearBox.y = screenW*.5, screenH*.28
    gdisplay:insert(clearBox)
    scrollView = widget.newScrollView
        {
            top = screenH*.4,
            left = screenW*.05,
            width = screenW*.9,
            height = screenH*.6,
            scrollWidth = 600,
            scrollHeight = 800,
            hideBackground = true,
        }


    for i=1,10,1 do
            color = color +1
            button1[i] = widget.newButton
                {
                    left = scrX,
                    top = scrY,
                    width = sizeFramW,
                    height = sizeFramH,
                    id = color,
                    defaultFile = img,
                    overFile = img,
                    onEvent = onButtonEvent
                }
            button1[i].anchorX = 0.7
            if color_id == 1 then  --red
                button1[i]:setFillColor( 1,0,0 )
                clearBox:setFillColor( 1,0,0 )
            elseif color_id == 2 then --green
                button1[i]:setFillColor( 0,1,0 )
                clearBox:setFillColor( 0,1,0 )
            elseif color_id == 3 then --blue
                button1[i]:setFillColor( 0,0.7,1 )
                clearBox:setFillColor( 0,0.7,1 )
            elseif color_id == 4 then --purple
                button1[i]:setFillColor( 148/255, 0 ,211/255 )
                clearBox:setFillColor( 148/255, 0 ,211/255 )
            elseif color_id == 5 then --yellow
                button1[i]:setFillColor( 1,1,0 )
                clearBox:setFillColor( 1,1,0 )
            elseif color_id == 6 then --pink
                button1[i]:setFillColor( 255/255, 192/255, 203/255 )
                clearBox:setFillColor( 255/255, 192/255, 203/255 )
            end

            scrollView:insert(button1[i])
        scrY = scrY + (screenH*.12)
    end

    gdisplay:insert(scrollView)
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