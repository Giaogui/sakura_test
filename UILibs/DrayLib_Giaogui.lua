-- DrayLib_Giaogui.lua (CORRECTED & WORKING)

local CoreGui = game:GetService("CoreGui")

-- destroy old
pcall(function()
    CoreGui.DrRay:Destroy()
end)

local Library = {}

-- create gui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DrRay"
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.fromScale(0.4, 0.5)
Main.Position = UDim2.fromScale(0.3, 0.25)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Color = Color3.fromRGB(80, 80, 80)

local TabsContainer = Instance.new("Frame", Main)
TabsContainer.Size = UDim2.new(1, 0, 1, -40)
TabsContainer.Position = UDim2.new(0, 0, 0, 40)
TabsContainer.BackgroundTransparency = 1

local TabsLayout = Instance.new("UIListLayout", TabsContainer)
TabsLayout.Padding = UDim.new(0, 6)

-- ===== API =====

function Library:Load(title, theme)
    local Window = {}

    function Window:NewTab(name, icon)
        local TabFrame = Instance.new("Frame")
        TabFrame.Parent = TabsContainer
        TabFrame.Size = UDim2.new(1, -10, 0, 200)
        TabFrame.BackgroundTransparency = 1

        local layout = Instance.new("UIListLayout", TabFrame)
        layout.Padding = UDim.new(0, 6)

        local Tab = {}

        function Tab:NewLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Parent = TabFrame
            Label.Size = UDim2.new(1, -10, 0, 30)
            Label.BackgroundTransparency = 1
            Label.TextColor3 = Color3.new(1, 1, 1)
            Label.TextWrapped = true
            Label.Text = text
        end

        function Tab:NewButton(text, desc, callback)
            local Button = Instance.new("TextButton")
            Button.Parent = TabFrame
            Button.Size = UDim2.new(1, -10, 0, 32)
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.TextColor3 = Color3.new(1, 1, 1)
            Button.Text = text

            Button.MouseButton1Click:Connect(function()
                if type(callback) == "function" then
                    callback()
                end
            end)
