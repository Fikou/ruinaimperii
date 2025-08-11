GLOBAL_LIST_INIT(climates, initialize_climates())

/proc/initialize_climates()
	. = list()
	for(var/climate in subtypesof(/datum/climate))
		.[climate] = new climate()

/datum/climate
	var/name = "broken climate"
	var/desc = "Report this!"

/datum/climate/arctic
	name = "Arctic"

/datum/climate/continental
	name = "Continental"

/datum/climate/oceanic
	name = "Oceanic"

/datum/climate/mediterranean
	name = "Mediterranean"

/datum/climate/semiarid
	name = "Semiarid"

/datum/climate/arid
	name = "Arid"

/datum/climate/wastes
	name = "Wastes"
	desc = "Inhospitable to human life, these provinces can't be moved on by an army or settled."
