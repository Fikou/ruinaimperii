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

/datum/nation/wessex
	name = "Wessex"
	color = "#cc0000"

/datum/nation/eire
	name = "Eire"
	color = "#00cc00"

/datum/nation/pictavia
	name = "Pictavia"
	color = "#0000cc"