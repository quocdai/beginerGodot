extends Node

var Circle = preload("res://objects/Circle.tscn")
var Jumper = preload("res://objects/Jumper.tscn")

var player
var count=-1
var score = 0
func _ready():
	randomize()
	$HUB.hide()
	
func new_game():
	$Camera2D.position = $StartPosition.position
	player = Jumper.instance()
	player.position = $StartPosition.position
	add_child(player)
	player.connect("captured", self, "_on_Jumper_captured")
	player.connect("died", self, "_on_Jumper_died")
	spawn_circle($StartPosition.position)
	$HUB.show()
	if Settings.enable_music:
		$Music.play()
	
func spawn_circle(_position=null):
	var c = Circle.instance()
	if !_position:
		var x = rand_range(-150, 150)
		var y = rand_range(-500, -400)
		_position = player.target.position + Vector2(x, y)
	add_child(c)
	count +=1
	score +=1
	if count==c.chars.size():
		count=0
	c.init(_position,count)
	$HUB.update_score(score)
	
func _on_Jumper_captured(object):
	$Camera2D.position = object.position
	object.capture(player)
	call_deferred("spawn_circle")
	
func _on_Jumper_died():
	get_tree().call_group("circles", "implode")
	$Screens.game_over()
	$HUB.hide()
	
