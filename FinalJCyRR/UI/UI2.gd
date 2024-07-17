extends CanvasLayer

onready var control = $Control
onready var count_hp1 = $Control/CenterContainer2/HBoxContainer/CountVidas
onready var count_hp2 = $Control/CenterContainer3/HBoxContainer/CountVidas2

var starting_lives

func _ready():
	add_to_group("enemy_killed")

func enemy_killed():
	
	var player1_hp = get_parent().get_node("Player1").get("HP")
	count_hp1.text = str(player1_hp)+" / " + str(starting_lives)
	
	var player2_hp = get_parent().get_node("Player2").get("HP")
	count_hp2.text = str(player2_hp)+" / " + str(starting_lives)
	
