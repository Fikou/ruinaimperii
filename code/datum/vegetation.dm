GLOBAL_LIST_INIT(vegetations, initialize_vegetations())

/proc/initialize_vegetations()
    . = list()
    for(var/vegetation in subtypesof(/datum/vegetation))
        .[vegetation] = new vegetation()

/datum/vegetation
    var/name = "broken vegetation"
    var/desc = "Report this!"

/datum/vegetation/barren
    name = "Barren"

/datum/vegetation/sparse
    name = "Sparse"

/datum/vegetation/grass
    name = "Grass"

/datum/vegetation/woods
    name = "Woods"

/datum/vegetation/forest
    name = "Forest"