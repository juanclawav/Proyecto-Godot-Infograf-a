extends Node2D


func _ready():
	var _return = get_tree().change_scene("res://scenes/Menu.tscn")
	queue_free()

