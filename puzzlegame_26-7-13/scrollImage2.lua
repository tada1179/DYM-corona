-- have backup in file scrollImage2.lua date backup 26-6-13 08.41 AM.

module(..., package.seeall)
local widget = require "widget"
-- set some global values for width and height of the screen
local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight

local prevTime = 0
local pointListY =0
function new()
    -- setup a group to be the scrolling screen
    local scrollView = display.newGroup()
    local Gscroll = display.newGroup()



    local pointListX = screenW *.1
    pointListY =  screenH*.08

    scrollView.top = math.floor(screenH*.18) or 0
    --    scrollView.bottom =   math.floor(screenH*.36)
    scrollView.bottom =   math.floor(screenH*.27)


    print("scrollView.top.top",scrollView.top,"scrollView.bottom",scrollView.bottom)

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
    local function onBtnRelease(event)
        print("xx onBtnRelease")
        print("event.target.id",event.target.id)
    end

    local maxChapter = 10
    local listCharacter = {}
    local backButton
    for i = 1, maxChapter, 1 do

        pointListY = pointListY + (screenH*.105)

        if i == maxChapter then
            local imgFrmList = "img/background/sellBattle_Item/frame.png"
            listCharacter[i] = display.newImageRect( imgFrmList, screenW*.7, screenH*.1)
            listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
            listCharacter[i].x, listCharacter[i].y = screenW*.15, pointListY
            listCharacter[i].id = i
            listCharacter[i].alpha = 0

            local imgBnt = "img/background/button/Button_BACK.png"
            backButton = widget.newButton{
                default= imgBnt,
                over= imgBnt,
                top = pointListY,
                left = screenW*.5,
                width= screenW/10, height= screenH/21,
                onRelease = onBtnRelease	-- event listener function
            }
            backButton.id=i


            local txtbattle = display.newText(i..":"..pointListY, screenW*.68, pointListY,native.systemFontBold, 20)
            txtbattle:setTextColor(200, 200, 200)
            txtbattle.alpha = 0
            scrollView:insert(txtbattle)
        else
            local imgFrmList = "img/background/sellBattle_Item/frame.png"
            listCharacter[i] = display.newImageRect( imgFrmList, screenW*.7, screenH*.1)
            listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
            listCharacter[i].x, listCharacter[i].y = screenW*.15, pointListY
            listCharacter[i].id = i
            listCharacter[i].numTouches = 0

            local imgBnt = "img/background/button/Button_BACK.png"
            backButton = widget.newButton{
                default= imgBnt,
                over= imgBnt,
                top = pointListY,
                left = screenW*.5,
                width= screenW/10, height= screenH/21,
                onRelease = onBtnRelease	-- event listener function
            }
            backButton.id=i


            local txtbattle = display.newText(i..":"..pointListY, screenW*.68, pointListY,native.systemFontBold, 20)
            txtbattle:setTextColor(200, 200, 200)
            scrollView:insert(txtbattle)
        end

        scrollView:insert(listCharacter[i])
        scrollView:insert(backButton)
    end

    function scrollView:addScrollBar(r,g,b,a)
        if self.scrollBar then self.scrollBar:removeSelf() end

        local scrollColorR = r or 255
        local scrollColorG = g or 0
        local scrollColorB = b or 100
        local scrollColorA = a or 120

        --		local viewPortH = screenH - self.top - self.bottom + (screenH*.08)
        --		local viewPortH =  scrollView.height - self.bottom
        local viewPortH =  self.height - self.bottom
        local scrollH = viewPortH*self.height/(self.height*2  - viewPortH)

        local SCROLL_LINE = display.newImageRect( "img/background/frame/SCROLL_LINE.png", screenW*.3, screenH*.6)
        SCROLL_LINE:setReferencePoint( display.TopLeftReferencePoint )
        SCROLL_LINE.x =  screenW*.73
        SCROLL_LINE.y =  screenH*.29
        Gscroll:insert(SCROLL_LINE)

        local scrollBar = display.newImageRect( "img/background/frame/SCROLLER.png", screenW*.18, screenH*.15)
        scrollBar:setReferencePoint( display.TopLeftReferencePoint )
        scrollBar.x = screenW*.8
        Gscroll:insert(scrollBar)

        --		local yRatio = viewPortH/self.height
        --		local yRatio = (scrollView.height*.06)/(screenH*.56)
        --		local yRatio = (screenH)/(pointListY-(screenH*.105))
        local LH = SCROLL_LINE.height/scrollBar.height
        print("SCROLL_LINE.height:",SCROLL_LINE.height,"scrollBar.height:",scrollBar.height,"LH:",LH)


        --		local yRatio = (screenH*.6)/(self.height- (self.bottom + self.top))
        local yRatio = ((screenH*.6)-scrollBar.height*1.15)/(self.height- (self.bottom + self.top))
        self.yRatio =  yRatio

        print("self.(self.height - self.bottom)",(self.height - self.bottom- self.top))
        print("self.yRatio",self.yRatio)
        scrollBar.y = scrollBar.height*1.15 + self.top

        --		scrollBar.y = scrollBar.height + self.top

        self.scrollBar = scrollBar
        self.SCROLL_LINE = SCROLL_LINE
        --        transition.to(scrollBar,  { time=400, alpha=0 } )
        --        transition.to(SCROLL_LINE,  { time=400, alpha=0 } )

    end
    if maxChapter >=5 then
        scrollView:addEventListener( "touch", scrollView )
        scrollView:addScrollBar()
    end

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
        scrollView:removeScrollBar()
        Gscroll:removeSelf()
    end

    return scrollView
end
