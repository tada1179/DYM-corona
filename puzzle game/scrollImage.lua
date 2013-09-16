-- have backup in file scrollImage2.lua date backup 26-6-13 08.41 AM.

module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
local http = require("socket.http")
local json = require("json")
local screenW, screenH = display.contentWidth, display.contentHeight

local prevTime = 0
local pointListY =0
function new(map_id,user_id)
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
    pointListY =  screenH *.07

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

        local option = {

            effect = "fade",
            time = 100,
            params =
            {
                chapter_id = event.target.id,
                map_id = map_id,
                user_id = user_id

            }
        }
        storyboard.gotoScene( "misstion",option )
        return true
    end

    local maxChapter = 10
    local dataTable = {}
    local function loadChapter()
        local URL = "http://localhost/dym/chapter_list.php?user_id="..user_id.."&map_id="..map_id
        local response = http.request(URL)
        if response == nil then
            print("No Dice")
        else
            dataTable = json.decode(response)
            maxChapter = dataTable.All

            local m = maxChapter
            while m > 0  do
                dataTable[m] = {}
                dataTable[m].chapter_id = dataTable.chapter[m].chapter_id
                dataTable[m].chapter_name = dataTable.chapter[m].chapter_name
                dataTable[m].ID_status = dataTable.chapter[m].ID_status
                m = m -1
            end
        end

    end
    loadChapter()

    local pointName = screenH*.15
    local pointNameX = screenW*.12
    local pointBonus = screenH*.11

    local frmsizsX = screenW*.7
    local frmsizsY = screenH*.1

    for i = 1,10 , 1 do
--    for i = maxChapter,1 , -1 do
        pointListY = pointListY + (screenH*.11)
            if true then
--            if dataTable[i].ID_status == "clear" then
                local imgFrmList = "img/background/misstion/CLEAR_LAYOUT.png"
                listCharacter[i] = display.newImageRect( imgFrmList,frmsizsX ,frmsizsY)
                listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
                listCharacter[i].x, listCharacter[i].y = pointNameX, pointListY
--                listCharacter[i].id = dataTable[i].chapter_id
                listCharacter[i].numTouches = 0

                local imgBnt = "img/background/misstion/CLEAR_LAYOUT.png"
                backButton = widget.newButton{
                    defaultFile= imgBnt,
                    overFile= imgBnt,
                    top = pointListY,
                    left = pointNameX,
                    width= frmsizsX, height= frmsizsY,
                    onRelease = onBtnRelease,	-- event listener function
                }
                backButton.id=i
--                txtbattle = display.newText(dataTable[i].chapter_name, screenW*.2, pointName+screenH*.06,native.systemFontBold, 25)
--                txtbattle:setTextColor(200, 200, 200)
--                scrollView:insert(txtbattle)
            else
                local imgFrmList = "img/background/misstion/NEW_LAYOUT.png"
                listCharacter[i] = display.newImageRect( imgFrmList, frmsizsX, frmsizsY)
                listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
                listCharacter[i].x, listCharacter[i].y = pointNameX, pointListY
                listCharacter[i].id = i

                local imgBnt = "img/background/misstion/NEW_LAYOUT.png"
                backButton = widget.newButton{
                    defaultFile= imgBnt,
                    overFile= imgBnt,
                    top = pointListY,
                    left = pointNameX,
                    width= frmsizsX, height= frmsizsY,
                    onRelease = onBtnRelease,	-- event listener function

                }
                backButton.id=  dataTable[i].chapter_id
                txtbattle = display.newText(dataTable[i].chapter_name, screenW*.2, pointName+screenH*.06,native.systemFontBold, 25)
                txtbattle:setTextColor(200, 200, 200)
                scrollView:insert(txtbattle)
            end
        pointName = pointName + (screenH*.11)
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
    local maxChapter = 10
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
