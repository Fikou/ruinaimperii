/world
	name = "Ruina Imperii"
	fps = 60		// 25 frames per second
	icon_size = 32	// 32x32 icon size by default
	view = 10
	movement_mode = TILE_MOVEMENT_MODE

var/global/datum/global_vars/GLOB = new /datum/global_vars()

/datum/global_vars

/world/Tick()
	for(var/client/client as anything in GLOB.clients)
		client.handle_movement()

/world/New()
	for(var/atom/atom)
		atom.on_ready()
