var video = document.createElement("video");
video.setAttribute("style", "display:none;");
video.setAttribute("id", "webcam");
video.setAttribute("width", "500");
video.setAttribute("height", "400");
video.setAttribute("autoplay", "true");
if(document.body!=null)document.body.appendChild(video); 
 
function init() {
    if (navigator.webkitGetUserMedia) {
        navigator.webkitGetUserMedia({video:true}, gotStream, noStream);
 
        function gotStream(stream) {
            video.src = webkitURL.createObjectURL(stream);
            video.onerror = function () {
                stream.stop();
                streamError();
            };
        }
 
        function noStream() {
            alert('No camera available.');
        }
 
        function streamError() {
            alert('Camera error.');
        }
    }
}




var ctx;
PImage img;
PImage img2;
int nb=40;

void setup(){
    size(800,600);
    ctx = externals.context;
    ellipseMode(CORNER);
    smooth();
    init();
    colorMode(HSB,360,100,100);
    img2=loadImage("imagenes/v1.gif",width,height);
}
 
void draw(){
    pushMatrix();
    translate(width,0);
    scale(-1,1);//mirror the video
    
    ctx.drawImage(video, 0, 0, width, height); //video is defined outside processing code
    popMatrix();

    //do something
    img=get();
    img.resize(nb,nb);
   
    background(0);
    image(img2,0,0,width,height);   
    
   noStroke();
   //float ba=map(mouseX,0,width,0,100);
   //float be=map(mouseY,0,height,0,100);
   
for(int j=0; j<nb; j+=2){
for(int i=0; i<nb; i+=2){
     float h=hue(img.get(i,j));
     float s=saturation(img.get(i,j));
     float b=brightness(img.get(i,j));
       if(b>21){          
          fill(h,s+50,b);
          rect(i*width/nb, j*height/nb, width/nb, height/nb);
        }
     }
    }
    
}

