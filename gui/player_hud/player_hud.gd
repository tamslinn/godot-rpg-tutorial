extends CanvasLayer

var hearts : Array[HeartGui] = []

func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGui:
			hearts.append(child)
			child.visible = false
	pass
	
func update_hp(hp : int, max_hp:  int) -> void :
	update_max_hp(max_hp)
	for i in max_hp:
		update_heart(i, hp)
	
	
func update_heart( index : int, hp : int) -> void:
	var val : int = clampi (hp  - index * 2, 0, 2)
	hearts[index].value = val

func update_max_hp( max_hp : int) -> void:
	var heart_count : int = roundi(max_hp/2)
	for i in hearts.size():
		if i < heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass
