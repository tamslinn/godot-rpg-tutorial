class_name SlotData extends Resource

@export var item_data : ItemData
@export var quantity : int = 0 : set = set_quantity

func set_quantity(q : int) -> void:
	quantity = q
	emit_changed()
