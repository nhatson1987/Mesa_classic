// This software is written for educational (non-commercial) purpose. 
// There is no warranty or other guarantee of fitness for this software, 
// it is provided solely "as is". 

// Created by Bellafkir Hicham, August 2017
// http://creativecommons.org/licenses/by/4.0/

function point(name,x,y,radius,isActive,color){
    if (radius === undefined) {
      radius = 10;
    }
    if (isActive === undefined) {
      isActive = false;
    }
    if (color === undefined) {
      color = "#5CB85C";
    }
  
  
    this.name= name;
    this.x = x; 
    this.y = y; 
    this.radius=radius; // pixel in canvas not grid
    this.color = color;
    this.disToOrigin;
    this.isActive=isActive; 
     
    this.setDisToOrigin= function(){
        this.disToOrigin = Math.sqrt(Math.pow(this.x,2)+Math.pow(this.y,2));
    }; 
    
    this.equals = function(point){
      return   name===point.name;
    };
    
    this.scalarProduct= function(point){
        return this.x*point.x + this.y*point.y;
        
    };
    
    this.sub = function(p){
        return  new point("",this.x-p.x,this.y-p.y); 
    };
    
    
}

function Edge(idName,point1,point2,color){
    if (color === undefined) {
      color = "black";
    }
  
    this.idName = idName;
    this.point1=point1;
    this.point2=point2;
    this.pointOfyMin;
    this.color = color;
    
    this.Init = function(){
        if(point1.y >= point2.y){
            this.yMin =Math.round(point2.y);
            this.yMax = Math.round(point1.y);
            this.pointOfyMin=2;
        }else{
            this.yMin =Math.round(point1.y);
            this.yMax = Math.round(point2.y);
            this.pointOfyMin=1;
        }
        this.xHit= this.pointOfyMin===1 ? Math.round(point1.x) : Math.round(point2.x);
        this.mInv=(Math.round(point2.x)-Math.round(point1.x))/(Math.round(point2.y)-Math.round(point1.y));
        
       
    };
    
    this.getPoint = function(name){
        if(point1.name===name){return point1;}
        else if(point2.name===name){return point2;}
        else{ return;}
    };
}


/*
 *  Polygon for scanline
 */
function Polygon(edges){
    this.edges=edges;
    
    this.removeEdges = function(deleted_point,isFirstPoint){
       if (isFirstPoint === undefined) {
         isFirstPoint = false;
       }
      
       var edg_index=this.getConcernedEdges(deleted_point);
       if(edg_index.length===1){ this.edges.splice(edg_index[0],1); }
       else if(edg_index.length===0){return;}
       else{
           var idname;
           var newEdg;
           var ids;
           if(isFirstPoint){
               idname=(this.edges[edg_index[1]].idName+this.edges[edg_index[0]].idName).split(deleted_point.name).join("");
               ids = idname.split("");
               newEdg=new Edge(idname,this.edges[edg_index[1]].getPoint(ids[0]),this.edges[edg_index[0]].getPoint(ids[1]));
           }
           else{
               idname=(this.edges[edg_index[0]].idName+this.edges[edg_index[1]].idName).split(deleted_point.name).join("");
                ids = idname.split("");
                newEdg=new Edge(idname,this.edges[edg_index[0]].getPoint(ids[0]),this.edges[edg_index[1]].getPoint(ids[1]));
            }
            newEdg.Init();
            if(this.edges.length===3){
                var flip=false;
                if(newEdg.point1.equals(this.edges[0].point1)&& newEdg.point2.equals(this.edges[this.edges.length-1].point1)){
                        flip=true;    
                }
            }
            this.edges.splice(edg_index[0],1);
            this.edges.splice(edg_index[1]-1,1);
            var cnt = this.contains(newEdg);
            if(!cnt.contain){
                this.edges.splice(edg_index[1]-1,0,newEdg);
            }
            else{
                //console.log(this.edges[0].point1.name+"   "+this.edges[0].point2.name);
                if(flip){
                    this.edges.splice(cnt.index-1,1,newEdg);    
                }
                
            }
       }
         
    };
    
    this.getConcernedEdges = function(point){
        var edg_index=[];
       for(i=0;i<edges.length;i++){
           if(edges[i].idName.search(point.name)>=0){
               edg_index.push(i);
                
           }
       }
        return edg_index;
    };
    
    
    this.contains = function(edge){
        for(i=0; i<edges.length; i++){
            if(edges[i].idName===edge.idName || edges[i].idName===edge.idName.split("").reverse().join("")){
                return {"contain":true, "index":i};
            }
        }
        return {"contain":false, "index":null};
        
    };
    
      this.addEdge= function(points){
        if(points.length>=2){
               var idname = points[points.length-2].name+points[points.length-1].name;
                var edge1= new Edge(idname,points[points.length-2],points[points.length-1]);
                edge1.Init();
                if(points.length>2){
                    idname=points[points.length-1].name+points[0].name;
                    var edge2= new Edge(idname,points[points.length-1],points[0]);
                    edge2.Init();
                    if(points.length>3){
                        edges.splice(edges.length-1,1); 
                    }
                    edges.push(edge1);
                    edges.push(edge2);
                   
                }
                else{
                    edges.push(edge1);
                }
               
            }
    };
    
   this.getEdgeTable = function(){
       var sorted_edges = edges.slice().sort(compare);  // clone the array and sort it
       return sorted_edges;
   };
             
  function compare(edg1,edg2){
      if(edg1.yMin !== edg2.yMin){
        return edg1.yMin - edg2.yMin;
      }
      else{
          return edg1.xHit - edg2.xHit;
      }
  }           
}

