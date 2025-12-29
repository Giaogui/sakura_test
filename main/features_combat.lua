{\rtf1\ansi\ansicpg936\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- features_combat.lua (STABLE, CLEAN)\
\
local Players = game:GetService("Players")\
local RunService = game:GetService("RunService")\
\
local LP = Players.LocalPlayer\
local Combat = \{\}\
\
-- =====================\
-- AIMLOCK\
-- =====================\
local aimConn\
\
function Combat.ToggleAimlock()\
    getgenv().Aimlock = not getgenv().Aimlock\
\
    if getgenv().Aimlock and not aimConn then\
        aimConn = RunService.RenderStepped:Connect(function()\
            if not getgenv().Aimlock then return end\
\
            local cam = workspace.CurrentCamera\
            local myChar = LP.Character\
            if not myChar then return end\
\
            for _,p in ipairs(Players:GetPlayers()) do\
                if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then\
                    cam.CFrame = CFrame.new(\
                        cam.CFrame.Position,\
                        p.Character.HumanoidRootPart.Position\
                    )\
                    break\
                end\
            end\
        end)\
    end\
\
    return getgenv().Aimlock\
end\
\
-- =====================\
-- INSTA KILL\
-- =====================\
function Combat.ToggleInstaKill()\
    getgenv().InstaKill = not getgenv().InstaKill\
\
    if getgenv().InstaKill then\
        task.spawn(function()\
            while getgenv().InstaKill do\
                local myChar = LP.Character\
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")\
\
                if myHRP then\
                    for _,m in ipairs(workspace:GetDescendants()) do\
                        local hum = m:FindFirstChildOfClass("Humanoid")\
                        local hrp = m:FindFirstChild("HumanoidRootPart")\
\
                        if hum and hrp and m ~= myChar and hum.Health > 0 then\
                            if (hrp.Position - myHRP.Position).Magnitude <= 25 then\
                                pcall(function()\
                                    hum.Health = 0\
                                    hum:TakeDamage(hum.MaxHealth)\
                                end)\
                            end\
                        end\
                    end\
                end\
\
                task.wait(0.15)\
            end\
        end)\
    end\
\
    return getgenv().InstaKill\
end\
\
-- =====================\
-- TP PUNCH\
-- =====================\
function Combat.ToggleTPBehind()\
    getgenv().TPBehind = not getgenv().TPBehind\
\
    if getgenv().TPBehind then\
        task.spawn(function()\
            while getgenv().TPBehind do\
                local myChar = LP.Character\
                local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")\
\
                if myHRP then\
                    for _,m in ipairs(workspace:GetDescendants()) do\
                        local hum = m:FindFirstChildOfClass("Humanoid")\
                        local hrp = m:FindFirstChild("HumanoidRootPart")\
\
                        if hum and hrp and m ~= myChar and hum.Health > 0 then\
                            myHRP.CFrame = hrp.CFrame * CFrame.new(0, 0, -2)\
                            pcall(function()\
                                hum:TakeDamage(hum.MaxHealth / 2)\
                            end)\
                            task.wait(0.05)\
                        end\
                    end\
                end\
\
                task.wait(0.2)\
            end\
        end)\
    end\
\
    return getgenv().TPBehind\
end\
\
-- =====================\
return Combat\
}