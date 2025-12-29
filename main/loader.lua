-- Giaogui Clean Loader (BOM-SAFE, FINAL)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- ===== SERVICES =====
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

-- ===== DESTROY OLD UI =====
pcall(function()
    CoreGui.GiaoguiUI:Destroy()
end)

-- ===== GLOBAL FLAGS =====
getgenv().Aimlock = false
getgenv().InstaKill = false
getgenv().TPBehind = false

-- =====================================
-- ===== LOAD COMBAT (BOM SAFE) ========
-- =====================================
local COMBAT_URL =
    "https://raw.githubusercontent.com/Giaogui/sakura_test/main/main/features_combat.lua"

local src = game:HttpGet(COMBAT_URL)
assert(type(src) == "string" and #src > 10, "HttpGet failed")

-- 🔥 STRIP UTF-8 BOM (THIS IS THE FIX)
if src:sub(1,3) == "\239\187\191" then
    src = src:sub(4)
end

local fn, err = loadstring(src)
assert(fn, "loadstring failed: " .. tostring(err))

local Combat = fn()
assert(type(Combat) == "table", "Combat module invalid")

warn("Combat module loaded:", Combat)

-- ===============================
-- ===== SAKURA UI =====
-- ===============================
local Gui = Instance.new("ScreenGui", CoreGui)
Gui.Name = "GiaoguiUI"
Gui.ResetOnSpawn = false

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 520, 0, 380)
Main.Position = UDim2.new(0.5, -260, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(20,20,25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(90,90,120)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "Giaogui | Rebuild"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(220,220,255)
Title.TextXAlignment = Enum.TextXAlignment.Left

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -20, 1, -70)
Content.Position = UDim2.new(0, 10, 0, 60)
Content.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", Content)
layout.Padding = UDim.new(0,8)

local function Toggle(text, callback)
    local b = Instance.new("TextButton", Content)
    b.Size = UDim2.new(1, 0, 0, 36)
    b.BackgroundColor3 = Color3.fromRGB(40,40,55)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.Text = text .. " : OFF"
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

    b.MouseButton1Click:Connect(function()
        local state = callback()
        b.Text = text .. " : " .. (state and "ON" or "OFF")
        b.BackgroundColor3 = state and Color3.fromRGB(90,120,255)
            or Color3.fromRGB(40,40,55)
    end)
end

Toggle("Aimlock", Combat.ToggleAimlock)
Toggle("Insta Kill", Combat.ToggleInstaKill)
Toggle("TP Punch", Combat.ToggleTPBehind)

warn("Giaogui UI Loaded")
