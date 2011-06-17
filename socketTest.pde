//Rob Seward 2011
//robseward.com

import processing.net.*;
import processing.opengl.*;

int port = 6780;       
Server myServer;   

HashMap ipToId;
int maxUsers = 10;
int activeUsers = 0;
color[] colors = {#FF0000, #00FF00, #0000FF, #00FFFF};

Point[] userPositions = new Point[maxUsers];


void setup()
{
  //size(320, 480);
  size(1920, 1280,OPENGL);

  myServer = new Server(this, port);
  ipToId = new HashMap();
}

void draw()
{
  background(50,50,50);
  while(checkSocket()){
    ;
  }
  drawUsers();
}


boolean checkSocket(){
  Client thisClient = myServer.available();

  if (thisClient !=null) {
    String whatClientSaid = thisClient.readString();
    
    if (whatClientSaid != null) {
      if(!ipToId.containsKey(thisClient.ip())){
        ipToId.put(thisClient.ip(), new Integer(activeUsers));
        activeUsers++;  
      }
      String clientId = ipToId.get(thisClient.ip()) + "";
      parseClientData(whatClientSaid, int(clientId));
    } 
    return true;
  } 
  return false;
}


void parseClientData(String data, int clientId){
  String[] coords = split(data, ":");

  for(int i=0; i < coords.length - 1; i++){
         String[] coord = split(coords[i], ",");
         if(coord.length > 2){
           int y = height - int(coord[1]) * 4;
           int x = int(coord[2]) * 4;

           if(coord[0].equals("b")){
             touchBegan(x, y, clientId);
           } else if (coord[0].equals("m")){
             touchMoved(x, y, clientId); 
           } else if (coord[0].equals("e")){
             touchEnded(x, y, clientId); 
           }
         }
      }
}

void drawUsers(){
  for(int i=0; i < activeUsers; i++){
    fill(colors[i]);
    stroke(colors[i]);
    Point p = userPositions[i];
    ellipse(p.x, p.y, 40, 40);   
    
  }  
}


//////////

void mousePressed() {
  touchBegan(mouseX, mouseY, 0);
}
void mouseDragged() {
   touchMoved(mouseX, mouseY, 0);
}
void mouseReleased(){
  touchEnded(mouseX, mouseY, 0);
}

void touchBegan(int x, int y, int id){
  println("TOUCH BEGAN " + x + ", " + y);
  if(id < maxUsers) userPositions[id] = new Point(x, y);
 
}

void touchMoved(int x, int y, int id){
  println(" TM: " + x + ", " + y);
  if(id < maxUsers) userPositions[id] = new Point(x, y);
}

void touchEnded(int x, int y, int id){
  if(id < maxUsers) userPositions[id] = new Point(x, y);
}


///////////

class Point {
  public int x;
  public int y;
  public  Point(int x, int y){
    this.x = x;
    this.y = y;  
  }
}


