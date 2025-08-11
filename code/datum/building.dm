/datum/building
	var/name = "broken building"
	var/desc = "Report this!"
	var/list/employment_requirements = list()

/datum/building/proc/add_to(turf/ground/location)
	location.buildings += src