local CollisionSystem = tiny.processingSystem(class "CollisionSystem")

CollisionSystem.filter = tiny.requireAll("collider", "pos", "movable")

function CollisionSystem:init(bumpWorld)
    self.bumpWorld = bumpWorld
end

function CollisionSystem:process(e, dt)
	-- print(self.bumpWorld:countItems())

	local pos = e.pos
	local vel = e.movable.velocity

    pos.x, pos.y, cols, len = self.bumpWorld:move(e, pos.x + vel.x * dt, pos.y + vel.y * dt, collisionFilter)

	for i=1,len do
	end
end

function CollisionSystem:onAdd(e)
    local pos = e.pos
    local col = e.collider
    self.bumpWorld:add(e, pos.x, pos.y, col.w, col.h)
end

function CollisionSystem:onRemove(e)
    self.bumpWorld:remove(e)
end


return CollisionSystem