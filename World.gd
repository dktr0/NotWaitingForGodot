extends Spatial

func _ready():
	print("World::_ready()");
	$"/root/NotWaitingForGodot/Player".playerStart(2,2,-19);
	loadCSVMap();

func davidReady(x=0,y=0,z=0,yScale=2):
	cubeRow("                    ",x+0,y+0,z-20,2,0,1,1,0,yScale);
	cubeRow(" ++++++             ",x+0,y+0,z-18,2,0,1,1,0,yScale);
	cubeRow("      +         +++ ",x+0,y+0,z-16,2,0,1,1,0,yScale);
	cubeRow("      +++++++   + + ",x+0,y+0,z-14,2,0,1,1,0,yScale);
	cubeRow("      +     +++++ + ",x+0,y+0,z-12,2,0,1,1,0,yScale);
	cubeRow("   ++++++   +++   + ",x+0,y+0,z-10,2,0,1,1,0,yScale);
	cubeRow("   +    +   ++    + ",x+0,y+0,z-8,2,0,1,1,0,yScale);
	cubeRow("   ++   +   +     + ",x+0,y+0,z-6,2,0,1,1,0,yScale);
	cubeRow("    +   +   +     + ",x+0,y+0,z-4,2,0,1,1,0,yScale);
	cubeRow("  +++   +   +     + ",x+0,y+0,z-2,2,0,1,1,0,yScale);
	cubeRow("  +   +++   +     + ",x+0,y+0,z+0,2,0,1,1,0,yScale);
	cubeRow("  +++++     +     + ",x+0,y+0,z+2,2,0,1,1,0,yScale);
	cubeRow("  +      ++++     + ",x+0,y+0,z+4,2,0,1,1,0,yScale);
	cubeRow("  ++++++++    +++++ ",x+0,y+0,z+6,2,0,1,1,0,yScale);
	cubeRow("         +    +     ",x+0,y+0,z+8,2,0,1,1,0,yScale);
	cubeRow("      ++++ ++++     ",x+0,y+0,z+10,2,0,1,1,0,yScale);
	cubeRow("  +++++    +        ",x+0,y+0,z+12,2,0,1,1,0,yScale);
	cubeRow("  +   +++  ++++     ",x+0,y+0,z+14,2,0,1,1,0,yScale);
	cubeRow("  +     +     O     ",x+0,y+0,z+16,2,0,1,1,0,yScale);
	cubeRow("                    ",x+0,y+0,z+18,2,0,1,1,0,yScale);

func jackReady(x=0, y=0, z=0, yScale=2):
	cubeRow ("....................",x+0,y+0,z-20, 2, 0, 1, 1, 1,yScale);
	cubeRow ("  +    +++++++++    ",x+0,y+0,z-18, 2, 0, 1, 1, 1,yScale);
	cubeRow ("  ++++++    +  +    ",x+0,y+0,z-16, 2, 0, 1, 1, 1,yScale);
	cubeRow ("    ++++++  +     + ",x+0,y+0,z-14, 2, 0, 1, 1, 1,yScale);
	cubeRow ("     +++ ++ +    ++ ",x+0,y+0,z-12, 2, 0, 1, 1, 1,yScale);
	cubeRow ("       +  +++  +++  ",x+0,y+0,z-10, 2, 0, 1, 1, 1,yScale);
	cubeRow ("     +++      ++    ",x+0,y+0,z-8, 2, 0, 1, 1, 1,yScale);
	cubeRow ("       ++++  ++     ",x+0,y+0,z-6, 2, 0, 1, 1, 1,yScale);
	cubeRow ("    +   ++++++      ",x+0,y+0,z-4, 2, 0, 1, 1, 1,yScale);
	cubeRow ("    +       +++++++ ",x+0,y+0,z-2, 2, 0, 1, 1, 1,yScale);
	cubeRow ("    +   ++++++   ++ ",x+0,y+0,z+0, 2, 0, 1, 1, 1,yScale);
	cubeRow (" ++++++++        +  ",x+0,y+0,z+2, 2, 0, 1, 1, 1,yScale);
	cubeRow (" +      ++++     +  ",x+0,y+0,z+4, 2, 0, 1, 1, 1,yScale);
	cubeRow (" ++++++++++     0+  ",x+0,y+0,z+6, 2, 0, 1, 1, 1,yScale);
	cubeRow ("       +++       +  ",x+0,y+0,z+8, 2, 0, 1, 1, 1,yScale);
	cubeRow ("      +++++++    +  ",x+0,y+0,z+10, 2, 0, 1, 1, 1,yScale);
	cubeRow (" +        ++        ",x+0,y+0,z+12, 2, 0, 1, 1, 1,yScale);
	cubeRow (" +++      +++++++++ ",x+0,y+0,z+14, 2, 0, 1, 1, 1,yScale);
	cubeRow (" ++++++++++++++++   ",x+0,y+0,z+16, 2, 0, 1, 1, 1,yScale);
	cubeRow ("                    ",x+0,y+0,z+18, 2, 0, 1, 1, 1,yScale);
	
func nadiaReady(x=0, y=0, z=0,yScale=2):
	cubeRow("....................", x,y+0,z-20,2,0,0,0,0,yScale);
	cubeRow("  +++               ", x,y+0,z-18,2,0, 0,0,0,yScale);
	cubeRow("    +++++o+++++     ", x,y+0,z-16,2,0, 0,0,0,yScale);
	cubeRow("     ++  oo   +++++ ", x,y+0,z-14,2,0, 0,0,0,yScale);
	cubeRow("     +++      ++    ", x,y+0,z-12,2,0, 0.5,0,0,yScale);
	cubeRow("    ++  +     ++    ", x,y+0,z-10,2,0, 0,0,0,yScale);
	cubeRow("   ++   +++++++     ", x,y+0,z-8,2,0, 0,0,0,yScale);
	cubeRow("  +++    ++         ", x,y+0,z-6,2,0, 0,0,0,yScale);
	cubeRow(" ++      +++        ", x,y+0,z-4,2,0, 0,0,0,yScale);
	cubeRow(" ++        ++       ", x,y+0,z-2,2,0,0,0,0,yScale);
	cubeRow(" ++   +++ +++       ", x,y+0,z-0,2,0, 0,0,0,yScale);
	cubeRow(" ++  ++    ++       ", x,y+0,z+2,2,0, 0,0,0,yScale);
	cubeRow(" ++++++ ++++++      ", x,y+0,z+4,2,0, 0,0,0,yScale);
	cubeRow("       ++    ++++++ ", x,y+0,z+6,2,0, 0,0,0,yScale);
	cubeRow("       ++     ++    ", x,y+0,z+8,2,0, 0,0,0,yScale);
	cubeRow("     ++++      ++++ ", x,y+0,z+10,2,0, 0,0,0,yScale);
	cubeRow("   +++  ++++++++++  ", x,y+0,z+12,2,0, 0,0,0,yScale);
	cubeRow(" ++++   ++       ++ ", x,y+0,z+14,2,0, 0,0,0,yScale);
	cubeRow("    ++           ++ ", x,y+0,z+16,2,0, 0,0,0,yScale);
	cubeRow("....................", x,y+0,z+18,2,0, 0,0,0,yScale);
	
func leoReady(x=0,y=0,z=0,yScale=2):
	cubeRow("                    ", x+0,y+0,z-20,2,0, 1,1,0,yScale);
	cubeRow(" ++         ++      ", x+0,y+0,z-18,2,0, 1,1,0,yScale);
	cubeRow(" +  ++++++++++      ", x+0,y+0,z-16,2,0, 1,1,0,yScale);
	cubeRow("    +  +++++  ++    ", x+0,y+0,z-14,2,0, 1,1,0,yScale);
	cubeRow("    +++++ ++++++    ", x+0,y+0,z-12,2,0, 1,1,0,yScale);
	cubeRow("   +++  +      +    ", x+0,y+0,z-10,2,0, 1,1,0,yScale);
	cubeRow("    ++  +      +    ", x+0,y+0,z-8,2,0, 1,1,0,yScale);
	cubeRow("   +++++++++++++    ", x+0,y+0,z-6,2,0, 1,1,0,yScale);
	cubeRow("   + +      +  +    ", x+0,y+0,z-4,2,0, 1,1,0,yScale);
	cubeRow("   +++ ++++ ++++    ", x+0,y+0,z-2,2,0, 1,1,0,yScale);
	cubeRow("   +   + ++    +    ", x+0,y+0,z-0,2,0, 1,1,0,yScale);
	cubeRow("   +++++  ++++++    ", x+0,y+0,z+2,2,0, 1,1,0,yScale);
	cubeRow("    +     +   +++   ", x+0,y+0,z+4,2,0, 1,1,0,yScale);
	cubeRow("    +  + +++++++ +  ", x+0,y+0,z+6,2,0, 1,1,0,yScale);
	cubeRow("   ++  + +   +   +  ", x+0,y+0,z+8,2,0, 1,1,0,yScale);
	cubeRow("   +   +++   +   +  ", x+0,y+0,z+10,2,0, 1,1,0,yScale);
	cubeRow(" ++++   ++++++ ++++ ", x+0,y+0,z+12,2,0, 1,1,0,yScale);
	cubeRow(" +  +   +      +  + ", x+0,y+0,z+14,2,0, 1,1,0,yScale);
	cubeRow(" ++++  ++++++  ++++ ", x+0,y+0,z+16,2,0, 1,1,0,yScale);
	cubeRow("          0000      ", x+0,y+0,z+18,2,0, 1,1,0,yScale);        
				
func makeACube(x=0,y=0,z=0,r=1,g=0,b=0,xSize=2,ySize=2,zSize=2):
	var sb = StaticBody.new();
	
	var boxShape = BoxShape.new();
	boxShape.extents = Vector3(xSize*0.5,ySize*0.5,zSize*0.5);
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
	
func movableCube(x=0,y=0,z=0,r=1,g=0,b=0,xSize=2,ySize=2,zSize=2,axisLock=""):
	var sb = RigidBody.new();
	if axisLock.find("x")>=0:
		sb.axis_lock_angular_x = true;
		sb.axis_lock_linear_x = true;
	elif axisLock.find("y")>=0:
		sb.axis_lock_angular_y = true;
		sb.axis_lock_linear_y = true;		
	elif axisLock.find("z")>=0:
		sb.axis_lock_angular_z = true;
		sb.axis_lock_linear_z = true;
	var boxShape = BoxShape.new();
	boxShape.extents = Vector3(xSize*0.5,ySize*0.5,zSize*0.5);
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
	
func cubeRow(spec="",x=0,y=0,z=0,xInc=2,zInc=0,r=1,g=0,b=0,yScale=2):
	var head = spec.substr(0,1);
	var tail = spec.substr(1,-1);
	while head.length() > 0:
		if head == " " || head == "." :
			# print("putting a cube at " + str(x) + " " + str(y) + " " + str(z));
			makeACube(x,y,z,r,g,b,2,yScale,2);
			makeACube(x,y-yScale,z,r,g,b,2,yScale,2);
		elif head == "0" || head =="O" || head =="o":
			pass;
		else:
			makeACube(x,y-yScale,z,r,g,b,2,yScale,2);
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


func loadMaze(path="res://map.txt"):
	print("loading maze called " + path);
	var file = File.new();
	file.open(path, File.READ);
	var map = file.get_as_text();
	var lines = map.split("\n");
	print(str(lines));
	for lineNo in lines.size():
		print("line " + str(lineNo) + ": " + lines[lineNo]);
		cubeRow(lines[lineNo],0,0,-20+(lineNo*2),2,0,1,0,0,5);
		
func loadCSVMap(path="res://map.txt"):
	print("loading CSV map called " + path);
	var file = File.new();
	file.open(path, File.READ);
	var map = file.get_as_text();
	var rows = map.split("\n");
	for rowNo in rows.size():
		print("row " + str(rowNo) + ": " + rows[rowNo]);
		csvMapRow(rows[rowNo],0,0,-20+(rowNo*2),2,0,0,1,0,0,5);
		
func csvMapRow(row="",xStart=0,yStart=0,zStart=0,xInc=0,yInc=0,zInc=0,r=1,g=1,b=1,yScale=5):
	var cells = row.split(",");
	for cellNo in cells.size():
		var cell = cells[cellNo].to_lower();
		var x = xStart + (xInc * cellNo);
		var y = yStart + (yInc * cellNo);
		var z = zStart + (zInc * cellNo);
		if cell == "s": # impassable
			makeACube(x,y,z,r,g,b,2,yScale,2);
			makeACube(x,y-yScale,z,r,g,b,2,yScale,2); # movable
		elif cell == "b":
			movableCube(x,y,z,r,g,b,2,yScale,2);
			makeACube(x,y-yScale,z,r,g,b,2,yScale,2);
		elif cell == "m":
			movableCube(x,y,z,r,g,b,2,yScale,2,"y");
			makeACube(x,y-yScale,z,r,g,b,2,yScale,2);
		elif cell == "mx":
			movableCube(x,y,z,r,g,b,2,yScale,2,"yz");
			makeACube(x,y-yScale,z,r,g,b,2,yScale,2);
		elif cell == "mz":
			movableCube(x,y,z,r,g,b,2,yScale,"xy");
			makeACube(x,y-yScale,z,r,g,b,2,yScale,2);
		elif cell == "t":
			tTree(x,y,z);
			makeACube(x,y-yScale,z,r,g,b,2,yScale,2);
		elif cell == "0" || cell =="o": # hole
			pass;
		else:
			makeACube(x,y-yScale,z,r,g,b,2,yScale,2);
			
