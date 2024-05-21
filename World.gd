extends Spatial

func _ready():
	print("World::_ready()");
	doHTTPRequest();
#	reset();
	
func doHTTPRequest():
	print("doHTTPRequest");
	$HTTPRequest.connect("request_completed", self, "_on_request_completed");
	var url = "https://docs.google.com/spreadsheets/d/14qT2o_0n8Im94eKiRVjA4K4qozhorJw0Z95SlzhMxaM/gviz/tq?gid=400419988&tqx=out:csv";
	var error = $HTTPRequest.request(url);
	if error != OK:
	  push_error("An error occurred in the HTTP request.")
	else:
	  print("request appears to have been initiated successfully... but who knows?")
	
func _on_request_completed(result, response_code, headers, body):
	print("_on_request_completed");
	var map = body.get_string_from_utf8();
	loadCSVMapString(map);
	
func reset():
	print("World::reset()");
	deleteWorld();
	loadCSVMap();
	$"/root/NotWaitingForGodot/Player".playerStart(2,3,-19);

func deleteWorld():
	for i in range(0, get_child_count()):
		get_child(i).queue_free()

				
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
	
func makeABeam(dir="up",x=0,y=0,z=0,r=1,g=0,b=0,xSize=2,ySize=2,zSize=2):
	var scene = preload("res://Beam.tscn");
	var beam = scene.instance();
	beam.beamDirection = dir;
	beam.translation = Vector3(x,y,z);
	add_child(beam);
	
func makeADoor(x=0,y=0,z=0,r=1,g=0,b=0,xSize=2,ySize=2,zSize=2):
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
	sb.add_to_group("doors");
	add_child(sb);
	
func makeAKey(x=0,y=0,z=0,r=1,g=0,b=0,xSize=2,ySize=2,zSize=2):
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
	sb.add_to_group("keys");
	add_child(sb);
	
func invisibleCube(x=0,y=0,z=0,xSize=2,ySize=2,zSize=2):
	var sb = StaticBody.new();
	var boxShape = BoxShape.new();
	boxShape.extents = Vector3(xSize*0.5,ySize*0.5,zSize*0.5);
	var owner = sb.create_shape_owner(sb);
	sb.shape_owner_add_shape(owner, boxShape);
	sb.translation = Vector3(x,y,z);
	add_child(sb);
	
func movableCube(x=0,y=0,z=0,r=1,g=0,b=0,xSize=2,ySize=2,zSize=2,axis="x"):
	var sb = RigidBody.new();
	sb.axis_lock_angular_x = true;
	sb.axis_lock_angular_y = true;
	sb.axis_lock_angular_z = true;
	if axis=="xz":
		sb.axis_lock_linear_y = true;		
	elif axis=="x":
		sb.axis_lock_linear_y = true;		
		sb.axis_lock_linear_z = true;		
	elif axis=="z":
		sb.axis_lock_linear_y = true;		
		sb.axis_lock_linear_x = true;		
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
	sb.set_mass(1);
	sb.set_friction(1);
	sb.set_bounce(0);
	sb.set_linear_damp(5);
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
		# print("line " + str(lineNo) + ": " + lines[lineNo]);
		cubeRow(lines[lineNo],0,0,-20+(lineNo*2),2,0,1,0,0,5);
		
func loadCSVMap(path="res://map.txt"):
	print("loading CSV map called " + path);
	var file = File.new();
	file.open(path, File.READ);
	var map = file.get_as_text();
	loadCSVMapString(map);
	
func loadCSVMapString(map=""):
	var rows = map.split("\n");
	for rowNo in rows.size():
		# print("row " + str(rowNo) + ": " + rows[rowNo]);
		csvMapRow(rows[rowNo],0,0,-20+(rowNo*2),2,0,0,1,0,0,2.5);

func csvMapRow(row="",xStart=0,yStart=0,zStart=0,xInc=0,yInc=0,zInc=0,r=1,g=1,b=1,yScale=5):
	var cells = row.split(",");
	for cellNo in cells.size():
		var cell = cells[cellNo].to_lower();
		var x = xStart + (xInc * cellNo);
		var y = yStart + (yInc * cellNo);
		var z = zStart + (zInc * cellNo);
		var substance = "grass";
		var h = 0;
		var hasAKey = false;
		var hasADoor = false;
		var movableBlock = null;
		var beam = null;
		if cell.find("w")>=0:
			substance = "water";
		if cell.find("s")>=0:
			substance = "stone";
		if cell.find("k")>=0:
			hasAKey = true;
		if cell.find("door")>=0:
			hasADoor = true;
		if cell.find("beamup")>=0:
			beam = "up";
		if cell.find("beamdown")>=0:
			beam = "down";
		if cell.find("beamleft")>=0:
			beam = "left";
		if cell.find("beamright")>=0:
			beam = "right";
		if cell.find("movablex")>=0 || cell.find("moveablex")>=0:
			movableBlock = "x";
		elif cell.find("movablez")>=0 || cell.find("moveablez")>=0:
			movableBlock = "z";
		elif cell.find("movable")>=0 || cell.find("moveable")>=0:
			movableBlock = "xz";
		if cell.find("1")>=0:
			h = 1;
		if cell.find("2")>=0:
			h = 2;
		if cell.find("3")>=0:
			h = 3;
		if cell.find("4")>=0:
			h = 4;
		if cell.find("5")>=0:
			h = 5;
		if cell.find("6")>=0:
			h = 6;
		if cell.find("7")>=0:
			h = 7;
		if cell.find("8")>=0:
			h = 8;
		if cell.find("9")>=0:
			h = 9;
		var c;
		if substance == "water":
			c = Vector3(0,0,1);
		elif substance == "stone":
			c = Vector3(0.6,0.1,0.3);
		else: # substance == "grass 
			c = Vector3(0,1,0);
		# makeACube(x,y-yScale,z,c.x,c.y,c.z,2,yScale,2);
		var h2 = h + 1;
		makeACube(x,y-yScale+(h*yScale*0.5),z,c.x,c.y,c.z,2,yScale*h2,2);
		#for n in h:
		#	makeACube(x,y-yScale+(n*yScale),z,c.x,c.y,c.z,2,yScale,2);
		if substance == "water":
			var e = 6;
			for n in e:
				invisibleCube(x,y-yScale+(h*yScale)+(n*yScale),z,2,yScale,2);
		if hasADoor:
			makeADoor(x,y+(h*yScale),z,0,0,0,2,yScale,2);
		elif hasAKey:
			makeAKey(x,y+(h*yScale),z,1,0,0,yScale,2);
		elif movableBlock != null:
			movableCube(x,y+(h*yScale),z,0,1,1,2,2,2,movableBlock);
		elif beam != null:
			makeABeam(beam,x,y+(h*yScale),z,0,0,0,2,yScale,2);
