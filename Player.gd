extends CharacterBody3D

var fall = 0;
var speed = 18;
var acceleration = 6;
var gravity = 1;
var jump = 18;
var mouse_sensitivity = 0.05;

@onready var camera = $"/root/NotWaitingForGodot/Player/Camera3D";
@onready var world = $"/root/NotWaitingForGodot/World";

var cameraMode = 1; # 1 == first-person, 2 == top-down

var cameraMode2Zoom = 0.5; # 0-1 where 0 is max zoomed in, 1 is max zoomed out

var keys = 0;

func playerStart(x=0,y=0,z=0):
	print("changing player start " + str(x) + " " + str(y) + " " + str(z));
	global_position = Vector3(x,y,z);

func _ready():
	print("Player::ready() " + name);
	set_up_direction(Vector3.UP);

func _input(event):	
	if world.mode != 2:
		if cameraMode == 1:
			_inputMode1(event);
		else:
			_inputMode2(event);
	else:
		_inputMode1(event);

func _inputMode1(event):
	if world.mode != 2:
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity)) 
			camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity)) 
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _inputMode2(_event):
	pass

func _physics_process(delta):
	if cameraMode == 1:
		_physics_process1(delta);
	else:
		_physics_process2(delta);
		
func _physics_process1(delta):
	if global_position.y > -5:
		if not is_on_floor():
			fall -= gravity;
		elif Input.is_action_just_pressed("a_button"):
			fall = jump * world.jump;
	else:
		fall = 0;
	var leftStick = Input.get_vector("left_stick_left","left_stick_right","left_stick_up","left_stick_down");
	var rightStick = Input.get_vector("right_stick_left","right_stick_right","right_stick_up","right_stick_down");
	if world.mode != 2:
		rotate_y(-rightStick.x*0.04); 
		camera.rotation.x -= rightStick.y * 0.04;
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90));
	var xMove = leftStick.x;
	var zMove = leftStick.y;
	if world.mode == 2:
		zMove = 0;
	var direction = Vector3(0,0,0);
	direction += xMove * transform.basis.x;
	direction += zMove * transform.basis.z;
	if direction.length() > 1:
		direction = direction.normalized();
	velocity = velocity.lerp(direction * speed, acceleration * delta);
	velocity.y = fall;
	set_velocity(velocity);
	move_and_slide();
	pushThingsAround();
	
func _physics_process2(delta):
	if global_position.y > -5:
		if not is_on_floor():
			fall -= gravity;
		elif Input.is_action_just_pressed("a_button"):
			fall = jump;
	else:
		fall = 0;
	var leftStick = Input.get_vector("left_stick_left","left_stick_right","left_stick_up","left_stick_down");
	var rightStick = Input.get_vector("right_stick_left","right_stick_right","right_stick_up","right_stick_down");
	rotate_y(-rightStick.x*0.04); 
	var p = global_position;
	var cameraMaxHeight = 110;
	var cameraMinHeight = 5;
	cameraMode2Zoom = clamp(cameraMode2Zoom + (rightStick.y * 0.02),0,1);
	var cz = cameraMode2Zoom * (cameraMaxHeight - cameraMinHeight) + cameraMinHeight;
	#camera.set_global_translation(Vector3(p.x,p.y+cz,p.z));
	camera.global_position = Vector3(p.x,p.y+cz,p.z);
	camera.rotation.x = deg_to_rad(-90);
#	camera.rotation.x -= rightStick.y * 0.04;
#	camera.rotation.x = clamp(camera.rotation.x, deg2rad(-90), deg2rad(90));
	var xMove = leftStick.x;
	var zMove = leftStick.y;
	var direction = Vector3(0,0,0);
	direction += xMove * transform.basis.x;
	direction += zMove * transform.basis.z
	if direction.length() > 1:
		direction = direction.normalized();
	velocity = velocity.lerp(direction * speed, acceleration * delta);
	velocity.y = fall;
	set_velocity(velocity);
	move_and_slide();
	pushThingsAround();
	
func pushThingsAround():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i);
		if c.get_collider() is RigidBody3D:
			c.get_collider().apply_central_impulse(-c.get_normal() * 1.0);

func _on_Area_body_entered(body):
	if body.is_in_group("doors"):
		if keys>0:
			body.queue_free();
			keys = keys - 1;
			print("you have " + str(keys) + " keys");
	if body.is_in_group("keys"):
		keys = keys + 1;
		$"../SoundBank".pickup();
		print("you have " + str(keys) + " keys");
		body.queue_free();
	if body.is_in_group("collisionon_laser1"):
		world.collisionOn("laser1");
	if body.is_in_group("collisionoff_laser1"):
		world.collisionOff("laser1");
	if body.is_in_group("collisionon_laser2"):
		world.collisionOn("laser2");
	if body.is_in_group("collisionoff_laser2"):
		world.collisionOff("laser2");
	if body.is_in_group("collisionon_laser3"):
		world.collisionOn("laser3");
	if body.is_in_group("collisionoff_laser3"):
		world.collisionOff("laser3");
	if body.is_in_group("collisionon_laser4"):
		world.collisionOn("laser4");
	if body.is_in_group("collisionoff_laser4"):
		world.collisionOff("laser4");
	if body.is_in_group("collisionon_laser5"):
		world.collisionOn("laser5");
	if body.is_in_group("collisionoff_laser5"):
		world.collisionOff("laser5");
	if body.is_in_group("collisionon_laser6"):
		world.collisionOn("laser6");
	if body.is_in_group("collisionoff_laser6"):
		world.collisionOff("laser6");
	if body.is_in_group("collisionon_laser7"):
		world.collisionOn("laser7");
	if body.is_in_group("collisionoff_laser7"):
		world.collisionOff("laser7");
	if body.is_in_group("teleportto"):
		var targetID = body.targetID;
		print("teleporting to " + targetID);

func _on_area_3d_area_entered(area):
	if area.is_in_group("teleportto"):
		var targetID = area.targetID;
		print("teleporting to " + targetID);
		var nodes = get_tree().get_nodes_in_group("teleportfrom_" + targetID);
		if nodes.size() > 0:
			print("teleporting to " + targetID);
			global_position = nodes[0].global_position;
		else:
			print("warning no node with correct teleportfrom found to teleport to!");
