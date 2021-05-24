--[[
Version
  0.05 5/24/2021
Changelog
  0.01 - First Draft
  0.02 - Added Support for Bridge Program
  0.03 - Added Support for Bridge No Side Wall Programs
  0.04 - Added Support for Multi Menu and Add Multi Build Program
  9.05 - English is understandable
--]]

local options = {
	"Excavation Program 2017",
	"3x3 Tunnel Program 2017",
	"Strip Mining Program 2017 [WIP]",
	"Bridge Program 2017",
	"Bridge Program with No Side Walls 2017",
    "Next Page",
    "Multi Build Program 2017[WIP]",
    "Back Page"
}

local optionSize = 8
local n = 1
local currentPage = 1

local function runOptions()
	if n == 1 then
		shell.run("john-ComputerCraft-Program/Excavation2017")
	elseif n == 2 then
		shell.run("john-ComputerCraft-Program/Tunnel2017")
	elseif n == 3 then
		shell.run("john-ComputerCraft-Program/StripMining2017")
    elseif n == 4 then
        shell.run("john-ComputerCraft-Program/Bridge2017")
    elseif n == 5 then
        shell.run("john-ComputerCraft-Program/BridgeNoWalls2017")
    elseif n == 7 then
        shell.run("john-ComputerCraft-Program/MultiBuild2017")
	end
end

local function gui()
	while true do
		term.clear()
		term.setCursorPos(1,1)
		for i = 1 , 6 do
            if i + ((currentPage-1) * 6) <= optionSize then
                if n == i + ((currentPage-1)*6) then
                    print("---> ".. options[i + ((currentPage-1)*6)])
                    print("")
                else
                    print("     ".. options[i + ((currentPage-1)*6)])
                    print("")
                end
			end
		end
		local event, key = os.pullEvent("key")
		if key == keys.up and n > 1 + ((currentPage-1)*6) then
			n = n - 1
		elseif key == keys.down and n < 6 + ((currentPage-1)*6) then
            if(n < optionSize) then
			    n = n + 1
            end
		elseif key == keys.enter then
            if n == 6 then
                currentPage = 2
                n = 7
            elseif n == 8 then
                currentPage = 1
                n = 6
            else
			    break
            end
		end 
	end
	runOptions()
end

gui()
