// This software is written for educational (non-commercial) purpose. 
// There is no warranty or other guarantee of fitness for this software, 
// it is provided solely "as is". 

// Created by Bellafkir Hicham, August 2017
// http://creativecommons.org/licenses/by/4.0/

function EdgeFlag() {
  var pixels;

  this.points;
  this.width;
  this.canvas;
  var template;
  var that = this;
  this.isDone;

  var p_min;
  var p_max;
  var flag;

  var x, y;


  this.init = function (canvas, points, tmp) {
    template = tmp;
    pixels = [];
    this.points = points.slice();
    this.canvas = canvas;
    this.width = canvas.getGridWidth();
    boudingBox();

    this.points.push(this.points[0]);
    for (i = 0; i < this.points.length - 1; i++) {
      if (this.points[i].y > this.points[i + 1].y) {
        RasterContourEdge(this.points[i + 1], this.points[i]);
      } else {
        RasterContourEdge(this.points[i], this.points[i + 1]);
      }
    }
    flag = false;
    this.isDone = false;
    x = undefined;
    y = undefined;
  };

  // round the y-value, if we accept float points 
  function RasterContourEdge(p1, p2) {
    if (p1.y === p2.y) {
      return;
    }
    var mInv = (p1.x - p2.x) / (p1.y - p2.y);
    var intersect_x = p1.x;
    negatePixel(p1.x, p1.y);
    for (var y = p1.y + 1; y < p2.y; y++) {
      intersect_x += mInv;
      var pixel_x = Math.ceil(intersect_x);
      negatePixel(pixel_x, y);
    }
  }
  ;


  function negatePixel(x, y) {
    if (pixels[y * that.width + x] === undefined) {
      that.canvas.fill_pixel(x, y, true);
      pixels[y * that.width + x] = true;
    } else {
      that.canvas.unfill_pixel(x, y);
      pixels[y * that.width + x] = undefined;

    }
  }


  function  setNextPixel() {
    if (x === undefined && y === undefined) {
      x = p_min.x;
      y = p_min.y;
    } else {
      if (x + 1 <= p_max.x) {
        x += 1;
      } else {
        y < p_max.y ? (y += 1, (x = p_min.x, flag = false)) : that.isDone = true;
      }
    }

  }

  // a boolean variable to catch if marking the curring Pixel is needed or not
  this.step = function (mark) {
    if (mark === undefined) {
      mark = true;
    }   
    
    // set the next pixel
    setNextPixel();
    if (pixels[y * that.width + x] !== undefined) {
      flag = !flag;
    }
    if (flag) {
      that.canvas.fill_pixel(x, y, true);
    } else {
      that.canvas.unfill_pixel(x, y);
    }

    // visualization code
    template.setCurrentPixel(x, y);
    var pixel = new point("", x, y);
    mark ? this.canvas.drawRect(pixel, pixel, false, flag ? "green" : "red") : null;
    template.setFlagValue(flag);
  };







  this.step_back = function () {
    var pixel = new point("", x, y);
    pixels[y * that.width + x] === undefined ? that.canvas.unfill_pixel(x, y) : null;
    if (pixels[y * that.width + x] !== undefined) {
      that.canvas.fill_pixel(x, y, true);
      flag = !flag;
      template.setFlagValue(flag);
    }


    if (x === p_min.x) {
      if (y === p_min.y) {
        that.canvas.drawRect(pixel, pixel, false, flag ? "green" : "red");
        return;
      } else {
        x = p_max.x;
        y -= 1;
      }
    } else {
      x -= 1;
    }

    template.setCurrentPixel(x, y);
    pixel.x = x;
    pixel.y = y;
    that.canvas.drawRect(pixel, pixel, false, flag ? "green" : "red");


  };

  function boudingBox() { // I think I need "that" feld
    var x_sort = that.points.slice().sort(function (p1, p2) {
      return compare(p1, p2, true);
    });
    var y_sort = that.points.slice().sort(function (p1, p2) {
      return compare(p1, p2);
    });
    p_min = new point("min", x_sort[0].x, y_sort[0].y);
    var last = that.points.length - 1;
    p_max = new point("max", x_sort[last].x, y_sort[last].y);
    that.canvas.drawRect(p_min, p_max, true, "green");

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
}