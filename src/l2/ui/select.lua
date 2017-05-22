select = button:extend()

function select:new(variants, x, y, w, h)
	select.super.new(self, variants[1], x, y, w, h)

	self.variants = variants
	self.variant = 1

	self.onChangeCallback = function(s) end

	self:onClick(lume.combine(self.onClickCallback, function(b)
		b.variant = b.variant + 1

		if b.variant > #b.variants then
			b.variant = 1
		end

		b:setLabel(b.variants[b.variant])
		b:onChangeCallback(b)
	end))
end

function select:getVariant()
	return self.variants[self.variant]
end

function select:getVariantIndex()
	return self.variant
end

function select:onChange(callback)
	self.onChangeCallback = callback
	return self
end