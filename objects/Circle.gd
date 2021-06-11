extends Area2D

onready var orbit_position = $Pivot/OrbitPosition
var chars = ["A","B","C","D","E","F","G","H","I","J","K","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
var radius = 100
var rotation_speed = PI
var count=0

func init(_position, _count):
	position = _position
	count  = _count
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.radius = radius
	var img_size = $Sprite.texture.get_size().x / 2
	$Sprite.scale = Vector2(1, 1) * radius / img_size
	orbit_position.position.x = radius + 25
	rotation_speed *= pow(-1, randi() % 2)
	if count<chars.size():
		$Content.text = chars[count]
	else :
		count=0
func _process(delta):
	$Pivot.rotation += rotation_speed * delta
