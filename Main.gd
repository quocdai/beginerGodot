extends Node

var Circle = preload("res://objects/Circle.tscn")
var Jumper = preload("res://objects/Jumper.tscn")

var player
var count=0
func _ready():
	randomize()
	new_game()
	
func new_game():
	$Camera2D.position = $StartPosition.position
	player = Jumper.instance()
	player.position = $StartPosition.position
	add_child(player)
	player.connect("captured",self,"_on_Jumper_captured")
	spawn_circle($StartPosition.position)
	
func spawn_circle(_position=null):
	var c = Circle.instance()
	if !_position:
		_position = player.target.position + Vector2(rand_range(-150, 150), rand_range(-500, -400))
	add_child(c)
	count +=1
	c.init(_position,count)
	
func _on_Jumper_captured(object):
	$Camera2D.position = object.position
	call_deferred("spawn_circle")
