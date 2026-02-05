class_name InventorySlotUI extends Button

var slot_data : SlotData : set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
	focus_entered.connect(_item_focused)
	focus_exited.connect(_item_exited)
	
func set_slot_data( data : SlotData) -> void:
	slot_data = data
	if slot_data == null:
		return
	texture_rect.texture = slot_data.item_data.texture
	label.text = str(slot_data.quantity)

func _item_focused() -> void:
	if slot_data == null:
		return
	PauseMenu.update_item_description(slot_data.item_data.description)
	
func _item_exited() -> void:
	PauseMenu.update_item_description("")
