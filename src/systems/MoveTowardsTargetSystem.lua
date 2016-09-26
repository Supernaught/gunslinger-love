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
	local targetAngle = self:getAngleFromTargetPos(e)

	if e.rotateTowardsTarget then
		e.angle = targetAngle
	end

	e.movable.velocity.x = math.cos(targetAngle - math.rad(90)) * e.speed
	e.movable.velocity.y = math.sin(targetAngle - math.rad(90)) * e.speed
end

function MoveTowardsTargetSystem:getAngleFromTargetPos(e)
	return math.atan2((e.targetPos.y - e.pos.y), (e.targetPos.x - e.pos.x)) + math.rad(90)
end

return MoveTowardsTargetSystem