// V2: Moving the boat across the screen, adding delay to the loop

PImage boat, ocean_1, ocean_2, ocean;
int frame_counter = 0;
int boat_speed = 3;
int boat_x = 1000;
int pause_counter;
boolean pause = false;

void setup() {
    size(1000, 1000);

    boat = loadImage("Assets/boat.png");
    ocean_1 = loadImage("Assets/ocean_1.png");
    ocean_2 = loadImage("Assets/ocean_2.png");
    ocean = ocean_1;
}

void draw() {
    frame_counter++;
    // Every 30 seconds the background changes
    change_background();
    imageMode(CORNER);
    image(ocean, 0, 0);
    
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
        // If counter runs out
        if (pause_counter==0) {
            pause = false;
        } else {
            pause_counter--;
        }
    }
    
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
