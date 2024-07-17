extends CanvasLayer

onready var control = $Control
onready var count_enemies = $Control/CenterContainer/HBoxContainer/CountEnemiesL
onready var count_hp = $Control/CenterContainer2/HBoxContainer/CountVidas

var starting_enemies
var starting_lives


func _ready():
	add_to_group("enemy_killed")

func enemy_killed():
	var enemies_remaining = get_parent().get_node("Enemies").get_child_count()
	count_enemies.text = str(enemies_remaining) + " / " + str(starting_enemies)
	var player_hp = get_parent().get_node("Player").get("HP")
	count_hp.text = str(player_hp)+" / " + str(starting_lives)
	
