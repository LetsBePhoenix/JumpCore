extends Node2D

@onready var buttonMap1 = $Map1
var chosenMap = 1
var lobbyTimer = 0

func _physics_process(delta: float) -> void:
	if lobbyTimer >= glob_lobby.timeSleep:
		lobbyTimer = 0
		if Input.get_action_strength("map_next"):
			chosenMap += 1
		elif Input.get_action_strength("map_bevore"):
			chosenMap -= 1
		if chosenMap <= 0:
			chosenMap = 1
		elif chosenMap >= glob_lobby.maxMaps:
			chosenMap = glob_lobby.maxMaps
		if Input.get_action_raw_strength("game_start"):
			if chosenMap == 1:
				get_tree().root.add_child(load("res://szenes/map/map.tscn").instantiate())
				queue_free()
			# Weitere Karten
		print(chosenMap)
	lobbyTimer += 1
