/mob
	icon = 'icons/mob.dmi'
	appearance_flags = PIXEL_SCALE|TILE_BOUND
	var/move_cooldown = 0

/mob/proc/talk(what)
	global_chat("<b>[name]</b>: [what]")

/mob/proc/get_move_cooldown()
	return 0.1 SECONDS

/mob/proc/handle_click(atom/clicked_on, list/modifiers)
	. = FALSE

/mob/proc/walk_self(moving_dirs)
	if(move_cooldown > world.time)
		return
	var/cooldown_multiplier = 1
	var/dir_to_move = moving_dirs
	if((moving_dirs & (NORTH|SOUTH)) == (NORTH|SOUTH))
		dir_to_move &= ~(NORTH|SOUTH)
	if((moving_dirs & (EAST|WEST)) == (EAST|WEST))
		dir_to_move &= ~(EAST|WEST)
	if(dir_to_move == NONE)
		return
	if(dir_to_move in GLOB.diagonals)
		Move(get_step(src, dir_to_move & (NORTH|SOUTH)), dir_to_move & (NORTH|SOUTH))
		dir_to_move &= ~(NORTH|SOUTH)
		cooldown_multiplier = SQRT_2
	Move(get_step(src, dir_to_move), dir_to_move)
	move_cooldown = world.time + get_move_cooldown() * cooldown_multiplier

/mob/player
	icon_state = "player"
	maptext_y = 26
	maptext_width = 128
	maptext_x = -48
	mouse_opacity = 0
	var/image/selection_image
	var/turf/selected_location
	var/datum/nation/nation

/mob/player/New(spawnloc)
	..()
	selection_image = image('icons/terrain.dmi', "selected", layer = 3.9)

/mob/player/Login()
	..()
	name = capitalize(key)
	maptext = "<span class='maptext center'>[name]</span>"
	src << selection_image
	for(var/nation_type in GLOB.nations)
		var/datum/nation/nation = GLOB.nations[nation_type]
		if(nation.ckey == ckey && length(nation.locations))
			set_nation(nation_type)
			break
	if(!nation)
		for(var/nation_type in GLOB.nations)
			if(set_nation(nation_type))
				break

/mob/player/Logout()
	..()
	if(nation)
		nation.ckey = null
	del(src)

/mob/player/can_cross(atom/crossing_atom)
	return TRUE

/mob/player/talk(what)
	if(nation)
		global_chat("<b>[name]</b> ([nation.name]): [what]")
		return
	global_chat("<b>[name]</b> (Observer): [what]")

/mob/player/proc/set_nation(datum/nation/nation_type)
	. = FALSE
	var/datum/nation/possible_nation = GLOB.nations[nation_type]
	if(possible_nation.ckey)
		return
	nation = GLOB.nations[nation_type]
	nation.ckey = ckey
	color = nation.color
	return TRUE

/mob/player/handle_click(atom/clicked_on, list/modifiers)
	. = ..()
	if(modifiers["right"])
		cancel_selection()
		return TRUE
	if(isturf(clicked_on))
		select_location(clicked_on)
		. = TRUE

/mob/player/proc/select_location(turf/location)
	cancel_selection()
	selected_location = location
	selection_image.loc = location
	client.screen += new /atom/movable/screen/location(null, location)

/mob/player/proc/cancel_selection()
	if(selected_location)
		selected_location = null
		selection_image.loc = null
		del(locate(/atom/movable/screen/location) in client.screen)
