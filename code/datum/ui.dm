/atom/movable/screen
	appearance_flags = PIXEL_SCALE|RESET_ALPHA|RESET_COLOR|RESET_TRANSFORM
	plane = UI_PLANE

/atom/movable/screen/Click(location, control, params)
	return

/atom/movable/screen/overlay
	mouse_opacity = 0

/atom/movable/screen/location
	name = "location view"
	icon = 'icons/ui.dmi'
	icon_state = "location"
	screen_loc = "BOTTOMLEFT"
	alpha = 230

/atom/movable/screen/location/New(spawnloc, turf/selected_location)
	var/atom/movable/screen/name = new /atom/movable/screen/overlay()
	name.maptext = "<span class='maptext'>[selected_location.location_name]</span>"
	name.maptext_width = 150
	name.maptext_x = 4
	name.maptext_y = 115
	vis_contents += name
	var/atom/movable/screen/topography = new /atom/movable/screen/overlay()
	topography.icon = 'icons/ui.dmi'
	topography.icon_state = "topvegcli"
	switch(selected_location.type)
		if(/turf/water/deep)
			topography.icon_state = "ocean"
		if(/turf/water)
			topography.icon_state = "sea"
		if(/turf/ground/plain)
			topography.icon_state = "plain"
		if(/turf/ground/wetland)
			topography.icon_state = "wetland"
		if(/turf/ground/hill)
			topography.icon_state = "hill"
		if(/turf/ground/mountain)
			topography.icon_state = "mountain"
	topography.maptext = "<span class='maptext'>Topography</span>"
	topography.maptext_width = 150
	topography.maptext_x = 4
	topography.maptext_y = 104
	vis_contents += topography
	var/atom/movable/screen/climate = new /atom/movable/screen/overlay()
	climate.icon = 'icons/ui.dmi'
	climate.icon_state = "topvegcli"
	switch(selected_location.climate.type)
		if(/datum/climate/wastes)
			climate.icon_state = "wastes"
		if(/datum/climate/arctic)
			climate.icon_state = "arctic"
		if(/datum/climate/continental)
			climate.icon_state = "continental"
		if(/datum/climate/oceanic)
			climate.icon_state = "oceanic"
		if(/datum/climate/mediterranean)
			climate.icon_state = "mediterranean"
		if(/datum/climate/semiarid)
			climate.icon_state = "semiarid"
		if(/datum/climate/arid)
			climate.icon_state = "arid"
	climate.maptext = "<span class='maptext'>Climate</span>"
	climate.maptext_width = 150
	climate.maptext_x = 106
	climate.maptext_y = 104
	vis_contents += climate
	if(istype(selected_location, /turf/ground))
		var/atom/movable/screen/vegetation = new /atom/movable/screen/overlay()
		vegetation.icon = 'icons/ui.dmi'
		vegetation.icon_state = "topvegcli"
		var/turf/ground/selected_ground = selected_location
		switch(selected_ground.vegetation.type)
			if(/datum/vegetation/barren)
				vegetation.icon_state = "barren"
			if(/datum/vegetation/sparse)
				vegetation.icon_state = "sparse"
			if(/datum/vegetation/grass)
				vegetation.icon_state = "grass"
			if(/datum/vegetation/woods)
				vegetation.icon_state = "woods"
			if(/datum/vegetation/forest)
				vegetation.icon_state = "forest"
		vegetation.maptext = "<span class='maptext'>Vegetation</span>"
		vegetation.maptext_width = 150
		vegetation.maptext_x = 56
		vegetation.maptext_y = 104
		vis_contents += vegetation
