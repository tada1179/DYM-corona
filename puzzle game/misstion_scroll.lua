-- have backup in file scrollImage2.lua date backup 26-6-13 08.41 AM.

module(..., package.seeall)
local widget = require "widget"
local storyboard = require( "storyboard" )
storyboard.purgeOnSceneChange = true
local scene = storyboard.newScene()
-- set some global values for width and height of the screen
local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight


local prevTime = 0
local pointListY =0
function new(params)
    -- setup a group to be the scrolling screen
    local scrollView = display.newGroup()
    local Gscroll = display.newGroup()
    local AllView = display.newGroup()

    local user_id = params.user_id
    local chapter_id = params.chapter_id
    local map_id = params.map_id
    local maxChapter = 0
    local characterItem = {}

    local pointListX = screenW *.1
    pointListY =  screenH *.185

    scrollView.top = math.floor(screenH*.18) or 0
    scrollView.bottom =   math.floor(screenH*.27)

    local listCharacter = {}
    local backButton

    local imgFrmList
    local NameMission
    local txtbattle
    local txtstamina
    local SCROLL_LINE
    local scrollBar
    local imgBnt = "img/background/button/Button_BACK.png"
    -----------------------------------
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

            Runtime:addEventListener("enterFrame", trackVelocity)
            display.getCurrentStage():setFocus( self )
            self.isFocus = true
        elseif( self.isFocus ) then

            if( phase == "moved" ) then
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

        if math.abs(self.velocity) < .01 then
            self.velocity = 0
            Runtime:removeEventListener("enterFrame", scrollView )
        end

        self.velocity = self.velocity*friction
        self.y = math.floor(self.y + self.velocity*timePassed)

        local upperLimit = self.top
        local bottomLimit = screenH - self.height - self.bottom
        if ( self.y > upperLimit ) then
            self.velocity = 0
            Runtime:removeEventListener("enterFrame", scrollView )
            self.tween = transition.to(self, { time=400, y=upperLimit, transition=easing.outQuad})

        elseif ( self.y < bottomLimit and bottomLimit < 0 ) then
            self.velocity = 0
            Runtime:removeEventListener("enterFrame", scrollView )
            self.tween = transition.to(self, { time=400, y=bottomLimit, transition=easing.outQuad})

        elseif ( self.y < bottomLimit ) then
            self.velocity = 0
            Runtime:removeEventListener("enterFrame", scrollView )
            self.tween = transition.to(self, { time=400, y=upperLimit, transition=easing.outQuad})

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

        for i = #listCharacter,1,-1 do
            table.remove(listCharacter[i],i)
            listCharacter[i] = nil
        end
        listCharacter = nil

        display.remove(backButton)
        backButton = nil

        display.remove(imgFrmList)
        imgFrmList = nil

        display.remove(NameMission)
        NameMission = nil

        display.remove(txtbattle)
        txtbattle = nil

        display.remove(txtstamina)
        txtstamina = nil

        display.remove(SCROLL_LINE)
        SCROLL_LINE = nil

        display.remove(scrollBar)
        scrollBar = nil

        for i= scrollView.numChildren,1,-1 do
            local child = scrollView[i]
            child.parent:remove( child )
            child = nil
        end
        scrollView:removeSelf(scrollView)
        display.remove(scrollView)
        scrollView = nil

        for i= Gscroll.numChildren,1,-1 do
            local child = Gscroll[i]
            child.parent:remove( child )
            child = nil
        end
        Gscroll:removeSelf(Gscroll)
        display.remove(Gscroll)
        Gscroll = nil

        for i= AllView.numChildren,1,-1 do
            local child = AllView[i]
            child.parent:remove( child )
            child = nil
        end
        AllView:removeSelf(AllView)
        display.remove(AllView)
        AllView = nil

        local option = {

            effect = "fade",
            time = 100,
            params =
            {
                mission_id = event.target.id,
                chapter_id = chapter_id,
                map_id = map_id,
                user_id = user_id

            }
        }
           storyboard.gotoScene( "guest",option )

       return true
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
        local yRatio = ((screenH*.6)-scrollBar.height*1.15)/(scrollView.height- (scrollView.bottom + scrollView.top))
        scrollView.yRatio =  yRatio

        scrollBar.y = scrollBar.height*1.15 + scrollView.top

        scrollView.scrollBar = scrollBar
        scrollView.SCROLL_LINE = SCROLL_LINE

    end

    local function loatCharacter()
        local http = require("socket.http")
        local json = require("json")
        local Linkmission = "http://localhost/dym/mission_list.php"
        local numberHold_character =  Linkmission.."?user_id="..user_id.."&chapter_id="..chapter_id
        local numberHold = http.request(numberHold_character)
        local framele = require("alertMassage").loadFramElement()

        if numberHold == nil then
            print("No Dice")
        else
            local allRow  = json.decode(numberHold)
            maxChapter = tonumber(allRow.All)

            local k = maxChapter
            while k > 0  do
                characterItem[k] = {}
                characterItem[k].mission_id = allRow.mission[k].mission_id
                characterItem[k].mission_name = allRow.mission[k].mission_name
                characterItem[k].mission_img= allRow.mission[k].mission_img
                characterItem[k].mission_img_boss= allRow.mission[k].mission_img_boss
                characterItem[k].mission_boss_element= tonumber(allRow.mission[k].mission_boss_element)
                characterItem[k].mission_stamina= tonumber(allRow.mission[k].mission_stamina)
                characterItem[k].mission_run= tonumber(allRow.mission[k].mission_run)
                characterItem[k].mission_characterNum= tonumber(allRow.mission[k].mission_characterNum)
                characterItem[k].ID_clear = allRow.mission[k].ID_clear
                k = k - 1
            end
        end
    if maxChapter >=5 then
        scrollView:addEventListener( "touch", scrollView )
        addScrollBar()
    end
        local pointPic = screenH*.195
        local pointNameY = screenH*.2
        local pointbattleY = screenH*.24
        local typeFont = native.systemFontBold

        local frmsizsX = screenW*.7
        local frmsizsY = screenH*.1
        local pointNameX = screenW*.12

        local imgBoss
        local Fr_imgBoss
        for i = maxChapter, 1, -1 do

            if characterItem[i].ID_clear == "clear" then
                local imgFrmList = "img/background/misstion/CLEAR_LAYOUT.png"
                listCharacter[i] = display.newImageRect( imgFrmList, frmsizsX, frmsizsY)
                listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
                listCharacter[i].x, listCharacter[i].y = pointNameX, pointListY
                listCharacter[i].id = i

                imgBoss = display.newImageRect( characterItem[i].mission_img_boss, screenW*.12, screenH*.08)
                imgBoss:setReferencePoint( display.TopLeftReferencePoint )
                imgBoss.x, imgBoss.y = screenW*.68, pointPic
                scrollView:insert(imgBoss)

                backButton = widget.newButton{
                    defaultFile= framele[characterItem[i].mission_boss_element],
                    overFile= framele[characterItem[i].mission_boss_element],
                    top = pointListY,
                    left = pointNameX,
                    width=frmsizsX, height= frmsizsX,
                    onRelease = onBtnRelease	-- event listener function
                }
                backButton.id= characterItem[i].mission_id

                NameMission = display.newText(characterItem[i].mission_name, screenW*.18, pointNameY,typeFont, 23)
                NameMission:setTextColor(200, 200, 200)
                scrollView:insert(NameMission)

                txtbattle = display.newText("Battle : "..characterItem[i].mission_run, screenW*.43, pointbattleY,typeFont, 20)
                txtbattle:setTextColor(147, 112, 219)
                scrollView:insert(txtbattle)

                txtstamina = display.newText("stamina : "..characterItem[i].mission_stamina, screenW*.2, pointbattleY,typeFont, 20)
                txtstamina:setTextColor(173, 255, 47)
                scrollView:insert(txtstamina)

            else
                local imgFrmList = "img/background/misstion/NEW_LAYOUT.png"
                listCharacter[i] = display.newImageRect( imgFrmList, frmsizsX, frmsizsY)
                listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
                listCharacter[i].x, listCharacter[i].y = pointNameX, pointListY
                listCharacter[i].id = i
                listCharacter[i].numTouches = 0

                imgBoss = display.newImageRect( characterItem[i].mission_img_boss, screenW*.12, screenH*.08)
                imgBoss:setReferencePoint( display.TopLeftReferencePoint )
                imgBoss.x, imgBoss.y = screenW*.68, pointPic
                scrollView:insert(imgBoss)

                imgBoss = display.newImageRect(framele[characterItem[i].mission_boss_element], screenW*.12, screenH*.08)
                imgBoss:setReferencePoint( display.TopLeftReferencePoint )
                imgBoss.x, imgBoss.y = screenW*.68, pointPic
                scrollView:insert(imgBoss)

                backButton = widget.newButton{
                    defaultFile= imgFrmList,
                    overFile= imgFrmList,
                    top = pointListY,
                    left = pointNameX,
                    width=frmsizsX, height= frmsizsY,
                    onRelease = onBtnRelease	-- event listener function
                }
                backButton.id= characterItem[i].mission_id

                NameMission = display.newText(characterItem[i].mission_name, screenW*.18, pointNameY,typeFont, 23)
                NameMission:setTextColor(200, 200, 200)
                scrollView:insert(NameMission)

                txtbattle = display.newText("Battle : "..characterItem[i].mission_run, screenW*.45, pointbattleY,typeFont, 20)
                txtbattle:setTextColor(147, 112, 219)
                scrollView:insert(txtbattle)

                txtstamina = display.newText("stamina : "..characterItem[i].mission_stamina, screenW*.2, pointbattleY,typeFont, 20)
                txtstamina:setTextColor(173, 255, 47)
                scrollView:insert(txtstamina)
            end
            pointbattleY = pointbattleY + (screenH*.11)
            pointNameY = pointNameY + (screenH*.11)
            pointListY = pointListY + (screenH*.11)
            pointPic = pointPic + (screenH*.11)

            scrollView:insert(listCharacter[i])
            scrollView:insert(backButton)
        end
   end
        loatCharacter()

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
--    storyboard.removeAll ()
--    storyboard.purgeAll()

    AllView:insert(Gscroll)
    AllView:insert(scrollView)
    return AllView
end
