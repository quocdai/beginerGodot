extends CanvasLayer
onready var tween = get_node("Tween")
onready var items  = [$Message,$ScoreBox/HBoxContainer/score,$ScoreBox/HBoxContainer/showscore]
func _ready():
	for n in items:
		tween.interpolate_property(n,"rect_scale",Vector2.ZERO,Vector2.ONE,0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tween.start()
func show_message(text):
	$Message.text = text
	tween.interpolate_property($Message,"modulate",Color(1, 1, 1, 0),Color(1, 1, 1, 1), 2.0,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.interpolate_property($Message,"rect_scale",Vector2.ONE,Vector2.ZERO,2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()
func hide():
	$ScoreBox.hide()
func show():
	$ScoreBox.show()
func update_score(value):
	$ScoreBox/HBoxContainer/score.text = str(value)
