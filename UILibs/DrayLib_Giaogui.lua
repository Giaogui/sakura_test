-- DrayLib_Giaogui.lua (SAFE / STABLE)

local CoreGui = game:GetService("CoreGui")

pcall(function()
    CoreGui.DrRay:Destroy()
end)

local Library = {}

-- UI root
local Gui = Instance.new("ScreenGui")
Gui.Name = "DrRay"
Gui.Parent = CoreGui

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0, 400, 0, 300)
Main.Position = UDim2.new(0.5, -200, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -20, 1, -20)
Content.Position = UDim2.new(0, 10, 0, 10)
Content.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 6)

-- API
function Library:Load(title, theme)
    local Window = {}

    function Window:NewTab(name, icon)
        local Tab = {}

        function Tab:NewLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Parent = Content
            Label.Size = UDim2.new(1, 0, 0, 30)
            Label.BackgroundTransparency = 1
            Label.TextColor3 = Color3.new(1,1,1)
            Label.Text = text
        end

        function Tab:NewButton(text, desc, callback)
            local Button = Instance.new("TextButton")
            Button.Parent = Content
            Button.Size = UDim2.new(1, 0, 0, 30)
            Button.BackgroundColor3 = Color3.fromRGB(50,50,50)
            Button.TextColor3 = Color3.new(1,1,1)
            Button.Text = text

            if type(callback) == "function" then
                Button.MouseButton1Click:Connect(callback)
            end
        end

        return Tab
    end

    return Window
end

return Library
