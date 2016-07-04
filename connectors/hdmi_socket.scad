use <hdmi_plug.scad>;

$fn=50;

container_depth=hdmi_depth() /2; //testing fit, should be +2;
container_width=hdmi_width() +2;
container_height=hdmi_height() + 2;

rounding_radius=2;

module hdmi_socket(){
    translate([-((container_depth-hdmi_depth())*.51),0,0])
        difference(){
            translate([(container_depth - hdmi_depth())*.51,0,0])
                cube([container_depth, container_width, container_height], center=true);
            hdmi_plug();
        }
}

module hdmi_socket_rounded(){
    translate([-((container_depth-hdmi_depth())*.51),0,0])
        difference(){
            translate([(container_depth - hdmi_depth())*.51,0,-(container_height/2)-rounding_radius])
                translate([-(container_depth/2),-(container_width/2),rounding_radius])
                    rotate([90,0,90])
                        linear_extrude(height=container_depth){
                            offset(r=rounding_radius) square([container_width,container_height]);
                    }
            hdmi_plug();
        }
}


translate([(container_height/2)+rounding_radius, (container_width/2)+rounding_radius, container_depth/2])
    rotate([0,-90,0])
        hdmi_socket_rounded();
 
//translate([container_height/2, container_width/2, container_depth/2])
//    rotate([0,90,0])
//        hdmi_socket();

