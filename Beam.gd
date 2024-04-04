extends StaticBody

onready var rayCast = $RayCast;
onready var rayMesh = $RayMesh;

var beamDirection = null;

func _ready():
	scaleAndCast();
		
func scaleAndCast(d=50):
	if beamDirection == "down":
		rayCast.cast_to = Vector3(0,0,50);
		rayMesh.set_scale(Vector3(0.1,0.1,d/2));
		rayMesh.set_translation(Vector3(0,0,d/2));
	elif beamDirection == "up":
		rayCast.cast_to = Vector3(0,0,-50);
		rayMesh.set_scale(Vector3(0.1,0.1,d*(-1)/2));
		rayMesh.set_translation(Vector3(0,0,(d*-1)/2));
	elif beamDirection == "left":
		rayCast.cast_to = Vector3(-50,0,0);
		rayMesh.set_scale(Vector3(d*(-1)/2,0.1,0.1));
		rayMesh.set_translation(Vector3(d*(-1)/2,0,0));
	elif beamDirection == "right":
		rayCast.cast_to = Vector3(50,0,0);
		rayMesh.set_scale(Vector3(d/2,0.1,0.1));
		rayMesh.set_translation(Vector3(d/2,0,0));
	else:
		print("UHOH - unrecognized beam direction (freeing beam node)");
		queue_free();

func _physics_process(delta):
	var hit = rayCast.get_collider();
	if hit != null:
		if hit.is_in_group("Player"):
			print("hit player");
			$"/root/NotWaitingForGodot/World".reset();
		elif !hit.is_in_group("Beam") && !hit.is_in_group("Player"):
			var d = get_translation().distance_to(hit.get_translation());
			scaleAndCast(d);
