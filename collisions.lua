local collisions = {}

--
-- 1 - hero
-- 2 - weapon
-- 3 - enemy
-- 4 - enemyWeapon
--
--
--
--
--
--
--
--




collisions.heroFilter = {categoryBits = 1, maskBits = 12}

collisions.weaponFilter = {categoryBits = 2, maskBits = 4}

collisions.enemyFilter = {categoryBits = 4, maskBits = 3}

collisions.enemyWeaponFilter = {categoryBits = 8, maskBits = 1}

return collisions