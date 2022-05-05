class Meteor{

  public int xCor; 
  public int yCor;     
  public int size;
  ArrayList<PVector> trail;

  Meteor(int xVal, int yVal, int s){
    xCor = xVal;
    yCor = yVal;
    size = s;
    trail = new ArrayList<PVector>();
    
  } 
  
  public void drop(float speed){  // the speed of thefalling Meteor
    yCor += speed;
  }
  
   void display(){
   //The trails behind the meteor
   for(int trails = 0; trails < 10; trails++){
     float range = random(-meteorSize,0);
     stroke(255, 165, 0);
     line(xCor-range, yCor+25, xCor-range, yCor-(random(60,80)));

    }
    //Displaying the meteor
    fill(200, 100, 50);
    image(meteorImg, xCor, yCor);
    
  }
}
