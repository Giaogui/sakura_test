-- Giaogui Hub 🌸
-- Rebranded loader.lua (logic unchanged where possible)

getgenv().ToggleUI = "J"

-- Libraries
local BoredLibrary = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Giaogui/sakura_test/main/UILibs/BoredLib_Giaogui.lua"
))()

local DrRayLibrary = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Giaogui/sakura_test/main/UILibs/DrayLib_Giaogui.lua"
))()

-- UI
local MainWindow = DrRayLibrary:Load("Giaogui Hub 🌸","Default")
local HomeTab = DrRayLibrary.newTab("Home","http://www.roblox.com/asset/?id=9405923687")

HomeTab.newLabel("Quick Scripts 🚀")

HomeTab.newButton("Animation Grabber","",function()
    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Giaogui/sakura_test/main/utils/AnimGrabber.lua"
    ))()
end)

HomeTab.newLabel("Giaogui Hub Stuff 🌸")
HomeTab.newButton("GitHub Repository","",function()
    setclipboard("https://github.com/Giaogui/sakura_test")
end)
