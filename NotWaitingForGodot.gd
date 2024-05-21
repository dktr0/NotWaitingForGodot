extends Spatial

#onready var player = $Player;
#onready var camera = $Player/Camera;


func _physics_process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.set_window_fullscreen(!OS.window_fullscreen);


func _on_request_completed(result, response_code, headers, body):
	print("here...")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print("here here here...")
