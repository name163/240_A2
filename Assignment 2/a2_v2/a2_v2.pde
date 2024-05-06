// V2: Moving the boat across the screen, adding delay to the loop
// Made it into a function for easier reading

PImage boat;
PImage ocean_sparse;
PImage ocean_dense;
PImage ocean_alternate;

int frame_counter = 0;
int boat_speed = 3;
int boat_x = 1000;
int pause_counter;

boolean pause = false;

void setup() {
    size(1000, 1000);

    boat = loadImage("Assets/boat.png");
    ocean_sparse = loadImage("Assets/ocean_1.png");
    ocean_dense = loadImage("Assets/ocean_2.png");
    ocean_alternate = ocean_sparse;
}

void draw() {
    frame_counter++;
    // Every 30 seconds the background changes
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

void boat_move() {
    if (pause==false) {
        image(boat, boat_x, 400);
        boat_x-=boat_speed;

        // If boat goes past left side of screen
        if (boat_x < -301) {
            boat_x = 1000;  // Reset boat position
            pause_boat();
        }
    } else {
        // If counter runs out
        if (pause_counter==0) {
            pause = false;
        } else {
            pause_counter--;
        }
    }
}

void pause_boat() {
    pause = true;   // Pause
    pause_counter=120;    // Delay reset
}