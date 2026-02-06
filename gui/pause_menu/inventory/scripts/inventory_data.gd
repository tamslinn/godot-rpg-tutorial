class_name InventoryData extends Resource

@export var slots : Array [SlotData]

# equivalent of ready but for a resource
func _init() -> void:
	_connect_slots

func add_item( item : ItemData, count : int = 1) -> bool:
	for s in slots:
		if s:
			if s.item_data == item:
				s.quantity += count
				return true
		
	for i in slots.size():
		if slots[i] == null:
			var newSlot = SlotData.new()
			newSlot.item_data = item
			newSlot.quantity = count
			slots[i] = newSlot
			newSlot.changed.connect(_slot_changed)
			return true
			
	print("inventory was full!")
	return false

func _connect_slots() -> void:
	for s in slots:
		if s:
			s.changed.connect(_slot_changed)
			
func _slot_changed() -> void:
	for s in slots:
		if s:
			if s.quantity < 1:
				s.changed.disconnect(_slot_changed)
				var i = slots.find(s)
				slots [i] = null
				emit_changed()
