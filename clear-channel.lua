-- clears a square channel around the tile selected
args = {...}
width = tonumber(args[1])
height = tonumber(args[2])
depth = tonumber(args[3]) or 1

local help = [====[

clear-channel
=============
Clears a channel around the tile selected by changing all tiles to empty space.

Usage::

    clear-channel [x-radius] [y-radius] [depth]

If no arguments are provided, will channel the highlighted tile only.
``depth`` is optional and defaults to 1.

]====]


pos = copyall(df.global.cursor)
x = pos.x%16
y = pos.y%16

--block = dfhack.maps.ensureTileBlock(pos.x,pos.y,pos.z)
--print(block.tiletype[x][y])
--block.tiletype[x][y] = df.tiletype.OpenSpace

if width and height then
    if depth then
        for iz=pos.z, pos.z-depth, -1 do
            for ix=pos.x-width, pos.x+width, 1 do
                for iy=pos.y-height, pos.y+height, 1 do
                    block = dfhack.maps.ensureTileBlock(ix,iy,iz)
                    block.tiletype[ix%16][iy%16] = df.tiletype.OpenSpace
                end
            end
        end
    else
        for ix=pos.x-width, pos.x+width, 1 do
            for iy=pos.y-height, pos.y+height, 1 do
                block = dfhack.maps.ensureTileBlock(ix,iy,iz)
                block.tiletype[ix%16][iy%16] = df.tiletype.OpenSpace
            end
        end
    end
else
    block = dfhack.maps.ensureTileBlock(pos.x,pos.y,pos.z)
    block.tiletype[x][y] = df.tiletype.OpenSpace
end