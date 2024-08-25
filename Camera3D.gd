extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var speed = .1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("w"):
		position.z -= speed
	if Input.is_action_pressed("s"):
		position.z += speed
	if Input.is_action_pressed("a"):
		position.x -= speed
	if Input.is_action_pressed("d"):
		position.x += speed
	pass
