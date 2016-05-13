//This sketch draws eyes which follow faces detected over a live video capture, using an image of Theresa May.

// Image license: https://commons.wikimedia.org/wiki/File:Theresa_May_-_Home_Secretary_and_minister_for_women_and_equality.jpg?uselang=en-gb
//using processing example "facedetection" in the openCV folder

//top left hand corner of the left eye is (108,238);
// top left hand corner of the right eye (208,239);
PImage theresa;
import gab.opencv.*;
import java.awt.Rectangle;
import processing.video.*;

Capture cam;
OpenCV opencv;
Rectangle[] faces;
Rectangle face;

// Coordinates of the centre of the eyes in the image
float leftEyeTopX = 108;
float leftEyeTopY = 238;
float rightEyeTopX = 208;
float rightEyeTopY = 239;
float eyeX;
float eyeY;
float eyeWidth = 30;
float eyeHeight = 14;
float irisSize = 20;
color irisColour = color(123,109,105); // Taken from original image
float pupilSize = 8;
boolean facesdetected;
float xpoint; //centre of the face detected
float ypoint; //centre of the face detected

void setup(){
  size(398,599);
  noStroke();
  theresa = loadImage("theresa.png");
  cam = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  faces = opencv.detect();
  cam.start();
    
}

void draw(){
  background(250);
  
  if (cam.available() == true) {
    cam.read();
    opencv.loadImage(cam);
   
  }
  Rectangle[] faces = opencv.detect();
  println(faces.length); //print how many faces is being detected
if(faces.length > 1){ //If there is more than 1 face detected
  face = faces[0]; //look at the first face
  facesdetected =true;
  } else if (faces.length==1){
  face = faces[0];
  facesdetected=true;
    } else { 
  facesdetected = false;
    }
    
    if(facesdetected){ // there are faces detected
     xpoint = face.x + face.width/2;  //find the middle of the face
     ypoint = face.y + face.height/2; //find the middle of the face
     eyeX = map(xpoint,0,cam.width,0,eyeWidth); //map the coordinates of the drawn eyes to the face position
     eyeY = map(ypoint,0,cam.height,0,eyeHeight);  
    drawEye(leftEyeTopX+eyeX,leftEyeTopY+eyeY); //draws the eyes in the spaces in the image 
    drawEye(rightEyeTopX+eyeX,rightEyeTopY+eyeY);
    image(theresa, 0,0);
    } else { 
      drawEye(leftEyeTopX+eyeWidth/2,leftEyeTopY+eyeHeight/2); //if no faces are detected face eyes forward
      drawEye(rightEyeTopX+eyeWidth/2,rightEyeTopY+eyeHeight/2);
      image(theresa, 0,0);
      }
}