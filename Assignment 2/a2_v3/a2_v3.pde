// V3: Created oil spill at the back of the boat

PImage boat;
PImage ocean_sparse;
PImage ocean_dense;
PImage ocean_alternate;
PImage oil_spill;

int frame_counter = 0;
int boat_speed = 3;
int boat_x = 1000;
int pause_counter;

boolean pause = false;

void setup() {
    size(1000, 1000);

    boat = loadImage("Assets/boat.png");
    oil_spill = loadImage("Assets/oil_spill.png");

    ocean_sparse = loadImage("Assets/ocean_1.png");
    ocean_dense = loadImage("Assets/ocean_2.png");
    ocean_alternate = ocean_sparse;
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
    tint(255, 240);
    image(oil_spill, boat_x+251, 0);
    tint(255, 255);
    image(boat, boat_x, 400);
    if (pause==false) {
        boat_x-=boat_speed;

        // If boat and half of spill goes past left side of screen
        if (boat_x < -1251) {
            pause_boat();
        }
    } else {
        // If counter runs out
        if (pause_counter==0) {
            boat_x = 1000;  // Reset boat position to beginning of GIF
            pause = false;
        } else {
            pause_counter--;
        }
    }
}

void pause_boat() {
    pause = true;   // Pause
    pause_counter=1200;    // Delay reset for 20 seconds
}