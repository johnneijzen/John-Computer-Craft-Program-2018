--[[
	Version
	0.09 4/11/2024
	Changelog
	0.01 1/20/2017 - Copy my old code
	0.02 1/20/2017 - Added Item Worng Place Checking Code
	0.03 1/20/2017 - Added EnderChest Support Not Tested
	0.04 1/26/2017 - Bug Fixing
	0.05 5/10/2017 - fix Small Mistakes
	0.06 5/11/2017 - Small Speed Tweaks and compacting of code
	0.07 5/24/2021 - English is understandable
	0.08 5/24/2021 - Code Formatting
    0.09 4/11/2024 - Code refactoring and cleanup
	ToDo
	Remove Gravel code from chestDrop since turtle are now non-full blocks so gravel break when it falls on turtle.
	it also break when it falls on chest.
]]
-- Local Variables in My New Program style it now a-z not random
-- Area
local depth = 0
local depthCounter = 0
local length = 0
local lengthCounter = 0
local width = 0
local widthCounter = 0
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
local isBlocked = 0 -- Fixing to Chest Probleem and moving probleem
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
local function checkSlot(slot, emptyMessage, wrongItemMessage)
    if turtle.getItemCount(slot) == 0 then
        print("Slot " .. slot .. " is empty. " .. emptyMessage)
        errorItems = 1
    else
        local itemData = turtle.getItemDetail(slot)
        if itemData.name == "minecraft:chest" then
            print("Slot " .. slot .. " contains a chest. " .. wrongItemMessage)
            errorItems = 1
        else
            print("Slot " .. slot .. " contains fuel.")
        end
    end
end

local function check()
    if noFuelNeed == 0 then
        checkSlot(1, "Please place fuel in the first slot.", "Chests are not allowed in this slot. Please move them to slot 3.")
        checkSlot(2, "This slot is empty. If this is a short job, it's okay.", "Chests are not allowed in this slot. Please move them to slot 3.")
    end

    if chest == 0 then
        print("The turtle doesn't have any chests.")
        print("Please place chests in the third slot.")
        errorItems = 1
    else
        print("The turtle has chests or an ender chest.")
    end

    if errorItems == 1 then
        print("Some items are missing. Please check and try again.")
        print("The turtle will recheck in 5 seconds.")
    end
end

-- ItemDump
local function chestDump()
    if turtle.getItemCount(16) > 0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
        repeat -- Better Fix To Gravel Problem. Compacted and Faster and less like to break.
            sleep(0.6) -- make turtle wait for 0.6 second for gravel to fall
            if turtle.detectUp() then -- if there is gravel remove it before placing chest
                turtle.digUp()
                sleep(0.6)
                isBlocked = 1
            else
                isBlocked = 0
            end
        until isBlocked == 0
        if enderChest == 0 then
            turtle.select(3)
            turtle.placeUp()
            chest = chest - 1
            for slot = 4, 16 do
                turtle.select(slot)
                sleep(0.6) -- Small fix for slow pc because i had reports of problems with this
                turtle.dropUp()
            end
            turtle.select(4)
            if chest == 0 then
                print("Out Of Chest")
                os.shutdown()
            end
        else -- Added Support Modded Enderchest
            turtle.select(3)
            turtle.placeUp()
            for slot = 4, 16 do
                turtle.select(slot)
                sleep(0.6) -- Small fix for slow pc because i had reports of problems with this
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

-- Mining Length
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
            if turtle.forward() then -- try to move if turtle can move isBlocked == 0 if cant move then isBlocked 1
                isBlocked = 0
            else
                isBlocked = 1
            end
        until isBlocked == 0
    end
    if turtle.detectUp() then
        turtle.digUp()
    end
    if turtle.detectDown() then
        turtle.digDown()
    end
    lengthCounter = lengthCounter + 1
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
                isBlocked = 0
            else
                isBlocked = 1
            end
        until isBlocked == 0
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
    lengthCounter = 0
    widthCounter = widthCounter + 1
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
    widthCounter = 0
    lengthCounter = 0
    depthCounter = depthCounter + 3
    totalBlocksDone = totalBlocksDone + 3
end

local function firstDig()
    turtle.digDown()
    turtle.down()
    turtle.digDown()
    turtle.down()
    turtle.digDown()
    widthCounter = 0
    lengthCounter = 0
    depthCounter = depthCounter + 3
    totalBlocksDone = totalBlocksDone + 3
end

local function main()
    repeat
        mineLong()
        refuel()
        chestDump()
        if lengthCounter == length then
            process = totalBlocksDone / totalBlocks * 100
            processRaw = totalBlocks - totalBlocksDone
            print("How Much Is Done: " .. math.floor(process + 0.5) .. " %")
            print("Total Blocks Left Is " .. processRaw)
            if widthCounter == width then
                if depthCounter < depth then
                    mineDeep()
                end
            else
                mineWide()
            end
        end
        if lengthCounter == length and widthCounter == width and depthCounter >= depth then
            doneDig = 1
        end
    until doneDig == 1
    print("Turtle is Done")
end

local function start()
    print("Welcome to the Excavation Turtle Program.")
    print("Please ensure that Slot 1 and Slot 2 contain fuel, and Slot 3 contains a chest.")
    local correct
    repeat
        print("Enter the desired length:")
        length = tonumber(read()) - 1
        print("Enter the desired width:")
        width = tonumber(read()) - 1
        print("Enter the desired depth:")
        depth = tonumber(read())
        print("You've entered: Length = " .. (length + 1) .. ", Width = " .. (width + 1) .. ", Depth = " .. depth)
        print("If this is correct, type 'Y'. If not, type 'N'.")
        correct = read()
    until correct:lower() == 'n'
    totalBlocks = (width + 1) * (length + 1) * depth
    print("The total number of blocks to mine is " .. totalBlocks)
    coalNeeded = totalBlocks / 3 / 80
    if turtle.getFuelLevel() == "unlimited" then
        print("Your turtle configuration indicates that no fuel is needed.")
        noFuelNeed = 1
    else
        print("The total amount of coal needed is " .. math.floor(coalNeeded + 0.5))
        sleep(1)
    end
    print("Are you using a modded Enderchest? (Y/N)")
    userInput = read()
    if userInput:lower() == 'y' then
        enderChest = 1
    end
    repeat
        itemCount()
        check()
        if (errorItems ~= 0) then
            sleep(5)
        end
    until errorItems == 0
    if noFuelNeed == 0 then
        if turtle.getFuelLevel() < 120 then
            turtle.select(1)
            turtle.refuel(2)
        end
    end
    print("Do you want to use Redstone as a starting input? (Y/N)")
    print("Note: Redstone input can only be detected from the back of the turtle.")
    starting = read()
    if starting:lower() == 'y' then
        local On = 0
        repeat
            os.pullEvent("redstone")
            if redstone.getInput("back") then
                On = 1
            end
        until On == 1
    end
    print("The turtle will now start!")
    firstDig()
    main()
end

start()
