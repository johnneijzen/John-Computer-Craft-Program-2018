--[[ 
    Version 
        0.07
    Changelogs
        0.01 Added Support for Excavation2017.lua
             Added Support for Tunnel2017.lua
        0.02 Added Support for StripMining2017.lua
        0.03 Added Pre Support for Bridge2017.lua
        0.05 Fully Added Support for Bridge2017.lua
        0.06 Added Support for BridgeNoWalls2017.lua
        0.07 Added Support for MultiBuild2017.lua
]]--

local download1 = http.get("https://raw.githubusercontent.com/johnneijzen/John-Computer-Craft-Program-2017/master/Turtle%20Programs/Excavation2017.lua")
local download2 = http.get("https://raw.githubusercontent.com/johnneijzen/John-Computer-Craft-Program-2017/master/Turtle%20Programs/Tunnel2017.lua")
local download3 = http.get("https://raw.githubusercontent.com/johnneijzen/John-Computer-Craft-Program-2017/master/Turtle%20Programs/StripMining2017.lua")
local download4 = http.get("https://raw.githubusercontent.com/johnneijzen/John-Computer-Craft-Program-2017/master/Turtle%20Programs/Bridge2017.lua")
local download5 = http.get("https://raw.githubusercontent.com/johnneijzen/John-Computer-Craft-Program-2017/master/Turtle%20Programs/BridgeNoWalls2017.lua")
local download6 = http.get("https://raw.githubusercontent.com/johnneijzen/John-Computer-Craft-Program-2017/master/Turtle%20Programs/MultiBuild2017.lua")
local downloadGUI = http.get("https://raw.githubusercontent.com/johnneijzen/John-Computer-Craft-Program-2017/master/JohnPrograms.lua")

local function downloadExcavation()
    local temp = download1.readAll()
    download1.close()
 
    fs.delete("john-ComputerCraft-Program/Excavation2017") -- To make sure it updates

    local file = fs.open("john-ComputerCraft-Program/Excavation2017","w")
    file.write(temp)
    file.close()
end
 
local function downloadTunnel()
    local temp = download2.readAll()
    download2.close()
 
    fs.delete("john-ComputerCraft-Program/Tunnel2017") -- To make sure it updates

    local file = fs.open("john-ComputerCraft-Program/Tunnel2017","w")
    file.write(temp)
    file.close()
end

local function downloadStripMining()
    local temp = download3.readAll()
    download3.close()
 
    fs.delete("john-ComputerCraft-Program/StripMining2017") -- To make sure it updates

    local file = fs.open("john-ComputerCraft-Program/StripMining2017","w")
    file.write(temp)
    file.close()
end

local function downloadBrige()
    local temp = download4.readAll()
    download4.close()

    fs.delete("john-ComputerCraft-Program/Bridge2017") -- To make sure it updates

    local file = fs.open("john-ComputerCraft-Program/Bridge2017","w")
    file.write(temp)
    file.close()
end

local function downloadBrigeNoWalls()
    local temp = download5.readAll()
    download5.close()

    fs.delete("john-ComputerCraft-Program/BridgeNoWalls2017") -- To make sure it updates

    local file = fs.open("john-ComputerCraft-Program/BridgeNoWalls2017","w")
    file.write(temp)
    file.close()
end

local function downloadMultiBuild()
    local temp = download6.readAll()
    download6.close()

    fs.delete("john-ComputerCraft-Program/MultiBuild2017") -- To make sure it updates

    local file = fs.open("john-ComputerCraft-Program/MultiBuild2017","w")
    file.write(temp)
    file.close()
end

 
local function downloadJohnPrograms()
    local temp = downloadGUI.readAll()
    downloadGUI.close()

    fs.delete("JohnPrograms") -- To make sure it updates

    local file = fs.open("JohnPrograms","w")
    file.write(temp)
    file.close()
end
 
local function update()
    downloadExcavation()
    downloadTunnel()
    downloadStripMining()
    downloadBrige()
    downloadBrigeNoWalls()
    downloadMultiBuild()
    downloadJohnPrograms()
    shell.run("JohnPrograms")
end
 
update()