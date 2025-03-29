--[[ 
    Version
    0.15 29/03/2025
    Changelog
    0.15 - Ensure block placement always works by checking and switching slots when needed
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
            return true
        end
    end
    print("Out of building blocks!")
    os.shutdown()
    return false
end

-- Function to ensure a block is available for placement
local function ensureBlockAvailable()
    if turtle.getItemCount(currentBuildingBlockSlot) == 0 then
        switchToNextSlot()
    end
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

-- Function to place a block down
local function placeBlockDown()
    ensureBlockAvailable()
    turtle.placeDown()
end

-- Function to place blocks on one side of the bridge
local function placeBlocks(side)
    moveForward()
    moveDown()
    placeBlockDown()
    moveUp()
    placeBlockDown()
    
    if side == "right" then
        turtle.turnRight()
    else
        turtle.turnLeft()
    end
    
    moveForward()
    moveDown()
    
    for _ = 1, bridgeWidth do
        placeBlockDown()
        moveForward()
    end
    
    placeBlockDown()
    moveUp()
    placeBlockDown()
    
    if side == "right" then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
end

-- Main function to construct the bridge
local function constructBridge()
    refuelTurtle()
    switchToNextSlot()
    repeat
        refuelTurtle()
        if direction == 0 then
            placeBlocks("right")
            direction = 1
        else
            placeBlocks("left")
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
