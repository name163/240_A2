// Test adding fish animation

PImage boat, ocean_1, ocean_2, dead_fish, ocean;
int frame_counter = 0;
int boat_speed = 3;
int boat_x = 1000;
int pause_counter;
float fish_alpha = 0;
int fish_x;
int fish_y;
int fish_size = 34;
int fish_size_change;
int random_seed = 0;
float alpha_increment;

PImage[] fish_list = new PImage[10];

boolean pause = false;

void setup() {
    size(1000, 1000);

    boat = loadImage("Assets/boat.png");
    ocean_1 = loadImage("Assets/ocean_1.png");
    ocean_2 = loadImage("Assets/ocean_2.png");
    for (int i = 0; i < fish_list.length; i++) {
        fish_list[i] = loadImage("Assets/dead_fish.png");
    }
    
    ocean = ocean_1;
}

void draw() {
    frame_counter++;
    // Every 30 seconds the background changes
    change_background();
    imageMode(CORNER);
    image(ocean, 0, 0);

    fish_up();
}

void fish_up() {
    randomSeed(random_seed);
    alpha_increment = 1;
    random(1, 4.25);
    fish_alpha += alpha_increment;
    for (PImage fish : fish_list) {
        
        display_fish(fish);
    }
}

void display_fish(PImage fish) {
    fish_x = int(random(30, 970));
    fish_y = int(random(30, 970));
    tint(255, fish_alpha);
    image(fish, fish_x, fish_y);
    tint(255, 255); // Reset change to the tint
}


// Changing background every 30 frames (half a second)
void change_background() {
    if (frame_counter%60==30) {
        ocean = ocean_2;
    }
    else if (frame_counter%60==0) {
        ocean = ocean_1;
    }
}

void boat_move() {
    if (pause==false) {
        image(boat, boat_x, 400);
        boat_x-=boat_speed;

        // If boat goes past left side of screen
        if (boat_x < -301) {
            boat_x = 1000;  // Reset boat position
            pause = true;   // Pause
            pause_counter=120;    // Delay reset
        }
    } else {
        // If counter runs out stops the pause and resets boat pos
        if (pause_counter==0) {
            pause = false;
        } else {
            pause_counter--;
        }
    }
}
