/atom
	appearance_flags = PIXEL_SCALE
	plane = GAME_PLANE

/atom/Cross(atom/movable/crossed_atom)
	return ..() | crossed_atom.can_cross(src)

/atom/proc/on_ready()
	return

/atom/movable/proc/can_cross(atom/crossing_atom)
	return FALSE

/obj/testmap
	icon = 'icons/test.dmi'
	layer = 3
