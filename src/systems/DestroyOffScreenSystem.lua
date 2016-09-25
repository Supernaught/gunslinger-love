local DestroyOffScreenSystem = tiny.processingSystem(class "DestroyOffScreenSystem")

DestroyOffScreenSystem.filter = tiny.requireAll("destroyOffScreen", "pos")

function DestroyOffScreenSystem:process(e, dt)
	if (e.pos.x < 0 or e.pos.x > push:getWidth()) or (e.pos.y < 0 or e.pos.y > push:getHeight()) then
		world:remove(e)
	end
end

return DestroyOffScreenSystem