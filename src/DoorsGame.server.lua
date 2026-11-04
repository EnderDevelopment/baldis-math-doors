-- Doors Game Script

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Doors = workspace:WaitForChild("Doors")
local Notebooks = workspace:WaitForChild("Notebooks")

local function generateMathProblem()
    local num1 = math.random(1, 10)
    local num2 = math.random(1, 10)
    local operation = math.random(1, 2)
    
    if operation == 1 then
        return num1, num2, num1 + num2, "+"
    else
        return num1, num2, num1 - num2, "-"
    end
end

local function onDoorTouched(otherPart)
    local player = Players:GetPlayerFromCharacter(otherPart.Parent)
    if player then
        local door = otherPart.Parent
        local notebook = Notebooks:FindFirstChild(door.Name .. "Notebook")
        
        if notebook then
            notebook.Transparency = 0
            
            local num1, num2, answer, operation = generateMathProblem()
            notebook.SurfaceGui.TextLabel.Text = num1 .. " " .. operation .. " " .. num2 .. " = ?"
            
            local function onNotebookTouched(otherPart)
                local player = Players:GetPlayerFromCharacter(otherPart.Parent)
                if player then
                    local userInput = player:WaitForChild("UserInputService").InputBegan:Wait()
                    
                    if userInput.KeyCode == Enum.KeyCode.Return then
                        local playerAnswer = tonumber(player:WaitForChild("PlayerGui"):WaitForChild("MathProblem"):WaitForChild("TextBox").Text)
                        
                        if playerAnswer == answer then
                            notebook.Transparency = 1
                            notebook:Destroy()
                        else
                            local Baldi = workspace:WaitForChild("Baldi")
                            Baldi:MoveTo(player.Character.HumanoidRootPart.Position)
                            player.Character.Humanoid.Health = 0
                        end
                    end
                end
            end
            
            notebook.Touched:Connect(onNotebookTouched)
        end
    end
end

for _, door in ipairs(Doors:GetChildren()) do
    door.Touched:Connect(onDoorTouched)
end