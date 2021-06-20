extends CanvasLayer

func show_message(text):
	$Message.text = text
func hide():
	$ScoreBox.hide()
func show():
	$ScoreBox.show()
