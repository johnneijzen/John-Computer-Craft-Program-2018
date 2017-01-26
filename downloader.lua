local function downloadExcavation()
	local download
	local temp
	local file

	download = http.get("https://raw.githubusercontent.com/johnneijzen/John-Computer-Craft-Program-2017/master/Excavation2017.lua")
	temp = download.readAll()
	download.close()

	file = fs.open("john-ComputerCraft-Program/Excavation2017","w")
	file.write(handle)
	file.close()
end

local function downloadTunnel()
	local download
	local temp
	local file

	download = http.get("https://raw.githubusercontent.com/johnneijzen/John-Computer-Craft-Program-2017/master/Turtle%20Programs/Tunnel2017.lua")
	temp = download.readAll()
	download.close()

	file = fs.open("john-ComputerCraft-Program/Tunnel2017","w")
	file.write(handle)
	file.close()
end

local function downloadJohnPrograms()
	local download
	local temp
	local file

	download = http.get("https://raw.githubusercontent.com/johnneijzen/John-Computer-Craft-Program-2017/master/JohnPrograms.lua")
	temp = download.readAll()
	download.close()

	file = fs.open("JohnPrograms","w")
	file.write(handle)
	file.close()
end

local function update()
	downloadExcavation()
	downloadTunnel()
	downloadJohnPrograms()
	shell.run("JohnPrograms")
end


update()

