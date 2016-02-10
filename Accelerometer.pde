import ketai.sensors.*;
KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;
boolean flag;
int old = 0;


void setup()
{
  sensor = new KetaiSensor(this);
  sensor.start();
  orientation(LANDSCAPE);
  flag = false;
}

void draw()
{
  background(78, 93, 75);
  float sum = sqrt((accelerometerX * accelerometerX) + (accelerometerY * accelerometerY) + (accelerometerZ * accelerometerZ));
  ellipse(accelerometerX * 50 + width / 2, height / 5, 100, 100);
  ellipse(accelerometerY * 50 + width / 2, 2 * height / 5, 100, 100);
  ellipse(accelerometerZ * 50 + width / 2, 3 * height / 5, 100, 100);
  ellipse(sum * 50 + width / 2, 4 * height / 5, 100, 100);
  if(sum > 2 && !flag){
    //"http://10.100.42.156:5000"
    
    flag = true;
    PostRequest post = new PostRequest("http://10.100.42.156:5000");
    post.addData("name", "Rune");
    post.send();
    println("Reponse Content: " + post.getContent());
    println("Reponse Content-Length Header: " + post.getHeader("Content-Length"));
    
    //System.out.println("Reponse Content: " + post.getContent());
    //System.out.println("Reponse Content-Length Header: " + post.getHeader("Content-Length"));
  }
  if(millis() > old + 100){
   flag = false; 
   old=millis();
  }
}

void onLinearAccelerationEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}