class_name InventoryUI extends Control

const INVENTORY_SLOT = preload("res://gui/pause_menu/inventory/inventory_slot.tscn")
@export var data : InventoryData

var focus_index : int = 0


func _ready() -> void:
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	data.changed.connect(_on_inventory_changed)
	clear_inventory()
	
func clear_inventory() -> void:
	for c in get_children():
		c.queue_free()
		
func update_inventory() -> void:
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = s
		new_slot.focus_entered.connect(_on_focus_entered)
		
		
	get_child(0).grab_focus()

func _on_focus_entered():
	for i in get_child_count():
		if get_child(i).has_focus():
			focus_index = i
			return
	
func _on_inventory_changed() -> void:
	var i = focus_index
	clear_inventory()
	update_inventory()
	await get_tree().process_frame
	get_child(i).grab_focus()
