extends Spatial

var configurationDoc = "14qT2o_0n8Im94eKiRVjA4K4qozhorJw0Z95SlzhMxaM";
var configurationSheet = "1674844352";
var configuration = {};
var playerStartX;
var playerStartY;
var playerStartZ;
onready var worldRequest = $"../WorldRequest";
onready var configurationRequest = $"../ConfigurationRequest";
var yScale = 2.5;

func googleDocCSV(docID,sheetID):
	return "https://docs.google.com/spreadsheets/d/" + docID + "/gviz/tq?gid=" + sheetID + "&tqx=out:csv";
	
func _ready():
	print("World::_ready()");
	getConfiguration();
	
func getConfiguration():
	configurationRequest.connect("request_completed", self, "_receivedConfiguration");
	var error = configurationRequest.request(googleDocCSV(configurationDoc,configurationSheet));
	if error != OK:
	  push_error("An error occurred in the HTTP request for the configuration");

func _receivedConfiguration(result, response_code, headers, body):
	print("received configuration");
	var txt = body.get_string_from_utf8();
	var rows = txt.split("\n");
	for rowNo in rows.size():
		var cols = rows[rowNo].split(",");
		var key = cols[0].substr(1,cols[0].length()-2);	
		var value = cols[1].substr(1,cols[1].length()-2);
		configuration[key] = value;
	print(str(configuration));
	playerStartX = float(configuration["PlayerStartX"]);
	playerStartY = float(configuration["PlayerStartY"]);
	playerStartZ = float(configuration["PlayerStartZ"]);
	# deleteWorld();
	getWorld(googleDocCSV(configurationDoc,configuration["WorldSheet"]));
	
func playerToStartPosition():
	$"/root/NotWaitingForGodot/Player".playerStart(playerStartX,playerStartY,playerStartZ);

func getWorld(url):
	worldRequest.connect("request_completed", self, "_receivedWorld");
	var error = worldRequest.request(url);
	if error != OK:
	  push_error("An error occurred in the HTTP request.")
	
func _receivedWorld(result, response_code, headers, body):
	print("received world");
	var map = body.get_string_from_utf8();
	loadCSVMap(map);
	playerToStartPosition();
	
func reset():
	print("World::reset()");
	deleteWorld();
	getConfiguration();

func deleteWorld():
	for i in range(0, get_child_count()):
		get_child(i).queue_free()

func makeWater(aspects):
	var nwfgwaterbase = preload("res://models/nwfgwaterbase.tscn");
	var x = aspects["x"];
	var y = aspects["y"];
	var z = aspects["z"];
	var sb = StaticBody.new();
	var boxShape = BoxShape.new();
	boxShape.extents = Vector3(1,1,1);
	var owner = sb.create_shape_owner(sb);
	sb.shape_owner_add_shape(owner, boxShape);
	var m = nwfgwaterbase.instance();
	sb.add_child(m);
	sb.translation = Vector3(x,y,z);
	realizeClass(aspects,sb);	
	realizeCollision(aspects,sb);
	add_child(sb);

func makeStone(aspects):
	var nwfgstonewall = preload("res://models/nwfgstonewall.tscn")
	var x = aspects["x"];
	var y = aspects["y"];
	var z = aspects["z"];
	var h = aspects["h"];
	var sb = StaticBody.new();
	var boxShape = BoxShape.new();
	boxShape.extents = Vector3(1,1*h,1);
	var owner = sb.create_shape_owner(sb);
	sb.shape_owner_add_shape(owner, boxShape);
	for n in (h+1):
		var m = nwfgstonewall.instance();
		m.translation = Vector3(0,yScale*n,0);
		sb.add_child(m);
	sb.translation = Vector3(x,y,z);
	realizeClass(aspects,sb);	
	realizeCollision(aspects,sb);
	add_child(sb);

func makeGrass(aspects):
	var nwfggrasswall = preload("res://models/nwfggrasswall.tscn");
	var x = aspects["x"];
	var y = aspects["y"];
	var z = aspects["z"];
	var h = aspects["h"];
	var sb = StaticBody.new();
	var boxShape = BoxShape.new();
	boxShape.extents = Vector3(1,1*h,1);
	var owner = sb.create_shape_owner(sb);
	sb.shape_owner_add_shape(owner, boxShape);
	for n in (h+1):
		var m = nwfggrasswall.instance();
		m.translation = Vector3(0,yScale*n,0);
		sb.add_child(m);
	sb.translation = Vector3(x,y,z);
	realizeClass(aspects,sb);	
	realizeCollision(aspects,sb);
	add_child(sb);
	
func makeACube(aspects,x=0,y=0,z=0,r=1,g=0,b=0,xSize=2,ySize=2,zSize=2):
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
	realizeClass(aspects,sb);	
	realizeCollision(aspects,sb);
	add_child(sb);
	
func makeABeam(aspects,x=0,y=0,z=0,r=1,g=0,b=0,xSize=2,ySize=2,zSize=2,on=true):	
	var scene = preload("res://Beam.tscn");
	var beam = scene.instance();
	beam.aspects = aspects;
	beam.translation = Vector3(x,y,z);
	realizeClass(aspects,beam);
	realizeCollision(aspects,beam);
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
	sb.translation = Vector3(x+0.5,y+1.5,z+0.5);
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
			
func loadCSVMapFile(path="res://map.txt"):
	print("loading CSV map called " + path);
	var file = File.new();
	file.open(path, File.READ);
	var map = file.get_as_text();
	loadCSVMap(map);
	
func loadCSVMap(map=""):
	var rows = map.split("\n");
	for rowNo in rows.size():
		# print("row " + str(rowNo) + ": " + rows[rowNo]);
		csvMapRow(rows[rowNo],0,0,-20+(rowNo*2),2,0,0,1,0,0,2.5);

func csvMapRow(row="",xStart=0,yStart=0,zStart=0,xInc=0,yInc=0,zInc=0,r=1,g=1,b=1,yScale=5):
	var cells = row.split(",");
	for cellNo in cells.size():
		var x = xStart + (xInc * cellNo);
		var y = yStart + (yInc * cellNo);
		var z = zStart + (zInc * cellNo);
		csvMapCell(x,y,z,cells[cellNo]);
		
func csvMapCell(x,y,z,cell=""):
	cell = cell.to_lower();
	cell = cell.substr(1,cell.length()-2);	# remove quotation marks at beginning and end of cell
	var aspects = { "substance": "grass", "h": 0, "x": x, "y": y, "z": z };
	var codes = cell.split(" ",false);
	for codeNo in codes.size():
		parseCode(codes[codeNo],aspects);
	realizeAspects(aspects);
		
func parseCode(code,aspects):
	if code == "1":
		aspects["h"] = 1;
	elif code == "2":
		aspects["h"] = 2;
	elif code == "3":
		aspects["h"] = 3;
	elif code == "4":
		aspects["h"] = 4;
	elif code == "5":
		aspects["h"] = 5;
	elif code == "6":
		aspects["h"] = 6;
	elif code == "7":
		aspects["h"] = 7;
	elif code == "8":
		aspects["h"] = 8;
	elif code == "9":
		aspects["h"] = 9;
	elif code == "w":
		aspects["substance"] = "water";
	elif code == "s":
		aspects["substance"] = "stone";
	elif code == "g":
		aspects["substance"] = "grass";
	elif code == "key":
		aspects["key"] = true;
	elif code == "door":
		aspects["door"] = true;
	elif (code == "movable" || code == "moveable"):
		aspects["movableBlock"] = "xz";
	elif (code == "movablex" || code == "moveablex"):
		aspects["movableBlock"] = "x";
	elif (code == "movablez" || code == "moveablez"):
		aspects["movableBlock"] = "z";
	elif code == "beamup":
		aspects["beam"] = "up";
	elif code == "beamdown":
		aspects["beam"] = "down";
	elif code == "beamleft":
		aspects["beam"] = "left";
	elif code == "beamright":
		aspects["beam"] = "right";
	elif code == "off":
		aspects["on"] = false;
	elif code == "on":
		aspects["on"] = true;
	else:
		parseClass(code,aspects)
		parseCollision(code,aspects);
		
func realizeAspects(aspects={}):
	var c;
	var h = aspects["h"];
	var x = aspects["x"];
	var y = aspects["y"];
	var z = aspects["z"];
	if aspects["substance"] == "water":
		# c = Vector3(0,0,1);
		makeWater(aspects);
	elif aspects["substance"] == "stone":
		# c = Vector3(0.6,0.1,0.3);
		makeStone(aspects);
	else: # substance == "grass 
		# c = Vector3(0,1,0);
		makeGrass(aspects);
	#if aspects["substance"] == "water":
	#	var e = 6;
	#	for n in e:
	#		invisibleCube(x,y-yScale+(h*yScale)+(n*yScale),z,2,yScale,2);
	if aspects.has("door"):
		makeADoor(x,y+(h*yScale),z,0,0,0,2,yScale,2);
	if aspects.has("key"):
		makeAKey(x,y+(h*yScale+yScale),z,1,0,0,yScale,2);
	if aspects.has("movableBlock"):
		movableCube(x,y+(h*yScale+yScale),z,0,1,1,2,2,2,aspects["movableBlock"]);
	elif aspects.has("beam"):
		makeABeam(aspects,x,y+(h*yScale+yScale),z,0,0,0,2,yScale,2);

func parseFunction(funcName,code):
	# if code begins with funcName and an open bracket...
	if code.substr(0,funcName.length()+1) == (funcName + "("):
		code = code.trim_prefix(funcName+"(");
		# ... remove one closing bracket...
		code = code.trim_suffix(")");
		# ... and return the rest!
		return code;
	else:
		return null;

func parseCollision(code,aspects):
	var a = parseFunction("collision",code);
	if a != null:
		var b = parseFunction("on",a);
		if b != null:
			print("parsed collision(on = " + b);
			aspects["collisionOn"] = b;
			return;
		b = parseFunction("off",a);
		if b != null:
			print("parsed collision(off = " + b);
			aspects["collisionOff"] = b;
			
func parseClass(code,aspects):
	var a = parseFunction("class",code);
	if a != null:
		print("parsed class = " + a);
		aspects["class"] = a;

func realizeClass(aspects,sb):
	var _class = aspects.get("class",null);
	if _class != null:
		sb.add_to_group(_class);
		print("adding object to group " + _class);

func realizeCollision(aspects,sb):
	var collisionOn = aspects.get("collisionOn",null);
	var collisionOff = aspects.get("collisionOff",null);
	if collisionOn != null:
		sb.add_to_group("collisionOn_" + collisionOn);
	if collisionOff != null:
		sb.add_to_group("collisionOff_" + collisionOff);
	
func collisionOn(groupToTurnOn):
	print("collisionOn triggered! " + groupToTurnOn);
	# todo: find all objects of specified group and call on()
	
func collisionOff(groupToTurnOff):
	print("collisionOff triggered! " + groupToTurnOff);
	# todo: find all objects of specified group and call off()
