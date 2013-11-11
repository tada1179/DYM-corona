--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0ef0b3c9b0eeb5e30d414e91e43b5041:1/1$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- as_slide_icn_base
            x=2,
            y=2,
            width=56,
            height=10,

        },
        {
            -- as_slide_icn_show
            x=60,
            y=2,
            width=10,
            height=10,

        },
        {
            -- as_team_icn_team04
            x=72,
            y=2,
            width=306,
            height=22,

        },
        {
            -- as_team_icn_teamsta
            x=2,
            y=26,
            width=421,
            height=22,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 421,
            sourceHeight = 22
        },
        {
            -- as_team_icn_team03
            x=2,
            y=50,
            width=306,
            height=22,

        },
        {
            -- as_team_icn_team05
            x=2,
            y=74,
            width=306,
            height=22,

        },
        {
            -- as_team_icn_team02
            x=2,
            y=98,
            width=306,
            height=22,

        },
        {
            -- as_team_icn_team01
            x=2,
            y=122,
            width=306,
            height=22,

        },
        {
            -- as_slide_page_00
            x=2,
            y=146,
            width=176,
            height=32,

        },
        {
            -- item, item box
            x=180,
            y=146,
            width=86,
            height=37,

        },
        {
            -- sell_button
            x=268,
            y=146,
            width=144,
            height=40,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 144,
            sourceHeight = 40
        },
        {
            -- lock
            x=2,
            y=188,
            width=40,
            height=59,

        },
        {
            -- as_team_status
            x=44,
            y=188,
            width=232,
            height=97,

        },
        {
            -- locker_closed
            x=278,
            y=188,
            width=106,
            height=110,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 106,
            sourceHeight = 110
        },
    },
    
    sheetContentWidth = 425,
    sheetContentHeight = 300
}

SheetInfo.frameIndex =
{

    ["as_slide_icn_base"] = 1,
    ["as_slide_icn_show"] = 2,
    ["as_team_icn_team04"] = 3,
    ["as_team_icn_teamsta"] = 4,
    ["as_team_icn_team03"] = 5,
    ["as_team_icn_team05"] = 6,
    ["as_team_icn_team02"] = 7,
    ["as_team_icn_team01"] = 8,
    ["as_slide_page_00"] = 9,
    ["item, item box"] = 10,
    ["sell_button"] = 11,
    ["lock"] = 12,
    ["as_team_status"] = 13,
    ["locker_closed"] = 14,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
