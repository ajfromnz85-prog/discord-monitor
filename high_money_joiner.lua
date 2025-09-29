-- Upload this to GitHub as high_money_joiner.lua
-- High Money Server Joiner
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local function JoinHighMoneyServer()
    local success, result = pcall(function()
        return game:HttpGet("http://localhost:8080/get-server")
    end)
    
    if success then
        local data = HttpService:JSONDecode(result)
        
        if data.jobId then
            print("🎯 Joining High Money Server!")
            TeleportService:TeleportToPlaceInstance(109983668079237, data.jobId)
        else
            print("❌ No high money servers available (> $20M/s)")
        end
    else
        print("❌ Monitor offline - Make sure PowerShell script is running!")
    end
end

-- GUI code here (same as before)...
