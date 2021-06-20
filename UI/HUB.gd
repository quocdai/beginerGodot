extends CanvasLayer

func hide():
	$ScoreBox.hide()
func show():
	$ScoreBox.show()
func update_score(value):
	$ScoreBox/HBox/Score.text = str(value)
