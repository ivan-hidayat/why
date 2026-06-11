loadstring(game:HttpGet("https://raw.githubusercontent.com/4LynxX/Lynx/refs/heads/main/LynxxMain.lua"))()

local UserGameSettings = UserSettings():GetService("UserGameSettings")
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

task.wait(3)

pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

pcall(function()
    UserGameSettings.SavedQualityLevel = Enum.SavedQualityLevel.QualityLevel1
end)

pcall(function()
    if sethiddenproperty then
        sethiddenproperty(UserGameSettings, "GraphicsQualityLevel", 1)
    end
end)

if Terrain then
    pcall(function()
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end)
end

local function enforceLighting()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 1
    Lighting.ClockTime = 20
end

enforceLighting()

Lighting.Changed:Connect(function()
    enforceLighting()
end)

local function removeLag(object)
    pcall(function()
        if object:IsA("MeshPart") then
            object.RenderFidelity = Enum.RenderFidelity.Performance
            object.CastShadow = false
        elseif object:IsA("BasePart") then
            object.CastShadow = false
            object.Material = Enum.Material.SmoothPlastic
        elseif object:IsA("Texture") or object:IsA("Decal") then
            object.Texture = ""
        elseif object:IsA("ParticleEmitter") or object:IsA("Trail") or object:IsA("Smoke") or object:IsA("Fire") or object:IsA("Sparkles") then
            object.Enabled = false
        end
    end)
end

for _, descendant in ipairs(game:GetDescendants()) do
    removeLag(descendant)
end

game.DescendantAdded:Connect(function(descendant)
    removeLag(descendant)
end)
