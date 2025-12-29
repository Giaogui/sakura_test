-- BoredLib_Giaogui.lua (REBUILT CORE LOGIC)

local TweenService = game:GetService("TweenService")

local Bored = {}
Bored.__index = Bored

-- INTERNAL STATE
local Toggles = {}
local Sliders = {}

-- UI helpers
local function create(class, props)
    local obj = Instance.new(class)
    for i,v in pairs(props) do
        obj[i] = v
    end
    return obj
end

-- TAB OBJECT
function Bored.newTab(tabFrame)
    local self = setmetatable({}, Bored)
    self.Frame = tabFrame
    return self
end

-- ===== BUTTON =====
function Bored:newButton(text, desc, callback)
    local btn = create("TextButton", {
        Parent = self.Frame,
        Size = UDim2.new(1, -10, 0, 30),
        BackgroundColor3 = Color3.fromRGB(45,45,45),
        TextColor3 = Color3.new(1,1,1),
        Text = text
    })

    btn.MouseButton1Click:Connect(function()
        if type(callback) == "function" then
            callback()
        end
    end)
end

-- ===== TOGGLE (MOST IMPORTANT) =====
function Bored:newToggle(text, default, callback)
    Toggles[text] = default or false
    getgenv()[text] = Toggles[text]

    local btn = create("TextButton", {
        Parent = self.Frame,
        Size = UDim2.new(1, -10, 0, 30),
        BackgroundColor3 = Toggles[text] and Color3.fromRGB(0,170,0) or Color3.fromRGB(45,45,45),
        TextColor3 = Color3.new(1,1,1),
        Text = text .. ": " .. (Toggles[text] and "ON" or "OFF")
    })

    btn.MouseButton1Click:Connect(function()
        Toggles[text] = not Toggles[text]
        getgenv()[text] = Toggles[text]

        btn.Text = text .. ": " .. (Toggles[text] and "ON" or "OFF")
        btn.BackgroundColor3 = Toggles[text] and Color3.fromRGB(0,170,0) or Color3.fromRGB(45,45,45)

        if type(callback) == "function" then
            callback(Toggles[text])
        end
    end)
end

-- ===== SLIDER =====
function Bored:newSlider(text, min, max, default, callback)
    local value = default or min
    Sliders[text] = value
    getgenv()[text] = value

    local label = create("TextLabel", {
        Parent = self.Frame,
        Size = UDim2.new(1, -10, 0, 30),
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1,1,1),
        Text = text .. ": " .. value
    })

    label.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            value = math.clamp(value + 1, min, max)
            Sliders[text] = value
            getgenv()[text] = value
            label.Text = text .. ": " .. value

            if callback then
                callback(value)
            end
        end
    end)
end

return Bored
