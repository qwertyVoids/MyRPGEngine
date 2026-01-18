local Item = {}
Item.__index = Item

local function getItem(category, type, grade)
    local path = "items" .. "." .. category:lower() .. "." .. type:lower() .. "_" .. grade:lower()
    local success, item = pcall(require, path)
    return (success) and item or nil
end

function Item.new(category, type, grade)
    local item = getItem(category, type, grade)
    if not item then return nil end
    local self = setmetatable({_data = {}}, Item)
    for k, v in pairs(item) do
        self._data[k] = v
    end

    return self
end

function Item:GetData()
    local item = self._data
    local data = {}
    for k, v in pairs(item) do
        if type(v) ~= "table" then
            data[k] = v
        end
    end

    return data
end

function Item:GetTags()
    local tags = self._data.Tags
    local data = {}
    if not tags then return nil end
    for k, v in pairs(tags) do
        data[k] = v
    end

    return data
end

return Item
