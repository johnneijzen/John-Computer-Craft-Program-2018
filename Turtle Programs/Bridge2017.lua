--[[
Version
  0.03 5/24/2021
Changelog
  0.01 - First Draft
  0.02 - Small Changes
  0.03 - English is understandable
--]]

-- Locals Variables
local noFuelNeeded = 0 -- Check if turtle is using no fuel config
local itemFuel = turtle.getItemCount(1) -- Fuel Slot 1
local itemFuel1 = turtle.getItemCount(2) -- Fuel Slot 2
local distance = 0 -- Distance will dig
local distanceCount = 0 -- Count the distance
local errorItems = 0
local bridgeSize = 0 -- Brige Wide
local currentSlot = 3 -- For checking on cobble
local way = 0

local function check()
    if noFuelNeeded == 0 then
        if itemFuel == 0 then
            errorItems = 1
        else
            errorItems = 0
        end
    end
    if errorItems == 1 then
        print("Missing Fuel in Slot 1")
    end
end

local function itemCount()
    itemFuel = turtle.getItemCount(1)
    itemFuel = turtle.getItemCount(2)
end

local function refuel()
    if noFuelNeeded == 0 then
        repeat
            if turtle.getFuelLevel() < 120 then
                if itemFuel > 1 then
                    turtle.select(1)
                    turtle.refuel(1)
                    itemFuel = itemFuel - 1
                    turtle.select(3)
                elseif itemFuel1 > 1 then
                    turtle.select(2)
                    turtle.refuel(1)
                    itemFuel1 = itemFuel1 - 1
                    turtle.select(3)
                else
                    print("out of fuel")
                    os.shutdown()
                end
            end
        until turtle.getFuelLevel() >= 120
    end
end

local function blockPlaceRight()
    turtle.forward()
    turtle.down()
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
    turtle.turnRight()
    turtle.forward()
    turtle.down()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    if bridgeSize == 5 then
        turtle.forward()
        turtle.placeDown()
    end
    if bridgeSize == 5 or bridgeSize == 4 then
        turtle.forward()
        turtle.placeDown()
    end
    turtle.up()
    turtle.placeDown()
    turtle.turnLeft()
end

local function blockPlaceLeft()
    turtle.forward()
    turtle.down()
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
    turtle.turnLeft()
    turtle.forward()
    turtle.down()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    turtle.forward()
    turtle.placeDown()
    if bridgeSize == 5 then
        turtle.forward()
        turtle.placeDown()
    end
    if bridgeSize == 5 or bridgeSize == 4 then
        turtle.forward()
        turtle.placeDown()
    end
    turtle.up()
    turtle.placeDown()
    turtle.turnRight()
end

function main()
    refuel()
    turtle.select(3) -- this is cobble slot select
    repeat
        refuel()
        repeat
            if turtle.getItemCount(currentSlot) <= 8 then -- this code will switch turtle slot when cobble is less than 7
                currentSlot = currentSlot + 1
            elseif turtle.getItemCount(currentSlot) >= 8 then
                currentSlot = currentSlot
            else
                os.shutdown()
            end
        until turtle.getItemCount(currentSlot) >= 8
        turtle.select(currentSlot)
        if way == 0 then
            blockPlaceRight()
            way = 1
        else
            blockPlaceLeft()
            way = 0
        end
        distanceCount = distanceCount + 1
    until distance == distanceCount
end

function start()
    print("Welcome To John's Bridge Program")
    print("This Program Will Make A Brige From 3 Wide to 5 Wide")
    print("Please Enter Brige Size")
    bridgeSize = tonumber(read())
    print("Please Input Your Fuel In Slot 1 and Slot 2(Optional) Slot 3-15 Building Blocks")
    print("Please Input How Long Brige Will Be")
    distance = tonumber(read())
    print("Turtle Will Make " .. distance .. " Long Brige")
    if turtle.getFuelLevel() == "unlimited" then -- just check if config of fuel is to unlimited
        noFuelNeeded = 1
    end
    repeat
        itemCount()
        check()
        sleep(5)
    until errorItems == 0
    main()
end

start()