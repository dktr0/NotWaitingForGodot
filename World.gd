extends Spatial

var frame = 0;
var rng = RandomNumberGenerator.new()
var j = 0; #x position
var k = 0; #y-position

func _ready():
	#makeACube(0,0,-10);
	#makeACube(3,0,-10,0,1,0);
	#makeACube(-3,0,-10,0,0,1);
	#makeACube(3.5,1,-9,1,6,1);
	cubeMesh(0,-2,-10,30,30);
	cubeRow("++ + +++++",0,0,-10);
	cubeRow("++ +    ++",0,0,-8);



func _physics_process(_delta):
	pass
	#frame = frame + 1;
	#if frame%60 == 0:
#		var random_number_A = rng.randf_range(0.0, 1.0)
#		var random_number_B = rng.randf_range(0.0, 1.0)
#		var random_number_C = rng.randf_range(0.0, 1.0)
#		makeACube(6+3*j,0,-10,random_number_A,random_number_B, random_number_C);
#		makeACube(-(6+3*j),0,-10,random_number_A,random_number_B,random_number_C);
#		j = j+1;

				

func makeACube(x=0,y=0,z=0,r=1,g=0,b=0):
	var m = MeshInstance.new();
	var cm = CubeMesh.new();
	var sm = SpatialMaterial.new();
	sm.albedo_color = Color( r, g, b, 1 );
	cm.material = sm;
	m.mesh = cm;
	m.translation = Vector3(x,y,z);
	add_child(m);

func cubeRow(spec="",x=0,y=0,z=0,xInc=2,zInc=0):
	var head = spec.substr(0,1);
	var tail = spec.substr(1,-1);
	while head.length() > 0:
		if head != " ":
			print("putting a cube at " + str(x) + " " + str(y) + " " + str(z));
			makeACube(x,y,z);
		x = x + xInc;
		z = z + zInc;
		head = tail.substr(0,1);
		tail = tail.substr(1,-1);
		
func cubeMesh(x=0,y=0,z=0,xN=10,zN=10):
	print("cubemesh")
	for n1 in xN:
		for n2 in zN:
			var calcX = x + n1;
			var calcZ = z + n2;
			print("putting a cubemesh at " + str(calcX) + " " + str(y) + " " + str(calcZ));
			makeACube(calcX,y,calcZ,0,1,0);
