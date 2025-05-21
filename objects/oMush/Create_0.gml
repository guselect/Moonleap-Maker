near_lady = noone;

bigmask = false;
night = false;
gray = false;
glued = false;
wont_glue = false;

flash = 0;
xscale = 1;

image_index = 0;
image_speed = 0;

find_object_to_glue = function() {
  if glued or wont_glue then return;

  if instance_exists(oLady) {
  	if image_angle == 0 or image_angle == 180 { 
      near_lady = instance_nearest(x, y, oLady);
  		
  		if distance_to_object(near_lady) < 2 {
  			glued = true;
        return;
  		}
  	}
  }
  
  
  if instance_exists(oBatVer) {
    near_lady = instance_nearest(x, y, oBatVer);

    switch(image_angle) {
      case 90:
      case -270:
      case 270:
      case -90:
        if distance_to_object(near_lady) < 4 {
    			glued = true;
          return;
    		}
        break;
      
      case 0:
      case 180:
      case -180:
        if distance_to_object(near_lady) < 4 {
    			glued = true;
          return;
    		}
        break;
    }
  }
  
  if instance_exists(oBat) {
    near_lady = instance_nearest(x, y, oBat);
  	if (image_angle == -90 or image_angle == 90) and distance_to_object(near_lady) < 4 {
      glued = true;
      return;
  	} else if image_angle == 0 and distance_to_object(near_lady) < 4 {
      glued = true;
      return;
  	} else if image_angle == 180 and distance_to_object(near_lady) < 6 {
      glued = true;
      return;
  	}
  }

  wont_glue = true;
}

glue_on_object_if_exists = function() {
  if not glued or wont_glue then return;

  switch(near_lady.object_index) {
    case oLady:
      switch(image_angle) {
        case 0:
          x = near_lady.x - 8;
          break;

        case 180:
          x = near_lady.x + 8;
          break;
      }
      break;

    case oBatVer:
      switch(image_angle) {
        case 90:
        case -270:
          y = near_lady.y + 8;
          break;

        case -90:
        case 270:
          y = near_lady.y - 8;
          break;
        
        case 0:
          x = near_lady.x - 8;
          break;
        
        case 180:
          x = near_lady.x + 8;
          break;
      }
      break;

    case oBat:
    case oBatGiant:
      switch(image_angle) {
        case 90:
        case -90:
          y = near_lady.y - 8;
          break;
        
        case 0:
          x = near_lady.x - 8;
          break;
        
        case 180:
          x = near_lady.x + 8;
          break;
      }
      break;
  }
}