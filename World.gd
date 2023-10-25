extends Spatial


func _ready():
	makeACube(0,-1,0,0,1,0,200,1,200);
	davidReady();
	jackReady();
	leoReady();
	nadiaReady();

func davidReady():
	cubeRow("++++++++++++++++++++",0,0,-20,2,0,1,1,0);
	cubeRow("++++++++ +  +     ++",0,0,-18,2,0,1,1,0);
	cubeRow("      ++ +  + +++ ++",0,0,-16,2,0,1,1,0);
	cubeRow("++++  ++    + ++  ++",0,0,-14,2,0,1,1,0);
	cubeRow("++++  ++++  + ++  ++",0,0,-12,2,0,1,1,0);
	cubeRow("+       ++  + ++  ++",0,0,-10,2,0,1,1,0);
	cubeRow("+ ++++            ++",0,0,-8,2,0,1,1,0);
	cubeRow("+ ++++  ++++++++ +++",0,0,-6,2,0,1,1,0);
	cubeRow("+ ++++        ++ +++",0,0,-4,2,0,1,1,0);
	cubeRow("+ +++++++++++ ++   +",0,0,-2,2,0,1,1,0);
	cubeRow("+        ++++ ++++ +",0,0,0,2,0,1,1,0);
	cubeRow("++++++++++    ++++ +",0,0,2,2,0,1,1,0);
	cubeRow("+     ++++  ++++   +",0,0,4,2,0,1,1,0);
	cubeRow("++++  ++++  ++++  ++",0,0,6,2,0,1,1,0);
	cubeRow("++++  ++++  ++++  ++",0,0,8,2,0,1,1,0);
	cubeRow("++++    ++  ++++  ++",0,0,10,2,0,1,1,0);
	cubeRow("++++++      +     ++",0,0,12,2,0,1,1,0);
	cubeRow("++++++  ++++++++++++",0,0,14,2,0,1,1,0);
	cubeRow("++++++        ++++++",0,0,16,2,0,1,1,0);
	cubeRow("+++++++++++++ ++++++",0,0,18,2,0,1,1,0);

func jackReady():
	cubeRow ("++++++++++++++++++++", 40, 0, -20, 2, 0, 1, 1, 0);
	cubeRow ("+++      ++++++++     ++++", 40, 0, -18, 2, 0, 1, 1, 0);
	cubeRow ("        +++++  ++++     ++++", 40, 0, -16, 2, 0, 1, 1, 0); 
	cubeRow ("++    ++++       ++++    +++", 40, 0, -14, 2, 0, 1, 1, 0);
	cubeRow ("++      ++     +++++      +++", 40, 0, -12, 2, 0, 1, 1, 0);
	cubeRow ("+++            +++++      ++++", 40, 0, -10, 2, 0, 1, 1, 0);
	cubeRow ("+++++     ++++++++    +++", 40, 0, -8, 2, 0, 1, 1, 0);
	cubeRow ("+++          +++++++      +++", 40, 0, -6, 2, 0, 1, 1, 0);
	cubeRow ("++    +++++++++           +++", 40, 0, -4, 2, 0, 1, 1, 0);
	cubeRow ("++                                ++++", 40, 0, -2, 2, 0, 1, 1, 0);
	cubeRow ("++   +++++++++++++    +++", 40, 0, 0, 2, 0, 1, 1, 0);
	cubeRow ("++       +++++++++++   ++++", 40, 0, 2, 2, 0, 1, 1, 0);
	cubeRow ("++    ++++++++++    +++", 40, 0, 4, 2, 0, 1, 1, 0);
	cubeRow ("+     ++++++++        +++", 40, 0, 6, 2, 0, 1, 1, 0);
	cubeRow ("+     ++++++++++    +++", 40, 0, 8, 2, 0, 1, 1, 0);
	cubeRow ("++    ++++++++++    +++", 40, 0, 10, 2, 0, 1, 1, 0);
	cubeRow ("++                             +++", 40, 0, 12, 2, 0, 1, 1, 0);
	cubeRow ("++++    +++++++    +++", 40, 0, 14, 2, 0, 1, 1, 0);
	cubeRow ("+++++     +++++++    +++", 40, 0, 16, 2, 0, 1, 1, 0);
	cubeRow ("++                               +++", 40, 0, 18, 2, 0, 1, 1, 0);
	cubeRow ("      +++++++++++++++++", 40, 0, 20, 2, 0, 1, 1, 0);



func leoReady():
	cubeRow("+++++++  +++++++++++",0,0,-10+30,2,0,1,0,1);
	cubeRow("+   +++  +++++++++++",0,0,-8+30,2,0,1,0,1);
	cubeRow("+++ +++  +++++++++++",0,0,-6+30,2,0,1,0,1);
	cubeRow("+++         ++++ +++",0,0,-4+30,2,0,1,1,0);
	cubeRow("+++ +   +   +++   ++",0,0,-2+30,2,0,1,1,0);
	cubeRow("+++   +     ++++ +++",0,0,-0+30,2,0,1,0,0);
	cubeRow("++++++   +  ++++ +++",0,0,2+30,2,0,0,1,1);
	cubeRow("++++++       +++ ++",0,0,4+30,2,0,1,1,0);
	cubeRow("+++++      +   + +++",0,0,6+30,2,0,0,1,0);
	cubeRow("+++++ ++ +++++   +++",0,0,8+30,2,0,1,1,0);
	cubeRow("+++++ ++ ++++++ ++++",0,0,10+30,2,0,1,0,0);
	cubeRow("+++++ ++ ++++    +++",0,0,12+30,2,0,1,1,0);
	cubeRow("+++++ ++ +++     +++",0,0,14+30,2,0,1,1,0);
	cubeRow("++ +  ++ ++++   ++++",0,0,16+30,2,0,1,1,0);
	cubeRow("++ + + ++ + + + + ++",0,0,18+30,2,0,1,1,0);
	cubeRow("+++++++++++++   ++++",0,0,20+30,2,0,1,1,0);
		
func nadiaReady():
	cubeRow("+++++++++++++++  +++", 40,0,-2+30,2, 1,1,0);
	cubeRow("+++++++++++++++  +++", 40,0,-4+30,2, 1,1,0);
	cubeRow("++++++++++++++  ++++", 40,0,-6+30,2, 1,1,0);
	cubeRow("++++++++++++++  ++++", 40,0,-8+30,2, 1,1,0);
	cubeRow("++++++++++++++  ++++", 40,0,-10+30,2, 1,1,0);
	cubeRow("++++++++++++++  ++++", 40,0,-12+30,2, 1,1,0);
	cubeRow("++++++++++++++  ++++", 40,0,-14+30,2, 1,1,0);
	cubeRow("++++++++++++++  ++++", 40,0,-16+30,2, 1,1,0);
	cubeRow("++++  ++++++++  ++++", 40,0,-18+30,2, 1,1,0);
	cubeRow("++++   +++++++  ++++", 40,0,-20+30,2, 1,1,0);
	cubeRow("+++++  +++++++  ++++", 40,0,-22+30,2, 1,1,0);
	cubeRow("++          ++  ++++", 40,0,-24+30,2, 1,1,0);
	cubeRow("+++  +++++++++  ++++", 40,0,-26+30,2, 1,1,0);
	cubeRow("++  ++++++++++  ++++", 40,0,-28+30,2, 1,1,0);
	cubeRow("+++  +++++++++  ++++", 40,0,-30+30,2, 1,1,0);
	cubeRow("++++  ++++++++  ++++", 40,0,-32+30,2, 1,1,0);
	cubeRow("+++++   ++++++  ++++", 40,0,-34+30,2, 1,1,0);
	cubeRow("++++++          ++++", 40,0,-36+30,2, 1,1,0);
	cubeRow("+++++  +++++++  ++++", 40,0,-38+30,2, 1,1,0);
	cubeRow("++++  ++++++++  ++++", 40,0,-40+30,2, 1,1,0);
	cubeRow("+++++  +++++++  ++++", 40,0,-22+30,2, 1,1,0);
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

				
				
func makeACube(x=0,y=0,z=0,r=1,g=0,b=0,xSize=2,ySize=2,zSize=2):
	var sb = StaticBody.new();
	
	var boxShape = BoxShape.new();
	boxShape.extents = Vector3(xSize/2,ySize/2,zSize/2);
	var owner = sb.create_shape_owner(sb);
	sb.shape_owner_add_shape(owner, boxShape);
	
	var m = MeshInstance.new();
	var cm = CubeMesh.new();
	cm.size = Vector3(xSize,ySize,zSize);
	var sm = SpatialMaterial.new();
	sm.albedo_color = Color( r, g, b, 1 );
	cm.material = sm;
	m.mesh = cm;
	sb.add_child(m);
	sb.translation = Vector3(x,y,z);
	add_child(sb);
	
func makeASphere(x=0,y=0,z=0,r=1,g=0,b=0):
	print("makeASphere");
	var m = MeshInstance.new();
	var sm = SphereMesh.new();
	var mat = SpatialMaterial.new();
	mat.albedo_color = Color(r,g,b,1);

	sm.material = mat;
	m.mesh = sm;
	m.translation = Vector3(x,y,z);
	add_child(m);
	
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

func cubeVector(n=10,x=0,y=0,z=0,xInc=2,yInc=2,zInc=2,r=1,g=0,b=0):
	for i in n:
		makeACube(x,y,z,r,g,b);
		x = x + xInc;
		y = y + yInc;
		z = z + zInc;

func tree(x=0,y=0,z=0):
	cubeVector(10,0+x,0+y,0+z,0,1,0,1,0,0);
	makeACube(0+x,10+y,0+z,0,1,0,6,6,6);

func printStr(a="",b="",c="",d=""):
	print(str(a) + " " + str(b) + " " + str(c) + " " + str(d));

func fatimaReady():
	cubeMesh(0,-2,-10,30,30);
	makeASphere(0,0,-10,0,0,1);
	tree(0,0,0);
	tree(10,0,0);
	bush(12,-0.5,5)
	tree1(15,0,0);
	tree(20,2,0);
	tree2(30,0,0);
	bush(32,0,5)
	tree1(35,0,8);
	tree2(40,0,9);
	tree(50,0,10);
	bush(32,0,5)
	tree1(34,0,-7);
	tree2(37,0,5);
	tree(30,0,-7);
	bush(32,0.5,10)
	tree(0,0,10);
	tree1(10,0,10);
	tree2(20,0,8);
	bush(22,0,10)
	tree(35,0,10);
	tree1(30,0,18);
	bush(37,1,10)
	tree(32,0,20);
	tree1(30,0,-17);
	tree2(35,0,15);
	tree1(25,0,-17);
	
func tree1(x=0,y=0,z=0):
	cubeVector(10,0+x,0+y,0+z,0,1,0,1,0,0);
	makeACube(0+x,8+y,0+z,0,100,0,8,8,8);
	
func tree2(x=0,y=0,z=0):
	cubeVector(8,0+x,0+y,0+z,0,1,0,1,0,0);
	makeACube(0+x,6+y,0+z,0,1,0,4,4,4);
	
func bush(x=0,y=0,z=0):
	cubeVector(0,0+x,0+y,0+z,0,1,0,1,0,0);
	makeACube(0+x,0+y,0+z,0,100,0,2,2,2);

func agasthyaReady():
	tTree(0,0,10);
	tTree(10,0,20);
	tTree(20,0,20);

func tropicalTree(n=10,x=0,y=0,z=0,xInc=0,yInc=0.66,zInc=0,r=0.9,g=0.8,b=0.3):
	for i in n:
		makeASphere(x,y,z,r,g,b);
		x = x + xInc;
		y = y + yInc;
		z = z + zInc;

func tropicalLeaves(x=0,y=6.6,z=0,xInc=0.5,zInc=0.5):
	cubeRow("+++++++++",x,y,z,xInc,zInc,0,1,0);
	cubeRow("+++++++++",x,y,z,-xInc,zInc,0,1,0);
	cubeRow("+++++++++",x,y,z,xInc,-zInc,0,1,0);
	cubeRow("+++++++++",x,y,z,-xInc,-zInc,0,1,0);

func tTree(x=0,y=0,z=0):
	tropicalTree(10,0+x,0+y,0+z,0,0.66,0,0.9,0.8,0.3);
	tropicalLeaves(0+x,6.6+y,0+z,0.5,0.5);	

func house (x=0, y=0, z=0):
	cubeVector(10,0+x,0+y,0+z,0,1,0,0,1,1); #corner
	
	# this block makes up a wall
	cubeVector(10,1+x,0+y,0+z,0,1,0,0,1,1);
	cubeVector(10,2+x,0+y,0+z,0,1,0,0,1,1);
	cubeVector(10,3+x,0+y,0+z,0,1,0,0,1,1);
	cubeVector(10,4+x,0+y,0+z,0,1,0,0,1,1);
	cubeVector(10,5+x,0+y,0+z,0,1,0,0,1,1);
	cubeVector(10,6+x,0+y,0+z,0,1,0,0,1,1);
	cubeVector(10,7+x,0+y,0+z,0,1,0,0,1,1);
	cubeVector(10,8+x,0+y,0+z,0,1,0,0,1,1);
	
	
	
	cubeVector(10,10+x,0+y,0+z,0,1,0,0,1,1); #corner
	# making a wall
	cubeVector(10,10+x,0+y,1+z,0,1,0,0,1,1);
	cubeVector(10,10+x,0+y,2+z,0,1,0,0,1,1);
	cubeVector(10,10+x,0+y,3+z,0,1,0,0,1,1);
	cubeVector(10,10+x,0+y,4+z,0,1,0,0,1,1);
	cubeVector(10,10+x,0+y,5+z,0,1,0,0,1,1);
	cubeVector(10,10+x,0+y,6+z,0,1,0,0,1,1);
	cubeVector(10,10+x,0+y,7+z,0,1,0,0,1,1);
	cubeVector(10,10+x,0+y,8+z,0,1,0,0,1,1);
	
	
	cubeVector(10,0+x,0+y,10+z,0,1,0,0,1,1); # corner
	#making a wall
	cubeVector(10,1+x,0+y,10+z,0,1,0,0,1,1);
	cubeVector(10,2+x,0+y,10+z,0,1,0,0,1,1);
	cubeVector(10,3+x,0+y,10+z,0,1,0,0,1,1);
	cubeVector(10,4+x,0+y,10+z,0,1,0,0,1,1);
	cubeVector(10,5+x,0+y,10+z,0,1,0,0,1,1);
	cubeVector(10,6+x,0+y,10+z,0,1,0,0,1,1);
	cubeVector(10,7+x,0+y,10+z,0,1,0,0,1,1);
	cubeVector(10,8+x,0+y,10+z,0,1,0,0,1,1);
	
	
	
	cubeVector(10,10+x,0+y,10+z,0,1,0,0,1,1); # corner



func glitchyDecoration(x=0,y=0,z=0):
	cubeVector(10,0+x,0+y,1+z,0,1,0,1,0,1);
	cubeVector(10,0+x,0+y,2+z,0,2,0,0,0,1);
	cubeVector(10,0+x,0+y,3+z,0,3,0,1,0,1);
	cubeVector(10,0+x,0+y,4+z,0,4,0,1,0,0);

func cyrilReady():
	makeASphere(0,9,3,0,4,6);
	makeASphere(9,10,3,0,4,6);
	cubeRow("++++  ++  ++++++++++ +",56,56,56,56,0,1,1,1);
	cubeRow("++++  ++  ++++++++++ +",57,57,57,57,0,1,1,1);
