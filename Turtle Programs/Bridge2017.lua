--[[ 
    Version
    0.08 26/03/2025
    Changelog
    0.01 - First Draft
    0.02 - Small Changes
    0.03 - Improved readability
    0.04 - Code formatting
    0.05 - 11/04/2024 - Refactor code to allow switch slot for cobble without having to check for 8 or greater items
    0.06 - code refactoring
    0.07 - code refactoring
    0.08 - fix random bug in cc:tweaked
]]

-- Local Variables
local isFuelUnlimited = 0
local fuelItemCountSlot1 = 0
local fuelItemCountSlot2 = 0
local bridgeLength = 0
local bridgeLengthCounter = 0
local errorItemCount = 0
local bridgeWidth = 0
local currentBuildingBlockSlot = 3
local direction = 0

-- Function to switch to next slot if cobble slot is empty
local function switchToNextSlot()
    currentBuildingBlockSlot = currentBuildingBlockSlot + 1
    if currentBuildingBlockSlot > 16 then
        currentBuildingBlockSlot = 3 -- Reset to the first block slot
    end
    turtle.select(currentBuildingBlockSlot)
end

-- Function to check for fuel and print error message if fuel is missing
local function checkFuelAvailability()
    if isFuelUnlimited == 0 then
        if fuelItemCountSlot1 == 0 and fuelItemCountSlot2 == 0 then
            print("Missing Fuel in Slot 1 or Slot 2")
            errorItemCount = 1
        else
            errorItemCount = 0
        end
    end
end

-- Function to update fuelItemCountSlot1 and fuelItemCountSlot2 counts
local function updateFuelItemCount()
    fuelItemCountSlot1 = turtle.getItemCount(1)
    fuelItemCountSlot2 = turtle.getItemCount(2)
end

-- Function to refuel turtle
local function refuelTurtle()
    if isFuelUnlimited == 0 then
        repeat
            if turtle.getFuelLevel() < 120 then
                if fuelItemCountSlot1 > 0 then
                    turtle.select(1)
                    turtle.refuel(1)
                    fuelItemCountSlot1 = fuelItemCountSlot1 - 1
                elseif fuelItemCountSlot2 > 0 then
                    turtle.select(2)
                    turtle.refuel(1)
                    fuelItemCountSlot2 = fuelItemCountSlot2 - 1
                else
                    print("Out of fuel")
                    os.shutdown()
                end
            end
        until turtle.getFuelLevel() >= 120
    end
end

-- Function to place blocks on the right side
local function placeBlocksOnRightSide()
    turtle.forward()
    turtle.down()
    switchToNextSlot()
    for _ = 1, bridgeWidth do
        turtle.placeDown()
        turtle.forward()
        switchToNextSlot()
    end
    turtle.up()
    turtle.turnRight()
end

-- Function to place blocks on the left side
local function placeBlocksOnLeftSide()
    turtle.forward()
    turtle.down()
    switchToNextSlot()
    turtle.turnLeft()
    for _ = 1, bridgeWidth do
        turtle.placeDown()
        turtle.forward()
        switchToNextSlot()
    end
    turtle.up()
    turtle.turnRight()
end

-- Main function to construct the bridge
local function constructBridge()
    refuelTurtle()
    turtle.select(3) -- Select cobble slot
    repeat
        refuelTurtle()
        turtle.select(currentBuildingBlockSlot)
        if direction == 0 then
            placeBlocksOnRightSide()
            direction = 1
        else
            placeBlocksOnLeftSide()
            direction = 0
        end
        bridgeLengthCounter = bridgeLengthCounter + 1
    until bridgeLength == bridgeLengthCounter
end

-- Function to start the program
local function startProgram()
    print("Welcome To John's Bridge Program")
    print("This Program Will Make A Bridge From 3 Wide to 5 Wide")
    print("Please Enter Bridge Size (3 to 5):")
    bridgeWidth = tonumber(read())
    print("Please Input Your Fuel In Slot 1 and Slot 2 (Optional). Slot 3-15 Will Be Used For Building Blocks.")
    print("Please Input The Length Of The Bridge:")
    bridgeLength = tonumber(read())
    print("Turtle Will Make " .. bridgeLength .. " Long Bridge")
    if turtle.getFuelLevel() == "unlimited" then
        isFuelUnlimited = 1
    end
    repeat
        updateFuelItemCount()
        checkFuelAvailability()
        sleep(5)
    until errorItemCount == 0
    constructBridge()
end

startProgram()
