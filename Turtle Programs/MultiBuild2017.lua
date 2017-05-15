--[[
Version
  0.02 5/14/2017
Changelog
  0.02 - More Writing
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
-- Program Variables
local itemFuel = 0 -- Fuel Slot 1
local itemFuel1 = 0 -- Fuel Slot 2
local buildBlocksSlot = 3
local errorItems = 0
-- Display Variables
local n = 1
local optionSize = 5
local selectedOption

local options = {
    "Fill",
    "Cube",
    "Circle",
    "Square in Square Upwards",
    "Square in Square Downwards"
}

local function itemCount()
    itemFuel = turtle.getItemCount(1)
    itemFuel = turtle.getItemCount(2)
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

local function fill()

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
    print("Running Options List: ")
    sleep(1)
    selectedOption = display()
    if selectedOption == 1 then
        print("Enter The Lenght: ")
        length = tonumber(read())
        print("Enter The Width: ")
        width = tonumber(read())
        fill()
    elseif selectedOption == 2 then
        cube()
    elseif selectedOption == 3 then
        circle()
    elseif selectedOption == 4 then
        squareInSquareUpwards()
    elseif selectedOption == 5 then
        squareInSquareDownwards()
    end

end

start()