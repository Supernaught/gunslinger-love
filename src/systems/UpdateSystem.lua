local UpdateSystem = tiny.processingSystem(class "UpdateSystem")

UpdateSystem.filter = tiny.requireAll("update")

function UpdateSystem:process(e, dt)
	if e.toRemove then
		print('remove')
		world:remove(e)
	end

	e:update(dt)
end

return UpdateSystem