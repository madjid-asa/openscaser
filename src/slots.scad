include <config.scad>

module plugPuzzle(thickness=thickness, slotLength=slotLength){
    square([thickness, slotLength], center=true);
}



module plugDoublePuzzle(thickness=thickness, slotLength=slotLength, spacePlug=spacePlug, hole=false){
	// if(hole) {
	// 	slotCutout(thickness, slotLength);
	// 	translate([spacePlug, 0]) slotCutout(thickness, slotLength);
	// } else {
		echo(spacePlug);
		echo("okok");
		plugPuzzle(thickness, slotLength);
		translate([thickness*2, 0]) plugPuzzle(thickness, slotLength);
	// }
}

module slotCutout(thickness=thickness, slotLength=slotLength) {
    plugPuzzle(thickness, slotLength);
	rotate([0, 0, 45]) square(thickness, center = true);
}

module squarePiece () {
    difference() {
        square(squareSize, center=true);
        for(i = [0:3]) {
            rotate([0, 0, 90 * i]) translate([0, squareSize/2]) slotCutout();
        }
    }
}

module straightLigature() {
    intersection() {
        squarePiece();
        square([squareSize, ligatureWidth], center=true);
    }
}

module xLigature() {
    union() {
        straightLigature();
        rotate([0, 0, 90]) straightLigature();
    }
}

module lLigature() {
    ss = squareSize - (squareSize - ligatureWidth) / 2 ;
    intersection() {
        xLigature();
        translate([(squareSize - ss) / 2, (squareSize - ss) / 2]) square([ss, ss], center=true);
    };
}

module tLigature() {
    ss = squareSize - (squareSize - ligatureWidth) / 2 ;
    difference() {
        xLigature();
        translate([0, -ss]) square(squareSize, center = true);
    }
}

module translateSlotsInBase(widthBase=widthBaseFoot, heightBase=heightBaseFoot, offset=thickness)
{
	// bottom
	translate([widthBase/2-offset, 0, 0]) 
		rotate([0, 0, 0]) children(0);
	// top
	translate([widthBase/2+offset, heightBase, 0]) 
		rotate([0, 0, 180]) children(0);
	// right
	translate([widthBase, heightBase/2-offset, 0])
		rotate([0, 0, 90]) children(0);
	// left
	translate([0, heightBase/2+offset, 0]) 
		rotate([0, 0 ,-90]) children(0);
}

module getDifferenceOrUnion(diff){
	if (diff) {
		difference() {
			children(0);
			for (i = [1 : $children-1]) children(i);
		}
	} else {
		union() {
			children(0);
			for (i = [1 : $children-1]) children(i);
		}
	}
}



module baseFoot(widthBase=widthBaseFoot, heightBase=heightBaseFoot, offset=thickness, diff=true)
{	
	getDifferenceOrUnion(diff)
		{
			// BASE
			square([widthBase+2*thickness, heightBase+2*thickness]);
			// SLOTS
			translateSlotsInBase(widthBase, heightBase, offset)
				plugDoublePuzzle(thickness=thickness, slotLength=thickness, hole=diff);
				// hole(offset);
		}

}

