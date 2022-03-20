// This software is written for educational (non-commercial) purpose. 
// There is no warranty or other guarantee of fitness for this software, 
// it is provided solely "as is". 

// Created by Bellafkir Hicham, August 2017
// http://creativecommons.org/licenses/by/4.0/

function ScanLine() {
  var edgeTable;
  var activeTable;
  var scanline;
  var template;

  this.isDone;




  this.init = function (EdgeTable, tmp) {
    edgeTable = EdgeTable;
    activeTable = [];
    template = tmp;
    scanline = edgeTable[0].yMin;
    this.isDone = false;
    // roundPolygon(points);
  };


  this.step = function (canvasImage) {
    if (edgeTable.length > 0 || activeTable.length > 0) {
      pushToAT();
      canvasImage.drawScanline(scanline);
      template.setCurrentScanline(scanline);
      var interPoints = getIntersectionPoints();
      findToFillPixels(canvasImage, interPoints);
      template.setEdgeTable(edgeTable, "et");
      template.setEdgeTable(activeTable, "aet");
      deleteFromAT(scanline);
      scanline++;


    } else {
      this.isDone = true;
      canvasImage.drawScanline(100); //  this fubction calls also drawScreen, we need it for disactive the last active edges
      template.setEdgeTable(activeTable, "aet");
    }


  };


  function pushToAT() {
    i = 0;
    while (i < edgeTable.length && edgeTable[i].yMin === scanline) {
      if (1 / edgeTable[i].mInv !== 0) { // horizental edge
        activeTable.push($.extend(true, {}, edgeTable[i])); // clone object
        edgeTable[i].point1.isActive = true;
        edgeTable.splice(i, 1);

      } else {
        //edgeTable[i].point1.color="yellow";
        edgeTable.splice(i, 1);
      }
    }
    activeTable.sort(function (ed1, ed2) {
      return ed1.xHit - ed2.xHit;
    });
    //  template.setEdgeTable(edgeTable);
    //  template.
    //  (activeTable);
  }

  function getIntersectionPoints() {
    intersectionPoints = [];
    for (i = 0; i < activeTable.length; i++) {
      if (activeTable[i].yMax !== scanline) {
        intersectionPoints.push((activeTable[i].xHit));
      }
    }
    console.log(intersectionPoints);
    return intersectionPoints;
  }






  function deleteFromAT(scanline) {
    for (i = 0; i < activeTable.length; i++) {
      if (activeTable[i].yMax === scanline) {
        activeTable[i].point1.isActive = false;
        activeTable.splice(i, 1);
        i--;

      } else {
        activeTable[i].xHit = activeTable[i].xHit + activeTable[i].mInv;
      }
    }

  }

  // for drawing the intersectpoints, use just one instance. 
  var interPoint = new point("", 0, 0, 5, false, "green");

  function findToFillPixels(canvasImage, xHits) {
    if (xHits.length % 2 === 1) {
      console.log("scanline algorithm not working as expected"); // the worst nightmare  
    } else {
      interPoint.y = scanline;
      for (i = 0; i < xHits.length - 1; i += 2) {
        // draw the intesections points
        interPoint.x = xHits[i];
        canvasImage.drawPoint(interPoint);
        interPoint.x = xHits[i + 1];
        canvasImage.drawPoint(interPoint);

        var x_max = isInt(xHits[i + 1]) ? Math.max(xHits[i], xHits[i + 1] - 1) : Math.floor(xHits[i + 1]);
        var x0 = Math.ceil(xHits[i]);
        for (x = x0; x <= x_max; x++) { // ceil aufrunden
          canvasImage.fill_pixel(x, scanline, true);
        }
      }
    }

  }



  function isInt(n) {
    return n % 1 === 0;
  }

  this.getScanline = function () {
    return scanline;
  };

}


