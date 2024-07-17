extends Node2D

export var enemy_count = 20
export var lives_count = 2

onready var enemies = $Enemies
onready var spawn_points = $SpawnPoints
onready var ui = $UI

var enemy = preload("res://Characters/Enemy.tscn")
var player = preload("res://Characters/Player.tscn")

func _ready():
	$AudioStreamPlayer1.play()
	var potential_spawns = spawn_points.get_children()
	potential_spawns.shuffle()
	
	for i in range(enemy_count):
		var enemy_instance = enemy.instance()
		var next_spawn = potential_spawns.pop_front()
		enemy_instance.position = next_spawn.position
		enemies.add_child(enemy_instance)
	lives_count = player.instance().HP
	

	ui.starting_enemies = enemy_count
	ui.starting_lives = lives_count
