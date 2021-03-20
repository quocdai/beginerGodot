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
func _draw():
	if jumper:
		var r = ((radius - 50) / num_orbits) * (1 + num_orbits - current)
		draw_circle_arc_poly(Vector2.ZERO,r+10,orbit_start + PI/2,$Pivot.rotation,color(1,0,0))
		
func draw_circle_arc_poly(center, radius, angle_from, angle_to,color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc,colors)
