-- Animation Grabber
-- Rebranded for Giaogui Hub 🌸

local screenxD = Instance.new("ScreenGui", game.CoreGui)
screenxD.DisplayOrder = 500
screenxD.ResetOnSpawn = false
screenxD.Name = "GiaoguiAnimGrabber"

local drag = Instance.new("Frame", screenxD)
drag.BackgroundColor3 = Color3.fromRGB(114,137,218)
drag.BorderSizePixel = 0
drag.Position = UDim2.new(0.1,0,0.2,0)
drag.Size = UDim2.new(0,256,0,20)

local scroll = Instance.new("ScrollingFrame", drag)
scroll.BackgroundColor3 = Color3.fromRGB(44,47,51)
scroll.BorderSizePixel = 0
scroll.Position = UDim2.new(0,0,1,0)
scroll.Size = UDim2.new(1,0,0,320)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.ScrollBarThickness = 4

local uilist = Instance.new("UIListLayout", scroll)
uilist.Padding = UDim.new(0,1)

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local function createbutton(id)
    local str = string.match(tostring(id), "%d+")
    local button = Instance.new("TextButton", scroll)
    button.Size = UDim2.new(1,0,0,50)
    button.Text = ""
    button.BackgroundColor3 = Color3.fromRGB(35,39,42)
    button.BorderSizePixel = 0

    local name = Instance.new("TextLabel", button)
    name.BackgroundTransparency = 1
    name.Size = UDim2.new(1,0,0.5,0)
    name.TextColor3 = Color3.fromRGB(255,255,255)
    name.Font = Enum.Font.Gotham
    name.TextSize = 16
    name.TextXAlignment = Enum.TextXAlignment.Left

    local idlabel = name:Clone()
    idlabel.Parent = button
    idlabel.Position = UDim2.new(0,0,0.5,0)
    idlabel.Text = str

    pcall(function()
        name.Text = MarketplaceService:GetProductInfo(tonumber(str)).Name
    end)

    button.Activated:Connect(function()
        setclipboard(str)
    end)
end

local cache = {}

while true do
    local char = Players.LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        for _,track in pairs(hum:GetPlayingAnimationTracks()) do
            if not table.find(cache, track.Animation.AnimationId) then
                table.insert(cache, track.Animation.AnimationId)
                createbutton(track.Animation.AnimationId)
            end
        end
    end
    task.wait(1)
end
