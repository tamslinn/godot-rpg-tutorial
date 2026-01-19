class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction : Vector2 )
signal enemy_damaged()

const directions = [Vector2.RIGHT, 
					Vector2.DOWN, 
					Vector2.LEFT, 
					Vector2.UP ]
@export var hp : int = 3

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

var player : Player
var invulnerable : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
#@onready var hit_box : HitBox = $HitBox
@onready var state_machine : EnemyStateMachine = $EnemyStateMachine


func _ready() -> void:
	state_machine.initialize(self)
	player = PlayerManager.player


func _physics_process(delta: float) -> void:
	move_and_slide()
	
func set_direction(_new_direction : Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
		
	## times by cardinal direction to keep facing in first direction if you press two keys	
	var direction_id : int = int( round ((direction + cardinal_direction * 0.1).angle() / TAU * directions.size()))
	
	var new_direction = directions[direction_id]
		
	if new_direction == cardinal_direction:
		return false
	cardinal_direction = new_direction	
	direction_changed.emit(new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
func update_animation(state : String) -> void:
	animation_player.play(state + "_" + get_anim_direction())
	pass
	
func get_anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
