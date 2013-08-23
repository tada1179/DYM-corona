-- have backup in file scrollImage2.lua date backup 26-6-13 08.41 AM.

module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
-- set some global values for width and height of the screen
local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local prevTime = 0
local pointListY =0
function new(params)
    -- setup a group to be the scrolling screen
    local scrollView = display.newGroup()
    local Gscroll = display.newGroup()
    local AllView = display.newGroup()

    local user_id = params.user_id or nil
    local maxChapter = 0
    local characterItem = {}

    local pointListX = screenW *.1
    pointListY =  0

    scrollView.top = math.floor(screenH*.18) or 0
    --    scrollView.bottom =   math.floor(screenH*.36)
    scrollView.bottom =   math.floor(screenH*.27)


    print("scrollView.top",scrollView.top,"scrollView.bottom",scrollView.bottom)

    function scrollView:touch(event)
        print("scrollView touch")
        local phase = event.phase
        print(event.phase)
        if( phase == "began" ) then
            print("...0began self.y",self.y)
            print("...0began self.scrollBar",self.scrollBar.y)
            print("...0began self.event.y",event.y)
            self.startPos = event.y
            self.prevPos = event.y
            self.delta, self.velocity = 0, 0

            if self.tween then
                transition.cancel(self.tween)
            end

            Runtime:removeEventListener("enterFrame", scrollView )

            self.prevTime = 0
            self.prevY = 0

            transition.to(self.scrollBar,  { time=200, alpha=1 } )
            transition.to(self.SCROLL_LINE,  { time=200, alpha=1 } )

            -- Start tracking velocity
            Runtime:addEventListener("enterFrame", trackVelocity)

            -- Subsequent touch events will target button even if they are outside the stageBounds of button
            display.getCurrentStage():setFocus( self )
            self.isFocus = true
        elseif( self.isFocus ) then

            if( phase == "moved" ) then
                print("...0moved self.y",self.y)
                print("...0moved self.scrollBar",self.scrollBar.y)
                --self.bottom = screenH*.35
                local bottomLimit = screenH - self.height - self.bottom
                self.delta = event.y - self.prevPos
                self.prevPos = event.y

                if ( self.y >= self.top or self.y < bottomLimit ) then
                    print("MAX1 self.y",self.y)
                    self.y  = self.y + self.delta/2
                else
                    print("MAX2 self.y",self.y)
                    self.y = self.y + self.delta
                    --                                self.y = self.y
                end

                scrollView:moveScrollBar()

            elseif( phase == "ended" or phase == "cancelled" ) then
                local dragDistance = event.y - self.startPos
                self.lastTime = event.time
                if dragDistance== 0 then
                    print("ID NAME:",event.target.id)
                    --print("ID numTouches:",self.numTouches)
                end

                print("END dragDistance:",dragDistance)
                Runtime:addEventListener("enterFrame", scrollView )
                Runtime:removeEventListener("enterFrame", trackVelocity)

                -- Allow touch events to be sent normally to the objects they "hit"
                display.getCurrentStage():setFocus( nil )
                self.isFocus = false
            end
        end

        return true
    end

    function scrollView:enterFrame(event)
        print("scrollView:enterFrame self.top ",self.y )
        local friction = .9
        local timePassed = event.time - self.lastTime
        self.lastTime = self.lastTime + timePassed

        --turn off scrolling if velocity is near zero
        if math.abs(self.velocity) < .01 then
            self.velocity = 0
            Runtime:removeEventListener("enterFrame", scrollView )
            --transition.to(self.scrollBar,  { time=400, alpha=0 } )
        end

        self.velocity = self.velocity*friction
        self.y = math.floor(self.y + self.velocity*timePassed)

        local upperLimit = self.top
        local bottomLimit = screenH - self.height - self.bottom
        if ( self.y > upperLimit ) then
            print("001 bottomLimit",bottomLimit,"self.y",self.y)
            self.velocity = 0
            Runtime:removeEventListener("enterFrame", scrollView )
            self.tween = transition.to(self, { time=400, y=upperLimit, transition=easing.outQuad})
            --transition.to(self.scrollBar,  { time=400, alpha=0 } )
        elseif ( self.y < bottomLimit and bottomLimit < 0 ) then
            print("002 bottomLimit",bottomLimit,"self.y",self.y)
            self.velocity = 0
            Runtime:removeEventListener("enterFrame", scrollView )
            self.tween = transition.to(self, { time=400, y=bottomLimit, transition=easing.outQuad})
            --transition.to(self.scrollBar,  { time=400, alpha=0 } )
        elseif ( self.y < bottomLimit ) then
            print("003 bottomLimit",bottomLimit,"self.y",self.y)
            self.velocity = 0
            Runtime:removeEventListener("enterFrame", scrollView )
            self.tween = transition.to(self, { time=400, y=upperLimit, transition=easing.outQuad})
            --transition.to(self.scrollBar,  { time=400, alpha=0 } )
        end

        scrollView:moveScrollBar()

        return true
    end

    function scrollView:moveScrollBar()
        if self.scrollBar then
            local scrollBar = self.scrollBar
            local pointDif = (self.top - self.y ) * self.yRatio

            scrollBar.y = pointDif + scrollBar.height*1.15 + self.top

            if scrollBar.y < 5 + self.top + scrollBar.height*1.15 then
                scrollBar.y =   self.top + scrollBar.height*1.15
                print("## 1 scrollView:moveScrollBar self.scrollBar ",scrollBar.y )
            end

            if scrollBar.y > screenH - self.bottom  -5- scrollBar.height*.3   then
                scrollBar.y = screenH  - self.bottom  -5- scrollBar.height*.3

                print("## 2 scrollView:moveScrollBar self.scrollBar ",scrollBar.y )
            end

        end
    end

    function trackVelocity(event)

        local timePassed = event.time - scrollView.prevTime
        scrollView.prevTime = scrollView.prevTime + timePassed

        if scrollView.prevY then
            scrollView.velocity = (scrollView.y - scrollView.prevY)/timePassed
        end
        scrollView.prevY = scrollView.y
    end

    scrollView.y = scrollView.top
    local function clickScroll(event)
        print("clickScroll clickScroll")

    end



    function loatCharacter()
        local http = require("socket.http")
        local json = require("json")
        local LinkItem = "http://localhost/DYM/battle_item.php"
        local URL =  LinkItem.."?user_id="..user_id
        local response = http.request(URL)
        if response == nil then
            print("No Dice")
        else
            local dataTable = json.decode(response)

            maxChapter = dataTable.All
            --AllItem = dataTable.AllItem

            local m = 1
            while m <= maxChapter do
                if dataTable.chracter ~= nil then
                    characterItem[m] = {}
                    characterItem[m].holditem_id = dataTable.chracter[m].holditem_id
                    characterItem[m].item_name = dataTable.chracter[m].item_name
                    characterItem[m].holditem_amount = tonumber(dataTable.chracter[m].holditem_amount)
                    characterItem[m].imagePicture = dataTable.chracter[m].img
                    characterItem[m].imagefrm = tonumber(dataTable.chracter[m].element)
                    characterItem[m].excoin = tonumber(dataTable.chracter[m].excoin)
                    characterItem[m].ticket = tonumber(dataTable.chracter[m].ticket)
                end
                m = m+1
            end

        end
        createImage()
    end

    function createImage()
        local typeFont = native.systemFontBold
        local sizeFont =  18
        local sizeleaderW = screenW*.15
        local sizeleaderH = screenH*.1
        local listCharacter = {}
        local characELE = {}
        local frameElE = {}
        local NameItem
        local amountItem

        local pointY =  screenH*.07
        local pointX =  screenW*.12

        local pointYimg =  screenH*.07

        local pointYname =  screenH*.08
        local pointXname =  screenW*.4

        local pointXamount =  screenW*.75

        local image_Framelist = "img/background/sellBattle_Item/framesell_set.png"
        local frame =
        {
            "img/characterIcon/as_cha_frm01.png",
            "img/characterIcon/as_cha_frm02.png",
            "img/characterIcon/as_cha_frm03.png",
            "img/characterIcon/as_cha_frm04.png",
            "img/characterIcon/as_cha_frm05.png"
        }
        local rowscharac = maxChapter+1
        for i = 1, rowscharac, 1 do
            pointY = pointY + (screenH*.105)
            pointYimg = pointYimg + (screenH*.105)
            pointYname = pointYname + (screenH*.105)

            if i == rowscharac then
                listCharacter[i] = display.newImageRect( image_Framelist,screenW * .70 , sizeleaderH )
                listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
                listCharacter[i].x, listCharacter[i].y = pointX, pointY
                listCharacter[i].alpha =  0

                frameElE[i] = widget.newButton{
                    default=  frame[1],
                    width=sizeleaderW ,
                    height=sizeleaderH,
                    top = pointYimg,
                    left = pointX ,
                    onRelease = onButtonEvent	-- event listener function
                }frameElE[i].id = i
                frameElE[i].alpha =  0

                characELE[i] = display.newImageRect( image_Framelist,sizeleaderW,sizeleaderH )
                characELE[i] :setReferencePoint( display.TopLeftReferencePoint )
                characELE[i].alpha =  0
                characELE[i].x =  pointX
                characELE[i].y =  pointYimg

                NameItem = display.newText("name", screenW*.7, screenH*.5, typeFont, sizeFont)
                NameItem:setTextColor(255, 255, 255)
                NameItem.text =  string.format("name")
                NameItem.alpha =  0

                NameItem.x = pointXname
                NameItem.y = pointYname

                amountItem = display.newText("item", screenW*.7, screenH*.5, typeFont, sizeFont)
                amountItem:setTextColor(255, 255, 255)
                amountItem.text =  string.format("item")
                amountItem.alpha =  0
                amountItem.x = pointXamount
                amountItem.y = pointYname

            else
                listCharacter[i] = display.newImageRect( image_Framelist,screenW * .70 , sizeleaderH )
                listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
                listCharacter[i].x, listCharacter[i].y = pointX, pointY

                frameElE[i] = widget.newButton{
                    default=  frame[characterItem[i].imagefrm],
                    width=sizeleaderW ,
                    height=sizeleaderH,
                    top = pointYimg,
                    left = pointX ,
                    onEvent = onButtonEvent	-- event listener function
                }frameElE[i].id = i

                characELE[i] = display.newImageRect( characterItem[i].imagePicture,sizeleaderW,sizeleaderH )
                characELE[i] :setReferencePoint( display.TopLeftReferencePoint )
                characELE[i].x =  pointX
                characELE[i].y =  pointYimg

                NameItem = display.newText(characterItem[i].item_name, screenW*.7, screenH*.5, typeFont, sizeFont)
                NameItem:setTextColor(255, 255, 255)
                NameItem.text =  string.format(characterItem[i].item_name)
                NameItem.x = pointXname
                NameItem.y = pointYname

                amountItem = display.newText(characterItem[i].holditem_amount, screenW*.7, screenH*.5, typeFont, sizeFont)
                amountItem:setTextColor(255, 255, 255)
                amountItem.text =  string.format(characterItem[i].holditem_amount)
                amountItem.x = pointXamount
                amountItem.y = pointYname

            end
            scrollView:insert(amountItem)
            scrollView:insert(NameItem)
            scrollView:insert(listCharacter[i])
            scrollView:insert(characELE[i])
            scrollView:insert(frameElE[i])
        end
    end
    function onButtonEvent(event)

        local option = {
            effect = "slideRight",
            time = 100,
            params = {
                user_id = user_id,
                holditem_id = characterItem[event.target.id].holditem_id,
                item_name = characterItem[event.target.id].item_name,
                img_item = characterItem[event.target.id].imagePicture,
                amount = characterItem[event.target.id].holditem_amount,
                element_item = characterItem[event.target.id].imagefrm,
                coin_item = characterItem[event.target.id].excoin

            }
        }
        print(event.phase)

        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
            local scrollBar = self.scrollBar
        elseif event.phase == "moved" then
            local dy = math.abs( event.y - event.yStart )

            if  dy > 5 then
                --scrollView:takeFocus( event )
                --moveScrollBar(dy)
            end

        elseif event.phase == "release" then
            local alertMSN = require ("alertMassage")
            alertMSN.confrimSellItem(option)

        end

        return true
    end

    local function addScrollBar(r,g,b,a)

        if scrollView.scrollBar then scrollView.scrollBar:removescrollView() end

        local viewPortH =  scrollView.height - scrollView.bottom
        local scrollH = viewPortH*scrollView.height/(scrollView.height*2  - viewPortH)

        local SCROLL_LINE = display.newImageRect( "img/background/frame/SCROLL_LINE.png", screenW*.3, screenH*.6)
        SCROLL_LINE:setReferencePoint( display.TopLeftReferencePoint )
        SCROLL_LINE.x =  screenW*.73
        SCROLL_LINE.y =  screenH*.29
        Gscroll:insert(SCROLL_LINE)

        local scrollBar = display.newImageRect( "img/background/frame/SCROLLER.png", screenW*.18, screenH*.15)
        scrollBar:setReferencePoint( display.TopLeftReferencePoint )
        scrollBar.x = screenW*.8
        Gscroll:insert(scrollBar)
        local LH = SCROLL_LINE.height/scrollBar.height
        print("SCROLL_LINE.height:",SCROLL_LINE.height,"scrollBar.height:",scrollBar.height,"LH:",LH)


        --		local yRatio = (screenH*.6)/(scrollView.height- (scrollView.bottom + scrollView.top))
        local yRatio = ((screenH*.6)-scrollBar.height*1.15)/(scrollView.height- (scrollView.bottom + scrollView.top))
        scrollView.yRatio =  yRatio

        print("scrollView.(scrollView.height - scrollView.bottom)",(scrollView.height - scrollView.bottom- scrollView.top))
        print("scrollView.yRatio",scrollView.yRatio)
        scrollBar.y = scrollBar.height*1.15 + scrollView.top

        scrollView.scrollBar = scrollBar
        scrollView.SCROLL_LINE = SCROLL_LINE

    end
    if maxChapter >=5 then
        scrollView:addEventListener( "touch", scrollView )
        addScrollBar()
    end

--        scrollView:addEventListener( "touch", scrollView )
--        addScrollBar()

    function scrollView:removeScrollBar()
        if self.scrollBar then
            self.scrollBar:removeSelf()
            self.scrollBar = nil

            self.SCROLL_LINE:removeSelf()
            self.SCROLL_LINE = nil
        end
    end

    function scrollView:cleanUp()
        Runtime:removeEventListener("enterFrame", trackVelocity)
        Runtime:removeEventListener( "touch", scrollView )
        Runtime:removeEventListener("enterFrame", scrollView )
        Runtime:removeEventListener("addScrollBar", scrollView )
        scrollView:removeScrollBar()
        Gscroll:removeSelf()
    end

    AllView:insert(Gscroll)
    AllView:insert(scrollView)
    return AllView
end
