local Inventory = {}
Inventory.__index = Inventory

local function getService(action)
    local path = "services." .. action .. "Service"
    local success, service = pcall(require, path)
    if success then
        return service
    else
        return nil
    end
end

function Inventory.new()
    local self = setmetatable({_data = {}}, Inventory)
    self._data.MaxSlotCount = 36
    self._data.Slots = {}

    return self
end

function Inventory:AddItem(item)
    local slots = self._data.Slots
    for slot = 1, self._data_MaxSlotCount do
        if slots[slot] == nil then
            slots[slot] = item
            return { success = true, message = "Item successfully added to inventory!" }
        end
    end
    return { success = false, message = "Inventory is full!" }
end

function Inventory:RemoveItem(slot)
    --TODO
end

function Inventory:GetItemByName(name)
    --TODO
end

function Inventory:GetItemBySlot(slot)
    --TODO
end

function Inventory:UseItem(slot, owner)
    local item = self:GetItemBySlot(slot)
    local itemData = (item and item.GetData) and item:GetData() or {}
    local service = getService(itemData.Action)
    if service then
        service.apply(itemData.Value)
        return { success = true, message = "Item successfully used!" }
    else
        return { success = false, message = "Failed to use item!" }
    end
end

return Inventory
