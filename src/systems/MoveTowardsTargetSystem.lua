-- TODO: Clean

-- 
-- MoveTowardsTargetSystem
-- by Alphonsus
--
-- rotates object to targetPos (x,y) and moves towards it
--

local MoveTowardsTargetSystem = tiny.processingSystem(class "MoveTowardsTargetSystem")

MoveTowardsTargetSystem.filter = tiny.requireAll("moveTowardsTarget")

function MoveTowardsTargetSystem:process(e, dt)
	e.angle = self:getAngleFromTargetPos(e)
	e.movable.velocity.x = math.cos(e.angle) * e.speed
	e.movable.velocity.y = math.sin(e.angle) * e.speed
end

function MoveTowardsTargetSystem:setTargetPos(x, y)
	self.targetPos.x = x
	self.targetPos.y = y

	self.angle = self:getAngleFromTargetPos()

	self:setVelocityFromAngle()
	-- self.movable.velocity.x = xTarget - self.movable.velocity.x
	-- self.movable.velocity.y = yTarget - self.movable.velocity.y
end

function MoveTowardsTargetSystem:getAngleFromTargetPos(e)
	return math.atan2((e.targetPos.y - e.pos.y), (e.targetPos.x - e.pos.x))
end

return MoveTowardsTargetSystem