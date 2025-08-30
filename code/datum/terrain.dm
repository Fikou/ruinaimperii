/turf
	name = "broken terrain"
	desc = "Report this!"
	icon = 'icons/terrain.dmi'
	density = FALSE
	opacity = FALSE
	var/location_name = "Path"
	var/datum/climate/climate

/turf/on_ready()
	..()
	if(climate)
		var/image/climate_image = image('icons/terrain.dmi', lowertext(climate.name), layer = 3.5)
		climate_image.appearance_flags |= RESET_COLOR
		overlays += climate_image

/turf/water
	name = "sea"
	desc = "Water for navies to navigate through."
	icon_state = "water"
	density = TRUE
	location_name = "Sea"
	var/strait_connections = NONE

/turf/water/on_ready()
	if(strait_connections)
		var/dir_to_use = strait_connections
		if(dir_to_use == (NORTH|SOUTH))
			dir_to_use = SOUTH
		else if(dir_to_use == (EAST|WEST))
			dir_to_use = EAST
		overlays += image('icons/terrain.dmi', "strait", dir = dir_to_use, layer = 3.6)

/turf/water/deep
	name = "ocean"
	desc = "Water for navies to die in."
	icon_state = "deepwater"
	location_name = "Ocean"

/turf/ground
	var/datum/vegetation/vegetation
	var/datum/material/material
	var/list/population = list()
	var/list/buildings = list()
	var/river = NONE
	var/datum/nation/owning_nation
	var/datum/nation/controlling_nation

/turf/ground/on_ready()
	..()
	if(river)
		var/image/river_image = image('icons/terrain.dmi', "river", dir = river, layer = 3.2)
		river_image.appearance_flags |= RESET_COLOR
		overlays += river_image
	if(vegetation)
		overlays += image('icons/terrain.dmi', lowertext(vegetation.name), layer = 3.1)

/turf/ground/plain
	name = "plain"
	icon_state = "plain"

/turf/ground/plain/New(spawnloc)
	..()
	dir = pick(1, 2, 4, 8)

/turf/ground/wetland
	name = "wetland"
	icon_state = "wetland"

/turf/ground/wetland/New(spawnloc)
	..()
	dir = pick(1, 2, 4, 8)

/turf/ground/hill
	name = "hill"
	icon_state = "hill"

/turf/ground/mountain
	name = "mountain"
	icon_state = "mountain"

/obj/terrain_modifier
	name = "broken terrain modifier"
	icon = 'icons/terrain.dmi'

/obj/terrain_modifier/New(spawnloc)
	var/turf/turf_loc = loc
	if(!istype(turf_loc))
		return
	apply_changes(turf_loc)
	del src

/obj/terrain_modifier/proc/apply_changes(turf/turf_loc)
	return

/obj/terrain_modifier/climate
	name = "climate modifier"
	layer = 3.5
	var/datum/climate/climate_type

/obj/terrain_modifier/climate/apply_changes(turf/turf_loc)
	if(!istype(turf_loc))
		return
	turf_loc.climate = GLOB.climates[climate_type]

/obj/terrain_modifier/climate/arctic
	icon_state = "arctic"
	climate_type = /datum/climate/arctic

/obj/terrain_modifier/climate/continental
	icon_state = "continental"
	climate_type = /datum/climate/continental

/obj/terrain_modifier/climate/oceanic
	icon_state = "oceanic"
	climate_type = /datum/climate/oceanic

/obj/terrain_modifier/climate/mediterranean
	icon_state = "mediterranean"
	climate_type = /datum/climate/mediterranean

/obj/terrain_modifier/climate/semiarid
	icon_state = "semiarid"
	climate_type = /datum/climate/semiarid

/obj/terrain_modifier/climate/arid
	icon_state = "arid"
	climate_type = /datum/climate/arid

/obj/terrain_modifier/vegetation
	name = "vegetation modifier"
	layer = 3.1
	var/datum/vegetation/vegetation_type

/obj/terrain_modifier/vegetation/apply_changes(turf/ground/turf_loc)
	if(!istype(turf_loc))
		return
	turf_loc.vegetation = GLOB.vegetations[vegetation_type]

/obj/terrain_modifier/vegetation/barren
	icon_state = "barren"
	vegetation_type = /datum/vegetation/barren

/obj/terrain_modifier/vegetation/sparse
	icon_state = "sparse"
	vegetation_type = /datum/vegetation/sparse

/obj/terrain_modifier/vegetation/grass
	icon_state = "grass"
	vegetation_type = /datum/vegetation/grass

/obj/terrain_modifier/vegetation/woods
	icon_state = "woods"
	vegetation_type = /datum/vegetation/woods

/obj/terrain_modifier/vegetation/forest
	icon_state = "forest"
	vegetation_type = /datum/vegetation/forest

/obj/terrain_modifier/strait
	name = "strait"
	icon_state = "strait"
	layer = 3.6

/obj/terrain_modifier/strait/apply_changes(turf/water/turf_loc)
	if(!istype(turf_loc))
		return
	switch(dir)
		if(NORTH, SOUTH)
			turf_loc.strait_connections = NORTH|SOUTH
		if(EAST, WEST)
			turf_loc.strait_connections = EAST|WEST
		if(NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
			turf_loc.strait_connections = dir

/obj/terrain_modifier/river
	name = "river"
	icon_state = "river"
	layer = 3.2

/obj/terrain_modifier/river/apply_changes(turf/ground/turf_loc)
	if(!istype(turf_loc))
		return
	turf_loc.river = dir

/obj/terrain_modifier/settlement
	name = "broken settlement"
	icon_state = "settlement"
	layer = 3.3
	var/datum/nation/nation_type
	var/population = list()
	var/buildings = list()

/obj/terrain_modifier/settlement/apply_changes(turf/ground/turf_loc)
	if(!istype(turf_loc))
		return
	turf_loc.location_name = name
	turf_loc.population = population
	for(var/datum/building/building as anything in buildings)
		building = new building()
		building.add_to(turf_loc)
	if(nation_type)
		var/datum/nation/nation = GLOB.nations[nation_type]
		nation.conquer_location(turf_loc, peaceful = TRUE)

/obj/terrain_modifier/material
	name = "material modifier"
	icon = 'icons/materials.dmi'
	layer = 3.4
	var/datum/material/material_type

/obj/terrain_modifier/material/apply_changes(turf/ground/turf_loc)
	if(!istype(turf_loc))
		return
	turf_loc.material = GLOB.materials[material_type]

/obj/terrain_modifier/material/fish
	icon_state = "fish"
	material_type = /datum/material/fish

/obj/terrain_modifier/material/grain
	icon_state = "grain"
	material_type = /datum/material/fish
