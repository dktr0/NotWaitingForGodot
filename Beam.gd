extends StaticBody

onready var rayCast = $RayCast;
onready var rayMesh = $RayMesh;

var beamDirection = null;

func _ready():
	if beamDirection == "down":
		rayCast.cast_to = Vector3(0,0,50);
	elif beamDirection == "up":
		rayCast.cast_to = Vector3(0,0,-50);
	elif beamDirection == "left":
		rayCast.cast_to = Vector3(-50,0,0);
	else:
		rayCast.cast_to = Vector3(50,0,0);

func _physics_process(delta):
	var hit = rayCast.get_collider();
	if hit != null:
		if !hit.is_in_group("Beam"):
			var d = get_translation().distance_to(hit.get_translation());
			print(str(d));
			if(beamDirection == "down"):
				rayMesh.set_scale(Vector3(0.1,0.1,d/2));
				rayMesh.set_translation(Vector3(0,0,d/2));
			if(beamDirection == "up"):
				rayMesh.set_scale(Vector3(0.1,0.1,d*(-1)/2));
				rayMesh.set_translation(Vector3(0,0,(d*-1)/2));
			if(beamDirection == "left"):
				rayMesh.set_scale(Vector3(d*(-1)/2,0.1,0.1));
				rayMesh.set_translation(Vector3(d*(1)/2,0,0));
			if(beamDirection == "right"):
				rayMesh.set_scale(Vector3(d/2,0.1,0.1));
				rayMesh.set_translation(Vector3(d/2,0,0));
				
