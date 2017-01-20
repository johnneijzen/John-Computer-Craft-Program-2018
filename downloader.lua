local download
local temp
local file

local function run()
	download = http.get("https://raw.github.com/myName/repo/startup")
	temp = download.readAll()
	download.close()

	file = fs.open("test","w")
	file.write(handle)
	file.close()
end

run()