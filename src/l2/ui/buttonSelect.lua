buttonSelect = button:extend()

function buttonSelect:new(variants, x, y, w, h)
	buttonSelect.super.new(self, variants[1], x, y, w, h)

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

function buttonSelect:getVariant()
	return self.variants[self.variant]
end

function buttonSelect:getVariantIndex()
	return self.variant
end

function buttonSelect:onChange(callback)
	self.onChangeCallback = callback
	return self
end