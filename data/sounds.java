/*
 * With the way the current sound library works, we need to put all sound files
 * into a folder called "data" in the root directory of our project.

 Reference: https://processing.org:8443/reference/libraries/sound/SoundFile.html
 */

import processing.sound.*;
SoundFile bells[27];
SoundFile swells[3];
SoundFile ambience;

void setup() {
    // size ();
    // background();

    // Loads from /data folder
    // Bells
    for (int i = 0; i < 27; i++){
        string filename = "c0";
        if (i < 10){
            // generates mp3 filename for single digit index, e.g. "c003.mp3"
            filename += 0;
            filename += i;
        }
        else{
            // double digit index
            filename += i;
        }
        filename += .mp3;
        bells[i] = new SoundFile(this, filename)
    }

    // Swells
    swells[0] = new SoundFile(this, "swell1.mp3");
    swells[1] = new SoundFile(this, "swell2.mp3");
    swells[2] = new SoundFile(this, "swell3.mp3");

    // Ambient
    ambience = new SoundFile(this, "ambience.mp3");
}

// Usage
bells[i].play;
swells[i].play
ambience.play
