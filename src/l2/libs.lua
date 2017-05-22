lume = require "lib.lume"
autobatch = require "lib.autobatch"
object = require "lib.classic"
flux = require "lib.flux"
tick = require "lib.tick"
coil = require "lib.coil"

local libs = {}

function libs.update(dt)
	tick.update(dt)
	flux.update(dt)
	coil.update(dt)
end

return libs