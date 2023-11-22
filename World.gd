extends Spatial

func _ready():
	print("World::_ready()");
	$"/root/NotWaitingForGodot/Player".playerStart(-2,2,-18);
	makeACube(0,-1,0,0,1,0,800,1,800);
	davidReady(0,0,0);
	jackReady(0,0,40);
	nadiaReady(0,0,80);
	leoReady(0,0,120);

func davidReady(x=0,y=0,z=0):
	cubeRow("                    ",x+0,y+0,z-20,2,0,1,1,0);
	cubeRow("+++++++             ",x+0,y+0,z-18,2,0,1,1,0);
	cubeRow("      +         +++ ",x+0,y+0,z-16,2,0,1,1,0);
	cubeRow("      +++++++   + + ",x+0,y+0,z-14,2,0,1,1,0);
	cubeRow("      +     +++++ + ",x+0,y+0,z-12,2,0,1,1,0);
	cubeRow("   ++++++   +++   + ",x+0,y+0,z-10,2,0,1,1,0);
	cubeRow("   +    +   ++    + ",x+0,y+0,z-8,2,0,1,1,0);
	cubeRow("   ++   +   +     + ",x+0,y+0,z-6,2,0,1,1,0);
	cubeRow("    +   +   +     + ",x+0,y+0,z-4,2,0,1,1,0);
	cubeRow("  +++   +   +     + ",x+0,y+0,z-2,2,0,1,1,0);
	cubeRow("  +   +++   +     + ",x+0,y+0,z+0,2,0,1,1,0);
	cubeRow("  +   +     +     + ",x+0,y+0,z+2,2,0,1,1,0);
	cubeRow("  +      ++++     + ",x+0,y+0,z+4,2,0,1,1,0);
	cubeRow("  ++++++++    +++++ ",x+0,y+0,z+6,2,0,1,1,0);
	cubeRow("              +     ",x+0,y+0,z+8,2,0,1,1,0);
	cubeRow("      ++++++++++++  ",x+0,y+0,z+10,2,0,1,1,0);
	cubeRow("  +++++          +  ",x+0,y+0,z+12,2,0,1,1,0);
	cubeRow("  +   ++++++++++++  ",x+0,y+0,z+14,2,0,1,1,0);
	cubeRow("  +     +           ",x+0,y+0,z+16,2,0,1,1,0);
	cubeRow("  +                 ",x+0,y+0,z+18,2,0,1,1,0);

func jackReady(x=0, y=0, z=0):
	cubeRow ("..+.................",x+0,y+0,z-20, 2, 0, 1, 1, 1);
	cubeRow ("  +    ++++++++++++ ",x+0,y+0,z-18, 2, 0, 1, 1, 1);
	cubeRow ("  ++++++            ",x+0,y+0,z-16, 2, 0, 1, 1, 1); 
	cubeRow ("    +++           + ",x+0,y+0,z-14, 2, 0, 1, 1, 1);
	cubeRow ("     +++         ++ ",x+0,y+0,z-12, 2, 0, 1, 1, 1);
	cubeRow ("       +       +++  ",x+0,y+0,z-10, 2, 0, 1, 1, 1);
	cubeRow ("     +++      ++    ",x+0,y+0,z-8, 2, 0, 1, 1, 1);
	cubeRow ("       ++ +  ++     ",x+0,y+0,z-6, 2, 0, 1, 1, 1);
	cubeRow ("        ++++++      ",x+0,y+0,z-4, 2, 0, 1, 1, 1);
	cubeRow ("            +++++++ ",x+0,y+0,z-2, 2, 0, 1, 1, 1);
	cubeRow ("        ++++++   ++ ",x+0,y+0,z+0, 2, 0, 1, 1, 1);
	cubeRow (" ++++++++        +  ",x+0,y+0,z+2, 2, 0, 1, 1, 1);
	cubeRow (" +      ++++     +  ",x+0,y+0,z+4, 2, 0, 1, 1, 1);
	cubeRow (" ++++++++++      +  ",x+0,y+0,z+6, 2, 0, 1, 1, 1);
	cubeRow ("       +++       +  ",x+0,y+0,z+8, 2, 0, 1, 1, 1);
	cubeRow ("      +++++++    +  ",x+0,y+0,z+10, 2, 0, 1, 1, 1);
	cubeRow (" +        ++        ",x+0,y+0,z+12, 2, 0, 1, 1, 1);
	cubeRow (" +++     ++++++++++ ",x+0,y+0,z+14, 2, 0, 1, 1, 1);
	cubeRow (" ++++++++++++       ",x+0,y+0,z+16, 2, 0, 1, 1, 1);
	cubeRow (" +                  ",x+0,y+0,z+18, 2, 0, 1, 1, 1);
	
func nadiaReady(x=0, y=0, z=0):
	cubeRow(".++.................", x,y+0,z-20,2,0,0,0,0);
	cubeRow("  +++               ", x,y+0,z-18,2,0, 0,0,0);
	cubeRow("    +++++++++++     ", x,y+0,z-16,2,0, 0,0,0);
	cubeRow("     ++       +++++ ", x,y+0,z-14,2,0, 0,0,0);
	cubeRow("     +++      ++    ", x,y+0,z-12,2,0, 0.5,0,0);
	cubeRow("    ++  +     ++    ", x,y+0,z-10,2,0, 0,0,0);
	cubeRow("   ++   +++++++     ", x,y+0,z-8,2,0, 0,0,0);
	cubeRow("  +++    ++         ", x,y+0,z-6,2,0, 0,0,0);
	cubeRow("+++      +++        ", x,y+0,z-4,2,0, 0,0,0);
	cubeRow("+++        ++       ", x,y+0,z-2,2,0,0,0,0);
	cubeRow("      +++++++       ", x,y+0,z-0,2,0, 0,0,0);
	cubeRow("      +     +       ", x,y+0,z+2,2,0, 0,0,0);
	cubeRow("    +++ ++++++      ", x,y+0,z+4,2,0, 0,0,0);
	cubeRow("        +    +      ", x,y+0,z+6,2,0, 0,0,0);
	cubeRow("        +     +     ", x,y+0,z+8,2,0, 0,0,0);
	cubeRow("     ++++      ++++ ", x,y+0,z+10,2,0, 0,0,0);
	cubeRow("   +++  ++      ++  ", x,y+0,z+12,2,0, 0,0,0);
	cubeRow(" ++++   ++       ++ ", x,y+0,z+14,2,0, 0,0,0);
	cubeRow("    +            ++ ", x,y+0,z+16,2,0, 0,0,0);
	cubeRow("..+++...............", x,y+0,z+18,2,0, 0,0,0);
	
func leoReady(x=0,y=0,z=0):
	cubeRow(" ++         ++       ", x+0,y+0,z-20,2,0, 1,1,0);
	cubeRow(" +  ++++++++++      ", x+0,y+0,z-18,2,0, 1,1,0);
	cubeRow(" +++++      ++      ", x+0,y+0,z-16,2,0, 1,1,0);
	cubeRow("          ++++++    ", x+0,y+0,z-14,2,0, 1,1,0);
	cubeRow("    +++++      +    ", x+0,y+0,z-12,2,0, 1,1,0);
	cubeRow("   +++  +      +    ", x+0,y+0,z-10,2,0, 1,1,0);
	cubeRow("    ++  +      +    ", x+0,y+0,z-8,2,0, 1,1,0);
	cubeRow("   +++++++++   +    ", x+0,y+0,z-6,2,0, 1,1,0);
	cubeRow("   +           +    ", x+0,y+0,z-4,2,0, 1,1,0);
	cubeRow("   +     ++   ++    ", x+0,y+0,z-2,2,0, 1,1,0);
	cubeRow("   +  ++++++   +    ", x+0,y+0,z-0,2,0, 1,1,0);
	cubeRow("   +++++   +++++    ", x+0,y+0,z+2,2,0, 1,1,0);
	cubeRow("    +         +++   ", x+0,y+0,z+4,2,0, 1,1,0);
	cubeRow("    +     ++++++    ", x+0,y+0,z+6,2,0, 1,1,0);
	cubeRow("   ++        ++     ", x+0,y+0,z+8,2,0, 1,1,0);
	cubeRow("   +         ++     ", x+0,y+0,z+10,2,0, 1,1,0);
	cubeRow("+++++   ++++++  ++++", x+0,y+0,z+12,2,0, 1,1,0);
	cubeRow("++++++          ++++", x+0,y+0,z+14,2,0, 1,1,0);
	cubeRow("+++++  +++++++  ++++", x+0,y+0,z+16,2,0, 1,1,0);
	cubeRow("++++  ++++++++  ++++", x+0,y+0,z+18,2,0, 1,1,0);		
				
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
		if head == " " || head == "." :
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

	
func tree1(x=0,y=0,z=0):
	cubeVector(10,0+x,0+y,0+z,0,1,0,1,0,0);
	makeACube(0+x,8+y,0+z,0,100,0,8,8,8);
	
func tree2(x=0,y=0,z=0):
	cubeVector(8,0+x,0+y,0+z,0,1,0,1,0,0);
	makeACube(0+x,6+y,0+z,0,1,0,4,4,4);
	
func bush(x=0,y=0,z=0):
	cubeVector(0,0+x,0+y,0+z,0,1,0,1,0,0);
	makeACube(0+x,0+y,0+z,0,100,0,2,2,2);


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
