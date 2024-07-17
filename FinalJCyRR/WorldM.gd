extends Node2D

var player1 = preload("res://Characters/Player1.tscn")
var player2 = preload("res://Characters/Player2.tscn")
onready var ui = $UI2

func _ready():
	$AudioStreamPlayer.play()
	ui.starting_lives = player1.instance().HP
