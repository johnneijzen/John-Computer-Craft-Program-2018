--[[ 
    Version
    0.11 26/03/2025
    Changelog
    0.01 - First Draft
    0.02 - Small Changes
    0.03 - Improved readability
    0.04 - Code formatting
    0.05 - 11/04/2024 - Refactor code to allow switch slot for cobble without having to check for 8 or greater items
    0.06 - code refactoring
    0.07 - code refactoring
    0.08 - fix random bug in cc:tweaked
    0.09 - rewrite test
    0.10 - fix rewrite code
    0.11 - spacing issues in bridge code
]]

-- Local Variables
local isFuelUnlimited = false
local bridgeLength = 0
local bridgeWidth = 0
local bridgeLengthCounter = 0
local currentBuildingBlockSlot = 3
local direction = 0

-- Function to switch to a non-empty building block slot
local function switchToNextSlot()
    for slot = 3, 16 do
        if turtle.getItemCount(slot) > 0 then
            turtle.select(slot)
            currentBuildingBlockSlot = slot
            return
        end
    end
    print("Out of building blocks!")
    os.shutdown()
end

-- Function to check for fuel
local function checkFuelAvailability()
    if not isFuelUnlimited and turtle.getFuelLevel() == 0 then
        print("Out of fuel!")
        os.shutdown()
    end
end

-- Function to refuel the turtle
local function refuelTurtle()
    if isFuelUnlimited then return end
    
    for slot = 1, 2 do
        if turtle.getFuelLevel() < 120 and turtle.getItemCount(slot) > 0 then
            turtle.select(slot)
            turtle.refuel(1)
        end
    end
    checkFuelAvailability()
end

-- Function to place blocks on the right side
local function placeBlocksToRightSide()
    turtle.forward()
    turtle.down()
    if turtle.getItemCount(currentBuildingBlockSlot) == 0 then
        switchToNextSlot()
    end
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
    turtle.turnRight()
    turtle.forward()
    turtle.down()
    for _ = 1, bridgeWidth do
        turtle.placeDown()
        turtle.forward()
        if turtle.getItemCount(currentBuildingBlockSlot) == 0 then
            switchToNextSlot()
        end
    end
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
    turtle.turnLeft()
end

-- Function to place blocks on the left side
local function placeBlocksToLeftSide()
    turtle.forward()
    turtle.down()
    if turtle.getItemCount(currentBuildingBlockSlot) == 0 then
        switchToNextSlot()
    end
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
    turtle.turnLeft()
    turtle.forward()
    turtle.down()
    for _ = 1, bridgeWidth do
        turtle.placeDown()
        turtle.forward()
        if turtle.getItemCount(currentBuildingBlockSlot) == 0 then
            switchToNextSlot()
        end
    end
    turtle.placeDown()
    turtle.up()
    turtle.placeDown()
    turtle.turnRight()
end

-- Main function to construct the bridge
local function constructBridge()
    refuelTurtle()
    switchToNextSlot()
    repeat
        if direction == 0 then
            placeBlocksToRightSide()
            direction = 1
        else
            placeBlocksToLeftSide()
            direction = 0
        end
        bridgeLengthCounter = bridgeLengthCounter + 1
    until bridgeLengthCounter == bridgeLength
end

-- Function to start the program
local function startProgram()
    print("Welcome To John's Bridge Program")
    print("This Program Will Make A Bridge From 3 Wide to 5 Wide")
    print("Please Enter Bridge Width (3 to 5):")
    bridgeWidth = tonumber(read())
    print("Please Enter The Length Of The Bridge:")
    bridgeLength = tonumber(read())
    print("Turtle Will Build A " .. bridgeLength .. " Long Bridge")
    isFuelUnlimited = turtle.getFuelLevel() == "unlimited"
    constructBridge()
end

startProgram()
