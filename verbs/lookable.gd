class_name Lookable extends GameObject


@export var description: String = ""


static func look_around(objs: Array[GameObject]) -> Array[String]:
	var lookables: Array[String] = []
	for o in objs:
		if o.is_in_view() and o.has_node("Lookable"):
			lookables.append(o.get_node("Lookable").look())
	return lookables


func look() -> String:
	return description
