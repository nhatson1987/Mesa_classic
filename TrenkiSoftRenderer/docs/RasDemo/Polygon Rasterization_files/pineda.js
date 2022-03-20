// This software is written for educational (non-commercial) purpose. 
// There is no warranty or other guarantee of fitness for this software, 
// it is provided solely "as is". 

// Created by Bellafkir Hicham, August 2017
// http://creativecommons.org/licenses/by/4.0/

function Pineda() {
  this.points;  // array of points as representation of a Polygon
  this.canvasImage;
  var template;

  var p_min;
  var p_max;
  var leftSpin;
  var that = this;
  var normalVectors;
  var convex;
  this.isDone;

  // pixel
  var x;
  var y;
  var isLeftToRight;


  var within;
  var searchFirstPxMode;
  var backtrack_point;


  var backPoint = new point("", 0, 0);




  this.init = function (points, canvas, tmp, edgesMoved) {
    if (edgesMoved === undefined) {
      edgesMoved = true;
    }
    
    this.points = points.slice();
    this.points.push(this.points[0]);
    this.canvasImage = canvas;
    template = tmp;

    if (edgesMoved) {
      //console.log("convex test 2: "+isConvex());
      convex = isConvex();
      if (!convex) {
        template.setConvexMessage("The given polygon is not convex", true); // warning = true

      } else {
        template.setConvexMessage("The polygon is convex", false);
        // leftSpin = det(this.points[0].sub(this.points[1]),this.points[2].sub(this.points[1]))<0;
        normalVectors = [];  // init the array
        setNormalVectors();
      }
    }
    boudingBox();
    x = p_min.x;
    y = p_min.y;
    this.isDone = false;
    isLeftToRight = true;


    within = false;
    searchFirstPxMode = false;
    backtrack_point = undefined;
  };



  function boudingBox() {
    var x_sort = that.points.slice().sort(function (p1, p2) {
      return compare(p1, p2, true);
    });
    var y_sort = that.points.slice().sort(function (p1, p2) {
      return compare(p1, p2);
    });
    p_min = new point("min", x_sort[0].x, y_sort[0].y);
    var last = that.points.length - 1;
    p_max = new point("max", x_sort[last].x, y_sort[last].y);
    that.canvasImage.drawRect(p_min, p_max);
  }

  function compare(p1, p2, withX) {
    if (withX === undefined) {
      withX = false;
    }
    if (withX) {
      return p1.x - p2.x;
    } else {
      return p1.y - p2.y;
  }
  }

  function setNormalVectors() {
    if (leftSpin) {
      for (i = 0; i < that.points.length - 1; i++) {
        var n = normalVec(that.points[i], that.points[i + 1]);
        normalVectors.push(n);
        that.canvasImage.drawArrowHead(that.points[i], that.points[i + 1]);
        that.canvasImage.extendLine(that.points[i], that.points[i + 1]);
        template.setItemToPinedaTable(that.points[i], that.points[i + 1], n);
      }
    } else {
      for (i = that.points.length - 1; i > 0; i--) {
        var n = normalVec(that.points[i], that.points[i - 1]);
        normalVectors.push(n);
        that.canvasImage.drawArrowHead(that.points[i], that.points[i - 1]);
        that.canvasImage.extendLine(that.points[i], that.points[i - 1]);
        template.setItemToPinedaTable(that.points[i], that.points[i - 1], n);
      }
    }

  }


  function checkangels(points) {
    var sum = 0;
    var angle = 0;

    for (i = 0; i < points.length - 2; i++) {
      angle = Math.atan2(det(points[i + 1].sub(points[i]), points[i + 2].sub(points[i + 1])),
              points[i + 1].sub(points[i]).scalarProduct(points[i + 2].sub(points[i + 1])));
      if (leftSpin) {
        sum += angle * 180 / Math.PI;
      } else {
        sum += Math.abs(angle * 180 / Math.PI);
      }
    }
    return sum;
  }


  function isConvex() {
    var points = that.points.slice();
    points.push(points[1]);
    var isConvex = true;
    var isNegative = det(points[0].sub(points[1]), points[2].sub(points[1])) < 0;
    console.log(isNegative);
    for (i = 1; i < points.length - 2; i++) {
      if ((det(points[i].sub(points[i + 1]), points[i + 2].sub(points[i + 1])) < 0) !== isNegative) {
        isConvex = false;
        break;
      }
    }
    if (isConvex) {
      leftSpin = isNegative;
      var anglesSum = checkangels(points);
      console.log(anglesSum);
      isConvex = Math.round(anglesSum) === 360;
    }
    console.log("clockweise: " + isNegative);
    return isConvex;
  }


  function det(p1, p2) { // determinat of 2x2  if its negative then the v1 turns clockweise to v2
    return (p1.x * p2.y) - (p1.y * p2.x);
  }

  /*
   * normal vector.  vector as a point. 
   */
  function normalVec(p1, p2) {
    return new point("", -p2.y + p1.y, p2.x - p1.x);
  }

  function distanceToEdge(p0, n, p, edgeName) { // id = name of the edge 
    n.setDisToOrigin();
    var d = (n.scalarProduct(p) - n.scalarProduct(p0)) / n.disToOrigin;
    template.setDistanceToTableItem(edgeName, d);
    return  d;  // the distance to the edge
  }


  function distance2() {
    // mittelpunkt algorithmus
  }

  function storeBackPoint() {
    backPoint.x = x;
    backPoint.y = y;

  }

  this.searchOutside = function (markCurringPx) {
    if (checkPixel(x, y, markCurringPx)) {
      storeBackPoint();
      isLeftToRight ? x += 1 : x -= 1;
      markCurringPx ? this.canvasImage.drawRect(backtrack_point, backtrack_point, false, "green") : null;
    } else {
      isLeftToRight = isLeftToRight ? false : true;
      within = false;
      searchFirstPxMode = false;
      markCurringPx ? this.canvasImage.drawRect(backtrack_point, backtrack_point, false, "green") : null;
      storeBackPoint();
      x = backtrack_point.x;
      y = backtrack_point.y;
      return;
    }
  };

  this.getNextPixel_leftRight = function (secondLast, smart) {
    if (smart && secondLast && !within) { // "within" is the last one. 
      searchFirstPxMode = true;
      storeBackPoint();
      y += 1;
      backtrack_point = new point("", x - 1, y, 5);
      backtrack_point.color = "green";
    } else {
      if (x === p_max.x) {
        isLeftToRight = false;
        smart ? storeBackPoint() : null;
        y += 1;
      } else {
        smart ? storeBackPoint() : null;
        x += 1;
      }
    }
  };

  this.getNextPixel_RightLeft = function (secondLast, smart) { // "within" is the last one. 
    if (smart && secondLast && !within) {
      searchFirstPxMode = true;
      storeBackPoint();
      y += 1;
      backtrack_point = new point("", x + 1, y, 5); // 5 radius 
      backtrack_point.color = "green";
    } else {
      if (x === p_min.x) {
        isLeftToRight = true;
        smart ? storeBackPoint() : null;
        y += 1;
      } else {
        smart ? storeBackPoint() : null;
        x -= 1;
      }
    }
  };



  this.step_smarter = function (markCurringPx) {
    if (markCurringPx === undefined) {
      markCurringPx = true;
    }
    
    if (convex && y <= p_max.y) {
      if (markCurringPx) {
        var pixel = new point("", x, y);
        this.canvasImage.drawRect(pixel, pixel, false, "red");   // false for not in Grid canvas 
      }
      if (searchFirstPxMode) {
        this.searchOutside(markCurringPx);
      } else {
        backtrack_point = undefined;
        var lastWithin;
        lastWithin = within;
        within = checkPixel(x, y, markCurringPx);
        if (isLeftToRight) {
          this.getNextPixel_leftRight(lastWithin, true); // true for smart iteration
        } else {
          this.getNextPixel_RightLeft(lastWithin, true);
        }
      }
    } else {
      this.isDone = true;
  }
  };


  this.step_simple = function (markCurringPx) {
    if (markCurringPx === undefined) {
      markCurringPx = true;
    }
    
    if (convex && y <= p_max.y) {
      if (markCurringPx) {
        var pixel = new point("", x, y);
        this.canvasImage.drawRect(pixel, pixel, false, "red");   // false for not in Grid canvas
      }
      checkPixel(x, y, markCurringPx);
      if (isLeftToRight) {
        this.getNextPixel_leftRight(null, false); // false for not smart, null: the secondlast pixel not imported here
      } else {
        this.getNextPixel_RightLeft(null, false);
      }
    } else {
      this.isDone = true;
  }
  };


  /*
   * fill all pixels of the given polygon
   */
  this.fillAll = function (simple) {
    if (simple === undefined) {
      simple = true;
    }
    if (convex) {
      while (y <= p_max.y) {
        simple ? this.step_simple(false) : this.step_smarter(false);
      }
      this.isDone = true;
  }
  };

  /*
   * check if the current pixel given by x and y is within the polygon or not 
   * drawDistance: true for drawing the distances from the pixel to the polygon edges 
   */
  function checkPixel(x, y, drawDistance) {
     if (drawDistance === undefined) {
      drawDistance = true;
    }
    
    template.setCurrentPixel(x, y);
    var d;
    var within = true; // local variable
    var checkPoint = new point("toCheck", x, y); // it will better just to override one instance every time.
    if (leftSpin) {
      for (i = 0; i < that.points.length - 1; i++) {
        d = distanceToEdge(that.points[i], normalVectors[i], checkPoint, that.points[i].name + that.points[i + 1].name);
        if (d <= 0) {
          within = false;
          //break;
        }
        // draw the distance 
        drawDistance ? that.canvasImage.drawDistance(d, checkPoint, normalVectors[i]) : null;
      }
    } else {
      for (i = that.points.length - 1; i > 0; i--) {
        d = distanceToEdge(that.points[i], normalVectors[that.points.length - 1 - i], checkPoint, that.points[i].name + that.points[i - 1].name);
        if (d <= 0) {
          within = false;
          //  break;
        }
        drawDistance ? that.canvasImage.drawDistance(d, checkPoint, normalVectors[that.points.length - 1 - i]) : null;
      }

    }
    if (within) {
      that.canvasImage.fill_pixel(x, y, true);
    }
    return within;
  }



  this.getX = function () {
    return x;
  };

  this.getY = function () {
    return y;
  };

  this.back_simple = function () {
    var valid = true;
    this.canvasImage.unfill_pixel(x, y);
    if (isLeftToRight) {
      x - 1 < p_min.x ? (y === p_min.y ? (x = p_min.x + 1, valid = false) : (y -= 1, isLeftToRight = false)) : x -= 1;
    } else {
      x + 1 > p_max.x ? (y === p_min.y ? valid = false : (y -= 1, isLeftToRight = true)) : x += 1;
    }
    return valid;
  };


  this.back_smart = function () {
    x === p_min.x && y === p_min.y ? x = p_min.x + 1 : null;
    return {x: backPoint.x, y: backPoint.y};
  };

  this.getBackPoint = function () {
    return backPoint;
  };


  this.putDistancesFor = function (pixelPoint) {
    var d;
    if (leftSpin) {
      for (i = 0; i < that.points.length - 1; i++) {
        d = distanceToEdge(that.points[i], normalVectors[i], pixelPoint, that.points[i].name + that.points[i + 1].name);
        that.canvasImage.drawDistance(d, pixelPoint, normalVectors[i]);
      }
    } else {
      for (i = that.points.length - 1; i > 0; i--) {
        d = distanceToEdge(that.points[i], normalVectors[that.points.length - 1 - i], pixelPoint, that.points[i].name + that.points[i - 1].name);
        that.canvasImage.drawDistance(d, pixelPoint, normalVectors[that.points.length - 1 - i]);
      }
    }

    if (backtrack_point !== undefined && backtrack_point.y === backPoint.y) {
      this.canvasImage.drawRect(backtrack_point, backtrack_point, false, "green");
    }
  };
}

