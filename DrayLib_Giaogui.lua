-- FIXED DrayLib with returned API (restored behavior)

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local Library = {}
local WindowGui
local TabsFolder

-- ===== UI CREATION =====
WindowGui = Instance.new("ScreenGui")
WindowGui.Name = "DrRay"
WindowGui.Parent = CoreGui

local Main = Instance.new("Frame", WindowGui)
Main.Size = UDim2.fromScale(0.4, 0.5)
Main.Position = UDim2.fromScale(0.3, 0.25)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

TabsFolder = Instance.new("Folder", Main)
TabsFolder.Name = "Tabs"

-- ===== API =====
function Library:Load(title, theme)
    local Window = {}

    function Window:NewTab(name, icon)
        local TabFrame = Instance.new("Frame", TabsFolder)
        TabFrame.Name = name
        TabFrame.Size = UDim2.fromScale(1, 1)
        TabFrame.Visible = true
        TabFrame.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout", TabFrame)
        layout.Padding = UDim.new(0, 6)

        local Tab = {}

        function Tab:NewLabel(text)
            local Label = Instance.new("TextLabel", TabFrame)
            Label.Size = UDim2.fromScale(1, 0.08)
            Label.BackgroundTransparency = 1
            Label.TextColor3 = Color3.new(1, 1, 1)
            Label.Text = text
        end

        function Tab:NewButton(text, desc, callback)
            local Button = Instance.new("TextButton", TabFrame)
            Button.Size = UDim2.fromScale(1, 0.1)
            Button.Text = text
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.TextColor3 = Color3.new(1, 1, 1)

            Button.MouseButton1Click:Connect(function()
                if type(callback) == "function" then
                    callback()
                end
            end)
        end

        return Tab
    end

    return Window
end

return Library
