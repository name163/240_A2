// V4: Implemented fish class, added fish animation when oil spill covers the screen

PImage boat;
PImage ocean_sparse;
PImage ocean_dense;
PImage ocean_alternate;
PImage oil_spill;
PImage fish_icon;

int frame_counter = 0;
int boat_speed = 3;
int boat_x = 1000;
int pause_counter;
int boat_enter_pause_counter;
int list_length = 20;
int fish_random_x;
int fish_random_y;
int fish_random_color_r;
int fish_random_color_g;
int fish_random_color_b;
int fish_float_counter = 300;

float spill_opacity = 245;

boolean pause = false;

Fish[] fish_list = new Fish[list_length];

void setup() {
    size(1000, 1000);

    boat = loadImage("Assets/boat.png");
    oil_spill = loadImage("Assets/oil_spill.png");

    ocean_sparse = loadImage("Assets/ocean_1.png");
    ocean_dense = loadImage("Assets/ocean_2.png");
    ocean_alternate = ocean_sparse;

    for (int i = 0; i < fish_list.length; i++) {
        fish_random_x = int(random(30, 970));
        fish_random_y = int(random(30, 970));
        fish_random_color_r = int(random(150, 225));
        fish_random_color_g = int(random(150, 225));
        fish_random_color_b = int(random(150, 225));
        fish_list[i] = new Fish(
            loadImage("Assets/dead_fish.png"), fish_random_x, fish_random_y, fish_random_color_r, fish_random_color_g, fish_random_color_b
            );
    }
}

void draw() {
    frame_counter++;
    // Call function to change background
    change_background();
    imageMode(CORNER);
    image(ocean_alternate, 0, 0);
    
    // Moves boat
    boat_move();
}

// Changing background every 30 frames (half a second)
void change_background() {
    if (frame_counter%60==30) {
        ocean_alternate = ocean_dense;
    }
    else if (frame_counter%60==0) {
        ocean_alternate = ocean_sparse;
    }
}

// Oil spill and boat moves together
void boat_move() {
    draw_spill();
    draw_boat();

    if (pause==false) {
        boat_x-=boat_speed;

        // If boat and half of spill goes past left side of screen
        if (boat_x < -1251) {
            pause_boat();
        }
    } else {
        // If counter runs out
        if (pause_counter==0) {
            reset_scene();
        } else {
            fish_animation();
            if (pause_counter < 60) {
                spill_opacity -= 245 / 60;
            }
            fish_float_counter--;
            pause_counter--;
        }
    }
}

void draw_boat() {
    image(boat, boat_x, 400);
}

void draw_spill() {
    tint(255, spill_opacity);
    image(oil_spill, boat_x+251, 0);
    tint(255, 255);
}

void pause_boat() {
    pause = true;   // Pause
    pause_counter = 600;    // Delay reset for 20 seconds
    boat_enter_pause_counter = 60;
    fish_float_counter = 300;
}

void reset_scene() {
    for (Fish fish : fish_list) {
        fish.fish_alpha = 0;
    }
    println(fish_list[0].fish_alpha);
    boat_x = 1000;  // Reset boat position to beginning of GIF
    spill_opacity = 245;
    pause = false;
}

void fish_animation() {
    for (Fish fish : fish_list) {
        if (fish_float_counter < 60) {
            fish.sink_down();
        } else {
            fish.rise_to_surface();
        }
    }
}