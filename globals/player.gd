extends Node

var move_speed := 200
var acceleration := 1200.0
var deceleration := 1000.0
var jump_velocity := -300.0
var gravity := 1200.0
var max_jump_time := 0.2
var jump_boost_velocity := -250.0
var fast_fall_multiplier := 2.5         # Verstärkte Gravitation beim Runterfallen
var low_gravity_multiplier := 0.5       # Weniger Gravitation beim Halten der Sprungtaste
