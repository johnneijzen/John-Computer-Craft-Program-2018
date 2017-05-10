--[[
Version
  0.02 5/10/2017
Changelog
  0.01 - First Draft
  0.02 = Added Support for Bridge Program
--]]

local options = {
	"Excavation Program 2017",
	"Tunnel Program 2017",
	"Strip Mining Program 2017",
	"Bridge Program 2017"
}
local optionSize = 4
local n

local function runOptions()
	if n == 1 then
		shell.run("john-ComputerCraft-Program/Excavation2017")
	elseif n == 2 then
		shell.run("john-ComputerCraft-Program/Tunnel2017")
	elseif n == 3 then
		shell.run("john-ComputerCraft-Program/StripMining2017")
    elseif n == 4 then
        shell.run("john-ComputerCraft-Program/Bridge2017")
	end
end

local function gui()
	n = 1
	while true do
		term.clear()
		term.setCursorPos(1,1)
		for i = 1, optionSize do
			if n==i then
				print("---> "..options[i])
                print("")
			else
				print("     "..options[i])
                print("")
			end
		end
		local event, key = os.pullEvent("key")
		if key == keys.up and n > 1 then
			n = n - 1
		elseif key == keys.down and n < optionSize then
			n = n + 1
		elseif key == keys.enter then
			break
		end 
	end
	runOptions()
end

gui()
