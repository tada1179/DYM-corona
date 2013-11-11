--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:e0410a784a74ae1bc99a04020c2531e1:1/1$
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
            -- dark
            x=2,
            y=2,
            width=128,
            height=128,

        },
        {
            -- earth
            x=132,
            y=2,
            width=128,
            height=128,

        },
        {
            -- fire
            x=262,
            y=2,
            width=128,
            height=128,

        },
        {
            -- light
            x=392,
            y=2,
            width=128,
            height=128,

        },
        {
            -- water
            x=522,
            y=2,
            width=128,
            height=128,

        },
        {
            -- white
            x=652,
            y=2,
            width=128,
            height=128,

        },
    },
    
    sheetContentWidth = 782,
    sheetContentHeight = 132
}

SheetInfo.frameIndex =
{

    ["dark"] = 1,
    ["earth"] = 2,
    ["fire"] = 3,
    ["light"] = 4,
    ["water"] = 5,
    ["white"] = 6,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
