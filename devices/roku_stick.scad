use <media/connectors/hdmi_plug.scad>
fudge_factor=0.5;
real_stick_width=27;
stick_width=16;

rounding_radius=(real_stick_width - stick_width)/2;
echo("Stick width is ", stick_width); 

stick_height=12;

real_stick_body_depth=70;
stick_body_depth=real_stick_body_depth - (2* rounding_radius);


function roku_width()=real_stick_width;
function roku_height()=stick_height;
function roku_depth()=(real_stick_body_depth + hdmi_depth());

module roku_stick(){
    translate([-(hdmi_depth()/2)-0.25,0,0])
        union(){
            translate([-(stick_body_depth/2), -(stick_width/2), -(stick_height/2)])
                linear_extrude(height=stick_height){
                    offset(r=rounding_radius)
                        square([stick_body_depth,stick_width]);
                }
            translate([(real_stick_body_depth + hdmi_depth())/2-0.02,0,0])
                hdmi_plug();
        }
}

module roku_stick_cavity(){
    translate([-(hdmi_depth()/2)-0.25,0,0])
        union(){
            translate([-(stick_body_depth/2), -(stick_width/2), -(stick_height/2)])
                linear_extrude(height=stick_height+fudge_factor){
                    offset(r=rounding_radius)
                        square([stick_body_depth+fudge_factor,stick_width+fudge_factor]);
                }
            translate([(real_stick_body_depth +fudge_factor + hdmi_depth())/2-0.02,0,0])
                hdmi_plug();
        }
}

//translate([0,0, (real_stick_body_depth/2)])
//rotate([0,-90,0])
    roku_stick_cavity();