// Specs from: http://media.digikey.com/pdf/Data%20Sheets/Hirose%20PDFs/MD_Series.pdf
$fn=20;

hdmi_plug_depth=10;
hdmi_plug_width=15;
hdmi_plug_height=5;

function hdmi_depth() = hdmi_plug_depth;
function hdmi_width() = hdmi_plug_width;
function hdmi_height() = hdmi_plug_height;

hdmi_plug_top_height=3;
hdmi_plug_bottom_height=hdmi_plug_height-hdmi_plug_top_height;
hdmi_plug_bevel_width=1.3;

rounding_radius=0.35;
top_unrounded_height=hdmi_plug_top_height-(2*rounding_radius);
top_unrounded_width=hdmi_plug_width-(2*rounding_radius);
bottom_square_width=10.6;
bottom_bevel_hypotenuse=1.84;

diff_buffer=0.2;

module hdmi_upper(){
    translate([-(hdmi_plug_depth/2),-(top_unrounded_width/2),rounding_radius])
        rotate([90,0,90]) 
            linear_extrude(height=hdmi_plug_depth){
                offset(r=rounding_radius) square([top_unrounded_width,top_unrounded_height]);
            }
//    translate([0,0,2.25]) cube([10.9,15.1,4.5], center=true);
}

module hdmi_lower_side(){
    translate([0,-(hdmi_plug_bevel_width/2),(hdmi_plug_bottom_height/2) + 0.01])
    difference(){
        cube([hdmi_plug_depth, hdmi_plug_bevel_width, hdmi_plug_bottom_height], center=true);
        translate([0,-(hdmi_plug_bevel_width/2),-(hdmi_plug_bottom_height/2)]) 
            rotate([-45,0,0]) 
                cube([(hdmi_plug_depth + diff_buffer),bottom_bevel_hypotenuse,bottom_bevel_hypotenuse], center=true);
    }
}

module hdmi_lower(){
    translate([0,-(bottom_square_width/2),-(hdmi_plug_bottom_height)+0.01])
    union(){
        translate([0,0,0])
            hdmi_lower_side();
        translate([0,(bottom_square_width/2)-0.01,(hdmi_plug_bottom_height/2)])
            cube([hdmi_plug_depth,bottom_square_width+0.025,hdmi_plug_bottom_height+0.01],center=true);
        translate([0,bottom_square_width,0]) 
            rotate([0,0,180])
                hdmi_lower_side();
    }
}

module hdmi_plug(){
    translate([0,0,-((hdmi_plug_top_height/2)-(hdmi_plug_bottom_height/2))])
        union(){
            hdmi_upper();
            hdmi_lower();
        }
}

hdmi_plug();
