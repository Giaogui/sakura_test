-- Giaogui Hub Loader (WORKING)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local BASE = "https://raw.githubusercontent.com/Giaogui/sakura_test/main"
local UILIB = BASE .. "/UILibs"

local Library = loadstring(game:HttpGet(UILIB .. "/DrayLib_Giaogui.lua"))()

local Window = Library:Load("Giaogui Hub", "Default")
local Home = Window:NewTab("Home")

Home:NewLabel("Giaogui Hub Loaded")

Home:NewButton("Animation Grabber", "Utility", function()
    loadstring(game:HttpGet(BASE .. "/utils/AnimGrabber.lua"))()
end)
