local o_ten_one = require "lib.o-ten-one"
splash = state:extend()

function splash:init()
    self.s = o_ten_one({
            background = { 0, 0, 0 }
        })

    self.s.onDone = function()
        game:switchState(ingame())
    end
end

function splash:draw()
    self.s:draw()
end

function splash:update(dt)
    self.s:update(dt)
end