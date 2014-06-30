module(..., package.seeall)
local widget = require( "widget" )
local sqlite3 = require( "sqlite3" )
local util = require( "util" )
local facebook = require( "facebook" )
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local screenW = display.contentWidth
local screenH = display.contentHeight
local PinData
local Rowdata = 0
---------------------------------------
local function touchScreen(event)
    print("touchScreen")
    if ( "began" == event.phase ) then

    end
    return true
end

function DAILYMODE()
    local detailColor = {}
    local scrollView

    local aechiement = {}

    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )
    local row = 0
    local rowaechiement = 0

    for Allrowaechiement in db:nrows ("SELECT * FROM aechiement ;") do
        rowaechiement = rowaechiement + 1
        aechiement[rowaechiement] = {}
        aechiement[rowaechiement].aechiement_id = Allrowaechiement.aechiement_id
        aechiement[rowaechiement].aechiement_name = Allrowaechiement.aechiement_name
        aechiement[rowaechiement].aechiement_score = Allrowaechiement.score
        aechiement[rowaechiement].aechiement_scoreMax = Allrowaechiement.scoreMax
        aechiement[rowaechiement].aechiement_element = Allrowaechiement.aechiement_element

        print("rowaechiement =",rowaechiement,"aechiement[row].aechiement_name =",aechiement[rowaechiement].aechiement_name)
    end

    local function scrollListener( event )
        print("1234 ******* id = ",event.target.id)
        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
        elseif event.phase == "moved" then

            local dy = math.abs( event.y - event.yStart )
            if  dy > 5 then
                scrollView:takeFocus( event )
            end

        elseif  event.phase == "ended" then
            ArehiementAlertMode()
        end

        return true
    end
    local tapdisplay = display.newGroup()
    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                mode = page
            }
        }
        local function gotoPage()
            --storyboard.gotoScene("map",options)
            require("top_name").setEnabledTouch(1)
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        return true
    end

    local img = {"img/small_frame/btt_yes.png","img/small_frame/btt_no.png"}
    local scrY = screenH*.5
    local scrX = screenW*.3

    local NameMission = "Mission name is .."
    local massageDaily = "2000/1000"
    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
        local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.8
        myRectangle:setFillColor(0, 0, 0)
        tapdisplay:insert(myRectangle)


        local img_scorebar = "img/large_frame/frm_l_achieve.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = 0
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        BGMenuMode:addEventListener( "touch", BGMenuMode )
        tapdisplay:insert(BGMenuMode)

        local textmission = display.newText(NameMission,screenW*.5,screenH*.12,"CooperBlackMS",30)
        textmission.anchorX = 0.5
        textmission.anchorY = 1
        tapdisplay:insert(textmission)

        local textmission = display.newText(massageDaily,screenW*.5,screenH*.17,"CooperBlackMS",30)
        textmission.anchorX = 0.5
        textmission.anchorY = 1
        tapdisplay:insert(textmission)

        local pointY = 0
        local BTImg = {}
        local pointTextY = screenH*.05

        scrollView = widget.newScrollView
            {
                top = screenH*.22,
                left = screenW*.5,
                width = screenW*.7,
                height = screenH*.45,
                scrollWidth = 600,
                scrollHeight = 800,
                scrollBarOptions = {
                    sheet = "img/large_frame/ast_scroll.png",  --reference to the image sheet
                    topFrame = 1,            --number of the "top" frame
                    middleFrame = 1,         --number of the "middle" frame
                    bottomFrame = 1          --number of the "bottom" frame
                }  ,
                backgroundColor = { 0.8, 0.8, 0.8 },
            }
        scrollView.anchorX = 1
        scrollView.anchorY = 0.5

        for i = 1,rowaechiement,1 do
             BTImg[i] ={}
             BTImg[i] = widget.newButton
                {
                    left = -screenW*.1,
                    top = pointY,
                    defaultFile = "img/large_frame/frm_award.png",
                    overFile = "img/large_frame/frm_award.png",
                    onEvent = scrollListener
                }
             BTImg[i].id = i
             BTImg[i].anchorX = 0
             scrollView:insert(BTImg[i])

            local textmission = display.newText(aechiement[i].aechiement_name,screenW*.25,pointTextY,"CooperBlackMS",25)
            textmission:setFillColor(1, 0, 0)
            textmission.anchorX = 0
            textmission.anchorY = 1
            scrollView:insert(textmission)

            local textdetail = display.newText(aechiement[i].aechiement_scoreMax.." /::"..aechiement[i].aechiement_score,screenW*.25,pointTextY+screenH*.03,"CooperBlackMS",25)
            textdetail:setFillColor(1, 1, 0)
            textdetail.anchorX = 0
            textdetail.anchorY = 1
            scrollView:insert(textdetail)

            pointTextY = pointTextY + screenH*.15
            pointY = pointY + screenH*.15
        end

        local button1 = widget.newButton
            {
                left = screenW*.92,
                top = -screenH*.09,
                defaultFile = "img/universal/btt_cancel.png",
                overFile = "img/universal/btt_cancel.png",
                onEvent = menuMode
            }
        button1.font = native.newFont("CooperBlackMS",50)
        button1.anchorX = 1
        tapdisplay:insert(button1)

        tapdisplay:insert(scrollView)
        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

function ArehiementAlertMode()
    print("ArehiementAlertMode")
    local detailColor = {}


    local tapdisplay = display.newGroup()
    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                mode = page
            }
        }
        local function gotoPage()
            storyboard.gotoScene("mainMenu",options)
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        return true
    end

    local img = {"img/middle_frame/btt_next02.png"}
    local scrY = screenH*.45
    local scrX = screenW*.5

    local color = 0
    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
        local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.8
        myRectangle:setFillColor(0, 0, 0)
        tapdisplay:insert(myRectangle)

        local img_txt_youwin = "img/middle_frame/txt_youwin.png"
        local txt_youwin = display.newImage(img_txt_youwin)
        txt_youwin.x = screenW*.5
        txt_youwin.y = screenH*.05
        txt_youwin.anchorX = 0.5
        txt_youwin.anchorY = 1

        local img_scorebar = "img/middle_frame/frm_m_end.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = 0
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        BGMenuMode:addEventListener( "touch", BGMenuMode )
        tapdisplay:insert(BGMenuMode)
        tapdisplay:insert(txt_youwin)

        local BTset = {}
        for i=1,#img,1 do
            color = color +1
            BTset[i] = {}
            detailColor[i] = {}

            BTset[i] = widget.newButton
                {
                    left = scrX,
                    top = scrY,
                    id = color,
                    defaultFile = img[i],
                    overFile = img[i],
                    onEvent = menuMode
                }
            BTset[i].anchorX = 1
            tapdisplay:insert(BTset[i])

            scrX = scrX + (screenW*.4)
        end

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

function ProfilePin(option)
    local color = option.color
    local pin_id = option.pin_id
    local pin_idold = option.pin_idold
    local team_no = option.team_no


    local detailColor = {}

    local tapdisplay = display.newGroup()
    local touch = 0
    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options

        local function gotoPage()
           storyboard.gotoScene("pageWith",options)
           storyboard.gotoScene("team_main",options)
        end
        if page == "close" and touch == 1 then

            if color == 0 then
               options =
                {
                    pin_id = pin_id,
                }
            else
                options =
                {
                    team_no = team_no,
                    pin_id = pin_idold,
                    color = color,
                }

                PinSetting(options)
            end

        else
            options =
            {
                team_no = team_no,
                pin_id = pin_id,
                color = color,
            }

            local path = system.pathForFile("datas.db", system.DocumentsDirectory)
            db = sqlite3.open( path )

            local updateplayMission ="update team set pin_id='"..page.."' where team_no = '"..team_no.."' and team_element = '"..color.."';"
            db:exec(updateplayMission)
            db:close()
            timer.performWithDelay ( 100,gotoPage)
        end

        return true

    end
    local function menuMode(event)
        if event.phase == "ended"  then
            touch = 1
            local page = event.target.id
            transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        end
        return true
    end

    local IMGcolorBT = {
        "img/ally_frame/asst_ally_f.png",
        "img/ally_frame/asst_ally_wd.png",
        "img/ally_frame/asst_ally_wt.png",
        "img/ally_frame/asst_ally_d.png",
        "img/ally_frame/asst_ally_c.png",
        "img/ally_frame/asst_ally_b.png",
    }
    local imgRowdata = "img/small_frame/btt_yes.png"
    local scrY = screenH*.45
    local scrX = screenW*.5

    local countcolor = 0
    Rowdata = 0
    PinData = {}

    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )

    for AllPindata in db:nrows ("SELECT * FROM pin WHERE pin_id = '"..pin_id.."';") do
        Rowdata = Rowdata + 1
        PinData[Rowdata] = {}
        PinData[Rowdata].pin_id = tonumber(AllPindata.pin_id)
        PinData[Rowdata].pin_element = tonumber(AllPindata.pin_element)
        PinData[Rowdata].pin_imgmini = AllPindata.pin_imgmini
        PinData[Rowdata].pin_imgbig = AllPindata.pin_imgbig
        PinData[Rowdata].pin_name = AllPindata.pin_name
        PinData[Rowdata].pin_no = AllPindata.pin_no
        PinData[Rowdata].pin_exp = AllPindata.pin_exp
    end

    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
        local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.8
        myRectangle:setFillColor(0, 0, 0)
        tapdisplay:insert(myRectangle)

        local img_scorebar = "img/ally_frame/frm_allyinfo.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = 0
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        tapdisplay:insert(BGMenuMode)

        local BGIMG = display.newImage(PinData[Rowdata].pin_imgbig)
        BGIMG.x = screenW*.5
        BGIMG.y = screenH*.08
        BGIMG.anchorX = 0.5
        BGIMG.anchorY = 0
        tapdisplay:insert(BGIMG)

        local IMGcolor = display.newImage(IMGcolorBT[PinData[Rowdata].pin_element])
        IMGcolor.x = screenW*.178
        IMGcolor.y = screenH*.36
        IMGcolor.anchorX = 0.5
        IMGcolor.anchorY = 0
        tapdisplay:insert(IMGcolor)

        local txtName = display.newText(PinData[Rowdata].pin_name,screenW*.48,screenH*.395,"CooperBlackMS",25)
        txtName:setFillColor(1, 1, 1)
        txtName.anchorX = 0
        txtName.anchorY = 1
        tapdisplay:insert(txtName)

        local txtNo = display.newText(PinData[Rowdata].pin_no,screenW*.3,screenH*.395,"CooperBlackMS",25)
        txtNo:setFillColor(1, 1, 1)
        txtNo.anchorX = 0
        txtNo.anchorY = 1
        tapdisplay:insert(txtNo)

        local txtDeteil = display.newText("aaaaaaaaaaaaaaa",screenW*.15,screenH*.43,"CooperBlackMS",25)
        txtDeteil:setFillColor(1, 1, 1)
        txtDeteil.anchorX = 0
        txtDeteil.anchorY = 1
        tapdisplay:insert(txtDeteil)


        local button1 = widget.newButton
            {
                left = screenW*.9,
                top = -screenH*.07,
                defaultFile = "img/universal/btt_cancel.png",
                overFile = "img/universal/btt_cancel.png",
                onEvent = menuMode
            }
        button1.font = native.newFont("CooperBlackMS",50)
        button1.id = "close"
        button1.anchorX = 1
        tapdisplay:insert(button1)

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

function PinSetting(object)
    print("1111010100")
    local nameColor = {
        "img/clear_frame/txt_firepin.png",
        "img/clear_frame/txt_woodpin.png",
        "img/clear_frame/txt_waterpin.png",
        "img/clear_frame/txt_darkpin.png",
        "img/clear_frame/txt_boltpin.png",
        "img/clear_frame/txt_curepin.png",
    }
    local team_no = object.team_no
    local color = object.color
    local pin_id = tonumber(object.pin_id)

    local detailColor = {}
    local background = {}
    local scrollView
    local tapdisplay = display.newGroup()

    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil
        local options
        if page == "close"  then
            options =
            {
                params = {
                    team_no = team_no,
                    pin_id = pin_id,
                    color = color,
                }
            }
        else
            options =
            {
                params = {
                    team_no = team_no,
                    pin_id = page,
                    color = color,
                }
            }
            local path = system.pathForFile("datas.db", system.DocumentsDirectory)
            db = sqlite3.open( path )

            local updateplayMission ="update team set pin_id='"..page.."' where team_no = '"..team_no.."' and team_element = '"..color.."';"
            db:exec(updateplayMission)
            db:close()
        end

        local function gotoPage()
            storyboard.gotoScene("pageWith",options)
            storyboard.gotoScene("team_main",options)
        end



        timer.performWithDelay ( 100,gotoPage)
    end
    local function scrollListener( event )

        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
        elseif event.phase == "moved" then

            local dy = math.abs( event.y - event.yStart )
            if  dy > 5 then
                scrollView:takeFocus( event )
            end

        elseif  event.phase == "ended" then
            local options =
            {
                team_no = team_no,
                color = color,
                pin_idold =  pin_id,
                pin_id =  event.target.id,
            }
            transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()
                display.remove(tapdisplay)
                tapdisplay = nil end})

            ProfilePin(options)
        end

        return true
    end

    local function menuMode(event)
        local page = event.target.id

        if event.phase == "ended"  then


            transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        end

        return true
    end

    local img = {"img/small_frame/btt_yes.png","img/small_frame/btt_no.png"}
    local scrY = screenH*.5
    local scrX = screenW*.3

    local NameMission = "Mission name is .."
    local massageDaily = "2000/1000"
    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
        local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.9
        myRectangle:setFillColor(0, 0, 0)
        tapdisplay:insert(myRectangle)


        local img_scorebar = "img/clear_frame/frm_c_customize.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = 0
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        tapdisplay:insert(BGMenuMode)

        local textmission = display.newImage(nameColor[color])
        textmission.x = screenW*.5
        textmission.y = -screenH*.04
        textmission.anchorX = 0.5
        textmission.anchorY = 0.5
        tapdisplay:insert(textmission)

        local pointY = 0
        local BTImg = {}
        local pointTextY = screenH*.07

        scrollView = widget.newScrollView
            {
                top = screenH*.04,
                left = screenW*.5,
                width = screenW*.9,
                height = screenH*.68,
                scrollWidth = 600,
                scrollHeight = 800,
                scrollBarOptions = {
                    sheet = "img/large_frame/ast_scroll.png",  --reference to the image sheet
                    topFrame = 1,            --number of the "top" frame
                    middleFrame = 1,         --number of the "middle" frame
                    bottomFrame = 1          --number of the "bottom" frame
                }  ,
                hideBackground = true,
            }
        scrollView.anchorX = 1
        scrollView.anchorY = 0.5

        Rowdata = 0
        local Rowda2222ta = 0
        PinData = {}

        local path = system.pathForFile("datas.db", system.DocumentsDirectory)
        db = sqlite3.open( path )

        for AllPindata in db:nrows ("SELECT * FROM pin WHERE pin_element = '"..color.."' and pin_status = 1;") do
            Rowdata = Rowdata + 1
            PinData[Rowdata] = {}
            PinData[Rowdata].pin_id = tonumber(AllPindata.pin_id)
            PinData[Rowdata].pin_imgmini = AllPindata.pin_imgmini
            PinData[Rowdata].pin_imgbig = AllPindata.pin_imgbig
            PinData[Rowdata].pin_name = AllPindata.pin_name
            PinData[Rowdata].pin_no = AllPindata.pin_no
            PinData[Rowdata].pin_expmax = tonumber(AllPindata.pin_expmax)
            PinData[Rowdata].pin_exp = tonumber(AllPindata.pin_exp)
            if PinData[Rowdata].pin_expmax == PinData[Rowdata].pin_exp then
                PinData[Rowdata].pin_exp = "MAX"
            end

        end


        for i = 1,Rowdata,1 do
            BTImg[i] ={}
            background[i] ={}
            BTImg[i] = widget.newButton
                {
                    left = -screenW*.38,
                    top = pointY,
                    defaultFile = "img/clear_frame/frm_longtag.png",
                    overFile = "img/clear_frame/frm_longtag.png",
                    onEvent = scrollListener
--                    onEvent = menuMode
                }
            BTImg[i].id = PinData[i].pin_id
            BTImg[i].anchorX = 0
            BTImg[i]:setEnabled(true)
            scrollView:insert(BTImg[i])


            local backIMG = display.newImage( PinData[i].pin_imgmini )
            backIMG.x = screenW*.16
            backIMG.y = pointY +screenH*.08
            backIMG.anchorX = 0.5
            backIMG.anchorY = 0.5
            scrollView:insert( backIMG )

            background[i] = display.newImage( "img/clear_frame/btt_set.png" )
            background[i].x = screenW*.75
            background[i].y = pointY + screenH*.085
            background[i].id = PinData[i].pin_id
            background[i].anchorY = 0
            background[i]:addEventListener( "touch", menuMode )
            scrollView:insert( background[i] )

            local textmission = display.newText("No."..PinData[i].pin_no.."  "..PinData[i].pin_name,screenW*.25,pointTextY,"CooperBlackMS",35)
            textmission:setFillColor(1, 0, 0)
            textmission.anchorX = 0
            textmission.anchorY = 1
            scrollView:insert(textmission)

            local textdetail = display.newText("Exp: "..PinData[i].pin_exp,screenW*.25,pointTextY+screenH*.05,"CooperBlackMS",25)
            textdetail:setFillColor(1, 1, 0)
            textdetail.anchorX = 0
            textdetail.anchorY = 1
            scrollView:insert(textdetail)

            if PinData[i].pin_id == pin_id then
                backIMG.alpha = 0.3
                BTImg[i].alpha = 0.3
                background[i].alpha = 0.3
                background[i]:setFillColor(1, 1, 1)
                BTImg[i]:setFillColor(1, 1, 1)
                BTImg[i]:setEnabled(false)
            end

            pointTextY = pointTextY + screenH*.18
            pointY = pointY + screenH*.18
        end

        local button1 = widget.newButton
            {
                left = screenW*.87,
                top = -screenH*.07,
                defaultFile = "img/universal/btt_cancel.png",
                overFile = "img/universal/btt_cancel.png",
                onEvent = menuMode
            }
        button1.font = native.newFont("CooperBlackMS",50)
        button1.id = "close"
        button1.anchorX = 1
        tapdisplay:insert(button1)

        tapdisplay:insert(scrollView)
        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

function ShopMode()
    local detailColor = {}
    local scrollView

    local function scrollListener( event )
        if event.phase == "begen" then
            event.markX = event.x
            event.markY = event.y
        elseif event.phase == "moved" then

            local dy = math.abs( event.y - event.yStart )
            if  dy > 5 then
                scrollView:takeFocus( event )
            end

        elseif  event.phase == "ended" then
            ProfilePin()
        end

        return true
    end
    local tapdisplay = display.newGroup()
    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                mode = page
            }
        }
        local function gotoPage()
            --storyboard.gotoScene("map",options)
--            require("top_name").setEnabledTouch(1)
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        return true
    end

    local img = {"img/small_frame/btt_yes.png","img/small_frame/btt_no.png"}
    local scrY = screenH*.5
    local scrX = screenW*.3

    local NameMission = "Mission name is .."
    local massageDaily = "2000/1000"
    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
        local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.5
        myRectangle:addEventListener( "touch", touchScreen )
        myRectangle:setFillColor(0, 0, 0)
        tapdisplay:insert(myRectangle)


        local img_scorebar = "img/clear_frame/frm_c_customize.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = 0
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        BGMenuMode:addEventListener( "touch", BGMenuMode )
        tapdisplay:insert(BGMenuMode)

        local img_Title = "img/clear_frame/txt_shop.png"
        local textTitle = display.newImage(img_Title)
        textTitle.x = screenW*.5
        textTitle.y = -screenH*.04
        textTitle.anchorX = 0.5
        textTitle.anchorY = 0.5
        tapdisplay:insert(textTitle)

        local pointY = 0
        local BTImg = {}
        local pointTextY = screenH*.05

        scrollView = widget.newScrollView
            {
                top = screenH*.04,
                left = screenW*.48,
                width = screenW*.92,
                height = screenH*.68,
                scrollBarOptions = {
                    sheet = "img/large_frame/ast_scroll.png",  --reference to the image sheet
                    topFrame = 12,            --number of the "top" frame
                    middleFrame = 12,         --number of the "middle" frame
                    bottomFrame = 12          --number of the "bottom" frame
                }  ,
                hideScrollBar = false,
                hideBackground = true,
                horizontalScrollDisabled = true,
            }
        scrollView.anchorX = 1
        scrollView.anchorY = 0.5

        for i = 1,8,1 do
            BTImg[i] ={}
            BTImg[i] = widget.newButton
                {
                    left = -screenW*.38,
                    top = pointY,
                    defaultFile = "img/clear_frame/frm_longtag.png",
                    overFile = "img/clear_frame/frm_longtag.png",
                    onEvent = scrollListener
                }
            BTImg[i].id = i
            BTImg[i].anchorX = 0
            scrollView:insert(BTImg[i])

            local background = display.newImage( "img/clear_frame/btt_set.png" )
            background.x = screenW*.75
            background.y = pointY + screenH*.085
            background.anchorY = 0
            scrollView:insert( background )

            local textmission = display.newText("AAAABB xxx weee",screenW*.25,pointTextY,"CooperBlackMS",25)
            textmission:setFillColor(1, 0, 0)
            textmission.anchorX = 0
            textmission.anchorY = 1
            scrollView:insert(textmission)

            local textdetail = display.newText("xxx weee",screenW*.25,pointTextY+screenH*.03,"CooperBlackMS",25)
            textdetail:setFillColor(1, 1, 0)
            textdetail.anchorX = 0
            textdetail.anchorY = 1
            scrollView:insert(textdetail)

            pointTextY = pointTextY + screenH*.18
            pointY = pointY + screenH*.18
        end

        local img_tabImg = "img/large_frame/frm_scroll.png"
--        local tabImg = display.newImage(img_tabImg)
        local tabImg = display.newImageRect(img_tabImg,10,650)
        tabImg.x = screenW*.932
        tabImg.y = screenH*.375
        tabImg.anchorX = 0.5
        tabImg.anchorY = 0.5
        tapdisplay:insert(tabImg)

        local button1 = widget.newButton
            {
                left = screenW*.87,
                top = -screenH*.07,
                defaultFile = "img/universal/btt_cancel.png",
                overFile = "img/universal/btt_cancel.png",
                onEvent = menuMode
            }
        button1.anchorX = 1
        tapdisplay:insert(button1)

        tapdisplay:insert(scrollView)
        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

function SELECTMODE(object,option)
    object = object +1
    if object == 2 then

    else
        local button1 = {}
        local detailColor = {}

        local tapdisplay = display.newGroup()
        local function handleButtonEvent( page )
            display.remove(tapdisplay)
            tapdisplay = nil

            local options =
            {
                effect = "zoomInOutFade",
                time = 100,
                params = {
                    mode = page
                }
            }
            local function gotoPage()
                if page == 1 then
                    require("menu").HietcreateScene()
                    storyboard.gotoScene("mainmap",options)

                elseif page == 2 then

                    classicMODE()

                elseif page == 3 then
                  --  require("menu").menu_setEnabledTouch(1)
                    --                storyboard.gotoScene("mission",options)

                elseif option == "close" then

                else


                end
                return true
            end
            timer.performWithDelay ( 100,gotoPage)
        end
        local function menuMode(event)
            local page = event.target.id
            if event.phase == "ended" then
                transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
            end
            return true
        end

        local img = {
            "img/main_menu/btt_strymode.png" ,
            "img/main_menu/btt_clssmode.png" ,
            "img/main_menu/btt_comingsoon.png" ,
        }
        local scrY = screenH*.12
        local scrX = screenW*.5

        local color = 0
        timer.performWithDelay ( 300,function()
--
            local BGMode = display.newRoundedRect(0,screenH*.25,screenW,screenH,0)
            BGMode.anchorX = 0
            BGMode.alpha = 0.5
            BGMode:setFillColor(0, 0, 0)
            BGMode:addEventListener( "touch", touchScreen )
            tapdisplay:insert(BGMode)

            local BGMenuMode = display.newImage("img/main_menu/frm_l_menu.png")
            BGMenuMode.x = screenW*.5
            BGMenuMode.y = screenH*.3
            BGMenuMode.anchorX = 0.5
            BGMenuMode.anchorY = 0.5
            BGMenuMode:addEventListener( "touch", BGMenuMode )
            tapdisplay:insert(BGMenuMode)

            local imgtext = "img/main_menu/txt_pzzlmode.png"
            local text = display.newImage(imgtext)
            text.x = screenW*.5
            text.anchorX = 0.5
            text.anchorY = 0.2
            tapdisplay:insert(text)
            for i=1,#img,1 do
                color = color +1
                button1[i] = {}
                detailColor[i] = {}

                button1[i] = widget.newButton
                    {
                        left = scrX,
                        top = scrY,
                        id = color,
                        defaultFile = img[color],
                        overFile = img[color],
                        onEvent = menuMode
                    }
                button1[i].anchorX = 1
                tapdisplay:insert(button1[i])

                scrY = scrY + (screenH*.15)
            end

            button1 = widget.newButton
                {
                    left = screenW*.92,
                    top = -screenH*.09,
                    defaultFile = "img/universal/btt_cancel.png",
                    overFile = "img/universal/btt_cancel.png",
                    onEvent = menuMode
                }
            button1.font = native.newFont("CooperBlackMS",50)
            button1.anchorX = 1
            tapdisplay:insert(button1)

            transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
        end )

        return true
    end


end

function setupMenu()

        local button1 = {}
        local detailColor = {}
        local touchCount = 1
        local tapdisplay = display.newGroup()
        local function handleButtonEvent( page )
            display.remove(tapdisplay)
            tapdisplay = nil

            local options =
            {
                effect = "zoomInOutFade",
                time = 100,
                params = {
                    mode = page
                }
            }
            local function gotoPage()
                touchCount = 1
                if page == 1 then
                    require("menu").HietcreateScene()
                    storyboard.gotoScene("classic",options)

                else
                    require("menu").menu_setEnabledTouch(1)

                end
            end
            timer.performWithDelay ( 100,gotoPage)
        end

        local function menuMode(event)

            local page = event.target.id
            if event.phase == "ended" and touchCount == 2 then
                transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
            end
            return true
        end

        local img = "img/iconbox.png"
        local scrY = screenH*.13
        local scrX = screenW*.5

        local color = 0
        local txtLabel = {
            "CLASSIC",
            "TIME ATTACK",
            "MISSION TASK",
        }
        timer.performWithDelay ( 300,function()
            local BGMenuMode = display.newImage("img/main_menu/frm_l_menu.png")
            BGMenuMode.x = screenW*.5
            BGMenuMode.y = screenH*.3
            BGMenuMode.anchorX = 0.5
            BGMenuMode.anchorY = 0.5
            BGMenuMode.touch = touchScreen
            BGMenuMode:addEventListener( "touch", BGMenuMode )
            tapdisplay:insert(BGMenuMode)
            local text = display.newText("MENU",screenW*.5,screenH*.08,"CooperBlackMS",45)
            text.anchorX = 0.5
            text.anchorY = 1
            tapdisplay:insert(text)
            for i=1,#txtLabel,1 do
                color = color +1
                button1[i] = {}
                detailColor[i] = {}

                button1[i] = widget.newButton
                    {
                        left = scrX,
                        top = scrY,
                        width = screenW*.4,
                        height = screenH*.08,
                        id = color,
                        defaultFile = img,
                        overFile = img,
                        font = "CooperBlackMS",
                        fontSize = 25,
                        label = txtLabel[color],
                        labelColor = {
                            default={ 1, 1, 1 },
                            over={ 0, 0, 0, 0.5 }
                        },
                        onEvent = menuMode
                    }
                button1[i].anchorX = 1
                tapdisplay:insert(button1[i])

                scrY = scrY + (screenH*.11)
            end

            button1 = widget.newButton
                {
                    left = screenW*.89,
                    top = -screenH*.05,
                    defaultFile = "img/as_butt_sell_minus.png",
                    overFile = "img/as_butt_sell_minus.png",
                    width = screenW*.1,
                    height = screenH*.08,
                    id = "colse",
                    fontSize = 60,
                    font = "CooperBlackMS",
                    labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
                    onEvent = menuMode
                }
            button1.font = native.newFont("CooperBlackMS",50)
            button1.anchorX = 1
            tapdisplay:insert(button1)

            transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
        end )

        return true

end

--mission mode
function Youwin(team_no,score1,score2,mission_name,countColor,mission_exp,map_id)

    local button1 = {}
    local detailColor = {}
    local team_no = team_no
    local scoreMission = {mission_name,score1,score2}

    local tapdisplay = display.newGroup()
    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                team_no = team_no ,
                map_id = map_id ,
                countColor = countColor ,
                mission_exp = mission_exp
            }
        }
        local function gotoPage()
            storyboard.gotoScene("youwin",options)
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        return true
    end

    local img = "img/middle_frame/btt_next02.png"
    local scrY = screenH*.45
    local scrX = screenW*.5

    local color = 0
    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
        local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.8
        myRectangle:setFillColor(0, 0, 0)
        tapdisplay:insert(myRectangle)

        local img_txt_youwin = "img/middle_frame/txt_youwin.png"
        local txt_youwin = display.newImage(img_txt_youwin)
        txt_youwin.x = screenW*.5
        txt_youwin.y = screenH*.05
        txt_youwin.anchorX = 0.5
        txt_youwin.anchorY = 1

        local img_scorebar = "img/middle_frame/frm_m_end.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = 0
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        BGMenuMode:addEventListener( "touch", BGMenuMode )
        tapdisplay:insert(BGMenuMode)
        tapdisplay:insert(txt_youwin)


        local img_txt_hiscore = {"","img/middle_frame/txt_hiscore.png","img/middle_frame/txt_urscore.png"}
        local img_textbar = "img/middle_frame/ast_scorebar.png"
        local pointBar = screenH*.14
        local pointhiscore = screenH*.25
        local pointTextScore = screenH*.17

        for i=1,#scoreMission,1 do
            local textbar = display.newImage(img_textbar)
            textbar.x = screenW*.5
            textbar.anchorX = 0.5
            textbar.anchorY = 0.1
            tapdisplay:insert(textbar)

            if i== 1 then
                textbar.y = pointBar
                pointBar = pointBar + screenH*.04


                local textmission = display.newText(scoreMission[i],screenW*.5,pointTextScore,"CooperBlackMS",30)
                textmission.anchorX = 0.5
                textmission.anchorY = 1
                tapdisplay:insert(textmission)
                pointTextScore = pointTextScore + screenH*.04
            else
                pointBar = pointBar + screenH*.1
                textbar.y = pointBar

--                local hiscore = display.newImage(img_txt_hiscore[i-1])
                local hiscore = display.newImage(img_txt_hiscore[i])
                hiscore.x = screenW*.5
                hiscore.y = pointhiscore
                tapdisplay:insert(hiscore)
                pointhiscore = pointhiscore + screenH*.1

                pointTextScore = pointTextScore + screenH*.1
--                local textmission = display.newText(scoreMission[i-1],screenW*.5,pointTextScore,"CooperBlackMS",30)
                local textmission = display.newText(scoreMission[i],screenW*.5,pointTextScore,"CooperBlackMS",30)
                textmission.anchorX = 0.5
                textmission.anchorY = 1
                tapdisplay:insert(textmission)

            end

        end
        for i=1,1,1 do
            color = color +1
            button1[i] = {}
            detailColor[i] = {}

            button1[i] = widget.newButton
                {
                    left = scrX,
                    top = scrY,
                    id = color,
                    defaultFile = img,
                    overFile = img,
                    onEvent = menuMode
                }
            button1[i].anchorX = 1
            tapdisplay:insert(button1[i])

            scrY = scrY + (screenH*.11)
        end

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end


function RetryMode()
    local detailColor = {}

    local tapdisplay = display.newGroup()
    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                mode = page
            }
        }
        local function gotoPage()
            storyboard.gotoScene("mainMenu",options)
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        return true
    end

    local img = {"img/small_frame/btt_yes.png","img/small_frame/btt_no.png"}
    local scrY = screenH*.5
    local scrX = screenW*.3

    local color = 0
    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
        local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.8
        myRectangle:setFillColor(0, 0, 0)
        tapdisplay:insert(myRectangle)

        local img_txt_youwin = "img/middle_frame/txt_youwin.png"
        local txt_youwin = display.newImage(img_txt_youwin)
        txt_youwin.x = screenW*.5
        txt_youwin.y = screenH*.05
        txt_youwin.anchorX = 0.5
        txt_youwin.anchorY = 1

        local img_scorebar = "img/middle_frame/frm_m_end.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = 0
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        BGMenuMode:addEventListener( "touch", BGMenuMode )
        tapdisplay:insert(BGMenuMode)
        tapdisplay:insert(txt_youwin)

        local BTset = {}
        for i=1,#img,1 do
            color = color +1
            BTset[i] = {}
            detailColor[i] = {}

            BTset[i] = widget.newButton
                {
                    left = scrX,
                    top = scrY,
                    id = color,
                    defaultFile = img[i],
                    overFile = img[i],
                    onEvent = menuMode
                }
            BTset[i].anchorX = 1
            tapdisplay:insert(BTset[i])

            scrX = scrX + (screenW*.4)
        end

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

function ExitMode()
    local detailColor = {}

    local tapdisplay = display.newGroup()
    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                mode = page
            }
        }
        local function gotoPage()
            storyboard.gotoScene("map",options)
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        return true
    end

    local img = {"img/small_frame/btt_yes.png","img/small_frame/btt_no.png"}
    local scrY = screenH*.5
    local scrX = screenW*.3

    local color = 0
    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
        local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.8
        myRectangle:setFillColor(0, 0, 0)
        tapdisplay:insert(myRectangle)

        local img_txt_youwin = "img/middle_frame/txt_youwin.png"
        local txt_youwin = display.newImage(img_txt_youwin)
        txt_youwin.x = screenW*.5
        txt_youwin.y = screenH*.05
        txt_youwin.anchorX = 0.5
        txt_youwin.anchorY = 1

        local img_scorebar = "img/middle_frame/frm_m_end.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = 0
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        BGMenuMode:addEventListener( "touch", BGMenuMode )
        tapdisplay:insert(BGMenuMode)
        tapdisplay:insert(txt_youwin)

        local BTset = {}
        for i=1,#img,1 do
            color = color +1
            BTset[i] = {}
            detailColor[i] = {}

            BTset[i] = widget.newButton
                {
                    left = scrX,
                    top = scrY,
                    id = color,
                    defaultFile = img[i],
                    overFile = img[i],
                    onEvent = menuMode
                }
            BTset[i].anchorX = 1
            tapdisplay:insert(BTset[i])

            scrX = scrX + (screenW*.4)
        end

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

function YouLoseMODE(event)

    local button1 = {}
    local detailColor = {}
    local NameMission = event.params.mission_name
    local scoreMission = {100,80}

    local toptapdisplay = display.newGroup()
    local tapdisplay = display.newGroup()
    local function handleButtonEvent( page )

        display.remove(toptapdisplay)
        toptapdisplay = nil

        display.remove(tapdisplay)
        tapdisplay = nil


        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                team_no = event.params.team_no ,
                map_id = event.params.map_id  ,
                mission_id = event.params.mission_id   ,
                mission_name = event.params.mission_name  ,
            }
        }
        local function gotoPage()

            if page == 1 then
                storyboard.gotoScene("pageWith",options)
                storyboard.gotoScene("mission",options)
            elseif page == 2 then

                storyboard.gotoScene("mainMap",options)
            else
                --storyboard.gotoScene("map",options)
            end

        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        if event.phase == "ended" then
            transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        end
        return true
    end

    local scrY = screenH*.25
    local scrX = screenW*.5

    local color = 0

    local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
    myRectangle.strokeWidth = 2
    myRectangle.anchorX = 0
    myRectangle.anchorY = 0
    myRectangle.alpha = 0.8
    myRectangle:setFillColor(0, 0, 0)
    toptapdisplay:insert(myRectangle)

    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
--        tapdisplay:insert(myRectangle)

        local img_txt_youwin = "img/middle_frame/txt_youlose.png"
        local txt_youwin = display.newImage(img_txt_youwin)
        txt_youwin.x = screenW*.5
        txt_youwin.y = screenH*.05
        txt_youwin.anchorX = 0.5
        txt_youwin.anchorY = 1

        local img_scorebar = "img/middle_frame/frm_m_end.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = 0
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        BGMenuMode:addEventListener( "touch", BGMenuMode )
        tapdisplay:insert(BGMenuMode)
        tapdisplay:insert(txt_youwin)


        local img_txt_hiscore = {"img/middle_frame/txt_hiscore.png","img/middle_frame/txt_urscore.png"}
        local img_textbar = "img/middle_frame/ast_scorebar.png"
        local pointBar = screenH*.14
        local pointhiscore = screenH*.25
        local pointTextScore = screenH*.17
        for i=1,1,1 do
            local textbar = display.newImage(img_textbar)
            textbar.x = screenW*.5
            textbar.anchorX = 0.5
            textbar.anchorY = 0.1
            tapdisplay:insert(textbar)
            if i== 1 then
                textbar.y = pointBar
                pointBar = pointBar + screenH*.04


                local textmission = display.newText(NameMission,screenW*.5,pointTextScore,"CooperBlackMS",30)
                textmission.anchorX = 0.5
                textmission.anchorY = 1
                tapdisplay:insert(textmission)

            end

        end
        local img = {"img/middle_frame/btt_retry02.png","img/middle_frame/btt_exit02.png"}
        for i=1,#img,1 do
            color = color +1
            button1[i] = {}
            detailColor[i] = {}

            button1[i] = widget.newButton
                {
                    left = scrX,
                    top = scrY,
                    id = color,
                    defaultFile = img[i],
                    overFile = img[i],
                    onEvent = menuMode
                }
            button1[i].anchorX = 1
            tapdisplay:insert(button1[i])

            scrY = scrY + (screenH*.15)
        end

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

--classic mode
function PuzzleEnd(score1,score2,countColor)

    local button1 = {}
    local detailColor = {}
    local NameMission = "my mission name is.."
    local scoreMission = {score1,score2}

    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )
    local tablefill ="UPDATE user SET user_score_classic = '"..score1.."';"
    db:exec( tablefill )

    local tapdisplay = display.newGroup()
    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                mode = page,
                countColor = countColor,
            }
        }
        local function gotoPage()
            require( "mission_anima" ).TimeOut()
            storyboard.gotoScene("mainMenu",options)
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        return true
    end

    local img = "img/middle_frame/btt_next02.png"
    local scrY = screenH*.45
    local scrX = screenW*.5

    local color = 0
    timer.performWithDelay ( 300,function()

        local groupViewgameoverFile = display.newGroup()
        local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.8
        myRectangle:setFillColor(0, 0, 0)
        tapdisplay:insert(myRectangle)

        local img_txt_youwin = "img/middle_frame/txt_pzzlend.png"
        local txt_youwin = display.newImage(img_txt_youwin)
        txt_youwin.x = screenW*.5
        txt_youwin.y = screenH*.05
        txt_youwin.anchorX = 0.5
        txt_youwin.anchorY = 1

        local img_scorebar = "img/middle_frame/frm_m_end.png"
        local BGMenuMode = display.newImage(img_scorebar)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = 0
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.1
        BGMenuMode:addEventListener( "touch", BGMenuMode )
        tapdisplay:insert(BGMenuMode)
        tapdisplay:insert(txt_youwin)


        local img_txt_hiscore = {"img/middle_frame/txt_hiscore.png","img/middle_frame/txt_urscore.png"}
        local img_textbar = "img/middle_frame/ast_scorebar.png"
        local pointBar = screenH*.14
        local pointhiscore = screenH*.2
        local pointTextScore = screenH*.17
        for i=1,2,1 do

                local hiscore = display.newImage(img_txt_hiscore[i])
                hiscore.x = screenW*.5
                hiscore.y = pointhiscore
                tapdisplay:insert(hiscore)

                local imgTab = display.newImage(img_textbar)
                imgTab.x = screenW*.5
                imgTab.y = pointhiscore + screenH*.05
                tapdisplay:insert(imgTab)

                pointhiscore = pointhiscore + screenH*.1

                pointTextScore = pointTextScore + screenH*.1
                local textmission = display.newText(scoreMission[i],screenW*.5,pointTextScore,"CooperBlackMS",30)
                textmission.anchorX = 0.5
                textmission.anchorY = 1
                tapdisplay:insert(textmission)


        end
        for i=1,1,1 do
            color = color +1
            button1[i] = {}
            detailColor[i] = {}

            button1[i] = widget.newButton
                {
                    left = scrX,
                    top = scrY,
                    id = color,
                    defaultFile = img,
                    overFile = img,
                    onEvent = menuMode
                }
            button1[i].anchorX = 1
            tapdisplay:insert(button1[i])

            scrY = scrY + (screenH*.11)
        end

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

function classicMODE()
    local user_score = 0
    local path = system.pathForFile("datas.db", system.DocumentsDirectory)
    db = sqlite3.open( path )
    for rowdata in db:nrows ("SELECT * FROM user;") do
        user_score = rowdata.user_score_classic
    end
    db:close()

    local button1 = {}
    local detailColor = {}
    local touchCount = 1
    local tapdisplay = display.newGroup()
    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                mode = page   ,
                user_score = user_score,
            }
        }
        local function gotoPage()
            if page == 1 then
                require("menu").HietcreateScene()
                storyboard.gotoScene("classic",options)

            elseif page == 2 then


            elseif page == 3 then
                require("menu").menu_setEnabledTouch(1)
                --                storyboard.gotoScene("mission",options)

            else


            end
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        if event.phase == "ended"  then
            transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        end
        return true
    end

    local img = {
        "img/small_frame/btt_start.png" ,
    }
    local scrY = screenH*.3
    local scrX = screenW*.5

    local color = 0
    timer.performWithDelay ( 300,function()
        local BGMenuMode = display.newImage("img/main_menu/frm_l_menu.png")
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = screenH*.3
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0.5
        BGMenuMode:addEventListener( "touch", BGMenuMode )
        tapdisplay:insert(BGMenuMode)

        local imgtext = "img/main_menu/txt_pzzlmode.png"
        local text = display.newImage(imgtext)
        text.x = screenW*.5
        text.anchorX = 0.5
        text.anchorY = 0.2
        tapdisplay:insert(text)

        local img_scorebar = "img/middle_frame/ast_scorebar.png"
        local tab_scorebar = display.newImage(img_scorebar)
        tab_scorebar.x = screenW*.5
        tab_scorebar.y = screenH*.2
        tab_scorebar.anchorX = 0.5
        tab_scorebar.anchorY = 0
        tapdisplay:insert(tab_scorebar)

        local text = display.newText(user_score,screenW*.5,screenH*.24,"CooperBlackMS",40)
        text.anchorX = 0.5
        text.anchorY = 1
        tapdisplay:insert(text)

        for i=1,#img,1 do
            color = color +1
            button1[i] = {}
            detailColor[i] = {}

            button1[i] = widget.newButton
                {
                    left = scrX,
                    top = scrY,
                    id = color,
                    defaultFile = img[color],
                    overFile = img[color],
                    onEvent = menuMode
                }
            button1[i].anchorX = 1
            tapdisplay:insert(button1[i])

            scrY = scrY + (screenH*.15)
        end

        button1 = widget.newButton
            {
                left = screenW*.92,
                top = -screenH*.09,
                defaultFile = "img/universal/btt_cancel.png",
                overFile = "img/universal/btt_cancel.png",
                onEvent = menuMode
            }
        button1.font = native.newFont("CooperBlackMS",50)
        button1.anchorX = 1
        tapdisplay:insert(button1)

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

function missionMODE()
    local name_mission = "MY name id mission xxx"
    local button1 = {}
    local detailColor = {}
    local touchCount = 1
    local tapdisplay = display.newGroup()
    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil


        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                mode = page
            }
        }
        local function gotoPage()
            if page == 1 then
                require("menu").HietcreateScene()
                storyboard.gotoScene("mission",options)

            elseif page == 2 then


            elseif page == 3 then
                require("menu").menu_setEnabledTouch(1)
                --                storyboard.gotoScene("mission",options)

            else


            end
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        if event.phase == "ended"  then
            transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        end
        return true
    end

    local img = {
        "img/small_frame/btt_start.png" ,
    }
    local scrY = screenH*.3
    local scrX = screenW*.5

    local color = 0
    timer.performWithDelay ( 300,function()
        local BGMenuMode = display.newRoundedRect(0,screenH*.25,screenW,screenH,0)
        BGMenuMode.anchorX = 0
        BGMenuMode.alpha = 0.5
        BGMenuMode:setFillColor(0, 0, 0)
        BGMenuMode:addEventListener( "touch", touchScreen )
        tapdisplay:insert(BGMenuMode)

        local imgtext = "img/small_frame/frm_s_mssn.png"
        local text = display.newImage(imgtext)
        text.x = screenW*.5
        text.anchorX = 0.5
        text.anchorY = 0
        tapdisplay:insert(text)

        local textName = display.newText(name_mission,screenW*.5,screenH*.26,"CooperBlackMS",30)
        textName.anchorX = 0.5
        textName.anchorY = 1
        tapdisplay:insert(textName)

        for i=1,#img,1 do
            color = color +1
            button1[i] = {}
            detailColor[i] = {}

            button1[i] = widget.newButton
                {
                    left = scrX,
                    top = scrY,
                    id = color,
                    defaultFile = img[color],
                    overFile = img[color],
                    onEvent = menuMode
                }
            button1[i].anchorX = 1
            tapdisplay:insert(button1[i])

            scrY = scrY + (screenH*.15)
        end

        button1 = widget.newButton
            {
                left = screenW*.92,
                top = -screenH*.03,
                defaultFile = "img/universal/btt_cancel.png",
                overFile = "img/universal/btt_cancel.png",
                onEvent = menuMode
            }
        button1.font = native.newFont("CooperBlackMS",50)
        button1.anchorX = 1
        tapdisplay:insert(button1)

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end


local function faceBookPost()
    local gdisplay = display.newGroup()
    local function listener( event )

        --- Debug Event parameters printout --------------------------------------------------
        --- Prints Events received up to 20 characters. Prints "..." and total count if longer
        ---

        local maxStr = 20		-- set maximum string length
        local endStr

        for k,v in pairs( event ) do
            local valueString = tostring(v)
            if string.len(valueString) > maxStr then
                endStr = " ... #" .. tostring(string.len(valueString)) .. ")"
            else
                endStr = ")"
            end
            print( "   " .. tostring( k ) .. "(" .. tostring( string.sub(valueString, 1, maxStr ) ) .. endStr )
        end
        --- End of debug Event routine -------------------------------------------------------

        print( "event.name", event.name ) -- "fbconnect"
        print( "event.type:", event.type ) -- type is either "session" or "request" or "dialog"
        print( "isError: " .. tostring( event.isError ) )
        print( "didComplete: " .. tostring( event.didComplete) )
        -----------------------------------------------------------------------------------------
        -- After a successful login event, send the FB command
        -- Note: If the app is already logged in, we will still get a "login" phase
        --
        if ( "session" == event.type ) then
            -- event.phase is one of: "login", "loginFailed", "loginCancelled", "logout"
            -- statusMessage.textObject.text = event.phase		-- tjn Added

            print( "Session Status: " .. event.phase )

            if event.phase ~= "login" then
                -- Exit if login error
                return
            end
            --
            if fbCommand == POST_PHOTO then
                local attachment = {
                    name = characterItem[1].character_name,
                    link = "https://play.google.com/store/apps/details?id=com.dym.thai.PZ3KD_Android",
                    caption = "LV."..characterItem[1].txtLV.."     ATK:"..characterItem[1].txtATK,
                    description = "Puzzle of 3 kingdom",
                    picture = "http://133.242.169.252/img/character/chara_icon/"..characterItem[1].ImageCharacter..".png",
                    actions = json.encode( { { name = "Learn More", link = "http://dym.co.th" } } )
                }

                facebook.request( "me/feed", "POST", attachment )		-- posting the photo
            end

            -----------------------------------------------------------------------------------------

        elseif ( "request" == event.type ) then
            -- event.response is a JSON object from the FB server
            local response = event.response

            if ( not event.isError ) then
                response = json.decode( event.response )

                if fbCommand == GET_USER_INFO then
                    --  statusMessage.textObject.text = response.name
                    printTable( response, "User Info", 3 )
                    print( "name", response.name )

                elseif fbCommand == POST_PHOTO then
                    printTable( response, "photo", 3 )
                    --  statusMessage.textObject.text = "Photo Posted"

                elseif fbCommand == POST_MSG then
                    printTable( response, "message", 3 )
                    --  statusMessage.textObject.text = "Message Posted"

                else
                    -- Unknown command response
                    print( "Unknown command response" )
                    --  statusMessage.textObject.text = "Unknown ?"
                end

            else
                -- Post Failed
                --  statusMessage.textObject.text = "Post failed"
                printTable( event.response, "Post Failed Response", 3 )
            end

        elseif ( "dialog" == event.type ) then
            -- showDialog response
            --
            print( "dialog response:", event.response )
            -- statusMessage.textObject.text = event.response
        end
    end
    local fbCommand
    local appId  = "651894754887364"--nil	-- Add  your App ID here (also go into build.settings and replace XXXXXXXXX with your appId under CFBundleURLSchemes)
    local apiKey = "6a01a95d412e9d0a5657d1a58d5ac0c9"--nil	-- Not needed at this time


    if ( appId ) then

        -- ***
        -- ************************ Buttons Functions ********************************
        -- ***
      --  local function postPhoto_onRelease( event )
         --   if event.phase == "ended" or event.phase == "release" then
                --                facebook.login( appId, listener )
                -- call the login method of the FB session object, passing in a handler
                -- to be called upon successful login.
                fbCommand = POST_PHOTO
                facebook.login( appId, listener,  {"publish_actions"}  )
         --   end
       -- end
        -- "Post Photo with Facebook" button
--        local fbButton = widget.newButton {
--            defaultFile = "img/small_frame/btt_fb.png",
--            overFile = "img/small_frame/btt_fb.png",
--            label = "Post Photo",
--            labelColor =
--            {
--                default = { 255, 255, 255 },
--            },
--            onRelease = postPhoto_onRelease,
--        }
--        fbButton.x = screenW*.85
--        fbButton.y = screenH*.67
--        fbButton.anchorX = 1
--        fbButton.anchorY = 0.5
--        gdisplay:insert(fbButton)
    end
end

function MenuMODE()
    print("function MenuMODE")

    local config = {}
    config[1] = tonumber(require( "top_name" ).getSound())
    config[2] = tonumber(require( "top_name" ).getBGMSound())
    local button1 = {}
    local getPointBTonOffX = {0,0,0}
    local getPointBTonOffY = {0,0,0}
    local detailColor = {}
    local touchCount = 1
    local tapdisplay = display.newGroup()
    local img = {
        "img/small_frame/btt_on.png" ,
        "img/small_frame/btt_off.png" ,
        "img/small_frame/btt_fb.png" ,
    }

    local function handleButtonEvent( page )
        display.remove(tapdisplay)
        tapdisplay = nil

        local options =
        {
            effect = "zoomInOutFade",
            time = 100,
            params = {
                mode = page
            }
        }
        local function gotoPage()
            if page == 1 then
                require("menu").HietcreateScene()
                storyboard.gotoScene("classic",options)

            elseif page == 2 then
                require("menu").HietcreateScene()
                storyboard.gotoScene("mainMap",options)

            elseif page == 3 then
                require("menu").menu_setEnabledTouch(1)
                --                storyboard.gotoScene("mission",options)

            else


            end
        end
        timer.performWithDelay ( 100,gotoPage)
    end
    local function menuMode(event)
        local page = event.target.id
        if event.phase == "ended"  then
            transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
        end
        return true
    end
    local function switchMode(event)
        local idObj = event.target.id
        local idObjIMG = nil
        local displayStore = nil



        if event.phase == "ended"  then
            if event.target.status == 1 then
                idObjIMG = 2
            else
                idObjIMG = 1
            end

            if event.target.id == 3  then    --facebook
                faceBookPost()
            else
                displayStore = button1[idObj]
                button1[idObj] = widget.newButton
                    {
                        left = getPointBTonOffX[idObj],
                        top = getPointBTonOffY[idObj],
                        id = idObj,
                        defaultFile = img[idObjIMG],
                        overFile = img[idObjIMG],
                        onEvent = switchMode
                    }

                button1[idObj].status = idObjIMG
                button1[idObj].anchorX = 1
                tapdisplay:insert(button1[idObj])

                display.remove(displayStore)

                if idObj == 1 then
                    config[1] = idObjIMG
                    require( "top_name" ).setSound(idObjIMG,config[2])
                else
                    config[2] = idObjIMG
                    require( "top_name" ).setSound(config[1],idObjIMG)
                end
            end
        end
        return true
    end

    local scrY = screenH*.07
    local scrX = screenW*.39

    local color = 0
    timer.performWithDelay ( 300,function()
        local myRectangle = display.newRoundedRect(0, 0, screenW, screenH,0)
        myRectangle.strokeWidth = 2
        myRectangle.anchorX = 0
        myRectangle.anchorY = 0.25
        myRectangle.alpha = 0.8
        myRectangle:setFillColor(0, 0, 0)
        myRectangle.touch = touchScreen
        myRectangle:addEventListener( "touch", myRectangle )
        tapdisplay:insert(myRectangle)

        local img_BGMenuMode = "img/small_frame/frm_s_pause01.png"
        local BGMenuMode = display.newImage(img_BGMenuMode)
        BGMenuMode.x = screenW*.5
        BGMenuMode.y = -screenH*.1
        BGMenuMode.anchorX = 0.5
        BGMenuMode.anchorY = 0
        tapdisplay:insert(BGMenuMode)

        local getPlay = 1 --if touch pause in game
        if getPlay then
            local ModeIngame = function(event)
                if event.phase == "ended"  then

                     if event.target.id == 2 then
                         RetryMode()
                     elseif event.target.id == 3 then
                         ExitMode()
                     else
                         event.target.id = 0 --set to continues
                         menuMode(event)
                     end

                     event.target.id = 0 --set to continues
                     menuMode(event)
                end

            end
--            local img_BGMenuMode = "img/small_frame/frm_u_pause02.png"
--            local BGMenuMode = display.newImage(img_BGMenuMode)
--            BGMenuMode.x = screenW*.5
--            BGMenuMode.y = screenH*.4
--            BGMenuMode.anchorX = 0.5
--            BGMenuMode.anchorY = 0
--            tapdisplay:insert(BGMenuMode)
--
--            local imgPause= {
--                "img/small_frame/btt_resume.png" ,
--                "img/small_frame/btt_retry01.png" ,
--                "img/small_frame/btt_exit01.png" ,
--            }
--            local pointpauseY = screenH*.45
--            local pointpauseX = screenW*.3
--            local pausePlay ={}
--            for i=1,#imgPause,1 do
--                pausePlay[i] = {}
--                detailColor[i] = {}
--
--                if i == 1 then
--                    pausePlay[i] = widget.newButton
--                        {
--                            left = screenW*.5,
--                            top = pointpauseY,
--                            id = i,
--                            defaultFile = imgPause[i],
--                            overFile = imgPause[i],
--                            onEvent = ModeIngame
--                        }
--                    pausePlay[i].status = 1
--                    pausePlay[i].anchorX = 1
--                    tapdisplay:insert(pausePlay[i])
--
--                    pointpauseY = pointpauseY + (screenH*.1)
--                else
--                    pausePlay[i] = widget.newButton
--                        {
--                            left = pointpauseX,
--                            top = pointpauseY,
--                            id = i,
--                            defaultFile = imgPause[i],
--                            overFile = imgPause[i],
--                            onEvent = ModeIngame
--                        }
--                    pausePlay[i].status = 1
--                    pausePlay[i].anchorX = 1
--                    tapdisplay:insert(pausePlay[i])
--                    pointpauseX = pointpauseX + screenW*.4
--                end
--            end
        end

        for i=1,#img,1 do
            button1[i] = {}
            detailColor[i] = {}

            if i <= 2 then
                button1[i] = widget.newButton
                    {
                        left = scrX,
                        top = scrY,
                        id = i,
                        defaultFile = img[config[i]],
                        overFile = img[config[i]],
                        onEvent = switchMode
                    }
                button1[i].status = 1
                button1[i].anchorX = 1
                tapdisplay:insert(button1[i])
                getPointBTonOffX[i] = scrX
                getPointBTonOffY[i] = scrY

                scrX = scrX + (screenW*.37)
            else
                scrX = scrX - (screenW*.37)
                scrY = scrY + screenH*.14
                button1[i] = widget.newButton
                    {
                        left = scrX,
                        top = scrY,
                        id = i,
                        defaultFile = img[i],
                        overFile = img[i],
                        onEvent = switchMode
                    }
                button1[i].status = 1
                button1[i].anchorX = 1
                tapdisplay:insert(button1[i])

                getPointBTonOffX[i] = scrX
                getPointBTonOffY[i] = scrY
            end
        end

        local close = widget.newButton
            {
                left = screenW*.92,
                top = -screenH*.12,
                defaultFile = "img/universal/btt_cancel.png",
                overFile = "img/universal/btt_cancel.png",
                onEvent = menuMode
            }
        close.font = native.newFont("CooperBlackMS",50)
        close.anchorX = 1
        tapdisplay:insert(close)

        transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
    end )

    return true

end

function customizeTMODE(object,option)
    object = object +1
    if object == 2 then

    else
        local button1 = {}
        local detailColor = {}

        local tapdisplay = display.newGroup()
        local function handleButtonEvent( page )
            display.remove(tapdisplay)
            tapdisplay = nil

            local options =
            {
                effect = "zoomInOutFade",
                time = 100,
                params = {
                    mode = page
                }
            }
            local function gotoPage()
                if page == 1 then
                    storyboard.gotoScene("gallery",options)

                elseif page == 2 then
                    require("menu").HietcreateScene()
                   storyboard.gotoScene("team_main",options)

--                elseif page == 3 then
--                    require("menu").menu_setEnabledTouch(1)
                   -- storyboard.gotoScene("mission",options)

                elseif option == "close" then

                else


                end
            end
            timer.performWithDelay ( 100,gotoPage)
        end
        local function menuMode(event)

            local page = event.target.id
            if event.phase == "ended" then
                transition.to( tapdisplay, { time=200, y= tapdisplay.y - screenH*.5 ,onComplete= function()handleButtonEvent(page) end})
            end
            return true
        end

        local img = {
            "img/main_menu/btt_allygallery.png" ,
            "img/main_menu/btt_pinsetting.png" ,
            "img/main_menu/btt_comingsoon.png" ,
        }
        local scrY = screenH*.12
        local scrX = screenW*.5

        local color = 0
        timer.performWithDelay ( 300,function()

            local BGMode = display.newRoundedRect(0,screenH*.25,screenW,screenH,0)
            BGMode.anchorX = 0
            BGMode.alpha = 0.5
            BGMode:setFillColor(0, 0, 0)
            BGMode:addEventListener( "touch", touchScreen )
            tapdisplay:insert(BGMode)

            local BGMenuMode = display.newImage("img/main_menu/frm_l_menu.png")
            BGMenuMode.x = screenW*.5
            BGMenuMode.y = screenH*.3
            BGMenuMode.anchorX = 0.5
            BGMenuMode.anchorY = 0.5
            BGMenuMode:addEventListener( "touch", BGMenuMode )
            tapdisplay:insert(BGMenuMode)

            local imgtext = "img/main_menu/txt_customize.png"
            local text = display.newImage(imgtext)
            text.x = screenW*.5
            text.anchorX = 0.5
            text.anchorY = 0.2
            tapdisplay:insert(text)
            for i=1,#img,1 do
                color = color +1
                button1[i] = {}
                detailColor[i] = {}

                button1[i] = widget.newButton
                    {
                        left = scrX,
                        top = scrY,
                        id = color,
                        defaultFile = img[color],
                        overFile = img[color],
                        onEvent = menuMode
                    }
                button1[i].anchorX = 1
                tapdisplay:insert(button1[i])

                scrY = scrY + (screenH*.15)
            end

            button1 = widget.newButton
                {
                    left = screenW*.92,
                    top = -screenH*.09,
                    defaultFile = "img/universal/btt_cancel.png",
                    overFile = "img/universal/btt_cancel.png",
                    onEvent = menuMode
                }
            button1.font = native.newFont("CooperBlackMS",50)
            button1.anchorX = 1
            tapdisplay:insert(button1)

            transition.to( tapdisplay, { time=200, y=tapdisplay.y + screenH*.25 })
        end )

        return true
    end


end

