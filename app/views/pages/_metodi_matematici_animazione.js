// creo le basi della scene. Niente di molto interessante per ora: questo codice rimane quasi lo stesso
// fra un esempio e l'altro. Non è necessario capire subito i dettagli (saltare i dettagli
// è un principio che vale anche per apprendere le lingue straniere)
let canvas = document.getElementById('c');
canvas.addEventListener('wheel', evt => evt.preventDefault());
let engine = new BABYLON.Engine(canvas, true);
let scene = new BABYLON.Scene(engine);
scene.clearColor = new BABYLON.Color3(0.95, 0.95, 0.95);
let camera = new BABYLON.ArcRotateCamera('cam', Math.PI/2,Math.PI/2,8, new BABYLON.Vector3(0,0,0), scene);
camera.attachControl(canvas,true);
camera.wheelPrecision = 50;
camera.lowerRadiusLimit = 3;
camera.upperRadiusLimit = 13;
let light1 = new BABYLON.PointLight('light1',new BABYLON.Vector3(3,2,3), scene);
light1.parent = camera;

// qui comincia la parte interessante: creo una sfera e due anelli concentrici.
// Provate a cambiare i parametri : ad es. il diametro dell'anello esterno.

// ecco la sfera colorata di giallo
let sphere = BABYLON.MeshBuilder.CreateSphere('s', {diameter:2.0}, scene);
sphere.material = new BABYLON.StandardMaterial('smat', scene);
sphere.material.diffuseColor.set(0.8,0.6,0.1);

// un primo anello, colorato di azzurro.
let torus1 = BABYLON.MeshBuilder.CreateTorus('t', {diameter:2.8, thickness:0.4, tessellation : 70}, scene);
torus1.material = new BABYLON.StandardMaterial('smat', scene);
torus1.material.diffuseColor.set(0.2,0.6,0.8);
// dilato l'anello lungo l'asse y (l'asse dell'anello)
torus1.scaling.y = 3;

// aggiungo il secondo anello, blu.
let torus2 = BABYLON.MeshBuilder.CreateTorus('t', {diameter:4, thickness:0.5, tessellation : 70}, scene);
torus2.scaling.y = 2;
torus2.rotation.x = Math.PI/2;
torus2.material = new BABYLON.StandardMaterial('smat', scene);
torus2.material.diffuseColor.set(0.1,0.2,0.8);

// qui c'è l'animazione. Il codice seguente viene chiamato circa 60 volte al secondo.
engine.runRenderLoop(function() {

  // calcolo il numero di secondi trascorsi dall'inizio dell'animazione
  let t = performance.now() * 0.001;

  // ruoto l'anello interno attorno all'asse x. La velocità di rotazione è due radianti al secondo.
  // (usiamo i radianti invece dei gradi: l'angolo retto vale pi greco mezzi; l'angolo giro è due pi greco)
  // provate a modificare il coefficiente di t per fare andare l'anello più lento o più veloce.
  // come si fa a farlo ruotare in direzione opposta?
  torus1.rotation.x = t*2;

  // provate ad aggiungere una riga in modo da far ruotare anche l'anello esterno.

  // ... mettete qui il vostro codice  ...

  // qust'ultimo comando disegna il nuovo fotogramma
  scene.render();
});
