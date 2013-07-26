-- have backup in file scrollImage2.lua date backup 26-6-13 08.41 AM.

module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
-- set some global values for width and height of the screen
local screenW, screenH = display.contentWidth, display.contentHeight

local prevTime = 0
local pointListY =0
function new()
    -- setup a group to be the scrolling screen
    local scrollView = display.newGroup()
    local Gscroll = display.newGroup()
    local AllView = display.newGroup()

    local SCROLL_LINE
    local scrollBar
    local listCharacter = {}
    local backButton
    local txtbattle
    local pointListX = screenW *.1
    pointListY =  screenH*.08

    scrollView.top = math.floor(screenH*.18) or 0
    --    scrollView.bottom =   math.floor(screenH*.36)
    scrollView.bottom =   math.floor(screenH*.27)
     -------------------------------------------------------
    function scrollView:touch(event)
        local phase = event.phase
        if( phase == "began" ) then
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
                --self.bottom = screenH*.35
                local bottomLimit = screenH - self.height - self.bottom
                self.delta = event.y - self.prevPos
                self.prevPos = event.y

                if ( self.y >= self.top or self.y < bottomLimit ) then
                    self.y  = self.y + self.delta/2
                else
                    self.y = self.y + self.delta
                    --                                self.y = self.y
                end

                scrollView:moveScrollBar()

            elseif( phase == "ended" or phase == "cancelled" ) then
                local dragDistance = event.y - self.startPos
                self.lastTime = event.time

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
            self.velocity = 0
            Runtime:removeEventListener("enterFrame", scrollView )
            self.tween = transition.to(self, { time=400, y=upperLimit, transition=easing.outQuad})
            --transition.to(self.scrollBar,  { time=400, alpha=0 } )
        elseif ( self.y < bottomLimit and bottomLimit < 0 ) then
            self.velocity = 0
            Runtime:removeEventListener("enterFrame", scrollView )
            self.tween = transition.to(self, { time=400, y=bottomLimit, transition=easing.outQuad})
            --transition.to(self.scrollBar,  { time=400, alpha=0 } )
        elseif ( self.y < bottomLimit ) then
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
            end

            if scrollBar.y > screenH - self.bottom  -5- scrollBar.height*.3   then
                scrollBar.y = screenH  - self.bottom  -5- scrollBar.height*.3
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

    local function onBtnRelease(event)
        for i =#listCharacter,1,-1 do
            table.remove(listCharacter[i],i)
            display.remove(listCharacter[i])
            listCharacter[i] = nil
        end
        listCharacter = nil
        display.remove(backButton)
        backButton = nil

        display.remove(SCROLL_LINE)
        SCROLL_LINE = nil

        display.remove(scrollBar)
        scrollBar = nil

        display.remove(txtbattle)
        txtbattle = nil


        for i = scrollView.numChildren,1,-1 do
            local child = scrollView[i]
            child.parent:remove( child )
            child = nil
        end
        display.remove(scrollView)
        scrollView = nil

        for i = Gscroll.numChildren,1,-1 do
            local child = Gscroll[i]
            child.parent:remove( child )
            child = nil
        end
        display.remove(Gscroll)
        Gscroll = nil

        for i = AllView.numChildren,1,-1 do
            local child = AllView[i]
            child.parent:remove( child )
            child = nil
        end
        display.remove(AllView)
        AllView = nil

        storyboard.gotoScene( "misstion","fade",100 )
        return true
    end

    local maxChapter = 10
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
                left = screenW*.1,
                width= screenW/10, height= screenH/21,
                onRelease = onBtnRelease	-- event listener function
            }
            backButton.id=i
            backButton.alpha = 0
            txtbattle = display.newText(i..":"..pointListY, screenW*.68, pointListY,native.systemFontBold, 20)
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
                left = screenW*.15,
                width= screenW/10, height= screenH/21,
                onRelease = onBtnRelease	-- event listener function
            }
            backButton.id=i
            txtbattle = display.newText(i..":"..pointListY, screenW*.68, pointListY,native.systemFontBold, 20)
            txtbattle:setTextColor(200, 200, 200)
            scrollView:insert(txtbattle)
        end

        scrollView:insert(listCharacter[i])
        scrollView:insert(backButton)
    end

    local function addScrollBar(r,g,b,a)

        if scrollView.scrollBar then scrollView.scrollBar:removescrollView() end

        local viewPortH =  scrollView.height - scrollView.bottom
        local scrollH = viewPortH*scrollView.height/(scrollView.height*2  - viewPortH)

        SCROLL_LINE = display.newImageRect( "img/background/frame/SCROLL_LINE.png", screenW*.3, screenH*.6)
        SCROLL_LINE:setReferencePoint( display.TopLeftReferencePoint )
        SCROLL_LINE.x =  screenW*.73
        SCROLL_LINE.y =  screenH*.29
        Gscroll:insert(SCROLL_LINE)

        scrollBar = display.newImageRect( "img/background/frame/SCROLLER.png", screenW*.18, screenH*.15)
        scrollBar:setReferencePoint( display.TopLeftReferencePoint )
        scrollBar.x = screenW*.8
        Gscroll:insert(scrollBar)
        local LH = SCROLL_LINE.height/scrollBar.height


        --		local yRatio = (screenH*.6)/(scrollView.height- (scrollView.bottom + scrollView.top))
        local yRatio = ((screenH*.6)-scrollBar.height*1.15)/(scrollView.height- (scrollView.bottom + scrollView.top))
        scrollView.yRatio =  yRatio
        scrollBar.y = scrollBar.height*1.15 + scrollView.top

        scrollView.scrollBar = scrollBar
        scrollView.SCROLL_LINE = SCROLL_LINE

    end
    if maxChapter >=5 then
        scrollView:addEventListener( "touch", scrollView )
        addScrollBar()
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
        Runtime:removeEventListener("addScrollBar", scrollView )
        scrollView:removeScrollBar()
        Gscroll:removeSelf()
    end

    AllView:insert(Gscroll)
    AllView:insert(scrollView)
    return AllView
end
