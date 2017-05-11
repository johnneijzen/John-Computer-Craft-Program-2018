--[[
Version
	0.06 5/10/2017
Changelog
	0.01 1/20/2017 -- Copy my old code
	0.02 1/20/2017 -- Added Item Worng Place Checking Code
	0.03 1/20/2017 -- Added EnderChest Support Not Tested
	0.04 1/26/2017 -- Bug Fixing
	0.05 5/10/2017 -- fix Small Mistakes
	0.06 5/11/2017 -- Small Speed Tweaks and compacting of code
ToDo
    Remove Gravel code from chestDrop since turtle are now non-full blocks so gravel break when it falls on turtle.
    it also break when it falls on chest.
]]

-- Local Variables in My New Program style it now a-z not random
-- Area
local deep = 0
local deepCount = 0
local long = 0
local longCount = 0
local wide = 0
local wideCount = 0
-- Misc
local corrent
local coalNeeded
local itemData
local process
local processRaw
local starting
local totalBlocks = 0
local totalBlocksDone = 0
local userInput
-- Inventory
local chest = 0
local enderChest = 0
local errorItems = 0
local fuelCount = 0
local fuelCount1 = 0
local noFuelNeed = 0 -- This is 0 if fuel is needed and 1 is not needed
-- Dig Misc
local blocked = 0 -- Fixing to Chest Probleem and moving probleem
local LorR = 0 -- Left or Right This is for Wide Code
local doneDig = 0

-- ItemCheck
local function itemCount()
	fuelCount = turtle.getItemCount(1)
	fuelCount1 = turtle.getItemCount(2)
	chest = turtle.getItemCount(3)
	errorItems = 0
end

-- Checking
local function check()
	if noFuelNeed == 0 then
		if fuelCount == 0 then
			print("Turtle has no fuel")
			print("Put fuel in First and Second slot")
			errorItems = 1
		else
			itemData = turtle.getItemDetail(1)
			if itemData.name == "minecraft:chest" then
				print("Chest are in wrong slot please move them to slot 3")
				errorItems = 1
			else
				print("Turtle has Fuel Slot 1")
			end
		end
		if fuelCount1 == 0 then
			print("Turtle has no extra fuel but if is short job it okey")
		else
			itemData = turtle.getItemDetail(2)
			if itemData.name == "minecraft:chest" then
				print("Chest are in wrong slot please move them to slot 3")
				errorItems = 1
			else
				print("Turtle has Fuel Slot 2")
			end
		end
	end
	if chest == 0 then
		print("No chest in Turtle")
		print("Put chest in Thrid slot")
		errorItems = 1
	else
		print("Turtle has chest or Ender Chest")
	end
	if errorItems == 1 then
		print("Items are missing please try again")
		print("Turtle will recheck in 5 sec")
	end 
end

-- ItemDump
local function chestDump()
	if turtle.getItemCount(16)> 0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
		repeat -- Better Fix To Gravel Problem. Compacted and Faster and less like to break.
			sleep(0.6) -- I let turtle wait for 0.6 second for gravel to fall
			if turtle.detectUp() then -- if there is gravel remove it before placing chest
				turtle.digUp()
				sleep(0.6)
				blocked = 1
			else
				blocked = 0
			end
		until blocked == 0
		if enderChest == 0 then
			turtle.select(3)
			turtle.placeUp()
			chest = chest - 1
			for slot = 4, 16 do
				turtle.select(slot)
				sleep(0.6) -- Small fix for slow pc because i had people problem with this
				turtle.dropUp()
			end
			turtle.select(4)
			if chest == 0 then
				print("Out Of Chest")
				os.shutdown()
			end
		else -- Added Support Modded EnderChest
			turtle.select(3)
			turtle.placeUp()
			for slot = 4, 16 do
				turtle.select(slot)
				sleep(0.6) -- Small fix for slow pc because i had people problem with this
				turtle.dropUp()
			end
			turtle.select(3)
			turtle.digUp()
			turtle.select(4)
		end
	end
end

-- Refuel
local function refuel()
	if noFuelNeed == 0 then
		repeat
			if turtle.getFuelLevel() < 120 then
				if fuelCount > 0 then
					turtle.select(1)
					turtle.refuel(1)
					fuelCount = fuelCount - 1
				elseif fuelCount1 > 0 then
					turtle.select(2)
					turtle.refuel(1)
					fuelCount1 = fuelCount1 - 1
				else
					print("Out Of Fuel")
					os.shutdown()
				end
			end
		until turtle.getFuelLevel() >= 120
	end
end

-- Mining Lenght
local function mineLong()
	if turtle.detect() then
		turtle.dig()
	end
	if not turtle.forward() then
		repeat
			if turtle.detect() then -- First check if there is block front if there is dig if not next step.
				turtle.dig()
				sleep(0.6)
			end
			if turtle.forward() then -- try to move if turtle can move blocked == 0 if cant move then blocked 1
				blocked = 0
			else
				blocked = 1
			end
		until blocked == 0
	end
	if turtle.detectUp() then
		turtle.digUp()
	end
	if turtle.detectDown() then
		turtle.digDown()
	end
	longCount = longCount + 1
	totalBlocksDone = totalBlocksDone + 3
end

-- Mining Width
local function mineWide()
	if LorR == 0 then
		turtle.turnRight()
	else
		turtle.turnLeft()
	end
	if turtle.detect() then
		turtle.dig()
	end
	if not turtle.forward() then
		repeat
			if turtle.detect() then
				turtle.dig()
				sleep(0.6)
			end
			if turtle.forward() then
				blocked = 0
			else
				blocked = 1
			end
		until blocked == 0
	end
	if turtle.detectUp() then
		turtle.digUp()
	end
	if turtle.detectDown() then
		turtle.digDown()
	end
	if LorR == 0 then
		turtle.turnRight()
		LorR = 1
	else
		turtle.turnLeft()
		LorR = 0
	end
	longCount = 0
	wideCount = wideCount + 1
	totalBlocksDone = totalBlocksDone + 3
end

-- Mine Deep
local function mineDeep()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.turnRight()
	turtle.turnRight()
	wideCount = 0
	longCount = 0
	deepCount = deepCount + 3
	totalBlocksDone = totalBlocksDone + 3
end

local function firstDig()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	turtle.down()
	turtle.digDown()
	wideCount = 0
	longCount = 0
	deepCount = deepCount + 3
	totalBlocksDone = totalBlocksDone + 3
end

local function main()
	repeat
		mineLong()
		refuel()
		chestDump()
		if longCount == long then
			process = totalBlocksDone / totalBlocks * 100
			processRaw = totalBlocks - totalBlocksDone
			print("How Much Is Done: " .. math.floor(process+0.5) .. " %")
			print("TotalBlocks Still Need To Dig Is " .. processRaw)
			if wideCount == wide then
				if deepCount < deep then
					mineDeep()
				end
			else
				mineWide()
			end
		end
		if longCount == long and wideCount == wide and deepCount >= deep then
			doneDig = 1
		end
	until doneDig == 1
	print("turtle is Done")
end

local function start()
	print("Welcome To Excavation Turtle Program")
	print("Slot 1: Fuel, Slot 2: Fuel, Slot 3: Chest")
	repeat
		print("Whats is Lenght you want")
		long = tonumber(read()-1)
		print("Whats is Width you want")
		wide = tonumber(read()-1)
		print("Whats is Depth You Want")
		deep = tonumber(read())
		print("Is This Corrent Lenght " .. "Lenght = " .. (long + 1) .. " Width = " .. (wide + 1) .. " Depth = " .. (deep))
		print("Type y Or Y if it is correct and if not then n or N")
		corrent = read()
	until correct == N or correct == n
	totalBlocks = (wide + 1) * (long + 1) * deep -- 1 is add because above it removed for wide and long code
	print("Total amount for block to mine is " .. totalBlocks)
	coalNeeded = totalBlocks / 3 / 80
	if turtle.getFuelLevel() == "unlimited" then
		print("Your turtle config does need fuel")
		noFuelNeed = 1
    else
        print("Total amount for Coal needed is " .. math.floor(coalNeeded+0.5))
        sleep(1)
	end
	print("Are you using Modded EnderChest Instead")
	print("Y or N")
	userInput = read()
	if userInput == "Y" or userInput == "y" then
		enderChest = 1
	end
	repeat
		itemCount()
		check()
        if(errorItems ~= 0) then
		    sleep(5)
        end
	until errorItems == 0
	if noFuelNeed == 0 then
		if turtle.getFuelLevel() < 120 then
			turtle.select(1)
			turtle.refuel(2)
		end
	end
	print("Do You Want Redstone as Starting Input")
	print("Note: Redstone Input can only be detect from back turtle")
	print("Y or N")
	starting = read()
	if starting == "Y" or starting == "y" then
        local On = 0
		repeat
			os.pullEvent("redstone") -- Wait For Redstone Input without it break with words Too long without yielding.
			if redstone.getInput("back") then
				On = 1
			end	
		until On == 1
    end
    print("Turtle will now start!")
    firstDig()
    main()
end

start()
