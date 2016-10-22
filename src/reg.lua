-- Static values used for the game

local reg = {}

reg.T_SIZE = 8 -- tile size
reg.GRAVITY = -80

-- debug flags
reg.DEBUG_RENDERS = false
reg.DEBUG_COLLIDERS = false

-- weapon stats
reg.weaponStats = {}
reg.weaponStats.pistol = {atkDelay = 0.08}
reg.weaponStats.machineGun = {atkDelay = 0.04}
reg.weaponStats.dualPistol = {atkDelay = 0.04, rotateSpeed = 6}
reg.weaponStats.shotgun = {atkDelay = 0.09, rotateSpeed = 12}

return reg