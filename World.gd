extends Spatial

var frame = 0;
var rng = RandomNumberGenerator.new()
var j = 0; #x position
var k = 0; #y-position

func _ready():
	agasthyaReady();
	fatimaReady();
	nadiaReady();
	yakariReady();
	jamesReady();
	davidReady();
	
func davidReady():
	cubeMesh(0,-2,-10,30,30);
	cubeRow("++++++++++++++++++++",240,0,-10,2,0,1,1,0);
	cubeRow("++++++++++  ++++    ",240,0,-8,2,0,1,1,0);
	cubeRow("      ++++  ++++  ++",240,0,-6,2,0,1,1,0);
	cubeRow("++++  ++++  ++++  ++",240,0,-4,2,0,1,1,0);
	cubeRow("++++  ++++  ++++  ++",240,0,-2,2,0,1,1,0);
	cubeRow("++++    ++  ++++  ++",240,0,-0,2,0,1,1,0);
	cubeRow("++++++            ++",240,0,2,2,0,1,1,0);
	cubeRow("++++++  ++++++++++++",240,0,4,2,0,1,1,0);
	cubeRow("++++++        ++++++",240,0,6,2,0,1,1,0);
	cubeRow("++++++++++++++++++++",240,0,8,2,0,1,1,0);

func nadiaReady():
	cubeRow("++++++++++++++++++++",80,0,-10, 0 , 2, 4);
	cubeRow("  +++++++++++++  +++",80,0,-8, 0 , 2, 4);
	cubeRow("++++++++++++++   +++",80,0,-6, 0 , 2, 4);
	cubeRow("++   ++++++++++    ++",80,0,-4, 0 , 2, 4);
	cubeRow("+++  ++++++++++  ++++",80,0,-2, 0 , 2, 4);
	cubeRow("++    ++++++   ++++++",80,0,0, 0 , 2, 4);
	cubeRow("+++++  ++++++   +++++",80,0,2, 0 , 2, 4);
	cubeRow("++++++  ++++++   ++++",80,0,4, 0 , 2, 4);
	cubeRow("++    ++++++   ++++++",80,0,6, 0 , 2, 4);
	cubeRow("++   ++++++++   +++++",80,0,8, 0 , 2, 4);
	cubeRow("++   ++++++++   +++++",80,0,10, 0 , 2, 4);
	cubeRow("+++  ++++++++   +++++",80,0,12, 0 , 2, 4);
	cubeRow("    +++++++   +++++++",80,0,14, 0 , 2, 4);
	cubeRow("+++++++++++++  ++++++",80,0,16, 0 , 2, 4);
	cubeRow("++++++++++++   ++++++",80,0,18, 0 , 2, 4);
	cubeRow("+++++++++++++   ++++++",80,0,20, 0 , 2, 4);
	cubeRow("++++++++++++   ++++++++",80,0,22, 0 , 2, 4);
	cubeRow("+++++++++++++  ++++++++",80,0,24, 0 , 2, 4);
	cubeRow("+++++++++++++   ++++++++",80,0,26, 0 , 2, 4);
	cubeRow("+++++++++++++  +++++++++",80,0,28, 0 , 2, 4);	
	
func jamesReady():
	   cubeRow("++++++++++++++++    ++",200,0,-10,2,0,0,0,1);
	   cubeRow("++++++++++++++++    ++",200,0,-8,2,0,0,0,1);
	   cubeRow("++++++++++++            ++",200,0,-6,2,0,0,0,1);
	   cubeRow("+++++++++++            +++",200,0,-4,2,0,0,0,1);
	   cubeRow("++++               +++    ++++",200,0,-2,2,0,0,0,1);
	   cubeRow("++++++      +++++++++++",200,0,0,2,0,0,0,1);
	   cubeRow("++++++    ++++++++++++",200,0,2,2,0,0,0,1);
	   cubeRow("++++++    ++++++++++++",200,0,4,2,0,0,0,1);
	   cubeRow("++++++    ++++++++++++",200,0,6,2,0,0,0,1);
	   cubeRow("++++++    ++++++++++++",200,0,8,2,0,0,0,1);
	   
func agasthyaReady():
	cubeMesh(0,-2,-8,39,39);
	cubeRow("+++  + +++++++ +++++",0,0,-10);
	cubeRow("+++ ++ ++++++    +++",0,0,-8);
	cubeRow("+++    +++++++ +++++",0,0,-6);
	cubeRow("+++ +++++++    +++++",0,0,-4);
	cubeRow("+   +++++++ ++++++++",0,0,-2);
	cubeRow("+ + +++++++ ++++++++",0,0,0);
	cubeRow("+ + ++++++  ++++++++",0,0,2);
	cubeRow("+ +  +++++ +++++++++",0,0,4);
	cubeRow("+  +      ++++++++++",0,0,6);
	cubeRow("++++ +++++++++++++++",0,0,8);

func fatimaReady(): 
	cubeRow("++++  ++ +++   ++ ++",40,0,8,2,0,1,1,0);
	cubeRow(" +++ +++   ++++  +++",40,0,6,2,0,1,1,0);
	cubeRow("++++++  +++++  ++++ ",40,0,4,2,0,1,0,1);
	cubeRow("++++   +++ +++  ++++",40,0,2,2,0,0,1,0);
	cubeRow("++ +++  ++++  ++  ++",40,0,0,2,0,1,1,0);
	cubeRow("++  +++  ++  +++++ +",40,0,-2,2,0,0,1,0);
	cubeRow("++   +  +++  +++  ++",40,0,-4,2,0,0,1,1);
	cubeRow("++   ++ + +  +++  ++",40,0,-6,2,0,1,1,0);
	cubeRow("   +++ +++    ++++++",40,0,-8,2,0,0,1,0);
	cubeRow("+  ++   +++   ++  ++",40,0,-10,2,0,1,0,0);
	cubeRow("+ ++++     ++ ++ +++",40,0,-12,2,0,1,1,0);
 
func yakariReady():
	cubeMesh(0,-2,-10,30,30);
	cubeRow("++++++++++++++++++ +",160,0,-10,2,0,1,1,0);
	cubeRow("+++++    +++ +++++ +",160,0,-8,2,0,1,1,0);
	cubeRow("++++++++ +++ +++++ +",160,0,-6,2,0,1,1,0);
	cubeRow("++++++++     +++++ +",160,0,-4,2,0,1,1,0);
	cubeRow("+++    +++++ +++++ +",160,0,-2,2,0,1,1,0);
	cubeRow("++++++ +++++   ++  +",160,0,-0,2,0,1,1,0);
	cubeRow("++ +++ +++  ++ +  ++",160,0,2,2,0,1,1,0);
	cubeRow("++ +++     +++   +++",160,0,4,2,0,1,1,0);
	cubeRow("++ +++++++ +++++++++",160,0,6,2,0,1,1,0);
	cubeRow("++ +++++++ +++++++++",160,0,8,2,0,1,1,0);


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
	var sb = StaticBody.new();
	var cs = CollisionShape.new();
	cs.set_shape(BoxShape.new());
	sb.add_child(cs);
	var m = MeshInstance.new();
	var cm = CubeMesh.new();
	var sm = SpatialMaterial.new();
	sm.albedo_color = Color( r, g, b, 1 );
	cm.material = sm;
	m.mesh = cm;
	sb.add_child(m);
	sb.translation = Vector3(x,y,z);
	add_child(sb);

func cubeRow(spec="",x=0,y=0,z=0,xInc=2,zInc=0,r=1,g=0,b=0):
	var head = spec.substr(0,1);
	var tail = spec.substr(1,-1);
	while head.length() > 0:
		if head != " ":
			# print("putting a cube at " + str(x) + " " + str(y) + " " + str(z));
			makeACube(x,y,z,r,g,b);
		x = x + xInc;
		z = z + zInc;
		head = tail.substr(0,1);
		tail = tail.substr(1,-1);
		
func cubeMesh(x=0,y=0,z=0,xN=10,zN=10):
	# print("cubemesh")
	for n1 in xN:
		for n2 in zN:
			var calcX = x + (n1*2);
			var calcZ = z + (n2*2);
			# print("putting a cubemesh at " + str(calcX) + " " + str(y) + " " + str(calcZ));
			makeACube(calcX,y,calcZ,0,1,0);
