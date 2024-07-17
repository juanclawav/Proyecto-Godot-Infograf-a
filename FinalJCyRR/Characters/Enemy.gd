extends KinematicBody2D

export var acceleration = 30
export var distance_check = 5
export var speed = 100

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var path_timer = $PathingTimer
onready var state_machine = $AnimationTree.get("parameters/playback")

var path
var velocity = Vector2.ZERO

func _ready():
	randomize()
	path_timer.start(randf())
	state_machine.travel("Walk")
	get_tree().call_group("enemy_killed", "enemy_killed")

func _physics_process(delta):
	if not path:
		return
	var player = get_tree().get_root().find_node("Player", true, false)
	var distance_to_destination = position.distance_to(path[0])
	if distance_to_destination > distance_check:
		if !player.dead :
			look_at(player.position)
			position = position.linear_interpolate(path[0], (speed * delta) / distance_to_destination)
			var _motion = move_and_slide(Vector2.ZERO)
		else :
			state_machine.stop()
	else:
		path.remove(0)
	if position.distance_to(player.position)<35:
		state_machine.travel("Attack")

func _on_HitBox_body_entered(body):
	get_tree().call_group("enemy_killed", "enemy_killed")
	queue_free()

func _on_PathingTimer_timeout():
	get_tree().call_group("enemy_killed", "enemy_killed")
	path_timer.start(randf())
	make_path()

func make_path():
	var player = get_tree().get_root().find_node("Player", true, false)
	path = navigation.get_simple_path(position, player.position, false)

