local ShooterSystem = tiny.processingSystem(class "ShooterSystem")

function ShooterSystem:init()
	self.filter = tiny.requireAll("shooter", "atkDelay", "canAtk")
end

function ShooterSystem:process(e, dt)
	print("SHOOT")
end

return ShooterSystem