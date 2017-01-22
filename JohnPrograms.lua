local options = {
	"Excavation Program",
	"Tunnel Program"
}
local optionSize = 2
local n
local key

local function runOptions()
	if n == 1 then
		shell.run("john-ComputerCraft-Program/Excavation2017")
	elseif n == 2 then
		shell.run("john-ComputerCraft-Program/Tunnel2017")
	end
end

local function gui()
	n = 1
	while true do
		term.clear()
		term.setcursorpos(0,0)
		for i = 1, optionSize do
			if n==i then
				print("---> "..option[i])
			else
				print("     "..option[i])
			end
		end
		key = os.pullEvent("key")
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