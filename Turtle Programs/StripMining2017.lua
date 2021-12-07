--[[
	Version
	0.04 5/24/2021
	Changelog
	0.01 - Rewriting.
	0.02 - Code Fixing
	0.03 - English is understandable
	0.04 5/24/2021 - Code Formatting
]]

-- Area
local distance = 0
local distanceApart = 0
local distanceApartCount = 0
local backwardsCount = 0
local forwardsCount = 0
-- Misc
local noFuelNeeded = 0
local LorR = 0 -- if 0 then left if 1 then right
local Mines = 0
local onlight = 0
local missingItems = 0
-- Inventory
local chests = 0
local fuelSlot = 0
local torch = 0

-- ItemCheck
local function itemCount()
    fuelSlot = turtle.getItemCount(1)
    chests = turtle.getItemCount(2)
    torch = turtle.getItemCount(3)
    missingItems = 0
end

-- Checking
local function check()
    if noFuelNeeded == 0 then
        if fuelSlot == 0 then
            print("Turtle has no fuel")
            print("Put fuel in First slot")
            missingItems = 1
        else
            print("Turtle has Fuel")
        end
    end
    if chests == 0 then
        print("No chests in turtle")
        print("Put chests in 1 slot")
        missingItems = 1
    else
        print("Turtle has chests")
    end
    if missingItems == 1 then
        print("Items are missing please try again")
        print("Turtle will recheck in 3 sec")
    end
end

-- Refuel
local function refuel()
    if noFuelNeeded == 0 then
        repeat
            if turtle.getFuelLevel() < 120 then
                if fuelSlot > 0 then
                    turtle.select(1)
                    turtle.refuel(1)
                    fuelSlot = fuelSlot - 1
                else
                    print("out of fuel")
                    os.shutdown()
                end
            end
        until turtle.getFuelLevel() >= 120
    end
end

-- ItemDump
local function chestDump()
    if turtle.getItemCount(16) > 0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
        turtle.digDown()
        turtle.select(2)
        turtle.placeDown()
        chests = chests - 1
        for slot = 5, 16 do
            turtle.select(slot)
            sleep(0.6)-- Small fix for slow pc because i had repots of problems with this
            turtle.dropDown()
        end
        turtle.select(4)
        if chests == 0 then
            print("Out Of chests")
            os.shutdown()
        end
    end
end

local function turnAround()
    turtle.turnLeft()
    turtle.turnLeft()
end

-- Every 8 block it place torch
local function placeTorch()
    if torch > 0 then
        turnAround()
        turtle.select(3)
        turtle.place()
        turnAround()
        torch = torch - 1
        onlight = 0
    end
end

local function dig()
    repeat
        refuel()
        chestDump()
        if turtle.detect() then
            turtle.dig()
        end
        if turtle.forward() then -- sometimes sand and gravel and block and mix-up distance
            forwardsCount = forwardsCount + 1
            onlight = onlight + 1
        end
        if turtle.detectUp() then
            turtle.digUp()
        end
        if onlight == 8 then
            placeTorch()
        end
    until forwardsCount == distance
end

--Back Program
local function back()
    turtle.up()
    turnAround()
    repeat
        if turtle.forward() then -- sometimes sand and gravel and block and mix-up distance
            backwardsCount = backwardsCount + 1
        end
        if turtle.detect() then -- Sometimes sand and gravel can happen and this will fix it
            if backwardsCount ~= distance then
                turtle.dig()
            end
        end
    until backwardsCount == distance
end

-- Multimines Program
local function nextMine()
    if LorR == 1 then
        turtle.turnLeft()
        turtle.down()
    else
        turtle.turnRight()
        turtle.down()
    end
    repeat
        if turtle.detect() then
            turtle.dig()
        end
        if turtle.forward() then
            distanceApartCount = distanceApartCount + 1
        end
        if turtle.detectUp() then
            turtle.digUp()
        end
    until distanceApartCount == distanceApart
    if LorR == 1 then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
end

-- Reset
local function reset()
    backwardsCount = 0
    forwardsCount = 0
    distanceApartCount = 0
    onlight = 0
end

local function main()
    repeat
        dig()
        back()
        reset()
        Mines = Mines - 1
    until Mines == 0
    print("Turtle is done")
end

-- Starting
local function start()
    print("Welcome to John's Mining Turtle Program")
    print("Slot 1: Fuel, Slot 2: Chests, (Optional Slot 3: Torchs)")
    print("Note: turtle will still work when there is no more torchs")
    print("How many block long will these mines be?")
    distance = tonumber(read())
    print("Left or Right")
    print("0 = Left and 1 = Right")
    LorR = tonumber(read())
    print("How many mines: ")
    Mines = tonumber(read())
    print("Distance Apart from each Mine")
    distanceApart = tonumber(read())
    distanceApart = distanceApart + 1
    if turtle.getFuelLevel() == "unlimited" then
        print("Your turtle config shows you do not need fuel")
        noFuelNeed = 1
    end
    repeat
        itemCount()
        check()
        sleep(3)
    until missingItems == 0
    main()
end

start()
