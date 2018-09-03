--[[
Version
  0.03 9/3/2018
Changelog
  0.03 - Fix Fill Function
TODO
  Make the 5 modes work
  fill aka 1 layer
  cube
  circle
  square in square upwards
  square in square downwards
--]]


-- local Variables
-- Area Variables
local width = 0
local widthCount = 0
local length = 0
local lengthCount = 0
local height = 0
local heightCount = 0
-- Program Variables
local itemFuel = 0 -- Fuel Slot 1
local itemFuel2 = 0 -- Fuel Slot 2
local noFuelNeeded = 0 -- This is 0 if fuel is needed and 1 is not needed
local buildBlocksSlot = 3
local errorItems = 1
-- Display Variables
local n = 1
local optionSize = 5
local selectedOption
-- Misc
local AllowTurtleDig = 1
local RsOrLs = 0

local options = {
    "Fill",
    "Cube",
    "Circle",
    "Square in Square Upwards",
    "Square in Square Downwards"
}

local function itemCount()
    itemFuel = turtle.getItemCount(1)
    itemFuel2 = turtle.getItemCount(2)
end

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

local function selectBuildBlocks()
    repeat
        if turtle.getItemCount(buildBlocksSlot) == 0 then
            buildBlocksSlot = buildBlocksSlot + 1
        elseif turtle.getItemCount(buildBlocksSlot) > 0 then
            buildBlocksSlot = buildBlocksSlot
        else
            os.shutdown()
        end
        turtle.select(buildBlocksSlot)
    until turtle.getItemCount(buildBlocksSlot) > 0
end

-- Build/Place Block
local function placeDown()
    if AllowTurtleDig == 1 then
        if turtle.detectDown() then
            turtle.digDown()
        end
    end
    selectBuildBlocks()
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

local function fill()
    repeat
        repeat
            refuel()
            placeDown()
            forward()
            lengthCount = lengthCount + 1
        until length == lengthCount
        if width ~= widthCount then
            refuel()
            lengthCount = 0
            if RsOrLs == 0 then
                placeDown()
                turtle.turnRight()
                turtle.forward()
                placeDown()
                turtle.turnRight()
                RsOrLs = 1
            else
                placeDown()
                turtle.turnLeft()
                turtle.forward()
                placeDown()
                turtle.turnLeft()
                RsOrLs = 0
            end
          widthCount = widthCount + 1
        end
    until width == widthCount and length == lengthCount
end

local function cube()

end

local function circle()

end

local function squareInSquareUpwards()

end

local function squareInSquareDownwards()

end

local function display()
    while true do
        term.clear()
        term.setCursorPos(1,1)
        for i = 1, optionSize do
            if n==i then
                print("---> "..options[i])
                print("")
            else
                print("     "..options[i])
                print("")
            end
        end
        local event, key = os.pullEvent("key")
        if key == keys.up and n > 1 then
            n = n - 1
        elseif key == keys.down and n < optionSize then
            n = n + 1
        elseif key == keys.enter then
            break
        end
    end
    return n
end

local function start()
    print("Welcome to Multi Build Program")
    print("Allow Turtle To Replace Blocks and Destory Blocks: 1(True) or 0(False)")
    print("Recommend true but false is faster since it wont replace blocks or example when half it is already build")
    AllowTurtleDig = tonumber(read())
    if turtle.getFuelLevel() == "unlimited" then
      noFuelNeeded = 1
    end
    repeat
      itemCount()
      check()
    until errorItems == 0
    print("Running Options List: ")
    selectedOption = display()
    if selectedOption == 1 then
        print("Enter The Lenght: ")
        length = (tonumber(read()) - 1)
        print("Enter The Width: ")
        width = (tonumber(read()) - 1)
        fill()
    elseif selectedOption == 2 then
        print("Enter The Lenght: ")
        length = tonumber(read())
        print("Enter The Width: ")
        width = tonumber(read())
        print("Enter The Height ")
        height = tonumber(read())
        cube()
    elseif selectedOption == 3 then

        circle()
    elseif selectedOption == 4 then
        print("Enter The Lenght: ")
        length = tonumber(read())
        print("Enter The Width: ")
        width = tonumber(read())
        print("Enter The Height ")
        height = tonumber(read())
        squareInSquareUpwards()
    elseif selectedOption == 5 then
        print("Enter The Lenght: ")
        length = tonumber(read())
        print("Enter The Width: ")
        width = tonumber(read())
        print("Enter The Height ")
        height = tonumber(read())
        squareInSquareDownwards()
    end

end

start()
