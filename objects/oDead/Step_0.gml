time -= 1;

shake = approach(shake, 0, 0.1);
x = random_range(xstart - shake, xstart + shake);

if image_index > 11 {
    instance_destroy();
}