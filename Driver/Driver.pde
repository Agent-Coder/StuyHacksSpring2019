import java.util.*;

public Game g;

float lastTime;
float dt;
float timeRunning;

void setup() {
  size(700, 700);
  g = new Game();
}

void draw() {
  float currentTime = millis() / 1000f;
  dt = currentTime-lastTime;
  timeRunning += dt;
  g.update(timeRunning, dt);
  lastTime = currentTime;
}
