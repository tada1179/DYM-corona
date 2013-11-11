--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:89202bcda1c812f1125e5f4b20ed8d91:1/1$
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
            -- battle_dark
            x=2,
            y=2,
            width=130,
            height=130,

        },
        {
            -- battle_light
            x=134,
            y=2,
            width=130,
            height=130,

        },
        {
            -- commu_dark
            x=2,
            y=134,
            width=130,
            height=130,

        },
        {
            -- commu_light
            x=134,
            y=134,
            width=130,
            height=130,

        },
        {
            -- gacha_dark
            x=2,
            y=266,
            width=130,
            height=130,

        },
        {
            -- gacha_light
            x=134,
            y=266,
            width=130,
            height=130,

        },
        {
            -- store_dark
            x=2,
            y=398,
            width=130,
            height=130,

        },
        {
            -- store_light
            x=134,
            y=398,
            width=130,
            height=130,

        },
        {
            -- team_dark
            x=2,
            y=530,
            width=130,
            height=130,

        },
        {
            -- team_light
            x=134,
            y=530,
            width=130,
            height=130,

        },
    },
    
    sheetContentWidth = 266,
    sheetContentHeight = 665
}

SheetInfo.frameIndex =
{

    ["battle_dark"] = 1,
    ["battle_light"] = 2,
    ["commu_dark"] = 3,
    ["commu_light"] = 4,
    ["gacha_dark"] = 5,
    ["gacha_light"] = 6,
    ["store_dark"] = 7,
    ["store_light"] = 8,
    ["team_dark"] = 9,
    ["team_light"] = 10,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
