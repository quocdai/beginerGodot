extends Node

var Circle = preload("res://objects/Circle.tscn")
var Jumper = preload("res://objects/Jumper.tscn")

var player
var score = 0 setget set_score
var highscore = 0
var level = 0

func _ready():
	randomize()
	load_score()
	$HUD.hide()
	
func new_game():
	settings.hide_ad_banner()
	self.score = 0
	level = 1
	$HUD.update_score(score)
	$Camera2D.position = $StartPosition.position
	player = Jumper.instance()
	player.position = $StartPosition.position
	add_child(player)
	player.connect("captured", self, "_on_Jumper_captured")
	player.connect("died", self, "_on_Jumper_died")
	spawn_circle($StartPosition.position)
	$HUD.show()
	$HUD.show_message("Go!")
	if settings.enable_music:
		$Music.play()
	
func spawn_circle(_position=null):
	var c = Circle.instance()
	if !_position:
		var x = rand_range(-150, 150)
		var y = rand_range(-500, -400)
		_position = player.target.position + Vector2(x, y)
	add_child(c)
	c.init(_position, level)
	
func _on_Jumper_captured(object):
	$Camera2D.position = object.position
	object.capture(player)
	call_deferred("spawn_circle")
	self.score += 1

func set_score(value):
	score = value
	$HUD.update_score(score)
	if score > 0 and score % settings.circles_per_level == 0:
		level += 1
		$HUD.show_message("Level %s" % str(level))
	
func _on_Jumper_died():
	if score > highscore:
		highscore = score
		save_score()
	get_tree().call_group("circles", "implode")
	$Screens.game_over(score, highscore)
	$HUD.hide()
	if settings.enable_music:
		$Music.stop()
	settings.show_ad_interstitial()

func load_score():
	var f = File.new()
	if f.file_exists(settings.score_file):
		f.open(settings.score_file, File.READ)
		highscore = f.get_var()
		f.close()
		
func save_score():
	var f = File.new()
	f.open(settings.score_file, File.WRITE)
	f.store_var(highscore)
	f.close()




