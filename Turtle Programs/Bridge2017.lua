--[[ 
    Version
    0.14 29/03/2025
    Changelog
    0.09 - rewrite test
    0.10 - fix rewrite code
    0.11 - spacing issues in bridge code
    0.12 - fix refuel and detectDown issues
    0.13 - fix refuel and forward issues
    0.14 - ensure blocks above are removed before moving up/down
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
        while turtle.getFuelLevel() < 180 and turtle.getItemCount(slot) > 0 do
            turtle.select(slot)
            turtle.refuel(1)
        end
    end
    checkFuelAvailability()
    turtle.select(currentBuildingBlockSlot) -- Switch back to building block slot after refueling
end

-- Function to move forward with digging if necessary
local function moveForward()
    while not turtle.forward() do
        turtle.dig()
    end
end

-- Function to move up with block removal
local function moveUp()
    while turtle.detectUp() do
        turtle.digUp()
    end
    turtle.up()
end

-- Function to move down with block removal
local function moveDown()
    while turtle.detectDown() do
        turtle.digDown()
    end
    turtle.down()
end

-- Function to place blocks on the right side
local function placeBlocksToRightSide()
    moveForward()
    moveDown()
    if turtle.getItemCount(currentBuildingBlockSlot) == 0 then
        switchToNextSlot()
    end
    turtle.placeDown()
    moveUp()
    turtle.placeDown()
    turtle.turnRight()
    moveForward()
    moveDown()
    for _ = 1, bridgeWidth do
        turtle.placeDown()
        moveForward()
        if turtle.getItemCount(currentBuildingBlockSlot) == 0 then
            switchToNextSlot()
        end
    end
    turtle.placeDown()
    moveUp()
    turtle.placeDown()
    turtle.turnLeft()
end

-- Function to place blocks on the left side
local function placeBlocksToLeftSide()
    moveForward()
    moveDown()
    if turtle.getItemCount(currentBuildingBlockSlot) == 0 then
        switchToNextSlot()
    end
    turtle.placeDown()
    moveUp()
    turtle.placeDown()
    turtle.turnLeft()
    moveForward()
    moveDown()
    for _ = 1, bridgeWidth do
        turtle.placeDown()
        moveForward()
        if turtle.getItemCount(currentBuildingBlockSlot) == 0 then
            switchToNextSlot()
        end
    end
    turtle.placeDown()
    moveUp()
    turtle.placeDown()
    turtle.turnRight()
end

-- Main function to construct the bridge
local function constructBridge()
    refuelTurtle()
    switchToNextSlot()
    repeat
        refuelTurtle()
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
