night = false;
ani = 0;

_slices = new SpriteSlices(self);
_slices.update_neighbors_once = true;
_slices.slice_boxes.center = new SpriteSliceBox(8, 8, 16, 16);
_slices.slice_boxes.left = new SpriteSliceBox(3, 3, 5, 26);
_slices.slice_boxes.right = new SpriteSliceBox(24, 3, 5, 26);
_slices.slice_boxes.top = new SpriteSliceBox(8, 3, 16, 5);
_slices.slice_boxes.bottom = new SpriteSliceBox(8, 24, 16, 5);

image_index = 2;
