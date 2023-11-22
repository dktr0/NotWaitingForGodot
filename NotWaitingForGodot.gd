extends Spatial

#onready var player = $Player;
#onready var camera = $Player/Camera;

func _physics_process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.set_window_fullscreen(!OS.window_fullscreen);
