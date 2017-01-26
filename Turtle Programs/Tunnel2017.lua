--[[
Version
    0.02 - 1/26/2017
Changelog
    0.01 - 1/21/2017
    0.02 - 1/26/2017 Bug Fixing
]]--

-- Locals Variables
local noFuelNeeded = 0 -- Check if turtle is using no fuel config
local itemFuel = 0 -- Fuel Slot 1
local itemFuel1 = 0 -- Fuel Slot 2
local chest = 0 -- Chest Slot 3
local distance = 0 -- Distance will dig
local distanceCount = 0 -- Count the distance
local errorItems = 0

-- itemCheck
local function itemCount()
    itemFuel = turtle.getItemCount(1)
    itemFuel1 = turtle.getItemCount(2)
    chest = turtle.getItemCount(3)
    errorItems = 0
end

-- Checking
local function checking()
    if noFuelNeed == 0 then
        if fuelCount == 0 then
            print("Turtle has no fuel")
            print("Put fuel in First and Second slot")
            errorItems = 1
        else
            itemData = turtle.getItemDetail(1)
            if itemData.name == "minecraft:chest" then
                print("Worng Slot Please Move to 3rd slot")
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
                print("Worng Slot Please Move to 3rd slot")
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
    end
    if errorItems == 1 then
        print("Items are missing please try again")
        print("Turtle will recheck in 5 sec")
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

local function dig()
    turtle.dig()
    turtle.forward()
    turtle.turnLeft()
    turtle.dig()
    turtle.digUp()
    turtle.up()
    turtle.dig()
    turtle.digUp()
    turtle.up()
    turtle.dig()
    turtle.turnRight()
    turtle.turnRight()
    turtle.dig()
    turtle.down()
    turtle.dig()
    turtle.down()
    turtle.dig()
    turtle.turnLeft()
end

local function chestDump()
    if turtle.getItemCount(16)> 0 then -- If slot 16 in turtle has item slot 4 to 16 will go to chest
        if Chest ~= 0 then
            turtle.select(3)
            turtle.digDown()
            turtle.placeDown()
            for slot = 4, 16 do
                turtle.select(slot)
                sleep(0.6) -- Small fix for slow pc because i had people problem with this
                turtle.dropDown()
            end
        turtle.select(4)
        else
            print("Out Of Chest")
            os.shutdown()
        end
    end
end

local function tunnel()
    repeat
        refuel()
        dig()
        chestDump()
        distanceCount = distanceCount + 1
    until distance == distanceCount
end

local function start()
    print("Welcome To John Tunnel Program")
    print("This 3x3 Tunnel Program 4x4 is coming soon after this one is done")
    print("Please Input Your Fuel In Slot 1 and Slot 2(Optional) and Chest in Slot 3")
    print("Please Input Your Distance You Want Turtle To Dig")
    distance = tonumber(read())
    print("Turtle Will Dig " .. distance .. " Long")
    if turtle.getFuelLevel() == "unlimited" then -- just check if config of fuel is to unlimited
        noFuelNeeded = 1
    end
    repeat
        itemCount()
        checking()
        sleep(5)
    until errorItems == 0
    tunnel()
end

start()
