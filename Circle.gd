extends Area2D
onready var orbit_position = $Pivot/OrbitPosition
onready var tween = get_node("Tween")

var radius = 100
var rotation_speed = PI
	
func init(_position,_radius=radius):
	position=_position
	radius = _radius
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.radius = radius
	var img_size = $Sprite.texture.get_size().x/2
	$Sprite.scale = Vector2.ONE*radius / img_size
	orbit_position.position.x = radius+25
	rotation_speed *= pow(-1,randi())
func _process(delta):
	$Pivot.rotation += rotation_speed * delta
func _ready():
	self.scale = Vector2.ZERO
	print("ready")
	tween.interpolate_property(self,"transform/scale",Vector2(1,1),Vector2(1.5,1.5),1.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	tween.start()
