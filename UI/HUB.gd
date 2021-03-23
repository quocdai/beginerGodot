extends CanvasLayer
onready var tween = get_node("Tween")
var items  = [$Message,$ScoreBox/HBoxContainer/score,$ScoreBox/HBoxContainer/showscore]
func _ready():
	 	#tween.interpolate_property(items[n],"rect_scale",Vector2.ZERO,Vector2.ONE,2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	 	#tween.start()
