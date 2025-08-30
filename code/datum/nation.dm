GLOBAL_LIST_INIT(nations, initialize_nations())

/proc/initialize_nations()
	. = list()
	for(var/nation in subtypesof(/datum/nation))
		.[nation] = new nation()

/datum/nation
	var/name = "Fikland"
	var/money = 0
	var/color = "#ffaa00"
	var/ckey
	var/flag = "fikland"
	var/list/locations = list()
	var/list/provinces = list()

/datum/nation/proc/conquer_location(turf/ground/location, peaceful = FALSE)
	location.color = color

/datum/nation/wessex
	name = "Wessex"
	color = list(0.5, 0, 0, 0.5, 0, 0, 0.5, 0, 0)

/datum/nation/eire
	name = "Eire"
	color = list(0, 0.5, 0, 0, 0.5, 0, 0, 0.5, 0)

/datum/nation/pictavia
	name = "Pictavia"
	color = list(0, 0.1, 0.5, 0, 0.1, 0.5, 0, 0.1, 0.5)