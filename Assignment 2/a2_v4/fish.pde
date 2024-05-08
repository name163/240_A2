class Fish {
    PImage fish_img;
    
    int posX;
    int posY;
    int fish_size;
    int fish_size_change;
    int random_seed = 0;
    int fish_random_color_r;
    int fish_random_color_g;
    int fish_random_color_b;
    
    float alpha_increment;
    float fish_alpha = 0;

    Fish(
        PImage fish_img, int posX, int posY, int fish_random_color_r, int fish_random_color_g, int fish_random_color_b
        ) {
        this.fish_img = fish_img;
        this.posX = posX;
        this.posY = posY;
        this.fish_random_color_r = fish_random_color_r;
        this.fish_random_color_g = fish_random_color_g;
        this.fish_random_color_b = fish_random_color_b;
        this.alpha_increment = random(1, 4.25);
    }

    void rise_to_surface() {
        randomSeed(random_seed);
        fish_alpha += alpha_increment;
        draw_fish();
    }

    void sink_down() {
        randomSeed(random_seed);
        fish_alpha -= alpha_increment;
        draw_fish();
    }

    void draw_fish() {
        tint(fish_random_color_r, fish_random_color_g, fish_random_color_b, fish_alpha);
        image(fish_img, posX, posY);
        tint(255, 255);
    }
}
