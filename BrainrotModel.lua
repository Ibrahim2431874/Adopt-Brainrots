-- BrainrotModel.lua
-- Roblox Brainrot model definition for adoption mechanics

-- Class Definition
BrainrotModel = {}
BrainrotModel.__index = BrainrotModel

-- Properties
function BrainrotModel.new(name)
    local self = setmetatable({}, BrainrotModel)
    self.name = name or "Unnamed Brainrot"
    self.age = 0
    self.adopted = false
    self.health = 100
    return self
end

-- Method to adopt the Brainrot
function BrainrotModel:adopt()
    if not self.adopted then
        self.adopted = true
        print(self.name .. " has been adopted!")
    else
        print(self.name .. " is already adopted.")
    end
end

-- Method to age the Brainrot
function BrainrotModel:ageUp()
    if self.adopted then
        self.age = self.age + 1
        print(self.name .. " is now " .. self.age .. " years old.")
    else
        print(self.name .. " needs to be adopted before aging.")
    end
end

-- Method to display health
function BrainrotModel:checkHealth()
    print(self.name .. "'s health is at " .. self.health .. "/100.")
end

-- Model Setup
local myBrainrot = BrainrotModel.new("Brainrot001")
myBrainrot:checkHealth()
myBrainrot:adopt()
myBrainrot:ageUp()