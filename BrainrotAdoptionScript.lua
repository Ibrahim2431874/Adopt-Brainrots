-- Main Brainrot Adoption System
-- Place this in ServerScriptService

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Configuration
local ADOPTION_RANGE = 20 -- How close player needs to be to adopt
local PICKUP_COOLDOWN = 1 -- Seconds between pickups

-- Store adopted Brainrots
local adoptedBrainrots = {}

-- Function to handle adoption
local function adoptBrainrot(player, brainrot)
    if brainrot:FindFirstChild("Humanoid") then
        local adopted = {
            name = brainrot.Name,
            player = player.UserId,
            adoptedTime = tick(),
            originalPart = brainrot
        }
        
        table.insert(adoptedBrainrots, adopted)
        
        print(player.Name .. " has adopted " .. brainrot.Name .. "!")
        
        -- Remove from world after adoption
        game:GetService("Debris"):AddItem(brainrot, 0.5)
    end
end

-- Function to handle player pickup
local function pickupBrainrot(player, brainrot)
    if brainrot and brainrot.Parent then
        local playerCharacter = player.Character
        if not playerCharacter then return end
        
        local rightHand = playerCharacter:FindFirstChild("RightHand") or playerCharacter:FindFirstChild("Right Arm")
        if rightHand then
            -- Weld Brainrot to player's hand
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = rightHand
            weld.Part1 = brainrot
            weld.Parent = brainrot
            
            -- Mark as picked up
            brainrot:SetAttribute("PickedUp", true)
            
            print(player.Name .. " picked up the Brainrot!")
            
            -- After 2 seconds, adopt it
            task.wait(2)
            adoptBrainrot(player, brainrot)
        end
    end
end

-- Listen for adoption requests from client
local adoptionRemote = Instance.new("RemoteFunction")
adoptionRemote.Name = "AdoptBrainrot"
adoptionRemote.Parent = ReplicatedStorage

function adoptionRemote.OnServerInvoke(player, action, brainrot)
    if action == "pickup" then
        pickupBrainrot(player, brainrot)
        return "Picked up!"
    elseif action == "adopt" then
        adoptBrainrot(player, brainrot)
        return "Adopted!"
    end
    return "Unknown action"
end

-- Find and setup your existing BrainRot part
local brainrot = workspace:FindFirstChild("BrainRot")
if brainrot then
    -- Add Humanoid if it doesn't have one
    if not brainrot:FindFirstChild("Humanoid") then
        local humanoid = Instance.new("Humanoid")
        humanoid.Parent = brainrot
    end
    print("BrainRot part found and configured!")
else
    print("Warning: BrainRot part not found in Workspace!")
end

print("Brainrot Adoption System Loaded!")