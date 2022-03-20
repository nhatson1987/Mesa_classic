// This software is written for educational (non-commercial) purpose. 
// There is no warranty or other guarantee of fitness for this software, 
// it is provided solely "as is". 

// Created by Bellafkir Hicham, August 2017
// http://creativecommons.org/licenses/by/4.0/


function lineToPixels(canvas,from,to){
    var x0 =Math.round(from.x); var y0=Math.round(from.y);
    var x1 =Math.round(to.x); var y1=Math.round(to.y);
      if(Math.abs(x0-x1)>=Math.abs(y0-y1)){
          if(x0 <= x1){
              lineToPixelX(canvas,x0,y0,x1,y1);
          }
          else{
              lineToPixelX(canvas,x1,y1,x0,y0);
          }
      }

     else{
         if(from.y <= to.y){
             lineToPixelY(canvas,x0,y0,x1,y1);
         }
         else{
             lineToPixelY(canvas,x1,y1,x0,y0);
         }
     }
}

function lineToPixelX(canvas,x0,y0,x1,y1){
    var dx = (x1 - x0);
    var dy= Math.abs(y1 - y0);
    var twoDx = 2*dx;
    var twoDy = 2*dy;
    var d= twoDy - dx;
    var inc = 1;
    if(y0 > y1){ inc=-1;}
    for(x=x0,y=y0; x<=x1;x++){
        canvas.fill_pixel(x,y,true);
        if(d >0){
            d+=twoDy-twoDx;
            y+=inc;
        }
        else{
            d+=twoDy;
        }
        
    }
}

 function lineToPixelY(canvas,x0,y0,x1,y1){
    var dx = x1 - x0;
    var dy= y1 - y0;
    var invM = dx/dy;
    var x=x0;
    for(y=y0; y<=y1;y++){
        canvas.fill_pixel(Math.round(x),y,true);
        x+=invM;
   }
}






