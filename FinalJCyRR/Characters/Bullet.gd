extends RigidBody2D

export var SPEED = 500
export var FADE_OUT = 0.5

onready var animation = $AnimationPlayer
onready var timer = $Timer
onready var state_machine = $AnimationTree.get("parameters/playback")

func initialize(new_position, new_rotation):
	position = new_position
	rotation_degrees = new_rotation

func _ready():
	apply_impulse(Vector2(), Vector2(SPEED,0).rotated(rotation))
	$AudioStreamPlayer.play()

func _on_Bullet_body_entered(body):
	if !body.name == "TileMap":
		$AudioStreamPlayer1.play()
	timer.start(FADE_OUT)
	state_machine.travel("FadeOut")

func _on_Timer_timeout():
	queue_free()
