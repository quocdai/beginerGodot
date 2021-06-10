extends Area2D

onready var orbit_position = $Pivot/OrbitPosition

var radius = 100

var rotation_speed = PI

func _ready():
	init()

func init(_radius=radius):
	radius = _radius
	$CollisionShade2D.shape = $CollisionShade2D.shade.duplicate()
	$CollisionShade2D.shape.radius = radius
	var img_size = $sprite.texture.get_size().x / 2
	$Sprite.scale = Vector2(1,1) * radius / img_size
	orbit_position.position.x = radius + 25
func _process(delta):
	$Pivot.rotation += rotation_speed * delta
