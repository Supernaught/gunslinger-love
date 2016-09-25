local CollisionSystem = tiny.processingSystem(class "CollisionSystem")

CollisionSystem.filter = tiny.requireAll("collider", "pos", "movable")

function CollisionSystem:init()
end

function CollisionSystem:process(e, dt)
	-- print(bumpWorld:countItems())

	local pos = e.pos
	local vel = e.movable.velocity

    pos.x, pos.y, cols, len = bumpWorld:move(e, pos.x, pos.y, collisionFilter)

	for i=1,len do
		print(i .. ' collided with ' .. tostring(cols[i].other))
		-- bumpWorld:remove(cols[i].other)
	end
end

function collisionFilter(e1,e2)
	if e1.isBullet then
		if e2.isEnemy then
			e2:die()
			-- bumpWorld:remove(e2)
			return "cross"
		elseif e2.isBullet then
			return nil
		end
	end

	print(e1.name .. ' / ' .. e2.name )

	-- if e1.isPlayer then
	-- 	print('player')
	-- elseif e1.isBullet then
	-- 	print('bullet')
	-- elseif e1.isEnemy then
	-- 	print('enemy')
	-- end
end

function CollisionSystem:onAdd(e)
    local pos = e.pos
    local col = e.collider
    bumpWorld:add(e, pos.x, pos.y, col.w, col.h)
end

function CollisionSystem:onRemove(e)
    bumpWorld:remove(e)
end


return CollisionSystem