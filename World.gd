extends Node3D

var docID;
var configID;
var worldID;
var worldURL;
var configuration = {};
var playerStartX;
var playerStartY;
var playerStartZ;
var playerGravity;
var mode = 2;
var jump;
var cameraX;
var cameraY;
var cameraZ;
var cachedMap = "";
@onready var configurationRequest = $"../ConfigurationRequest";
@onready var worldRequest = $"../WorldRequest";
@onready var worldRequest_Update = $"../WorldRequest_Update";
var gridScale = 2;
@onready var ui = $"../TitleUI";
@onready var player = $"/root/NotWaitingForGodot/Player";
var activeWorldMatrix;
var autoUpdateInterval;

func _physics_process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (!((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED;
	elif Input.is_action_just_pressed("reset"):
		reset();
	elif Input.is_action_just_pressed("update"):
		getWorld_Update();
	elif Input.is_action_just_pressed("playerStartHack"):
		playerToStartPosition();

func googleDocCSV(docID,sheetID):
	return "https://docs.google.com/spreadsheets/d/" + docID + "/gviz/tq?gid=" + sheetID + "&tqx=out:csv";
	
func getConfiguration(newDocID,newConfigID):
	docID = newDocID;
	configID = newConfigID;
	configurationRequest.connect("request_completed", Callable(self, "_receivedConfiguration"));
	var url = googleDocCSV(docID,configID);
	var error = configurationRequest.request(url);
	if error != OK:
		ui.setError("error in HTTP request for configuration (possibly bad document or configuration IDs), url=" + url);
	else:
		ui.setLog("requesting configuration sheet... url=" + url);

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
	playerStartX = float(configuration.get("PlayerStartX",0));
	playerStartY = float(configuration.get("PlayerStartY",0));
	playerStartZ = float(configuration.get("PlayerStartZ",0));
	mode = int(configuration.get("Mode",0));
	jump = float(configuration.get("Jump",1));
	cameraX = float(configuration.get("CameraX",0));
	cameraY = float(configuration.get("CameraY",1));
	cameraZ = float(configuration.get("CameraZ",12));
	playerGravity = float(configuration.get("PlayerGravity",1));
	player.gravity = playerGravity;
	player.positionCamera(cameraX,cameraY,cameraZ);
	
	autoUpdateInterval = configuration.get("AutoUpdateInterval",null);
	if autoUpdateInterval != null:
		autoUpdateInterval = float(autoUpdateInterval);
		print("starting auto update, interval = " + str(autoUpdateInterval));
		$"../AutoUpdateTimer".set_wait_time(autoUpdateInterval);
		$"../AutoUpdateTimer".start();
	
	if configuration.has("WorldSheet"):
		worldID = configuration["WorldSheet"];
		worldURL = googleDocCSV(docID,worldID);
		getWorld(worldURL);
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
	print("_receivedWorld");
	if result != HTTPRequest.RESULT_SUCCESS:
		ui.setError("error receiving world: " + str(result) + " " + str(response_code)+ " " + str(headers) + " " + str(body));
	else:
		ui.setLog("world sheet received");
		cachedMap = body.get_string_from_utf8();
		reset();

func getWorld_Update():
	worldRequest_Update.connect("request_completed", Callable(self, "_receivedWorld_Update"));
	var error = worldRequest_Update.request(worldURL);
	if error != OK:
		ui.setError("error in HTTP request for world (possibly bad world sheet ID in configuration sheet)");
	else:
		ui.setLog("requesting world sheet...");
	
func _receivedWorld_Update(result, response_code, headers, body):
	print("_receivedWorld_Update")
	if result != HTTPRequest.RESULT_SUCCESS:
		ui.setError("error receiving world: " + str(result) + " " + str(response_code)+ " " + str(headers) + " " + str(body));
	else:
		ui.setLog("world sheet received");
		cachedMap = body.get_string_from_utf8();
		update();
		
func launch():
	print("World::launch()");
	$Player.set_gravity_scale(0.1);
	getConfiguration(docID,configID);
	
func reset():
	print("World::reset()");
	$"../Player".frozen = false;
	updateCSV(cachedMap);
	playerToStartPosition();
	ui.hide();
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	
func update():
	print("World::update()");
	updateCSV(cachedMap);
	
func gameOver():
	$"../SoundBank".laser();
	reset();

func deleteWorld():
	for i in range(0, get_child_count()):
		get_child(i).queue_free()
		
func makeHole(aspects):
	var node3D = Node3D.new();	
	node3D.set_global_position(Vector3(aspects.x,aspects.y,aspects.z));
	aspects.node3D = node3D;
	add_child(node3D);
	return aspects;

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
	var nn;
	if mode != 2:
		nn = h + 1;
	else:
		nn = 1;
	var node3D = Node3D.new();	
	node3D.set_global_position(Vector3(aspects.x,aspects.y,aspects.z));
	for n in nn:
		var sb;
		if n == h && baseFactory != null:
			sb = baseFactory.instantiate();
		else:
			sb = factory.instantiate();
		if mode != 2:
			sb.position = Vector3(0,n*2,0);
		else:
			sb.position = Vector3(0,0,0);
		realizeStuff(aspects,sb);
		node3D.add_child(sb);
	aspects.node3D = node3D;
	add_child(node3D);
	return aspects;
	
func makeABeam(aspects):	
	var scene = preload("res://Beam.tscn");
	var beam = scene.instantiate();
	beam.aspects = aspects;
	var y = yCalc(aspects);
	beam.position = Vector3(aspects["x"],y,aspects["z"]);
	realizeStuff(aspects,beam);
	aspects.node3D.add_child(beam);
	
func makeADoor(aspects):
	var scene = preload("res://models/Door.tscn");
	var door = scene.instantiate();
	var y = yCalc(aspects);
	door.position = Vector3(aspects["x"],y,aspects["z"]);
	door.add_to_group("doors");
	realizeStuff(aspects,door);
	aspects.node3D.add_child(door);
	
func yCalc(aspects):
	if mode != 2:
		return (aspects["y"] + (aspects["h"] * gridScale + gridScale));
	else:
		return (aspects["y"]);
	
func makeAKey(aspects):
	var scene = preload("res://models/Key.tscn");
	var key = scene.instantiate();
	var y = yCalc(aspects);
	key.position = Vector3(aspects["x"],y,aspects["z"]);
	key.add_to_group("keys");
	realizeStuff(aspects,key);
	aspects.node3D.add_child(key);

func makeAnObelisk(aspects):
	var scene = preload("res://models/Obelisk.tscn");
	var o = scene.instantiate();
	var y = yCalc(aspects);
	o.position = Vector3(aspects["x"],y,aspects["z"]);
	realizeStuff(aspects,o);
	aspects.node3D.add_child(o);
	
func makeATeleportTo(aspects):
	print("makeATeleportTo");
	var scene = preload("res://teleporter.tscn");
	var t = scene.instantiate();
	var y = yCalc(aspects);
	t.position = Vector3(aspects["x"],y,aspects["z"]);
	t.targetID = aspects["teleportto"];
	t.add_to_group("teleportto");
	realizeStuff(aspects,t);
	aspects.node3D.add_child(t);

func makeATeleportFrom(aspects):
	print("makeATeleportFrom")
	var scene = preload("res://teleporter.tscn");
	var t = scene.instantiate();
	var y = yCalc(aspects);
	t.position = Vector3(aspects["x"],y,aspects["z"]);
	t.add_to_group("teleportfrom_" + aspects["teleportfrom"]);
	realizeStuff(aspects,t);
	aspects.node3D.add_child(t);
	
func movableBlock(aspects):
	print("movableBlock" + str(aspects));
	var scene = preload("res://MovableCube.tscn");
	var mc = scene.instantiate();
	mc.axis_lock_angular_x = true;
	mc.axis_lock_angular_y = true;
	mc.axis_lock_angular_z = true;
	if aspects["movableBlock"]=="xz":
		mc.axis_lock_linear_y = true;
	elif aspects["movableBlock"]=="x":
		mc.axis_lock_linear_y = true;
		mc.axis_lock_linear_z = true;
	elif aspects["movableBlock"]=="z":
		mc.axis_lock_linear_y = true;
		mc.axis_lock_linear_x = true;
	var y = yCalc(aspects);
	mc.position = Vector3(aspects["x"],y,aspects["z"]);
	mc.set_mass(1);
	mc.set_linear_damp(5); 
	realizeStuff(aspects,mc);
	aspects.node3D.add_child(mc);
	
#func loadCSVMapFile(path="res://map.txt"):
#	print("loading CSV map called " + path);
#	var file = File.new();
#	file.open(path, File.READ);
#	var map = file.get_as_text();
#	updateCSV(map);

		
func updateCSV(csv=""):
	var prevWorldMatrix = activeWorldMatrix;
	var prevMatrixRows;
	if prevWorldMatrix != null:
		print("there is a previous world matrix");
		prevMatrixRows = prevWorldMatrix.size();
	else:
		print("there is NO previous world matrix")
		prevMatrixRows = 0;
	activeWorldMatrix = csvToWorldMatrix(csv);
	var activeMatrixRows = activeWorldMatrix.size();
	var nRows = max(prevMatrixRows,activeMatrixRows);
	$"../Player".yFailThreshold = nRows * (-2.0) - 10.0;
	for rowIndex in nRows:
		if rowIndex >= prevMatrixRows:
			var r = updateRow(null,activeWorldMatrix[rowIndex]);
			activeWorldMatrix[rowIndex] = r;
		elif rowIndex >= activeMatrixRows:
			deleteRow(prevWorldMatrix[rowIndex]);
		else:
			var r = updateRow(prevWorldMatrix[rowIndex],activeWorldMatrix[rowIndex]);
			activeWorldMatrix[rowIndex] = r;
	
func csvToWorldMatrix(csv):
	var matrix = Array();
	var csvRows = csv.split("\n");
	for rowIndex in csvRows.size():
		var matrixRow = Array();
		var csvCells = csvRows[rowIndex].split(",");
		for columnIndex in csvCells.size():
			var matrixCell = { "rowIndex": rowIndex, "columnIndex": columnIndex, "def": csvCells[columnIndex] };
			matrixRow.append(matrixCell);
		matrix.append(matrixRow);
	return matrix;

func updateRow(prevRow,newRow):
	if prevRow == null: # just realize new row in world
		var nColumns = newRow.size();
		for columnIndex in nColumns:
			var c = updateCell(null,newRow[columnIndex]);
			newRow[columnIndex] = c;
	elif newRow != null: # iterate over previous and new cells
		var prevRowColumns = prevRow.size();
		var newRowColumns = newRow.size();
		var nColumns = max(prevRowColumns,newRowColumns);	
		for columnIndex in nColumns:
			if columnIndex >= prevRowColumns:
				var c = updateCell(null,newRow[columnIndex]);
				newRow[columnIndex] = c;
			elif columnIndex >= newRowColumns:
				deleteCell(prevRow[columnIndex]);
			else:
				var c = updateCell(prevRow[columnIndex],newRow[columnIndex]);
				newRow[columnIndex] = c;
	else:
		print("strange error in World::updateRow");
	return newRow;
				
func deleteRow(row):
	var nColumns = row.size();
	for columnIndex in nColumns:
		deleteCell(row[columnIndex]);
		
func updateCell(prevCell,newCell):
	if prevCell == null: # just creating cell from def in newCell
		return realizeCell(newCell);
	elif prevCell.def == newCell.def: # no change in definitions, nothing
		return prevCell
	else:
		print("cell definition changed at " + str(prevCell.columnIndex) + "," + str(prevCell.rowIndex)); 
		deleteCell(prevCell);
		return realizeCell(newCell);
	
func deleteCell(cell):
	var x = cell.get("node3D",null);
	if x != null:
		x.queue_free();
	else:
		print("strange error, delete cell couldn't find node3D")
		print(str(cell))
		
func realizeCell(cell):
	var x;
	var y;
	var z;
	if mode == 2: # side-scroller
		x = 2.0 * cell["columnIndex"];
		y = -2.0 * cell["rowIndex"]; # TODO: upside-down
		z = 0.0;
	else:
		x = 2.0 * cell["columnIndex"];
		y = 0.0;
		z = 2.0 * cell["rowIndex"];
	cell.x = x;
	cell.y = y;
	cell.z = z;
	var def = cell["def"].to_lower();
	def = def.substr(1,def.length()-2); # remove quotation marks at beginning and end of cell def
	if mode == 2:
		cell.substance = "hole";
	else:
		cell.substance = "grass";
	cell.h = 0;
	var codes = def.split(" ",false);
	for codeNo in codes.size():
		parseCode(codes[codeNo],cell);
	cell = realizeAspects(cell);
	return cell;
		
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
	elif code == "h":
		aspects["substance"] = "hole";
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
	elif code == "fail":
		aspects["fail"] = true;
	elif code == "win":
		aspects["win"] = true;
	parseSimpleFunction("teleportto",code,aspects);
	parseSimpleFunction("teleportfrom",code,aspects);
	parseSimpleFunction("class",code,aspects);
	parseSimpleFunction("id",code,aspects);
	parseSimpleFunction("collisionon",code,aspects);
	parseSimpleFunction("collisionoff",code,aspects);
	parseSimpleFunction("gravity",code,aspects);
		
func realizeAspects(aspects):
	# create basic terrain
	if aspects["substance"] == "water":
		aspects = makeGrassStoneWater(aspects);
	elif aspects["substance"] == "stone":
		aspects = makeGrassStoneWater(aspects);
	elif aspects["substance"] == "grass":
		aspects = makeGrassStoneWater(aspects);
	else:
		aspects = makeHole(aspects);
	# add further aspects to that terrain
	if aspects.has("door"):
		makeADoor(aspects);
	if aspects.has("key"):
		makeAKey(aspects);
	if aspects.has("movableBlock"):
		movableBlock(aspects);
	if aspects.has("beam"):
		makeABeam(aspects);
	if aspects.has("obelisk"):
		makeAnObelisk(aspects);
	if aspects.has("teleportto"):
		makeATeleportTo(aspects);
	if aspects.has("teleportfrom"):
		makeATeleportFrom(aspects);
	return aspects;

func parseFunction(funcName,code):
	# if code begins with funcName and an open bracket...
	if code.substr(0,funcName.length()+1) == (funcName + "("):
		code = code.trim_prefix(funcName+"("); # ... remove one closing bracket...
		code = code.trim_suffix(")"); # ... and return the rest!
		return code;
	else:
		return null;
			
func parseSimpleFunction(funcName,code,aspects):
	var a = parseFunction(funcName,code);
	if a != null:
		print(funcName + "(" + a + ")");
		aspects[funcName] = a;

func realizeStuff(aspects,sb):
	realizeClass(aspects,sb);
	realizeId(aspects,sb);
	realizeCollisionOn(aspects,sb);
	realizeCollisionOff(aspects,sb);
	realizeFail(aspects,sb);
	realizeWin(aspects,sb);
	realizeGravity(aspects,sb);
	
func realizeClass(aspects,sb):
	var _class = aspects.get("class",null);
	if _class != null:
		sb.add_to_group(_class);
		
func realizeId(aspects,sb):
	var _id = aspects.get("id",null);
	if _id != null:
		sb.add_to_group("_id_" + _id);

func realizeFail(aspects,sb):
	var x = aspects.get("fail",null);
	if x != null:
		sb.add_to_group("_fail");

func realizeWin(aspects,sb):
	var x = aspects.get("win",null);
	if x != null:
		sb.add_to_group("_win");
		
func realizeGravity(aspects,sb):
	var x = aspects.get("gravity",null);
	if x != null:
		sb.add_to_group("_gravity");

func realizeCollisionOn(aspects,sb):
	var cOn = aspects.get("collisionon",null);
	if cOn != null:
		var g = "collisionon_" + cOn;
		print("adding to group " + g)
		sb.add_to_group(g);

func realizeCollisionOff(aspects,sb):
	var cOff = aspects.get("collisionoff",null);
	if cOff != null:
		var g = "collisionoff_" + cOff;
		print("adding to group " + g);
		sb.add_to_group(g);
	
func collisionOn(groupToTurnOn):
	print("collisionOn triggered! " + groupToTurnOn);
	get_tree().call_group(groupToTurnOn, "turnOn");
	$"../SoundBank".buttonpush();
	
func collisionOff(groupToTurnOff):
	print("collisionOff triggered! " + groupToTurnOff);
	get_tree().call_group(groupToTurnOff, "turnOff");
	$"../SoundBank".buttonpush();

func _on_auto_update_timer_timeout():
	print("autoupdate");
	getWorld_Update();
