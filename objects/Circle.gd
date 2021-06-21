extends Area2D

onready var orbit_position = $Pivot/OrbitPosition

enum MODES {STATIC, LIMITED}

var radius = 100
var rotation_speed = PI
var mode = MODES.STATIC
var num_orbits = 5 
var current_orbits = 0
var orbit_start = null
var jumper = null
var links=["res://assets/png/1.png","res://assets/png/2.png","res://assets/png/3.png"]
var chars = ["A","B","C","D","E","F","G","H","I","J","K","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
var count =0
func init(_position,_count, _radius=radius, _mode=MODES.LIMITED):
	set_mode(_mode)
	position = _position
	radius = _radius
	count = _count
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.radius = radius
	orbit_position.position.x = radius + 25
	rotation_speed *= pow(-1, randi() % 2)
	#$Sprite.texture = load(links[rand_range(0, 3)])
	$Label.text = chars[count]
func set_mode(_mode):
	mode = _mode
	match mode:
		MODES.STATIC:
			$Label.hide()
		MODES.LIMITED:
			current_orbits = num_orbits
			$Label.show()
			
func _process(delta):
	$Pivot.rotation += rotation_speed * delta
	if mode == MODES.LIMITED and jumper:
		check_orbits()
		update()

func check_orbits():
	if abs($Pivot.rotation - orbit_start) > 2 * PI:
		current_orbits -= 1
		if Settings.enable_sound:
			$Beep.play()
		if current_orbits <= 0:
			jumper.die()
			jumper = null
			implode()
		orbit_start = $Pivot.rotation
		
func implode():
	queue_free()
	
func capture(target):
	jumper = target
	$Pivot.rotation = (jumper.position - position).angle()
	orbit_start = $Pivot.rotation
		
