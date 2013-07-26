module(...)


-- This file is for use with Corona Game Edition
--
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
--
-- Usage example:
--			local zwoptexData = require "ThisFile.lua"
-- 			local data = zwoptexData.getSpriteSheetData()
--			local spriteSheet = sprite.newSpriteSheetFromData( "Untitled.png", data )
--
-- For more details, see http://developer.anscamobile.com/content/game-edition-sprite-sheets
--
function getSpriteSheetData()
-- local screenW, screenH = display.contentWidth, display.contentHeight
--        local centerX = screenW*.5
--        local centerY = screenH*.5
--        print("centerX;",centerX)
    local sheet = {
        frames = {

            {
                name = "01.png",
                spriteColorRect = { x = 0, y = 4,  width = 200, height = 200 },
                textureRect = { x = 2, y = 50, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "02.png",
                spriteColorRect = { x = 0, y = 4, width = 200, height = 200 },
                textureRect = { x = 512, y = 50, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "03.png",
                spriteColorRect = { x = 0, y = 4,  width = 200, height = 200 },
                textureRect = { x = 1024, y = 50, width = 512, height = 436 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "04.png",
                spriteColorRect = { x = 0, y = 4,  width = 200, height = 200 },
                textureRect = { x = 1536, y = 50, width = 512, height = 436 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "05.png",
                spriteColorRect = { x = 0, y = 4,  width = 200, height = 200 },
                textureRect = { x = 2048, y = 50, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "06.png",
                spriteColorRect = { x = 0, y = 4,  width = 200, height = 200 },
                textureRect = { x = 2, y = 562, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "07.png",
                spriteColorRect = { x = 0, y = 4,  width = 200, height = 200 },
                textureRect = { x = 512, y = 562, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "08.png",
                spriteColorRect = { x = 0, y = 4, width = 200, height = 200 },
                textureRect = { x = 1024, y = 562, width = 512, height = 436 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "09.png",
                spriteColorRect = { x = 0, y = 4,   width = 200, height = 200 },
                textureRect = { x = 1536, y = 562, width = 512, height = 436 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "10.png",
                spriteColorRect = { x = 0, y = 4,  width = 200, height = 200 },
                textureRect = { x = 2048, y = 562, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "11.png",
                spriteColorRect = { x = 0, y = 4, width = 200, height = 200 },
                textureRect = { x = 2, y = 1074, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "12.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 436 },
                textureRect = { x = 512, y = 1074, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "13.png",
                spriteColorRect = { x = 0, y = 4, width = 512, height = 436 },
                textureRect = { x = 1024, y = 1074, width = 512, height = 436 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "14.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 436 },
                textureRect = { x = 1536, y = 1074, width = 512, height = 436 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "15.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 436 },
                textureRect = { x = 2048, y = 1074, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },


            {
                name = "16.png",
                spriteColorRect = { x = 0, y = 4, width = 200, height = 200 },
                textureRect = { x = 2, y = 1586, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "17.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 436 },
                textureRect = { x = 512, y = 1586, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "18.png",
                spriteColorRect = { x = 0, y = 4, width = 512, height = 436 },
                textureRect = { x = 1024, y = 1586, width = 512, height = 436 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "19.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 436 },
                textureRect = { x = 1536, y = 1586, width = 512, height = 436 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "20.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 436 },
                textureRect = { x = 2048, y = 1586, width = 512, height = 436 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "21.png",
                spriteColorRect = { x = 0, y = 4, width = 200, height = 200 },
                textureRect = { x = 2, y = 2098, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "22.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 450 },
                textureRect = { x = 512, y = 2098, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "23.png",
                spriteColorRect = { x = 0, y = 4, width = 512, height = 450 },
                textureRect = { x = 1024, y = 2098, width = 512, height = 512 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "24.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 450 },
                textureRect = { x = 1536, y = 2098, width = 512, height = 512 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "25.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 450 },
                textureRect = { x = 2048, y = 2098, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "26.png",
                spriteColorRect = { x = 0, y = 4, width = 200, height = 200 },
                textureRect = { x = 2, y = 2610, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "27.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 450 },
                textureRect = { x = 512, y = 2610, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "28.png",
                spriteColorRect = { x = 0, y = 4, width = 512, height = 450 },
                textureRect = { x = 1024, y = 2610, width = 512, height = 512 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "29.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 450 },
                textureRect = { x = 1536, y = 2610, width = 512, height = 512 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "30.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 450 },
                textureRect = { x = 2048, y = 2610, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },


            {
                name = "31.png",
                spriteColorRect = { x = 0, y = 4, width = 200, height = 200 },
                textureRect = { x = 2, y = 3122, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "32.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 450 },
                textureRect = { x = 512, y = 3122, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "33.png",
                spriteColorRect = { x = 0, y = 4, width = 512, height = 450 },
                textureRect = { x = 1024, y = 3122, width = 512, height = 512 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "34.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 450 },
                textureRect = { x = 1536, y = 3122, width = 512, height = 512 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "35.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 450 },
                textureRect = { x = 2048, y = 3122, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "36.png",
                spriteColorRect = { x = 0, y = 4, width = 200, height = 200 },
                textureRect = { x = 2, y = 3634, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "37.png",
                spriteColorRect = { x = 0, y = 4,width = 512, height = 450 },
                textureRect = { x = 512, y = 3634, width = 512, height = 512 },
                spriteSourceSize = { width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },

            {
                name = "38.png",
                spriteColorRect = { x = 0, y = 4, width = 512, height = 450 },
                textureRect = { x = 1024, y = 3634, width = 512, height = 512 },
                spriteSourceSize ={ width = 350, height = 161 },
                spriteTrimmed = true,
                textureRotated = false
            },


        }
    }

    return sheet
end