-- Player Script

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local function onPlayerAdded(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    local function onInputBegan(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.E then
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {character}
            
            local raycastResult = workspace:Raycast(character.HumanoidRootPart.Position, character.HumanoidRootPart.CFrame.LookVector * 5, raycastParams)
            
            if raycastResult then
                local part = raycastResult.Instance
                if part:IsA("BasePart") and part.Parent.Name == "Doors" then
                    part.Parent:Destroy()
                end
            end
        end
    end
    
    UserInputService.InputBegan:Connect(onInputBegan)
end

Players.PlayerAdded:Connect(onPlayerAdded)