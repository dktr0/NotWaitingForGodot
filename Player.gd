extends KinematicBody

func _ready():
	var camera = Camera.new();
	camera.name ="Camera";
	add_child(camera);
