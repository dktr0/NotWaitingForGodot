extends StaticBody3D

@onready var rayCast = $RayCast3D;
@onready var rayMesh = $RayMesh;

var beamDirection = null;
var on = true;
var _class = null;
var aspects = {};

func parseAspects():
	on = aspects.get("on",on);
	_class = aspects.get("class",_class);
	beamDirection = aspects.get("beam","down");
	
func turnOn():
	on = true;
	scaleAndCast();
	
func turnOff():
	on = false;
	rayCast.target_position = Vector3(0,0,0);
	rayMesh.set_scale(Vector3(0,0,0));
	rayMesh.set_position(Vector3(0,0,0));
	
func _ready():
	parseAspects();
	if on:
		turnOn();
	else:
		turnOff();
	
func scaleAndCast(d=50):
	if beamDirection == "down":
		rayCast.target_position = Vector3(0,0,d);
		rayMesh.set_scale(Vector3(0.1,0.1,d));
		rayMesh.set_position(Vector3(1,1,d/2.0));
	elif beamDirection == "up":
		rayCast.target_position = Vector3(0,0,d*(-1));
		rayMesh.set_scale(Vector3(0.1,0.1,d));
		rayMesh.set_position(Vector3(1,1,(d*-1)/2.0));
	elif beamDirection == "left":
		rayCast.target_position = Vector3(d*(-1),0,0);
		rayMesh.set_scale(Vector3(d,0.1,0.1));
		rayMesh.set_position(Vector3(d*(-1.0)/2.0,1,1));
	elif beamDirection == "right":
		rayCast.target_position = Vector3(d,0,0);
		rayMesh.set_scale(Vector3(d,0.1,0.1));
		rayMesh.set_position(Vector3(d/2.0,1,1));
	else:
		print("UHOH - unrecognized beam direction (freeing beam node)");
		queue_free();

func _physics_process(_delta):
	if on:
		var hit = rayCast.get_collider();
		if hit != null:
			if hit.is_in_group("Player"):
				print("hit player");
				$"/root/NotWaitingForGodot/World".reset();
			elif !hit.is_in_group("Player"):
			# elif !hit.is_in_group("Beam") && !hit.is_in_group("Player"):
				var d = get_position().distance_to(hit.get_position());
				scaleAndCast(d);
