--[[
Version
  0.02 5/10/2017
Changelog
  0.01 - Think this Program As FASTER VERSION OF Bridge 2017
  0.02 - Fix Small Bugs
--]]

-- Locals Variables
-- Area
local width = 0
local widthCount = 0
local length = 0
local lengthCount = 0
-- items
local noFuelNeeded = 0 -- Check if turtle is using no fuel config
local itemFuel = turtle.getItemCount(1) -- Fuel Slot 1
local itemFuel1 = turtle.getItemCount(2) -- Fuel Slot 2
local errorItems = 0
-- Others
local currentSlot = 3
local AllowTurtleDig = 0
local RsOrLs = 0


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

-- This Code will Switch Turtle Slot if Currect Slot has zero items and select slot
local function selectBlock()
    repeat
        if turtle.getItemCount(currentSlot) == 0 then
            currentSlot = currentSlot + 1
        elseif turtle.getItemCount(currentSlot) > 0 then
            currentSlot = currentSlot
        else
            os.shutdown()
        end
        turtle.select(currentSlot)
    until turtle.getItemCount(currentSlot) > 0
end

-- Build/Place Block
local function build()
    if AllowTurtleDig == 1 then
        if turtle.detectDown() then
            turtle.digDown()
        end
    end
    selectBlock()
    turtle.placeDown()
end

-- modifyed forward this can destory block in way if AllowTurtleDig is 1
local function forward()
    if AllowTurtleDig == 1 then
        if turtle.detect() then
            turtle.dig()
        end
    end
    turtle.forward()
end

local function main()
    repeat
        repeat
            refuel()
            build()
            forward()
            lengthCount = lengthCount + 1
        until length == lengthCount
        widthCount = widthCount + 1
        if width ~= widthCount then
            refuel()
            lengthCount = 0
            if RsOrLs == 0 then
                turtle.turnRight()
                turtle.forward()
                turtle.turnRight()
                turtle.forward()
                RsOrLs = 1
            else
                turtle.turnLeft()
                turtle.forward()
                turtle.turnLeft()
                turtle.forward()
                RsOrLs = 0
            end
        end
    until width == widthCount and length == lengthCount
end

local function start()
    print("Welcome To John Bridge 2017 No Side Walls Program")
    print("Please Input Your Fuel In Slot 1 and Slot 2(Optional) Slot 3-15 Building Blocks")
    print("Please Enter Brige Size")
    width = tonumber(read())
    print("Please Input How Far Brige Will Be")
    length = tonumber(read())
    print("Allow Turtle to Dig Block 1(True) or 0(False)")
    AllowTurtleDig = tonumber(read())
    print("Turtle Will Make " .. length .. " Long Brige" .. " with width of " .. width)
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