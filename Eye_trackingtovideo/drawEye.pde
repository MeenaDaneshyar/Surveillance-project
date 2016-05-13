

void drawEye(float xPos, float yPos){
  fill(irisColour); 
  ellipse(xPos,yPos,irisSize,irisSize); //draw the iris
  fill(0); 
  ellipse(xPos,yPos,pupilSize,pupilSize); //draw the pupil
}