-- TODO: Clean

-- 
-- MoveToTargetSystem
-- by Alphonsus
--
-- rotates object to targetPos (x,y) and moves towards it
--

local MoveToTargetSystem = tiny.processingSystem(class "MoveToTargetSystem")

MoveToTargetSystem.filter = tiny.requireAll("moveToTarget", "targetPos", "setTargetPos", "pos")

function MoveToTargetSystem:process(e, dt)
	e:update(dt)
end

function MoveToTargetSystem:setTargetPos(x, y)
	self.targetPos.x = x
	self.targetPos.y = y

	self.angle = self:getAngleFromTargetPos()

	self:setVelocityFromAngle()
	-- self.movable.velocity.x = xTarget - self.movable.velocity.x
	-- self.movable.velocity.y = yTarget - self.movable.velocity.y
end

function MoveToTargetSystem:getAngleFromTargetPos()
	return math.atan2((self.targetPos.y - self.pos.y), (self.targetPos.x - self.pos.x))
end

return MoveToTargetSystem