import flx3d.Flx3DView;
import flx3d.Flx3DUtil;
import flx3d.Flx3DCamera;
import flixel.FlxCamera;

var stageFront:Mesh;
var opponent:Mesh;

var xOff:Int = 0;
var yOff:Int = 0;

var timer:Int = 0;
var timerMax:Int = 50;

var LEFT:Bool = false;
var DOWN:Bool = false;
var UP:Bool = false;
var RIGHT:Bool = false;

var turnSpd:Int = 5;
var moveSpd:Int = 10;

var xOppOff:Int = 0;
var yOppOff:Int = 0;

public var view:Flx3DView;
public var cam:Flx3DCamera;

//2D Bullcrap for the one second the stage doesn't load in 3D.
function create() {
    importScript("data/scripts/pixel");
    if (PlayState.SONG.song == "Roses") {
        flabbergastGirls();
    }
}
//Line 40
public function flabbergastGirls() {
    bgGirls.animation.remove("danceLeft");
    bgGirls.animation.remove("danceRight");
    bgGirls.animation.addByIndices('danceLeft', 'BG fangirls dissuaded', CoolUtil.numberArray(14), "", 24, false);
    bgGirls.animation.addByIndices('danceRight', 'BG fangirls dissuaded', CoolUtil.numberArray(30, 15), "", 24, false);
    bgGirls.animation.play("danceLeft", true);
}
//3D Stuff now :yippee:

function postCreate() {
	Flx3DUtil.is3DAvailable();
	cam = new Flx3DCamera(0, 0, 500, 500, 1);
	view = new Flx3DView(0, 0, FlxG.width * 1.5, FlxG.height * 1.5);
	view.screenCenter();
	view.scrollFactor.set();
	view.antialiasing = true;
	//insert(members.indexOf(dad), view);
	insert(members.indexOf(boyfriend), view);


//3D Stage and skybox making.

			skyboxTex = new BitmapCubeTexture(Cast.bitmapData("models/skybox/px.png"), Cast.bitmapData("assets/models/skybox/nx.png"),
				Cast.bitmapData("models/skybox/py.png"), Cast.bitmapData("models/skybox/ny.png"),
				Cast.bitmapData("models/skybox/pz.png"), Cast.bitmapData("models/skybox/nz.png"));

			skybox = new SkyBox(skyboxTex);
			view.view.scene.addChild(skybox);


	view.addModel(Paths.awd("gronz"), function(model) {
		view.meshes[0].scale(2);
	}, Paths.image("models/school"), true);
	view.addModel(Paths.awd("trez"), function(mesh) {
		view.meshes[1].scale(3);
	}, Paths.image("models/petal"), true);



//3D Character Making

	view.addModel(Paths.awd("senpai/senpai"), function(mesh) {
		view.meshes[2].scale(150);
	}, Paths.image("models/senpai/senpai"), true);


	add(cam);  //Line 90
	add(view); //Line 91
	timer = timerMax;
}

function update() {
	xOff = -200 -FlxG.camera.scroll.x;
	FlxG.camera.scroll.y = 150;
	view.meshes[0].x = xOff;
	view.meshes[1].x = xOff;
	view.meshes[2].x = xOff - 300 + xOppOff;
	view.meshes[0].y = yOff;
	view.meshes[1].y = yOff;
	view.meshes[2].y = yOff - 100 + yOppOff;
	if (timer == 0) {
		view.meshes[2].rotationY = 0;
		view.meshes[2].rotationX = 0;
		xOppOff = 0;
		yOppOff = 0;
		LEFT = false;
		DOWN = false;
		UP = false;
		RIGHT = false;
	}
	if (timer > 0) {
		timer -= 1;
		if (LEFT) {
			view.meshes[2].rotationY += turnSpd;
			view.meshes[2].rotationX = 0;
			xOppOff -= moveSpd;
			yOppOff = 0;
		}
		if (DOWN) {
			view.meshes[2].rotationY = 0;
			view.meshes[2].rotationX -= turnSpd;
			xOppOff = 0;
			yOppOff -= moveSpd;
		}
		if (UP) {
			view.meshes[2].rotationY = 0;
			view.meshes[2].rotationX += turnSpd;
			xOppOff = 0;
			yOppOff += moveSpd;
		}
		if (RIGHT) {
			view.meshes[2].rotationY -= turnSpd;
			view.meshes[2].rotationX = 0;
			xOppOff += moveSpd;
			yOppOff = 0;
		}
	}
}

function onDadHit(note:Note) {
	if (note.direction == 0) {
		LEFT = true;
		DOWN = false;
		UP = false;
		RIGHT = false;
		view.meshes[2].rotationY = 0;
		view.meshes[2].rotationX = 0;
		xOppOff = 0;
		yOppOff = 0;
		timer = timerMax;
	}
	if (note.direction == 1) {
		LEFT = false;
		DOWN = true;
		UP = false;
		RIGHT = false;
		view.meshes[2].rotationY = 0;
		view.meshes[2].rotationX = 0;
		xOppOff = 0;
		yOppOff = 0;
		timer = timerMax;
	}
	if (note.direction == 2) {
		LEFT = false;
		DOWN = false;
		UP = true;
		RIGHT = false;
		view.meshes[2].rotationY = 0;
		view.meshes[2].rotationX = 0;
		xOppOff = 0;
		yOppOff = 0;
		timer = timerMax;
	}
	if (note.direction == 3) {
		LEFT = false;
		DOWN = false;
		UP = false;
		RIGHT = true;
		view.meshes[2].rotationY = 0;
		view.meshes[2].rotationX = 0;
		xOppOff = 0;
		yOppOff = 0;
		timer = timerMax;
	}
}
