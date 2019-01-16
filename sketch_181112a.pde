void setup() {
  fullScreen();
  pb[0] = width-50;
  ball[0] = width/2;
  ball[1] = height/2;
  ellipseMode(CENTER);
}
void keyPressed() {
  if ((keyCode == UP) & (pb[1] > 10))
    pb[1]-=50;
  else if ((keyCode == DOWN) & (pb[1] < height-(10+pb[3])))
    pb[1]+=50;
}
int ball[]= {
  width/2,height/2,
  70, 5, 5 // index 2 and 3 for dir x y 
};
int pa[] = {
  0,0,
  50,200
};
int pb[] = {
  width-50,0,
  50,200, 1 //index 4 for dir Y
};
float level;
int scores[]={0,0};
boolean ball_in(int x[]) {
  if ((((ball[0]+(ball[2]/2) >= x[0]) & (ball[0]+(ball[2]/2) <= x[0]+x[2])) | ((ball[0]-(ball[2]/2) >= x[0]) & (ball[0]-(ball[2]/2) <= x[0]+x[2]))) & (((ball[1]+(ball[2]/2) >= x[1]) & (ball[1]+(ball[2]/2) <= x[1]+x[3])) | ((ball[1]-(ball[2]/2) >= x[1]) & (ball[1]-(ball[2]/2) <= x[1]+x[3]))))
    return true;
  return false;
}
float speed[]={0.01,0.01};
void draw() {
  background(0);
  text("\t\tScores\nA: "+scores[0]+"\t\t B: "+scores[1], width/3, height/9);
  rect(pa[0],pa[1],pa[2],pa[3]);
  pa[1] = mouseY;
  if (pa[1]+pa[3] > height) {
    pa[1] -= (pa[1]+pa[3])-height;
  }
  rect(pb[0],pb[1],pb[2],pb[3]);
  if ((pb[1]+pb[3] > height) | (pb[1] < 0))
    pb[4] *= -1;
  ellipse(ball[0],ball[1],ball[2],ball[2]);
  ball[0]+=ball[3]+(ball[3]*speed[0]);
  ball[1]+=ball[4]+(ball[4]*speed[0]);
  if (frameCount%400 == 0) level+=0.4;
  if (pb[4] < 0)
    pb[4] = -(4+int(level%5));
  else
    pb[4] = 4+int(level%15);
  if (ball[3] < 0)
    ball[3] = -(4+int(level%5));
  else
    ball[3] = 4+int(level%5);
  if (ball[4] < 0)
    ball[4] = -(4+int(level%5));
  else
    ball[4] = 4+int(level%5);
  if(ball[0] > width) {
    
    scores[0]++;
    ball[3]*=-1;
    ball[0] = width/2;
    ball[1] = height/2;
  } else if(ball[0] < 0) {
    scores[1]++;
    ball[3]*=-1;
    ball[0] = width/2;
    ball[1] = height/2;
  }
  if((ball[1] > height) | (ball[1] < 0))
    ball[4]*=-1;
    println(ball[0] > width/2);
    if (ball[0] > width/2) {
      if (ball_in(pb)) {
        ball[3]*=-1;
      }
    } else {
      if (ball_in(pa))
        ball[3]*=-1;
    }
  speed[0]+=speed[1];
  if ((speed[0] >3.0) | (speed[0]<0.4)) speed[1]*=-1;
}
