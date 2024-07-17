extends KinematicBody2D

export var ACCEL = 75
export var FRICTION = 50
export var SPEED = 200
export var HP = 15

onready var timer = $RefreshTimer
onready var state_machine = $AnimationTree.get("parameters/playback")

var velocity = Vector2.ZERO
var hurt = false
var dead = false
var over = false

var bullet = preload("res://Characters/Bullet2.tscn")

var endgame = preload("res://scenes/Menu.tscn")

func _ready():
	add_to_group("enemy_killed")

func _physics_process(_delta):
	var input_vector = Vector2.ZERO

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	var enemy = get_tree().get_root().find_node("Player1", true, false)
	
	if input_vector != Vector2.ZERO:
		if !dead:
			look_at(enemy.position)
			velocity = velocity.move_toward(input_vector * SPEED, ACCEL)
			state_machine.travel("Walk")
		
	else:
		if !dead:
			look_at(enemy.position)
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
			state_machine.travel("Idle")

	velocity = move_and_slide(velocity)

	if Input.is_action_just_pressed("mouse_left"):
		if !dead:
			shoot()
		
	if hurt:
		state_machine.travel("Hurt")
		enemy_killed()
		hurt=false
	if dead:
		velocity = Vector2.ZERO
		death()

func death():
	state_machine.travel("Death")
	dead = true
	over = true

func enemy_killed():
	var enemylives_remaining = get_parent().get_node("Player1").get("HP")
	if enemylives_remaining == 0:
		game_over("W2")

func shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.initialize(get_global_position(), rotation_degrees)
	get_parent().add_child(bullet_instance)
	bullet_instance.state_machine.travel("Thrown")

func game_over(status):
	if !dead:
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
	var ending = endgame.instance()
	ending.initialize(status)
	get_tree().get_root().add_child(ending)
	var _return = get_tree().change_scene_to(ending)

func _on_RefreshTimer_timeout():
	enemy_killed()

func _on_HitBox_body_entered(body):
	if !over:
		get_tree().call_group("enemy_killed", "enemy_killed")
		HP-=1
		hurt = true
		if HP==0:
			$AudioStreamPlayer2.play()
			death()

