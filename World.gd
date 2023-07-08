extends Spatial

func _ready():
	makeACube(0,0,-10);
	makeACube(3,0,-10);
	makeACube(-3,0,-10);
			  
func makeACube(x,y,z):
	print("makeACube(" + str(x) + "," + str(y) + "," + str(z) + ")");
	var m = MeshInstance.new();
	var cm = CubeMesh.new();
	var sm = SpatialMaterial.new();
	sm.albedo_color = Color( 1, 0, 0, 1 );
	cm.material = sm;
	m.mesh = cm;
	m.translation = Vector3(x,y,z);
	add_child(m);
	
