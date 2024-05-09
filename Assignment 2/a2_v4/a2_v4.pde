// V4: Implemented fish class, added fish animation when oil spill covers the screen
// Added variations to fish size, refactored code and added appropriate comments

PImage boat;
PImage ocean_sparse;
PImage ocean_dense;
PImage ocean_alternate;
PImage oil_spill;
PImage fish_icon;

int frame_counter = 0;
int boat_speed = 10;
int boat_x = 1000;
int pause_counter;
int boat_enter_pause_counter;
int fish_list_length = 20;
int fish_random_x;
int fish_random_y;
int fish_random_color_r;
int fish_random_color_g;
int fish_random_color_b;
int fish_random_size;
int fish_float_counter = 300;

float spill_opacity = 245;

boolean pause = false;

Fish[] fish_list = new Fish[fish_list_length];

void setup() {
    size(1000, 1000);

    boat = loadImage("Assets/boat.png");
    oil_spill = loadImage("Assets/oil_spill.png");

    ocean_sparse = loadImage("Assets/ocean_1.png");
    ocean_dense = loadImage("Assets/ocean_2.png");
    ocean_alternate = ocean_sparse;

    // Setting up variables for each fish
    // Using random
    for (int i = 0; i < fish_list.length; i++) {
        // Ensure the int is contained within the border
        // So fish image won't go out of bounds
        fish_random_x = int(random(100, 900));
        fish_random_y = int(random(100, 900));
        // Limit rgb to shades of blue
        // So the colors are still sort of natural
        fish_random_color_r = int(random(150, 225));
        fish_random_color_g = int(random(150, 225));
        fish_random_color_b = int(random(150, 225));
        fish_random_size = int(random(32, 70));
        fish_list[i] = new Fish(
            loadImage("Assets/dead_fish.png"),
            fish_random_x,
            fish_random_y,
            fish_random_color_r,
            fish_random_color_g,
            fish_random_color_b,
            fish_random_size
        );
    }
}

void draw() {
    // Call function to change background
    change_background();
    imageMode(CORNER);
    image(ocean_alternate, 0, 0);
    
    // Moves boat
    boat_move();

    frame_counter++;
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

    // Check if boat has passed left side of screen
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
            // Oil spill fades away
            if (pause_counter < 60) {
                spill_opacity -= 245 / 60;
            }
            counter_decrement();
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
    pause = true;
    pause_counter = 600;
    boat_enter_pause_counter = 60;
    fish_float_counter = 300;
}

void reset_scene() {
    for (Fish fish : fish_list) {
        fish.fish_alpha = 0;
    }
    println(fish_list[0].fish_alpha);
    boat_x = 1000;
    spill_opacity = 245;
    pause = false;
}

// Controls when the fish objects appear and disappear
void fish_animation() {
    for (Fish fish : fish_list) {
        if (fish_float_counter < 60) {
            fish.sink_down();
        } else {
            fish.rise_to_surface();
        }
    }
}

void counter_decrement() {
    fish_float_counter--;
    pause_counter--;
}