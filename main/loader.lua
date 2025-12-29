-- Giaogui Clean Loader (Stage 1)

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer

-- ===== DESTROY OLD UI =====
pcall(function()
    CoreGui.GiaoguiUI:Destroy()
end)

-- ===== GLOBAL FLAGS (ALL OFF BY DEFAULT) =====
getgenv().Aimlock = false
getgenv().InstaKill = false
getgenv().TPBehind = false

-- ===== LOAD FEATURES =====
local Combat = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Giaogui/sakura_test/main/features_combat.lua"
))()
warn("Combat module loaded:", Combat)

-- ===== MODERN SAKURA-STYLE UI =====

local Gui = Instance.new("ScreenGui", CoreGui)
Gui.Name = "GiaoguiUI"
Gui.ResetOnSpawn = false

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 520, 0, 380)
Main.Position = UDim2.new(0.5, -260, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Name = "Main"

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(90, 90, 120)
Stroke.Thickness = 1.2

-- ===== TITLE =====
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "Giaogui | Rebuild"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.TextXAlignment = Left

-- ===== TAB BUTTONS =====
local Tabs = Instance.new("Frame", Main)
Tabs.Size = UDim2.new(0, 140, 1, -70)
Tabs.Position = UDim2.new(0, 10, 0, 60)
Tabs.BackgroundTransparency = 1

local TabLayout = Instance.new("UIListLayout", Tabs)
TabLayout.Padding = UDim.new(0, 6)

-- ===== CONTENT =====
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -170, 1, -70)
Content.Position = UDim2.new(0, 160, 0, 60)
Content.BackgroundTransparency = 1

-- ===== COMBAT TAB =====
local CombatTab = Instance.new("Frame", Content)
CombatTab.Size = UDim2.new(1, 0, 1, 0)
CombatTab.BackgroundTransparency = 1
CombatTab.Visible = true

local CombatLayout = Instance.new("UIListLayout", CombatTab)
CombatLayout.Padding = UDim.new(0, 8)

-- ===== HELPERS =====
local function CreateTabButton(name, onClick)
    local b = Instance.new("TextButton", Tabs)
    b.Size = UDim2.new(1, 0, 0, 36)
    b.Text = name
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(220,220,220)
    b.BackgroundColor3 = Color3.fromRGB(35,35,45)
    b.BorderSizePixel = 0

    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 8)

    b.MouseButton1Click:Connect(onClick)
    return b
end

local function CreateToggle(parent, text, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -10, 0, 36)
    b.BackgroundColor3 = Color3.fromRGB(40,40,55)
    b.BorderSizePixel = 0
    b.Text = text .. " : OFF"
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.fromRGB(255,255,255)

    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 8)

    b.MouseButton1Click:Connect(function()
        local state = callback()
        b.Text = text .. " : " .. (state and "ON" or "OFF")
        b.BackgroundColor3 = state
            and Color3.fromRGB(90,120,255)
            or Color3.fromRGB(40,40,55)
    end)
end

-- ===== TAB LOGIC =====
CreateTabButton("Combat", function()
    CombatTab.Visible = true
end)

-- ===== COMBAT TOGGLES =====
CreateToggle(CombatTab, "Aimlock", Combat.ToggleAimlock)
CreateToggle(CombatTab, "Insta Kill", Combat.ToggleInstaKill)
CreateToggle(CombatTab, "TP Punch", Combat.ToggleTPBehind)

warn("Giaogui UI Loaded (Sakura Style)")
