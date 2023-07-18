extends KinematicBody

var velocity = Vector3();
var fall = Vector3();
var speed = 18;
var acceleration = 6;
var gravity = 1;
var jump = 18;
var mouse_sensitivity = 0.05;

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var camera = Camera.new();
	camera.name ="Camera";
	add_child(camera);
	# TODO: need to add collision shape from code instead of in node graph

func _input(event):	
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity)) 
		$Camera.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity)) 
		$Camera.rotation.x = clamp($Camera.rotation.x, deg2rad(-90), deg2rad(90))
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if global_translation.y > 0:
		move_and_slide(fall, Vector3.UP)
	if not is_on_floor():
		fall.y -= gravity
	if Input.is_action_just_pressed("a_button") and is_on_floor():
		fall.y = jump
	var leftStick = Input.get_vector("left_stick_left","left_stick_right","left_stick_up","left_stick_down");
	var rightStick = Input.get_vector("right_stick_left","right_stick_right","right_stick_up","right_stick_down");
	rotate_y(-rightStick.x*0.04); 
	var camera = $Camera;
	camera.rotation.x -= rightStick.y * 0.04;
	camera.rotation.x = clamp(camera.rotation.x, deg2rad(-90), deg2rad(90));
	var xMove = leftStick.x;
	var zMove = leftStick.y;
	var direction = Vector3(0,0,0);
	direction += xMove * transform.basis.x;
	direction += zMove * transform.basis.z;
	if direction.length() > 1:
		direction = direction.normalized();
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta);
	velocity = move_and_slide(velocity, Vector3.UP);

