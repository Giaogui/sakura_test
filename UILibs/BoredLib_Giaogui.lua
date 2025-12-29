-- BoredLib_Giaogui.lua (REAL UI + TOGGLES)

local CoreGui = game:GetService("CoreGui")

pcall(function()
    CoreGui.BoredUI:Destroy()
end)

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BoredUI"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 400)
Main.Position = UDim2.new(0.5, -250, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)

local Tabs = Instance.new("UIListLayout", Main)
Tabs.Padding = UDim.new(0, 8)

local Bored = {}

-- TAB
function Bored.newTab(name, icon)
    local TabFrame = Instance.new("Frame", Main)
    TabFrame.Size = UDim2.new(1, -10, 0, 300)
    TabFrame.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", TabFrame)
    layout.Padding = UDim.new(0, 6)

    local Tab = {}

    -- BUTTON
    function Tab.newButton(text, callback)
        local btn = Instance.new("TextButton", TabFrame)
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Text = text

        btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
    end

    -- TOGGLE (CRITICAL)
    function Tab.newToggle(text, default, callback)
        local state = default or false
        getgenv()[text] = state

        local btn = Instance.new("TextButton", TabFrame)
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.TextColor3 = Color3.new(1,1,1)

        local function refresh()
            btn.Text = text .. ": " .. (state and "ON" or "OFF")
            btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(45,45,45)
        end

        refresh()

        btn.MouseButton1Click:Connect(function()
            state = not state
            getgenv()[text] = state
            refresh()
            if callback then callback(state) end
        end)
    end

    return Tab
end

return Bored
