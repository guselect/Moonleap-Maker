time += random_range(0, 2);

if time > 300 {
  var _x = x + random_range(0, 16),
      _y = y,
      _layer = layer,
      _water_drop_obj = oWaterDrop;
  
  instance_create_layer(_x, _y, _layer, _water_drop_obj);
  time = 0;
}
