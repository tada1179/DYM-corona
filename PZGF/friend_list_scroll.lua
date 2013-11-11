-- have backup in file scrollImage2.lua date backup 26-6-13 08.41 AM.

module(..., package.seeall)
local widget = require "widget"
local alertMSN = require "alertMassage"
local menu_barLight = require "menu_barLight"
local screenW, screenH = display.contentWidth, display.contentHeight
local pointListY = nil
function new(params)
    -- setup a group to be the scrolling screen
    local scrollView = display.newGroup()
    local Gscroll = display.newGroup()
    local AllView = display.newGroup()

    local user_id = params.user_id
    local maxChapter = 0
    local characterItem = {}

    local pointListX = screenW *.1
    pointListY =  screenW*.1

    scrollView.top = math.floor(screenH*.18) or 0
    --    scrollView.bottom =   math.floor(screenH*.36)
    scrollView.bottom =   math.floor(screenH*.27)

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
        menu_barLight.SEtouchButton()
        local charac_scene = require("character_scene")
        charac_scene.characterFriend_remove(characterItem[event.target.id].charac_id,characterItem[event.target.id].friend_userid,user_id,characterItem[event.target.id].friend_id)
    end

   local function createImage()
        local pointNameY = screenH*.08
        local pointbattleY = screenH*.1

        local FontAndSize ={}
        FontAndSize = menu_barLight.TypeFontAndSizeText()
        local typeFont = FontAndSize.typeFont
        local sizetext = FontAndSize.fontGuest
        local sizetextName = FontAndSize.fontSize
        local fontsizeHead = FontAndSize.fontSizeHead

        local sizecharacH =  screenH*.1
        local sizecharacW =  screenW*.137

        local pointFrameX = screenW*.1
        local pointFrameY = (screenH*.05)

        local pointLVX = screenW*.14
        local pointLVY = (screenH*.15)

        local pointNameX = screenW*.28
        local pointNameY = screenH*.07

        local pointDateX = screenW*.5
        local pointDateY = screenH*.1

        local img_framelist = "img/characterIcon/framelist.png"
        local frame = alertMSN.loadFramElement()

        local rowscharac = maxChapter+1
        for i = 1, rowscharac, 1 do
            pointListY = pointListY + (screenH*.001)
            pointbattleY = pointbattleY + (screenH*.11)
            pointNameY = pointNameY + (screenH*.11)
            pointListY = pointListY + (screenH*.11)
            pointLVY =  pointLVY + (screenH*.11)
            pointDateY = pointDateY + (screenH*.11)
            local listCharacter = {}
            if i == rowscharac then
                local imgFrmList = "img/background/sellBattle_Item/frame.png"
                listCharacter[i] = display.newImageRect( img_framelist, screenW*.75, screenH*.1)
                listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
                listCharacter[i].x, listCharacter[i].y = pointFrameX, pointListY
                listCharacter[i].id = i
                listCharacter[i].alpha = 0
                scrollView:insert(listCharacter[i])
                local NameMission = display.newText("name", screenW*.18, pointNameY,typeFont, sizetext)
                NameMission:setTextColor(255, 0, 255)
                NameMission.alpha = 0
                scrollView:insert(NameMission)

                local txtbattle = display.newText("Battle ", screenW*.68, pointbattleY,typeFont, sizetext)
                txtbattle:setTextColor(200, 200, 200)
                txtbattle.alpha = 0
                scrollView:insert(txtbattle)

                local txtstamina = display.newText("stamina ", screenW*.68, pointNameY,typeFont, sizetext)
                txtstamina:setTextColor(0, 0, 255)
                txtstamina.alpha = 0
                scrollView:insert(txtstamina)

            else
                listCharacter[i] = display.newImageRect( img_framelist, screenW*.75, screenH*.1)
                listCharacter[i]:setReferencePoint( display.TopLeftReferencePoint )
                listCharacter[i].x, listCharacter[i].y = pointFrameX, pointListY
                listCharacter[i].id = i
                scrollView:insert(listCharacter[i])
                local Character = display.newImageRect( characterItem[i].charac_img, sizecharacW, sizecharacH)
                Character:setReferencePoint( display.TopLeftReferencePoint )
                Character.x, Character.y = pointFrameX, pointListY
                Character.id = i
                scrollView:insert(Character)

                local FrmCharacter = widget.newButton{
                    defaultFile= frame[characterItem[i].element],
                    overFile= frame[characterItem[i].element],
                    top = pointListY,
                    left = pointFrameX,
                    width= sizecharacW, height= sizecharacH,
                    onRelease = onBtnRelease	-- event listener function
                }
                FrmCharacter.id=i
                scrollView:insert(FrmCharacter)

                local showLV = display.newText("Lv."..characterItem[i].level, pointLVX, pointLVY,typeFont, sizetext)
                showLV:setTextColor(255, 0, 255)
                scrollView:insert(showLV)

                local showName = display.newText(characterItem[i].friend_name, pointNameX, pointNameY,typeFont, sizetext)
                showName:setTextColor(255, 255, 255)
                scrollView:insert(showName)

                local showDate = display.newText(characterItem[i].dateModify, pointDateX, pointDateY,typeFont, sizetext)
                showDate:setTextColor(0, 0, 255)
                scrollView:insert(showDate)
            end


        end
    end
    function loatCharacter()
        local http = require("socket.http")
        local json = require("json")
        local LinkFriend = "http://133.242.169.252/DYM/friend_list.php"
        local numberHold_character =  LinkFriend.."?user_id="..user_id
        local numberHold = http.request(numberHold_character)

        if numberHold == nil then
            print("No Dice")
        else
            local allRow  = json.decode(numberHold)
            maxChapter = allRow.All

            local k = 1
            while(k <= maxChapter) do
                characterItem[k] = {}
                characterItem[k].charac_id= allRow.chracter[k].charac_id
                characterItem[k].friend_userid= allRow.chracter[k].friend_userid
                characterItem[k].friend_id= allRow.chracter[k].friend_id
                characterItem[k].friend_name = allRow.chracter[k].friend_name
                characterItem[k].charac_img = allRow.chracter[k].friend_img_mini
                characterItem[k].dateModify = allRow.chracter[k].friend_modify
                characterItem[k].element = tonumber(allRow.chracter[k].friend_element)
                characterItem[k].level = tonumber(allRow.chracter[k].friend_lv)
                k = k + 1
            end
        end

        createImage()
    end
    local function addScrollBar()

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
