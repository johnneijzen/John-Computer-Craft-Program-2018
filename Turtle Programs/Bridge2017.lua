--[[ 
    Version
    0.06 11/04/2024
    Changelog
    0.01 - First Draft
    0.02 - Small Changes
    0.03 - Improved readability
    0.04 - Code formatting
    0.05 - 11/04/2024 - Refactor code to allow switch slot for cobble without having to check for 8 or greater items
    0.06 - code refactoring
]]

-- Local Variables
local noFuelNeeded = 0 -- Check if turtle is using no fuel config
local itemFuel = 0 -- Fuel Slot 1
local itemFuel2 = 0 -- Fuel Slot 2
local distance = 0 -- Distance to dig
local distanceCount = 0 -- Count the distance
local errorItems = 0
local bridgeSize = 0 -- Bridge Width
local currentSlot = 3 -- For checking cobble
local way = 0

-- Function to switch to next slot if cobble slot is empty
local function switchSlot()
    currentSlot = currentSlot + 1
    turtle.select(currentSlot)
end

-- Function to check for fuel and print error message if fuel is missing
local function checkFuel()
    if noFuelNeeded == 0 then
        if itemFuel == 0 and itemFuel2 == 0 then
            print("Missing Fuel in Slot 1 or Slot 2")
            errorItems = 1
        else
            errorItems = 0
        end
    end
end

-- Function to update itemFuel and itemFuel2 counts
local function itemCount()
    itemFuel = turtle.getItemCount(1)
    itemFuel2 = turtle.getItemCount(2)
end

-- Function to refuel turtle
local function refuel()
    if noFuelNeeded == 0 then
        repeat
            itemCount() -- Update item counts
            if turtle.getFuelLevel() < 120 then
                if itemFuel > 0 then
                    turtle.select(1)
                    turtle.refuel(1)
                    itemFuel = itemFuel - 1
                elseif itemFuel2 > 0 then
                    turtle.select(2)
                    turtle.refuel(1)
                    itemFuel2 = itemFuel2 - 1
                else
                    print("Out of fuel")
                    os.shutdown()
                end
            end
        until turtle.getFuelLevel() >= 120
    end
end

-- Function to place blocks on the right side
local function placeBlocksRight()
    turtle.forward()
    turtle.down()
    switchSlot()
    for _ = 1, bridgeSize do
        turtle.placeDown()
        turtle.forward()
        switchSlot()
    end
    turtle.up()
    turtle.turnRight()
end

-- Function to place blocks on the left side
local function placeBlocksLeft()
    turtle.forward()
    turtle.down()
    switchSlot()
    turtle.turnLeft()
    for _ = 1, bridgeSize do
        turtle.placeDown()
        turtle.forward()
        switchSlot()
    end
    turtle.up()
    turtle.turnRight()
end

-- Main function to construct the bridge
local function constructBridge()
    refuel()
    turtle.select(3) -- Select cobble slot
    repeat
        refuel()
        turtle.select(currentSlot)
        if way == 0 then
            placeBlocksRight()
            way = 1
        else
            placeBlocksLeft()
            way = 0
        end
        distanceCount = distanceCount + 1
    until distance == distanceCount
end

-- Function to start the program
local function start()
    print("Welcome To John's Bridge Program")
    print("This Program Will Make A Bridge From 3 Wide to 5 Wide")
    print("Please Enter Bridge Size (3 to 5):")
    bridgeSize = tonumber(read())
    print("Please Input Your Fuel In Slot 1 and Slot 2 (Optional). Slot 3-15 Will Be Used For Building Blocks.")
    print("Please Input The Length Of The Bridge:")
    distance = tonumber(read())
    print("Turtle Will Make " .. distance .. " Long Bridge")
    if turtle.getFuelLevel() == "unlimited" then
        noFuelNeeded = 1
    end
    repeat
        itemCount()
        checkFuel()
        sleep(5)
    until errorItems == 0
    constructBridge()
end

start()
