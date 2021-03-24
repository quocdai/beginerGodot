extends Area2D

signal captured
signal died
onready var trail = $Trail/Points

var velocity = Vector2(100, 0)
var jump_speed = 1000
var target = null
var trail_length = 25

func _unhandled_input(event):
	if target and event is InputEventScreenTouch and event.pressed:
		jump()
		
func jump():
	target.implode()
	target = null
	velocity = transform.x * jump_speed
	if Settings.enable_sound:
		$Jump.play()

func _on_Jumper_area_entered(area):
	target = area
	velocity = Vector2.ZERO
	emit_signal("captured", area)
	if Settings.enable_sound:
		$Capture.play()
	
func _physics_process(delta):
	if trail.points.size() > trail_length:
		trail.remove_point(0)
	trail.add_point(position)
	
	if target:
		transform = target.orbit_position.global_transform
	else:
		position += velocity * delta
		
func die():
	target = null
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	if !target:
		emit_signal("died")
		die()
func _ready():
	$Sprite.material.set_shader_param("color",Settings.theme["player_body"])
	$Trail/Points.default_color = Settings.theme["player_trail"]
