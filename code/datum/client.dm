GLOBAL_LIST_EMPTY(clients)

/client
	parent_type = /datum
	var/list/movement_keys = list(
		"W" = NORTH,
		"A" = WEST,
		"S" = SOUTH,
		"D" = EAST,
	)
	var/list/key_mapping_mob = list(
		"T" = "say",
	)
	var/moving_dirs = NONE
	var/free_move = 0

/client/New()
	..()
	GLOB.clients += src
	var/mob/player/new_mob = new(locate(5, 5, 1))
	new_mob.ckey = ckey

/client/Del()
	GLOB.clients -= src
	..()

/client/Click(object, location, control, params)
	mob.handle_click(object, params2list(params))
	..()

/client/proc/handle_movement()
	mob.walk_self(moving_dirs)

/client/proc/set_move_dir(dir, state)
	if(!(dir in GLOB.cardinals))
		return
	if(state)
		if(moving_dirs && !(moving_dirs & dir) && world.time > free_move)
			if((dir & (NORTH|SOUTH) && !(moving_dirs & (NORTH|SOUTH))) || (dir & (EAST|WEST) && !(moving_dirs & (EAST|WEST))))
				mob.walk_self(dir)
		moving_dirs |= dir
	else
		if(free_move <= world.time)
			free_move = world.time + mob.get_move_cooldown() * SQRT_2
		moving_dirs &= ~dir

/client/verb/KeyDown(key as text)
	set hidden = TRUE
	if(movement_keys[key])
		set_move_dir(movement_keys[key], TRUE)
		return
	var/action = key_mapping_mob[key]
	if(action)
		switch(action)
			if("say")
				winset(src, "input", "focus=true")
		return

/client/verb/KeyUp(key as text)
	set hidden = TRUE
	if(movement_keys[key])
		set_move_dir(movement_keys[key], FALSE)
		return
	var/action = key_mapping_mob[key]
	if(action)
		switch(action)
			if("placeholder")
				return
		return

/client/verb/say(what as text)
	set hidden = TRUE
	mob.talk(what)
	winset(src, "map", "focus=true")

/client/verb/setZoomSize()
	set name = "Set Zoom Size"
	var/zoom = input(src, "Set zoom amount. Set to 0 to stretch the window to fit.", "Zoom Size", 0) as num
	if(zoom == null || zoom < 0)
		return
	if(zoom > 16)
		zoom = 16
	winset(src, "map", "zoom=[zoom]")

/client/verb/setZoomMode()
	set name = "Set Zoom Mode"
	var/static/list/zoom_modes = list(
		"Nearest Neighbour" = "distort",
		"Normal" = "normal",
		"Bilinear Sampling" = "blur",
	)
	var/mode = input(src, "Set zoom mode.", "Zoom Mode", "Nearest Neighbour") in zoom_modes
	if(!mode)
		return
	winset(src, "map", "zoom-mode=[zoom_modes[mode]]")
