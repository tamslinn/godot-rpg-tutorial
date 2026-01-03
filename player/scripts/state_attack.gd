class_name StateAttack extends State

var attacking : bool = false

@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelerate_speed : float = 5.0

@onready var walk_state : State = $"../Walk"
@onready var idle_state : State = $"../Idle"
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim : AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio_player: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"
@onready var hurt_box: HurtBox = %AttackHurtBox

## What happens when the player enters this state
func enter() -> void:
	attacking = true
	attack_anim.play("attack_" + player.get_anim_direction())
	player.update_animation("attack")
	audio_player.stream = attack_sound
	audio_player.pitch_scale = randf_range(0.9,1.1)
	audio_player.play()
	
	animation_player.animation_finished.connect(end_attack)
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	
## What happens when the player exits this state	
func exit() -> void:
	hurt_box.monitoring = false
	animation_player.animation_finished.disconnect(end_attack)
	
## What happens during the _process update in this state	
func process(delta: float) -> State:
	# slow down gradually if moving
	player.velocity -= player.velocity * decelerate_speed * delta
	# if attack finished, switch state
	if not attacking:
		if player.direction != Vector2.ZERO:
			return walk_state
		else:
			return idle_state
	return null
	
## What happens during the _physics update in this state	
func physics(_delta: float) -> State:
	return null
	
## What happens with inout events in this state
func handle_input(_event: InputEvent) -> State:
	return null
	
func end_attack(_new_animation_name : String) -> void:
	attacking = false
