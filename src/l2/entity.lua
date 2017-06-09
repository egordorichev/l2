Entity = Rect:extend()

function Entity:new(options)
    Entity.super.new(self)

    if options ~= nil then
        for k, v in pairs(options) do
            self[k] = v
        end
    end
end