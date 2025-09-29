-- High Money Server Joiner
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local function JoinHighMoneyServer()
    local success, result = pcall(function()
        return game:HttpGet("http://localhost:8080/get-server")
    end)
    
    if success then
        local data = HttpService:JSONDecode(result)
        
        if data.jobId then
            print("🎯 Joining High Money Server!")
            print("🆔 Job ID: " .. data.jobId)
            
            local joinSuccess, joinError = pcall(function()
                TeleportService:TeleportToPlaceInstance(109983668079237, data.jobId)
            end)
            
            if joinSuccess then
                print("✅ Joining server...")
            else
                print("❌ Join failed: " .. joinError)
            end
        else
            print("❌ No high money servers available (> $20M/s)")
            print("💡 Keep the PowerShell monitor running!")
        end
    else
        print("❌ Monitor offline - Make sure PowerShell script is running!")
        print("🔗 Check: http://localhost:8080/get-server")
    end
end

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local JoinButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local InfoLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HighMoneyJoiner"

-- Main Frame
MainFrame.Size = UDim2.new(0, 300, 0, 180)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Join Button
JoinButton.Size = UDim2.new(0, 280, 0, 50)
JoinButton.Position = UDim2.new(0, 10, 0, 10)
JoinButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
JoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinButton.Text = "🚀 JOIN HIGH MONEY SERVER"
JoinButton.Font = Enum.Font.GothamBold
JoinButton.TextSize = 16
JoinButton.Parent = MainFrame

-- Status Label
StatusLabel.Size = UDim2.new(0, 280, 0, 60)
StatusLabel.Position = UDim2.new(0, 10, 0, 70)
StatusLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "Ready to join servers > $20M/s"
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.TextWrapped = true
StatusLabel.Parent = MainFrame

-- Info Label
InfoLabel.Size = UDim2.new(0, 280, 0, 40)
InfoLabel.Position = UDim2.new(0, 10, 0, 140)
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoLabel.Text = "Monitors UCT & Chilli channels\nFilters > $20M/s servers only"
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 12
InfoLabel.TextWrapped = true
InfoLabel.Parent = MainFrame

-- Button click event
JoinButton.MouseButton1Click:Connect(function()
    JoinButton.Text = "CHECKING..."
    JoinButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    
    JoinHighMoneyServer()
    
    wait(2)
    JoinButton.Text = "🚀 JOIN HIGH MONEY SERVER"
    JoinButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
end)

-- Auto-check every 5 seconds
spawn(function()
    while true do
        local success, result = pcall(function()
            return game:HttpGet("http://localhost:8080/get-server")
        end)
        
        if success then
            local data = HttpService:JSONDecode(result)
            if data.jobId then
                StatusLabel.Text = "✅ SERVER AVAILABLE!\n> $20M/s server ready"
                StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                JoinButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            else
                StatusLabel.Text = "⏳ No high money servers\nMonitoring UCT & Chilli..."
                StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                JoinButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            end
        else
            StatusLabel.Text = "❌ MONITOR OFFLINE\nStart PowerShell script first"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            JoinButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        end
        
        wait(5)
    end
end)

print("🎯 High Money Server Joiner Loaded!")
print("💡 Make sure PowerShell monitor is running")
print("💰 Only joins servers > $20M/s")
