-- Baldi Basics Script

local Baldi = script.Parent

local function moveBaldi()
    while true do
        local target = workspace:GetChildren()[math.random(1, #workspace:GetChildren())]
        Baldi:MoveTo(target.Position)
        wait(math.random(5, 15))
    end
end

moveBaldi()