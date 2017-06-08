require "lib.autobatch"

flux = require "lib.flux"
lume = require "lib.lume"
coil = require "lib.coil"
tick = require "lib.tick"
Object = require "lib.classic"

libs = {}

function libs.update(dt)
    flux.update(dt)
    tick.update(dt)
end

return libs