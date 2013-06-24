print("character_scene")
module(..., package.seeall)
local storyboard = require( "storyboard" )
local previous_scene_name = storyboard.getPrevious()
local includeFUN = require("includeFunction")
local scene = storyboard.newScene()
local widget = require "widget"
local http = require("socket.http")
local json = require("json")

local screenW = display.contentWidth
local screenH = display.contentHeight
-----------------------------------------------
local LinkURL = "http://localhost/DYM/character.php"
local characterSelect
local character_type
local character_LV
local character_HP
local character_DEF
local character_ATK
local character_name
local ImageCharacter
local FrameCharacter
local typeFont = native.systemFontBold
local sizetext = 22
local sizetextName = 30

local Cteam_id
local Cholddteam_no
local character_id
local USER_id
local characterChoose = {}
local pageTeam,pageItem
-----------------------------------------------

function character_powerUP(id,USERID)
    print("character_powerUP ID:"..id)



    character_id =  id
    USER_id =  USERID

    local characterID =  LinkURL.."?character="..id.."&user_id="..USER_id
    local characterImg = http.request(characterID)

    if characterImg == nil then
        print("No Dice")
    else
        characterSelect  = json.decode(characterImg)
        character_type = "smach"
        character_name = characterSelect.chracter[1].charac_name
        character_DEF = characterSelect.chracter[1].charac_def
        character_ATK = characterSelect.chracter[1].charac_atk
        character_HP = characterSelect.chracter[1].charac_hp
        character_LV = characterSelect.chracter[1].charac_lv
        ImageCharacter = characterSelect.chracter[1].charac_img_mini
        FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)
        -- print("img"..characterSelect.charac_img_mini)
    end

    local options =
    {
        effect = "fade",
        time = 100,
        params = {
            character_id =character_id ,
            user_id = USER_id
        }
    }
    local maxfram = 5
    local frame = {"img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png" }

    -- print("frame[FrameCharacter]:"..frame[FrameCharacter])
    local btn_view
    local myRectangle
    local backButton
    local imageprofile
    local btn_cancel
    local btn_anyfunction
    local btn_view
    local framImage

    local NameText
    local SmachText
    local LVText
    local HPText
    local ATKText
    local DEFText
    local textLVHP


    local image_text = "img/text/CHARACTER.png"
    local image_anyfun = "img/background/character/Any_functions.png"
    local image_viewpro = "img/background/character/View_profile.png"
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_background = "img/background/background_1.png"
    local image_LVHP = "img/background/character/HP,LV,ATC,DEF_character.png"

    local groupView = display.newGroup()
    local groupENDView = display.newGroup()
    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        myRectangle.alpha       = 0
        btn_view.alpha          = 0
        myRectangle.alpha       = 0
        imageprofile.alpha      = 0
        btn_cancel.alpha        = 0
        btn_anyfunction.alpha   = 0
        btn_view.alpha          = 0
        framImage.alpha         = 0

        NameText.alpha = 0
        SmachText.alpha = 0
        LVText.alpha = 0
        HPText.alpha = 0
        ATKText.alpha = 0
        DEFText.alpha = 0
        textLVHP.alpha = 0

        if event.target.id == "imageprofile" then
            storyboard.gotoScene( "characterprofile" ,"flipFadeOutIn", 200 )

        elseif event.target.id == "anyfunction" then
            storyboard.gotoScene( "power_up_main" ,options )

        elseif event.target.id == "viewprofile" then
            storyboard.gotoScene( "characterprofile" ,options )

        elseif event.target.id == "cancel" then
            storyboard.gotoScene( "characterAll" ,"fade", 100 )
        end

        --storyboard.removeScene(previous_scene_name)

    end

    myRectangle = display.newRect(0, 0, screenW, screenH)
    myRectangle.strokeWidth = 3
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)

    myRectangle.touch = onTouchGameOverScreen
    myRectangle:addEventListener( "touch", myRectangle )
    --    groupENDView:insert(myRectangle)
    groupView:insert(myRectangle)

    --button image profile
    imageprofile = widget.newButton{
        default= ImageCharacter,
        over= ImageCharacter,
        width=screenW/4, height=screenH/5.3,
        onRelease = onBtncharacter	-- event listener function
    }
    imageprofile.id="id"..id
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x = screenW/2.65
    imageprofile.y = screenH/2.24
    groupView:insert(imageprofile)


    framImage = display.newImageRect(frame[FrameCharacter] ,screenW*.26, screenH*.2)
    framImage:setReferencePoint( display.TopLeftReferencePoint )
    framImage.x = screenW*.25
    framImage.y = screenH*.35
    groupView:insert(framImage)

    textLVHP = display.newImageRect(image_LVHP ,screenW*.07, screenH*.1)
    textLVHP:setReferencePoint( display.TopLeftReferencePoint )
    textLVHP.x = screenW*.55
    textLVHP.y = screenH*.42
    groupView:insert(textLVHP)

    local namelenght = string.len(character_name)
    --local pointName =  (screenW*.6)-((namelenght*sizetextName)/4)
    local pointtextLVHP = screenW*.7

    NameText = display.newText(character_name, screenW*.55, screenH *.35,typeFont, sizetextName)
    NameText:setTextColor(0, 255, 255)
    groupView:insert(NameText)

    SmachText = display.newText(character_type.."smach", screenW*.55, screenH *.38,typeFont, sizetextName)
    SmachText:setTextColor(200, 0, 200)
    groupView:insert(SmachText)

    LVText = display.newText(character_LV, pointtextLVHP, screenH *.412,typeFont, sizetext)
    LVText:setTextColor(0, 255, 255)
    groupView:insert(LVText)

    HPText = display.newText(character_HP, pointtextLVHP, screenH *.44,typeFont, sizetext)
    HPText:setTextColor(0, 255, 255)
    groupView:insert(HPText)

    ATKText = display.newText(character_ATK, pointtextLVHP, screenH *.468,typeFont, sizetext)
    ATKText:setTextColor(0, 255, 255)
    groupView:insert(ATKText)

    DEFText = display.newText(character_DEF, pointtextLVHP, screenH *.496,typeFont, sizetext)
    DEFText:setTextColor(0, 255, 255)
    groupView:insert(DEFText)

    --button cancel profile
    btn_cancel = widget.newButton{
        default=image_cancel,
        over=image_cancel,
        width=screenW*.23, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =display.contentWidth /2
    btn_cancel.y = display.contentHeight *.78
    groupView:insert(btn_cancel)

    --button anyfunction
    btn_anyfunction = widget.newButton{
        default= image_anyfun,
        over= image_anyfun,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_anyfunction.id="anyfunction"
    btn_anyfunction:setReferencePoint( display.CenterReferencePoint )
    btn_anyfunction.x =screenW *.5
    btn_anyfunction.y = screenH *.6
    groupView:insert(btn_anyfunction)

    --button btn_view
    btn_view = widget.newButton{
        default= image_viewpro,
        over= image_viewpro,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_view.id="viewprofile"
    btn_view:setReferencePoint( display.CenterReferencePoint )
    btn_view.x = screenW *.5
    btn_view.y = screenH *.69
    groupView:insert(btn_view)
    -- groupView:insert(groupView)

    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )
    return true
end

function character(id,holddteam_no,team_id,USERID)
    print("ID:"..id)
    print("holddteam_no:"..holddteam_no)
    print("team_id:"..team_id)
    local LinkURL = "http://localhost/DYM/Onecharacter.php"

    character_id =  id
    Cholddteam_no =  holddteam_no
    Cteam_id =  team_id
    USER_id =  USERID
    print("character_id",character_id)
    local characterID =  LinkURL.."?character="..id.."&user_id="..USER_id
    local characterImg = http.request(characterID)

    if characterImg == nil then
        print("No Dice")
    else
        characterSelect  = json.decode(characterImg)
        character_type = "smach"
        character_name = characterSelect.chracter[1].charac_name
        character_DEF = characterSelect.chracter[1].charac_def
        character_ATK = characterSelect.chracter[1].charac_atk
        character_HP = characterSelect.chracter[1].charac_hp
        character_LV = characterSelect.chracter[1].charac_lv
        ImageCharacter = characterSelect.chracter[1].charac_img_mini
        FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)
       -- print("img"..characterSelect.charac_img_mini)
    end

    local options =
    {
        effect = "fade",
        time = 100,
        params = {
            character_id =character_id ,
            holddteam_no =  Cholddteam_no  ,
            team_id =  Cteam_id ,
            user_id = USER_id
        }
    }
    local maxfram = 5
    local frame = {"img/characterIcon/as_cha_frm01.png",
                    "img/characterIcon/as_cha_frm02.png",
                    "img/characterIcon/as_cha_frm03.png",
                    "img/characterIcon/as_cha_frm04.png",
                    "img/characterIcon/as_cha_frm05.png" }

   -- print("frame[FrameCharacter]:"..frame[FrameCharacter])
    local btn_view
    local myRectangle
    local backButton
    local imageprofile
    local btn_cancel
    local btn_anyfunction
    local btn_view
    local framImage

    local NameText
    local SmachText
    local LVText
    local HPText
    local ATKText
    local DEFText
    local textLVHP


    local image_text = "img/text/CHARACTER.png"
    local image_anyfun = "img/background/character/Any_functions.png"
    local image_viewpro = "img/background/character/View_profile.png"
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_background = "img/background/background_1.png"
    local image_LVHP = "img/background/character/HP,LV,ATC,DEF_character.png"

    local groupView = display.newGroup()
    local groupENDView = display.newGroup()
    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        myRectangle.alpha       = 0
        btn_view.alpha          = 0
        myRectangle.alpha       = 0
        imageprofile.alpha      = 0
        btn_cancel.alpha        = 0
        btn_anyfunction.alpha   = 0
        btn_view.alpha          = 0
        framImage.alpha         = 0

        NameText.alpha = 0
        SmachText.alpha = 0
        LVText.alpha = 0
        HPText.alpha = 0
        ATKText.alpha = 0
        DEFText.alpha = 0
        textLVHP.alpha = 0

        if event.target.id == "imageprofile" then
            print( "event: "..event.target.id)

            storyboard.gotoScene( "characterprofile" ,"flipFadeOutIn", 200 )

        elseif event.target.id == "anyfunction" then
            print( "event: "..event.target.id)
            print("character_id:"..options.params.character_id)
            print("holddteam_no:"..options.params.holddteam_no)
            print("team_id:"..options.params.team_id)

            local  team_id = options.params.team_id
            local  charac_id = options.params.character_id
            local  holdteam_no = options.params.holddteam_no
            local  USER_id = options.params.user_id



            local ulrInsert = "http://localhost/dym/insertTeam.php"
            print("url:"..ulrInsert)
            local characterUP =  ulrInsert.."?team_id="..team_id.."&charac_id="..charac_id.."&holdteam_no="..holdteam_no.."&user_id="..USER_id
            local characterUPImg = http.request(characterUP)

            storyboard.gotoScene( "team_main" ,options )

        elseif event.target.id == "viewprofile" then
            print( "event: "..event.target.id)
            storyboard.gotoScene( "characterprofile" ,options )

        elseif event.target.id == "cancel" then
            print( "event: "..event.target.id)
            storyboard.gotoScene( "team_item" ,"fade", 100 )
        end

    end

    myRectangle = display.newRect(0, 0, screenW, screenH)
    myRectangle.strokeWidth = 3
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)

    myRectangle.touch = onTouchGameOverScreen
    myRectangle:addEventListener( "touch", myRectangle )
--    groupENDView:insert(myRectangle)
    groupView:insert(myRectangle)

    --button image profile
    imageprofile = widget.newButton{
        default= ImageCharacter,
        over= ImageCharacter,
        width=screenW/4, height=screenH/5.3,
        onRelease = onBtncharacter	-- event listener function
    }
    imageprofile.id="id"..id
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x = screenW/2.65
    imageprofile.y = screenH/2.24
    groupView:insert(imageprofile)


    framImage = display.newImageRect(frame[FrameCharacter] ,screenW*.26, screenH*.2)
    framImage:setReferencePoint( display.TopLeftReferencePoint )
    framImage.x = screenW*.25
    framImage.y = screenH*.35
    groupView:insert(framImage)

    textLVHP = display.newImageRect(image_LVHP ,screenW*.07, screenH*.1)
    textLVHP:setReferencePoint( display.TopLeftReferencePoint )
    textLVHP.x = screenW*.55
    textLVHP.y = screenH*.42
    groupView:insert(textLVHP)

    local namelenght = string.len(character_name)
    --local pointName =  (screenW*.6)-((namelenght*sizetextName)/4)
    local pointtextLVHP = screenW*.7

    NameText = display.newText(character_name, screenW*.55, screenH *.35,typeFont, sizetextName)
    NameText:setTextColor(0, 255, 255)
    groupView:insert(NameText)

    SmachText = display.newText(character_type.."smach", screenW*.55, screenH *.38,typeFont, sizetextName)
    SmachText:setTextColor(200, 0, 200)
    groupView:insert(SmachText)

    LVText = display.newText(character_LV, pointtextLVHP, screenH *.412,typeFont, sizetext)
    LVText:setTextColor(0, 255, 255)
    groupView:insert(LVText)

    HPText = display.newText(character_HP, pointtextLVHP, screenH *.44,typeFont, sizetext)
    HPText:setTextColor(0, 255, 255)
    groupView:insert(HPText)

    ATKText = display.newText(character_ATK, pointtextLVHP, screenH *.468,typeFont, sizetext)
    ATKText:setTextColor(0, 255, 255)
    groupView:insert(ATKText)

    DEFText = display.newText(character_DEF, pointtextLVHP, screenH *.496,typeFont, sizetext)
    DEFText:setTextColor(0, 255, 255)
    groupView:insert(DEFText)

    --button cancel profile
    btn_cancel = widget.newButton{
        default=image_cancel,
        over=image_cancel,
        width=screenW*.23, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =display.contentWidth /2
    btn_cancel.y = display.contentHeight *.78
    groupView:insert(btn_cancel)

    --button anyfunction
    btn_anyfunction = widget.newButton{
        default= image_anyfun,
        over= image_anyfun,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_anyfunction.id="anyfunction"
    btn_anyfunction:setReferencePoint( display.CenterReferencePoint )
    btn_anyfunction.x =screenW *.5
    btn_anyfunction.y = screenH *.6
    groupView:insert(btn_anyfunction)

    --button btn_view
    btn_view = widget.newButton{
        default= image_viewpro,
        over= image_viewpro,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_view.id="viewprofile"
    btn_view:setReferencePoint( display.CenterReferencePoint )
    btn_view.x = screenW *.5
    btn_view.y = screenH *.69
    groupView:insert(btn_view)
   -- groupView:insert(groupView)

    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )
    return true
end

function startBattle(team_no,item_no)
    pageTeam = team_no
    pageItem = item_no

    print("fn:startBattle team_no:"..pageTeam,"item_no:"..pageItem)
end

function getTeamgetItem()
    local user_id = includeFUN.USERIDPhone()
    local option = {
        params = {
            team_no = pageTeam ,
            item_no = pageItem ,
            user_id =  user_id
        }
    }
    return option
end


function characterFriend_remove(Recharacter,Refriendid,ReUSERID)
    local LinkURLCharac = "http://localhost/DYM/character.php"
    print("FN characterFriend remove character :",Recharacter.."friend:",Refriendid,"USERID:",ReUSERID)



    local character_id =  Recharacter
    local friend_id =  Refriendid
    local USER_id =  ReUSERID

    local Uuser_id
    local user_Name
    local user_LV

    local characterID =  LinkURLCharac.."?character="..character_id.."&user_id="..friend_id
    local characterImg = http.request(characterID)

    if characterImg == nil then
        print("No Dice")
    else
        characterSelect  = json.decode(characterImg)
        character_type = "smach"

        Uuser_id = characterSelect.chracter[1].user_id
        user_Name = characterSelect.chracter[1].user_Name
        user_LV = characterSelect.chracter[1].user_LV
        print("**** aaaaa user_Name",user_Name)


        character_name = characterSelect.chracter[1].charac_name

        character_DEF = characterSelect.chracter[1].charac_def
        character_ATK = characterSelect.chracter[1].charac_atk
        character_HP = characterSelect.chracter[1].charac_hp
        character_LV = characterSelect.chracter[1].charac_lv
        ImageCharacter = characterSelect.chracter[1].charac_img_mini
        FrameCharacter = tonumber(characterSelect.chracter[1].charac_element)
        -- print("img"..characterSelect.charac_img_mini)
    end

    local options =
    {
        effect = "fade",
        time = 100,
        params = {
            character_id =character_id ,
            friend_id = friend_id,
            user_id = USER_id
        }
    }
    local maxfram = 5
    local frame = {"img/characterIcon/as_cha_frm01.png",
        "img/characterIcon/as_cha_frm02.png",
        "img/characterIcon/as_cha_frm03.png",
        "img/characterIcon/as_cha_frm04.png",
        "img/characterIcon/as_cha_frm05.png" }

    -- print("frame[FrameCharacter]:"..frame[FrameCharacter])
    local btn_view
    local myRectangle
    local backButton
    local imageprofile
    local btn_cancel
    local btn_REMOVE
    local btn_view
    local framImage

    local txtLV_user
    local txtNameuser
    local txtID_user
    local NameText
    local SmachText
    local LVText
    local HPText
    local ATKText
    local DEFText
    local textLVHP


    local image_text = "img/text/CHARACTER.png"
    local image_REMOVE = "img/background/button/REMOVE_FRIEND.png"
    local image_viewpro = "img/background/character/View_profile.png"
    local image_cancel = "img/background/button/as_butt_discharge_cancel.png"
    local image_background = "img/background/background_1.png"
    local image_LVHP = "img/background/character/HP,LV,ATC,DEF_character.png"

    local groupView = display.newGroup()
    local groupENDView = display.newGroup()
    local function onTouchGameOverScreen ( self, event )

        if event.phase == "began" then

            --storyboard.gotoScene( "menu-scene", "fade", 400  )

            return true
        end
    end
    local function onBtncharacter(event)
        myRectangle.alpha       = 0
        btn_view.alpha          = 0
        myRectangle.alpha       = 0
        imageprofile.alpha      = 0
        btn_cancel.alpha        = 0
        btn_REMOVE.alpha   = 0
        btn_view.alpha          = 0
        framImage.alpha         = 0

        txtLV_user.alpha = 0
        txtNameuser.alpha = 0
        txtID_user.alpha = 0
        NameText.alpha = 0
        SmachText.alpha = 0
        LVText.alpha = 0
        HPText.alpha = 0
        ATKText.alpha = 0
        DEFText.alpha = 0
        textLVHP.alpha = 0

        if event.target.id == "imageprofile" then
            storyboard.gotoScene( "characterprofile" ,"flipFadeOutIn", 200 )

        elseif event.target.id == "Remove" then
            local respont = 2  -- remove friend
            local linkremove = "http://localhost/DYM/accepFriend.php"
            local numberHold_character =  linkremove.."?user_id="..USER_id.."&friend="..friend_id.."&respont="..respont
            local numberHold = http.request(numberHold_character)

--
            storyboard.gotoScene( "pageWith",options )
            storyboard.removeScene( "friend_list" )
            storyboard.gotoScene( "friend_list",options )
            storyboard.removeScene( "pageWith" )

            --storyboard.gotoScene( "friend_list" ,options )

        elseif event.target.id == "viewprofile" then
            storyboard.gotoScene( "characterprofile" ,options )

        elseif event.target.id == "cancel" then
            storyboard.gotoScene( "friend_list" ,"fade", 100 )
        end

        --storyboard.removeScene(previous_scene_name)

    end

    myRectangle = display.newRect(0, 0, screenW, screenH)
    myRectangle.strokeWidth = 3
    myRectangle.alpha = .8
    myRectangle:setFillColor(0, 0, 0)

    myRectangle.touch = onTouchGameOverScreen
    myRectangle:addEventListener( "touch", myRectangle )
    --    groupENDView:insert(myRectangle)
    groupView:insert(myRectangle)

    --button image profile
    imageprofile = widget.newButton{
        default= ImageCharacter,
        over= ImageCharacter,
        width=screenW/4, height=screenH/5.3,
        onRelease = onBtncharacter	-- event listener function
    }
    imageprofile.id="id"..Recharacter
    imageprofile:setReferencePoint( display.CenterReferencePoint )
    imageprofile.x = screenW/2.65
    imageprofile.y = screenH/2.24
    groupView:insert(imageprofile)


    framImage = display.newImageRect(frame[FrameCharacter] ,screenW*.26, screenH*.2)
    framImage:setReferencePoint( display.TopLeftReferencePoint )
    framImage.x = screenW*.25
    framImage.y = screenH*.35
    groupView:insert(framImage)

    textLVHP = display.newImageRect(image_LVHP ,screenW*.07, screenH*.1)
    textLVHP:setReferencePoint( display.TopLeftReferencePoint )
    textLVHP.x = screenW*.55
    textLVHP.y = screenH*.42
    groupView:insert(textLVHP)

    local namelenght = string.len(character_name)
    --local pointName =  (screenW*.6)-((namelenght*sizetextName)/4)
    local pointtextLVHP = screenW*.7

    -------*****user
    txtLV_user = display.newText("Lv."..user_LV, screenW*.2, screenH *.25,typeFont, sizetextName)
    txtLV_user:setTextColor(100, 255, 255)
    groupView:insert(txtLV_user)


    txtNameuser = display.newText(user_Name, screenW*.2, screenH *.2,typeFont, sizetextName)
    txtNameuser:setTextColor(200, 200, 200)
    groupView:insert(txtNameuser)

    txtID_user = display.newText("ID:[0000000"..Uuser_id.."]", screenW*.55, screenH *.25,typeFont, sizetextName)
    txtID_user:setTextColor(0, 255, 255)
    groupView:insert(txtID_user)
    -------*****user

    NameText = display.newText(character_name, screenW*.55, screenH *.35,typeFont, sizetextName)
    NameText:setTextColor(0, 255, 255)
    groupView:insert(NameText)

    SmachText = display.newText(character_type.."smach", screenW*.55, screenH *.38,typeFont, sizetextName)
    SmachText:setTextColor(200, 0, 200)
    groupView:insert(SmachText)

    LVText = display.newText(character_LV, pointtextLVHP, screenH *.412,typeFont, sizetext)
    LVText:setTextColor(0, 255, 255)
    groupView:insert(LVText)

    HPText = display.newText(character_HP, pointtextLVHP, screenH *.44,typeFont, sizetext)
    HPText:setTextColor(0, 255, 255)
    groupView:insert(HPText)

    ATKText = display.newText(character_ATK, pointtextLVHP, screenH *.468,typeFont, sizetext)
    ATKText:setTextColor(0, 255, 255)
    groupView:insert(ATKText)

    DEFText = display.newText(character_DEF, pointtextLVHP, screenH *.496,typeFont, sizetext)
    DEFText:setTextColor(0, 255, 255)
    groupView:insert(DEFText)

    --button cancel profile
    btn_cancel = widget.newButton{
        default=image_cancel,
        over=image_cancel,
        width=screenW*.23, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_cancel.id="cancel"
    btn_cancel:setReferencePoint( display.CenterReferencePoint )
    btn_cancel.x =display.contentWidth /2
    btn_cancel.y = display.contentHeight *.78
    groupView:insert(btn_cancel)

    --button anyfunction
    btn_REMOVE = widget.newButton{
        default= image_REMOVE,
        over= image_REMOVE,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_REMOVE.id="Remove"
    btn_REMOVE:setReferencePoint( display.CenterReferencePoint )
    btn_REMOVE.x =screenW *.5
    btn_REMOVE.y = screenH *.69
    groupView:insert(btn_REMOVE)

    --button btn_view
    btn_view = widget.newButton{
        default= image_viewpro,
        over= image_viewpro,
        width=screenW*.38, height=screenH*.06,
        onRelease = onBtncharacter	-- event listener function
    }
    btn_view.id="viewprofile"
    btn_view:setReferencePoint( display.CenterReferencePoint )
    btn_view.x = screenW *.5
    btn_view.y = screenH *.6
    groupView:insert(btn_view)
    -- groupView:insert(groupView)

    groupView.touch = onTouchGameOverScreen
    groupView:addEventListener( "touch", groupView )
    return true
end

