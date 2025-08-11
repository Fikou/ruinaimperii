GLOBAL_LIST_INIT(materials, initialize_materials())

/proc/initialize_materials()
    . = list()
    for(var/material in subtypesof(/datum/material))
        .[material] = new material()

/datum/material
    var/name = "broken material"
    var/icon_state = ""
    var/value = 1
    var/nutrition = 0

/datum/material/fish
    name = "fish"
    icon_state = "fish"
    value = 1.25
    nutrition = 1

/datum/material/grain
    name = "grain"
    icon_state = "grain"
    value = 2
    nutrition = 1.5