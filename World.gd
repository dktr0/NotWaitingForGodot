extends Node3D

var docID;
var configID;
var worldID;
var configuration = {};
var playerStartX;
var playerStartY;
var playerStartZ;
@onready var worldRequest = $"../WorldRequest";
@onready var configurationRequest = $"../ConfigurationRequest";
var gridScale = 2;
@onready var ui = $"../TitleUI";
@onready var player = $"/root/NotWaitingForGodot/Player";

func _physics_process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (!((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED;

func googleDocCSV(docID,sheetID):
	return "https://docs.google.com/spreadsheets/d/" + docID + "/gviz/tq?gid=" + sheetID + "&tqx=out:csv";
	
func getConfiguration(newDocID,newConfigID):
	docID = newDocID;
	configID = newConfigID;
	configurationRequest.connect("request_completed", Callable(self, "_receivedConfiguration"));
	var error = configurationRequest.request(googleDocCSV(docID,configID));
	if error != OK:
		ui.setError("error in HTTP request for configuration (possibly bad document or configuration IDs)");
	else:
		ui.setLog("requesting configuration sheet...");

func _receivedConfiguration(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		ui.setError("error receiving configuration: " + str(result) + " " + str(response_code)+ " " + str(headers) + " " + str(body));
		return;
	else:
		ui.setLog("configuration sheet received")
	var txt = body.get_string_from_utf8();
	var rows = txt.split("\n");
	for rowNo in rows.size():
		var cols = rows[rowNo].split(",");
		var key = cols[0].substr(1,cols[0].length()-2);	
		var value = cols[1].substr(1,cols[1].length()-2);
		configuration[key] = value;
	# print(str(configuration));
	playerStartX = float(configuration.get("PlayerStartX",0));
	playerStartY = float(configuration.get("PlayerStartY",0));
	playerStartZ = float(configuration.get("PlayerStartZ",0));
	if configuration.has("WorldSheet"):
		worldID = configuration["WorldSheet"];
		getWorld(googleDocCSV(docID,worldID));
	else:
		ui.setError("no WorldSheet ID found in configuration (possibly problem in configuration sheet, possibly bad IDs above)");
	
func playerToStartPosition():
	player.playerStart(playerStartX,playerStartY,playerStartZ);

func getWorld(url):
	worldRequest.connect("request_completed", Callable(self, "_receivedWorld"));
	var error = worldRequest.request(url);
	if error != OK:
		ui.setError("error in HTTP request for world (possibly bad world sheet ID in configuration sheet)");
	else:
		ui.setLog("requesting world sheet...");
	
func _receivedWorld(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		ui.setError("error receiving world: " + str(result) + " " + str(response_code)+ " " + str(headers) + " " + str(body));
	else:
		ui.setLog("world sheet received");
		var map = body.get_string_from_utf8();
		loadCSVMap(map);
		playerToStartPosition();
		ui.hide();
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

func reset():
	print("World::reset()");
	deleteWorld();
	getConfiguration(docID,configID);

func gameOver():
	$"../SoundBank".laser();
	reset();

func deleteWorld():
	for i in range(0, get_child_count()):
		get_child(i).queue_free()

func makeGrassStoneWater(aspects):
	var factory;
	var baseFactory;
	if aspects["substance"] == "water":
		factory = preload("res://WaterWall.tscn");
		baseFactory = preload("res://models/nwfgwaterbase.tscn");
	elif aspects["substance"] == "stone":
		factory = preload("res://models/nwfgstonewall.tscn");
	else:
		factory = preload("res://models/nwfggrasswall.tscn");
	var x = aspects["x"];
	var y = aspects["y"];
	var z = aspects["z"];
	var h = aspects["h"];
	for n in (h+1):
		var sb;
		if n == h && baseFactory != null:
			sb = baseFactory.instantiate();
		else:
			sb = factory.instantiate();
		sb.position = Vector3(x,n,z);
		realizeClass(aspects,sb);	
		realizeCollision(aspects,sb);
		add_child(sb);
	
func makeABeam(aspects):	
	var scene = preload("res://Beam.tscn");
	var beam = scene.instantiate();
	beam.aspects = aspects;
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	beam.position = Vector3(aspects["x"],y,aspects["z"]);
	realizeClass(aspects,beam);
	realizeCollision(aspects,beam);
	add_child(beam);
	
func makeADoor(aspects):
	var scene = preload("res://models/Door.tscn");
	var door = scene.instantiate();
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	door.position = Vector3(aspects["x"],y,aspects["z"]);
	door.add_to_group("doors");
	realizeClass(aspects,door);
	realizeCollision(aspects,door);
	add_child(door);
	
func makeAKey(aspects):
	var scene = preload("res://models/Key.tscn");
	var key = scene.instantiate();
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	key.position = Vector3(aspects["x"],y,aspects["z"]);
	key.add_to_group("keys");
	realizeClass(aspects,key);
	realizeCollision(aspects,key);
	add_child(key);

func makeAnObelisk(aspects):
	var scene = preload("res://models/Obelisk.tscn");
	var o = scene.instantiate();
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	o.position = Vector3(aspects["x"],y,aspects["z"]);
	realizeClass(aspects,o);
	realizeCollision(aspects,o);
	add_child(o);
	
func movableBlock(aspects):
	print("movableBlock");
	var scene = preload("res://MovableCube.tscn");
	var mc = scene.instantiate();
	mc.axis_lock_angular_x = true;
	mc.axis_lock_angular_y = true;
	mc.axis_lock_angular_z = true;
	if aspects["movableBlock"]=="xz":
		print("axis_lock_linear_y");
		mc.axis_lock_linear_y = true;
	elif aspects["movableBlock"]=="x":
		print("axis_lock_linear_y and z");
		mc.axis_lock_linear_y = true;
		mc.axis_lock_linear_z = true;
	elif aspects["movableBlock"]=="z":
		print("axis_lock_linear_y and x");
		mc.axis_lock_linear_y = true;
		mc.axis_lock_linear_x = true;
	var y = aspects["y"] + (aspects["h"] * gridScale + gridScale);
	mc.position = Vector3(aspects["x"],y,aspects["z"]);
	mc.set_mass(1);
	mc.set_linear_damp(5); 
	add_child(mc);
	
#func loadCSVMapFile(path="res://map.txt"):
#	print("loading CSV map called " + path);
#	var file = File.new();
#	file.open(path, File.READ);
#	var map = file.get_as_text();
#	loadCSVMap(map);
	
func loadCSVMap(map=""):
	var rows = map.split("\n");
	for rowNo in rows.size():
		csvMapRow(rows[rowNo],rowNo);

func csvMapRow(row,rowNo):
	var cells = row.split(",");
	for cellNo in cells.size():
		var x = 2.0 * float(cellNo);
		var y = 0;
		var z = 2.0 * float(rowNo);
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
	elif code == "obelisk":
		aspects["obelisk"] = true;
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
	if aspects["substance"] == "water":
		makeGrassStoneWater(aspects);
	elif aspects["substance"] == "stone":
		makeGrassStoneWater(aspects);
	else: # substance == "grass 
		makeGrassStoneWater(aspects);
	if aspects.has("door"):
		makeADoor(aspects);
	elif aspects.has("key"):
		makeAKey(aspects);
	elif aspects.has("movableBlock"):
		print("here movableBlock")
		movableBlock(aspects);
	elif aspects.has("beam"):
		makeABeam(aspects);
	elif aspects.has("obelisk"):
		makeAnObelisk(aspects);

func parseFunction(funcName,code):
	# if code begins with funcName and an open bracket...
	if code.substr(0,funcName.length()+1) == (funcName + "("):
		code = code.trim_prefix(funcName+"("); # ... remove one closing bracket...
		code = code.trim_suffix(")"); # ... and return the rest!
		return code;
	else:
		return null;

func parseCollision(code,aspects):
	var a = parseFunction("collision",code);
	if a != null:
		var b = parseFunction("on",a);
		if b != null:
			# print("parsed collision(on = " + b);
			aspects["collisionOn"] = b;
			return;
		b = parseFunction("off",a);
		if b != null:
			# print("parsed collision(off = " + b);
			aspects["collisionOff"] = b;
			
func parseClass(code,aspects):
	var a = parseFunction("class",code);
	if a != null:
		# print("parsed class = " + a);
		aspects["class"] = a;

func realizeClass(aspects,sb):
	var _class = aspects.get("class",null);
	if _class != null:
		sb.add_to_group(_class);
		# print("adding object to group " + _class);

func realizeCollision(aspects,sb):
	var cOn = aspects.get("collisionOn",null);
	var cOff = aspects.get("collisionOff",null);
	if cOn != null:
		sb.add_to_group("collisionOn_" + cOn);
	if cOff != null:
		sb.add_to_group("collisionOff_" + cOff);
	
func collisionOn(groupToTurnOn):
	# print("collisionOn triggered! " + groupToTurnOn);
	get_tree().call_group(groupToTurnOn, "turnOn");
	$"../SoundBank".buttonpush();
	
func collisionOff(groupToTurnOff):
	# print("collisionOff triggered! " + groupToTurnOff);
	get_tree().call_group(groupToTurnOff, "turnOff");
	$"../SoundBank".buttonpush();
