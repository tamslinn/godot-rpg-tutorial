class_name HeartGui extends Control


@onready var sprite: Sprite2D = $Sprite2D

var value : int = 2 :
	set(v):
		value = v
		update_sprite()

func update_sprite() -> void:
	sprite.frame = value
