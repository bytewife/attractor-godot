extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var rad = 60#120

var z_off = 20

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.



var t = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta/4
	var nx = rad * sin(t)
	var nz = rad * cos(t)
	transform.origin.x = nx
	transform.origin.z = nz + z_off
	
	look_at(Vector3(0,0,z_off),Vector3(0,1,0))
	#var target_position = Vector2(0,0)
	#var here = Vector2(transform.origin.x, transform.origin.z)
	#var angle = here.angle_to_point(target_position)
	#var deg = rad2deg(angle)
	#rotation.y = deg
	pass
