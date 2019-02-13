include <slots.scad>
thickness = 7;

module exportEachOne(){
    squarePiece();
    translate([-50, 0]) slotCutout();
    translate([0, 0]) squarePiece();	
    translate([50, 0]) straightLigature();
    translate([100, 0]) xLigature();
    translate([150, 0]) lLigature();
    translate([200, 0]) tLigature();
    translate([0, 50]) baseFoot();
    translate([0, 200]) baseFoot(200, 60, diff=false);
    plug();
    plugDoublePuzzle();
}
module export() {
     for(x = [0:3]) for(y = [0:3]) {
        translate([x * 40, y * 40]) squarePiece();
     }
 }

// exportEachOne();
export();