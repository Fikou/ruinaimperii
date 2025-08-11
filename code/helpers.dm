/proc/to_chat(who, text)
	who << text

/proc/print(...)
	var/printed_string = ""
	var/i = 1
	for(var/arg in args)
		printed_string += "[arg][i == length(args) ? "" : " "]"
	world << printed_string
	world.log << printed_string

/proc/subtypesof(type)
    return typesof(type) - type

/proc/global_chat(text)
	for(var/client/client as anything in GLOB.clients)
		to_chat(client, text)

/proc/capitalize(text)
	. = text
	if(text)
		. = text[1]
		return uppertext(.) + copytext(text, 1 + length(.))
