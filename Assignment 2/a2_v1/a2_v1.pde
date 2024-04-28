// V1: Loading basic assets into the scene, added basic wave animation

PImage boat, ocean_1, ocean_2, ocean;
int frame_counter = 0;

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
    
    imageMode(CENTER);
    image(boat, 500, 500);
}

void change_background() {
    if (frame_counter%60==30) {
        ocean = ocean_2;
    }
    else if (frame_counter%60==0) {
        ocean = ocean_1;
    }
}
