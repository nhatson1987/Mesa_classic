// This software is written for educational (non-commercial) purpose. 
// There is no warranty or other guarantee of fitness for this software, 
// it is provided solely "as is". 

// Created by Bellafkir Hicham, August 2017
// http://creativecommons.org/licenses/by/4.0/

function CanvasImage() {

  var that = this;

  // 4 canvas
  var main_canvas;
  var grid_canvas;
  var arrows_canvas;
  var highlight_canvas;

  var context;
  var context_grid;
  var context_pineda;
  var context_highlight;


  var polygon;  // only for scanline, used for efficient update of the edge table when a polygon is build 
  var points;

  var current_point_index; // the index of the current point selected.

  var template; // template api,  manage the data of tables.
  var zoomfactor = 20;  // how much real pixels match 1 pixel on the canvas 

  // just one instance, that we every time new inialize (singletones) 
  var scanline = new ScanLine();
  var pineda = new Pineda();
  var edgeFlag = new EdgeFlag();

  // help us to configure if we need to clean up the scene or not.
  var scanObjectIsInitialed = false;
  var pinedaObjectIsInitialed = false;
  var edgeFlagObjectIsInitialed = false;


  // fo point moved 
  var moved = false;

  // point names as Array.
  var names = "BCDEFGHIJKLMNOPQRSTUVWXYZ".split("");


  var pointsRounded = false;
  var noClick = false;


  /*
   * initialize the scene and add the liseners "mousedown", "mousemove", "click" and "dbclick".
   * @param {Template} tmp
   * @returns {undefined}
   */
  this.init = function (tmp) {
    main_canvas = document.getElementById('main');
    grid_canvas = document.getElementById('grid');
    arrows_canvas = document.getElementById('arrows');
    highlight_canvas = document.getElementById('highlight');

    // get the 2d context
    context = main_canvas.getContext('2d');
    context_grid = grid_canvas.getContext('2d');
    context_pineda = arrows_canvas.getContext('2d');
    context_highlight = highlight_canvas.getContext('2d');


    drawGrid();
    points = [];

    /*
     for parallel management of the Edge Table.  the easiest 
     way is just after "step" click we build the edge table,
     so that we don't even need the polygon data structure, but
     that is not efficient.
     */
    polygon = new Polygon([]);


    template = tmp;
    var point_default = new point("A", 12, 12, zoomfactor / 2);
    points.push(point_default);

    current_point_index = -1; // nothing is selected at the beginning
    template.disablePoint(); // nothing to delete at the beginning.


    drawContent();

    // add Listeners into the main canvas to interact with the user  
    main_canvas.addEventListener('mousedown', mouseDownListener);
    main_canvas.addEventListener('mousemove', mousePosition);

    main_canvas.addEventListener('click', function (event) {
      // mouse down and up will be called bevor this fuction
      if (!noClick) {
        var grid_coord = transformFromWindowToGrid(event.clientX, event.clientY);
        var index_point = checkPointSelected(grid_coord.x, grid_coord.y);
        if (index_point !== -1) {
          current_point_index = index_point;
          that.drawPoint(points[current_point_index], true); // draw the point on focus
          template.setPoint(points[current_point_index]);
        } else {
          // if none of the points are selected, disable the last onfocus point and create a new point 
          template.disablePoint();
          current_point_index = -1;
          //drawContent();
          addPoint(grid_coord.x, grid_coord.y);

        }
      } else {
        template.disablePoint();
      }

    });

  };


  /*
   * remove point from the canvas
   * @returns {undefined}
   */


  function addPoint(x, y) {
    //  var grid_coord = transformFromWindowToGrid(event.clientX,event.clientY);
    var point_name = names.shift();
    if (point_name !== undefined) {
      var user_point = new point(point_name, x, y, zoomfactor / 2);
      points.push(user_point);
      polygon.addEdge(points);
      cleanFromScanline();
      cleanFromPineda();
      cleanFromEdgeFlag();
      drawContent(); // to draw the new point on screen 
      template.setTableToEmpty("pt"); // do we have to put this in the clean pineda function ? 
      template.setEdgeTable(polygon.getEdgeTable(), "et"); // update the edge table
      pointsRounded = false;
      points.length === 3 ? drawGrid() : null;
    }
    // else ignore, no more points will be drawed  
  }


  this.removePoint = function () {
    if (current_point_index >= 0) { // not realy need to do this because the disabke the button if a point is not onfocus 
      names.push(points[current_point_index].name);

      // remove the concerned edges and update the edge table 
      polygon.removeEdges(points[current_point_index], current_point_index === 0);
      template.setEdgeTable(polygon.getEdgeTable(), "et");
      template.setTableToEmpty("aet");

      // delete the point from the points array, and disable the last selected point 
      points.splice(current_point_index, 1);
      current_point_index = -1;
      template.disablePoint();

      // clean up the scene  
      cleanFromScanline();
      cleanFromPineda();
      cleanFromEdgeFlag();
      template.setTableToEmpty("pt");
      drawContent();

      points.length === 1 ? drawGrid() : null;
    }
  };



  /* 
   *  handle mouse down
   * @param {type} event
   * @returns {undefined}
   */
  function mouseDownListener(event) {
    var grid_coord = transformFromWindowToGrid(event.clientX, event.clientY);
    var point_selected = checkPointSelected(grid_coord.x, grid_coord.y);
    if (point_selected >= 0) {
      current_point_index = point_selected;
      main_canvas.removeEventListener('mousemove', mousePosition);
      main_canvas.addEventListener('mousemove', mouseMoveListener);
      main_canvas.addEventListener('mouseup', mouseUpListener);
    }
  }

  /*
   * handle mouse move 
   * @param {type} event
   * @returns {undefined} 
   */
  function mouseMoveListener(event) {
    drawGrid();
    var grid_coordinates = transformFromWindowToGrid(event.clientX, event.clientY);
    var point = points[current_point_index];
    point.x = grid_coordinates.x;
    point.y = grid_coordinates.y;
    drawContent();
    moved = true;
    cleanFromPineda(); // we need to clean the scene from pineda  here not in mouseup function
    cleanFromScanline(); // the same here
    cleanFromEdgeFlag(); // the same here

    mousePosition(event); // set the mouse position and the highlight if mouve over some points 
  }

  /*
   * handle mouse up
   * @param {type} event
   * @returns {undefined}
   */
  function mouseUpListener(event) {
    main_canvas.removeEventListener('mousemove', mouseMoveListener);
    main_canvas.addEventListener('mousemove', mousePosition);
    var point = points[current_point_index];
    if (moved) {
      pointsRounded = false;
      var edg_index = polygon.getConcernedEdges(point);
      // init the moved edges
      if (edg_index.length) {
        polygon.edges[edg_index[0]].Init();
        if (edg_index.length === 2) {
          polygon.edges[edg_index[1]].Init();
        }
      }
      // update the edge table 
      template.setEdgeTable(polygon.getEdgeTable(), "et");
      template.setTableToEmpty("pt");
      current_point_index = -1; // the click funtion will be called also after this
      noClick = moved;
      moved = false;


    } else {
      noClick = false;
    }
  }

  /*
   * clean the scene from scanline data 
   * @returns {undefined}
   */
  function cleanFromScanline() {
    if (scanObjectIsInitialed) {
      setEdgesAsNotActive();
      drawGrid();
      template.resetCounter();
      template.setTableToEmpty("aet");
      scanObjectIsInitialed = false;
    }
  }

  /*
   * clean the scene from pineda data 
   * @returns {undefined}
   */
  function cleanFromPineda() {
    if (pinedaObjectIsInitialed) {
      context_pineda.clearRect(0, 0, arrows_canvas.width, arrows_canvas.height);  // delete the arrowheads 
      drawGrid();
      pinedaObjectIsInitialed = false;
      template.setEmptyDistance();
    }
  }


  /*
   * clean the scene from edge flag data 
   * @returns {undefined}
   */
  function cleanFromEdgeFlag() {
    if (edgeFlagObjectIsInitialed) {
      drawGrid();
      template.resetCounter();
      template.setFlagToEmpty()
      edgeFlagObjectIsInitialed = false;
    }
  }


  /*
   * visualize the scanline step on the scene and update the scanline tables 
   * @returns {undefined}
   */
  this.scanlineStep = function () {
    // 3 Edges for a polygon
    if (points.length >= 3) {
      if (!scanObjectIsInitialed || scanline.isDone) {
        // if "pinedaObjectIsInitialed" is true, then the clean pineda function will draw the grid 
        (scanline.isDone && !pinedaObjectIsInitialed) ? drawGrid() : null;
        cleanFromPineda();


        roundPoints();  // round the polygon first if the points are not rounded 

        // no need to set the edges as not active her, because its already the case.
        drawContent();
        scanline.init(polygon.getEdgeTable(), template);
        scanObjectIsInitialed = true;
      }
      cleanFromEdgeFlag();
      // disable the last point selected
      current_point_index = -1;
      template.disablePoint();

      // step 
      scanline.step(that); // just one line

    }
    // else ignore the step
  };


  /*
   * handle the scanline back option. 
   * @returns {undefined}
   */
  this.scanlineBack = function () {
    if (scanObjectIsInitialed) {
      var backTo = scanline.getScanline() - 2;  // one step back 
      cleanFromScanline();
      this.scanlineStep();
      while (scanline.getScanline() <= backTo) {
        this.scanlineStep();
      }
    }
    // ignore the click if the scanline object was not inialed 
  };

  this.scanline_all = function () {
    if (points.length >= 3) {
      if (pinedaObjectIsInitialed && scanline.isDone) {
        return;
      }
      roundPoints();
      cleanFromPineda();
      cleanFromEdgeFlag();
      // delete the pineda table data. new data will be calculed 
      template.setTableToEmpty("pt");
      scanline.init(polygon.getEdgeTable(), template);
      scanObjectIsInitialed = true;
      // set the edge table 
      template.setEdgeTable(polygon.getEdgeTable(), "et");

      while (!scanline.isDone) {
        scanline.step(this);
      }
    }
  };

  /*
   * 
   * @returns {undefined}
   */
  this.selectpicker_changed = function () {
    if (pinedaObjectIsInitialed) {
      drawGrid();
      drawContent();
      pineda.init(points, that, template, false);
    }
    // ignore the change else  
  };


  this.pinedaStep = function (simple) {
     if (simple === undefined) {
       simple = false;
     }
    // 3 Edges for a polygon
    if (points.length >= 3) {
      if (scanObjectIsInitialed) { // init the screen for pineda 
        cleanFromScanline();
        template.setEdgeTable(polygon.getEdgeTable(), "et");
        // delete the pineda table data. new data will be calculed  
        template.setTableToEmpty("pt");
      }
      if (edgeFlagObjectIsInitialed) {
        cleanFromEdgeFlag();
        // delete the pineda table data. new data will be calculed  
        template.setTableToEmpty("pt");
      }

      if (!pinedaObjectIsInitialed || pineda.isDone) {
        roundPoints();
        // if pineda is done filling´, them init without drawing the head arrows and extend lines 
        pinedaObjectIsInitialed && pineda.isDone ?
                (drawGrid(), pineda.init(points, that, template, false))
                : pineda.init(points, that, template);

        pinedaObjectIsInitialed = true;
      }
      // draw the Edges as not active, and then every time delte the distances and the current pixel
      drawContent();
      simple ? pineda.step_simple() : pineda.step_smarter();
  }
  // current_point_index=-1;
  // template.disablePoint();
  };
  /*
   * fill all the pixels of the polygon with pineda 
   * @param {type} all
   * @param {type} simple
   * @returns {undefined}
   */
  this.pinedaAll = function (simple) {
    // 3 Edges for a polygon
    if (points.length >= 3) {
      if (scanObjectIsInitialed) { // init the screen for pineda 
        cleanFromScanline();
        drawContent();
        template.setEdgeTable(polygon.getEdgeTable(), "et");
        // delete the pineda table data. new data will be calculed  
        template.setTableToEmpty("pt");
      }
      if (edgeFlagObjectIsInitialed) {
        cleanFromEdgeFlag();
        // delete the pineda table data. new data will be calculed  
        template.setTableToEmpty("pt");
      }
      if (!pinedaObjectIsInitialed) {
        roundPoints();
        pineda.init(points, that, template);
        pinedaObjectIsInitialed = true;
      } else {
        if (pineda.isDone) {
          return;
        } else {
          drawGrid();
          pineda.init(points, that, template, false);
        }
      }
      // show the the rounded points and delete if exist the current pixel and distances  
      drawContent();
      pineda.fillAll(simple);
    }
    current_point_index = -1;
    template.disablePoint();
  };

  /*
   * step back 
   * @returns {undefined}
   */
  this.pinedaBack = function () {
    if (pinedaObjectIsInitialed) {
      if (template.isSimplePinedaMode()) {
        // we have to use the step back function two time 
        // x,y in pineda schow the next pixel to fill not the current pixel.
        if (pineda.back_simple() && pineda.back_simple()) {// true for not the first px of the BB 
          drawContent();
          pineda.step_simple();
        }
      } else {
        // here we get the backpoint ("not the backtrack point")from pineda 
        // and inialize the pineda instance to start to fill untill the backpoint.
        var backPoint = pineda.back_smart();
        drawGrid();
        pineda.init(points, that, template, false);
        if (backPoint.x === pineda.getX() && backPoint.y === pineda.getY()) {
          drawContent();
          pineda.step_smarter();
        } else {
          drawContent();
          while (backPoint.x !== pineda.getX() || backPoint.y !== pineda.getY()) {
            pineda.step_smarter(false);
          }
          // draw the curring pixel and the current distances 
          pineda.putDistancesFor(pineda.getBackPoint());
          that.drawRect(pineda.getBackPoint(), pineda.getBackPoint(), false, "red");
        }
      }
    }
    // else ignore the click 
  };



  this.edgeFlagStep = function () {
    // 3 Edges for a polygon
    if (points.length >= 3) {
      if (scanObjectIsInitialed) { // init the screen for pineda 
        cleanFromScanline();
        template.setEdgeTable(polygon.getEdgeTable(), "et");
        // delete the pineda table data. new data will be calculed  
        template.setTableToEmpty("pt");
      }
      cleanFromPineda();
      if (!edgeFlagObjectIsInitialed || edgeFlag.isDone) {
        roundPoints();
        drawGrid();
        edgeFlag.init(this, points, template);
        edgeFlagObjectIsInitialed = true;
      }
      drawContent();
      edgeFlag.step();

    }
  };

  this.edgeFlag_back = function () {
    if (edgeFlagObjectIsInitialed) {
      drawContent();
      edgeFlag.step_back();
    }
  };



  this.edgeFlag_all = function () {
    if (points.length >= 3) {
      if (scanObjectIsInitialed) { // init the screen for pineda 
        cleanFromScanline();
        template.setEdgeTable(polygon.getEdgeTable(), "et");
        // delete the pineda table data. new data will be calculed  
        template.setTableToEmpty("pt");
      }
      cleanFromPineda();
      if (edgeFlagObjectIsInitialed) {
        drawContent();
        while (!edgeFlag.isDone) {
          edgeFlag.step(false);
        }
      } else {
        roundPoints(); // not working without rounding the points
        edgeFlag.init(that, points, template);
        while (!edgeFlag.isDone) {
          edgeFlag.step(false);
        }
      }

    }
  };


  /*
   * delete a filled pixel, use only by the back step of pineda wiht simple iteration 
   * @param {type} x
   * @param {type} y
   * @returns {undefined}
   */
  this.unfill_pixel = function (x, y) {
    context_grid.clearRect(x * zoomfactor + 1, y * zoomfactor + 1, zoomfactor - 2, zoomfactor - 2);
  };

  /*
   * round the points if its not already rounded 
   * @returns {undefined}
   */
  function roundPoints() {
    if (!pointsRounded) {
      for (i = 0; i < points.length; i++) {
        points[i].x = Math.round(points[i].x);
        points[i].y = Math.round(points[i].y);
      }
      pointsRounded = true;
    }
  }

  /*
   * set the mouse position on the canvas
   * @param {type} event
   * @returns {undefined}
   */
  function mousePosition(event) {
    var grid_coordinates = transformFromWindowToGrid(event.clientX, event.clientY);
    template.setMousePosition(grid_coordinates.x, grid_coordinates.y);
    var point_indx = checkPointSelected(grid_coordinates.x, grid_coordinates.y);
    if (point_indx >= 0) {
      setHighlight(point_indx);
    } else {
      context_highlight.clearRect(0, 0, highlight_canvas.width, highlight_canvas.height);
    }
  }

  function  setHighlight(point_indx) {
    context_highlight.clearRect(0, 0, main_canvas.width, main_canvas.height);
    context_highlight.beginPath();
    context_highlight.strokeStyle = "rgba(197, 189, 90, 0.74)";
    context_highlight.lineWidth = 8;
    var coord_canvas = transformFromGridToCanvas(points[point_indx].x, points[point_indx].y);
    context_highlight.arc(coord_canvas.x, coord_canvas.y, points[point_indx].radius, 0, 2 * Math.PI, false);
    context_highlight.stroke();
  }


  /*
   * draw current points and edges. we use the  head canvas, 
   * where all the listeners are set. 
   * @returns {undefined}
   */
  function drawContent() {
    context.clearRect(0, 0, main_canvas.width, main_canvas.height); // clean first the canvas
    if (points.length > 1) {
      drawEdges();
    }
    // rasterize the Edge if we have just 2 points
    if (points.length === 2) {
      lineToPixels(that, points[0], points[1]);
    }

    for (i = 0; i < points.length; i++) { // draw points after drawing the Edges 
      that.drawPoint(points[i], false); // false for not in focus 
    }

  }

  /*
   *  draw the grid at the given  zoomfactor
   *  the static canvas 
   * pixel_unit : number of Pixel for 1 unit
   */
  function drawGrid() {
    context_grid.clearRect(0, 0, main_canvas.width, main_canvas.height);
    context_grid.beginPath();
    context_grid.lineWidth = 1;
    context_grid.strokeStyle = "rgb(160,160,160)";
    context_grid.moveTo(0, 0);
    for (i = 0; i < 800; i = i + zoomfactor) {
      context_grid.moveTo(i, 0);
      context_grid.lineTo(i, 500);
      if (i < 500) {
        context_grid.moveTo(0, i);
        context_grid.lineTo(800, i);
      }
    }
    context_grid.stroke();

  }


  /*
   * fill the pixel (x,y)
   * @param {int} x
   * @param {int} y
   * @param {bool} background: if true use the background canvas 
   * @returns {undefined}
   */
  this.fill_pixel = function (x, y, inGridCanvas) {
    if (inGridCanvas === undefined) {
      inGridCanvas = false;
    }
    var posX = (Math.floor(x) * zoomfactor) + 1;
    var posY = (Math.floor(y) * zoomfactor) + 1;
    if (!inGridCanvas) {
      context.fillStyle = "#676767"; //rgba(0,0,0,0.5)
      context.fillRect(posX, posY, zoomfactor - 2, zoomfactor - 2);
    } else {
      context_grid.fillStyle = "#676767";
      context_grid.fillRect(posX, posY, zoomfactor - 2, zoomfactor - 2);
  }

  };


  /*
   * 
   * @param {type} x
   * @param {type} y
   * @returns {Json obj}
   */
  function transformFromWindowToGrid(x, y) {
    var rect = main_canvas.getBoundingClientRect();
    return {x: (x - rect.left) / zoomfactor - 0.5, y: (y - rect.top) / zoomfactor - 0.5};
  }

  /*
   * 
   * @param {type} x
   * @param {type} y
   * @returns {Json obj}
   */
  function transformFromGridToCanvas(x, y) {
    return {x: ((x + 0.5) * zoomfactor), y: ((y + 0.5) * zoomfactor)};
  }


  /*
   * draw the given Point on the canvas 
   * @param {Point} point
   * @param {bool} onFocus
   * @returns {undefined}
   */
  this.drawPoint = function (point, onFocus, grid) {
    if (onFocus === undefined) {
      onFocus = false;
    }
    if (grid === undefined) {
      grid = false;
    }
    var ctxt = grid ? context_grid : context;
    if (onFocus) {
      drawContent();
      ctxt.strokeStyle = "#d9534f";
      ctxt.lineWidth = 3;
    } else {
      ctxt.strokeStyle = "black";
      ctxt.lineWidth = 1;
    }
    ctxt.beginPath();
    ctxt.fillStyle = point.color;
    var canvas_coord = transformFromGridToCanvas(point.x, point.y);
    ctxt.arc(canvas_coord.x, canvas_coord.y, point.radius, 0, 2 * Math.PI, false);
    ctxt.fill();
    ctxt.fillStyle = "black";
    ctxt.font = " " + point.radius * 2 + "px Arial";
    var width = ctxt.measureText(point.name).width;
    var height = ctxt.measureText("w").width; // this is a GUESS of height
    ctxt.fillText(point.name, canvas_coord.x - width / 2, canvas_coord.y + height / 2);
    ctxt.stroke();
  };


  /*
   * check if a point is selected on the canvas
   * x , y  grid coordinates
   */
  function checkPointSelected(x, y) {
    for (i = 0; i < points.length; i++) {
      var d = Math.sqrt((points[i].x - x) * (points[i].x - x) + (points[i].y - y) * (points[i].y - y));
      if (d <= points[i].radius / zoomfactor) {
        return i;
      }
    }
    return -1;
  }

  /*  
   *  draw the edges. use the points array to get wich lines need to 
   *  drawed
   */
  function drawEdges() {
    context.beginPath();
    var coord_0 = transformFromGridToCanvas(points[0].x, points[0].y);
    var coord = coord_0;
    context.moveTo(coord_0.x, coord_0.y);
    if (points[0].isActive) {
      context.strokeStyle = "#C72020";
      context.lineWidth = 3;
    } else {
      context.strokeStyle = "#3E3E3E";
      context.lineWidth = 2;
    }
    for (i = 1; i < points.length; i++) {
      coord = transformFromGridToCanvas(points[i].x, points[i].y);
      context.lineTo(coord.x, coord.y);
      context.stroke();

      // defind how to draw the next point, as active or not 
      context.beginPath();
      context.moveTo(coord.x, coord.y);
      if (points[i].isActive) {
        context.strokeStyle = "#C72020";
        context.lineWidth = 3;
      } else {
        context.strokeStyle = "#3E3E3E";
        context.lineWidth = 2;
      }
    }
    context.lineTo(coord_0.x, coord_0.y);
    context.stroke();
  }

  /*
   * draw the scan line on the head canvas. 
   * @param {type} y
   * @returns {undefined}
   */
  this.drawScanline = function (y) {
    drawContent();
    context.beginPath();
    context.lineWidth = 2;
    var canvas_y = transformFromGridToCanvas(0, y).y;
    context.moveTo(0, canvas_y);
    context.strokeStyle = "green"; //#008B8B  helles blau
    context.lineTo(main_canvas.width, canvas_y);
    context.stroke();
  };


  this.getPoints = function () {
    return points;
  };

  this.getPolygon = function () {
    return polygon;
  };

  /*
   * get the scanline object
   * @returns {ScanLine|CanvasImage.scanline}
   */
  this.getScanner = function () {
    return scanline;
  };

  /*
   * get the next name of a point 
   */
  function getNextName() {
    if (names.length > 0) {
      var name = names[0];
      //names.splice(0,1);    
      return name;
    } else {
      // ignore. no more points will be drawed     
    }

  }
  /*
   * draw the Rect. given by the two points p1, p2
   * it used two draw the bounding box in pineda, and draw the current 
   * pixel, that we check wether its in or not, and the backtrack point  
   */
  this.drawRect = function (p1, p2, grid, color) {
    if (grid === undefined) {
      grid = true;
    }
    if (color === undefined) {
      color = "green";
    }
    
    var cor1 = transformFromGridToCanvas(p1.x - 0.5, p1.y - 0.5);
    var cor2 = transformFromGridToCanvas(p2.x + 0.5, p2.y + 0.5);
    if (grid) {
      context_grid.strokeStyle = color;
      context_grid.lineWidth = 2;
      context_grid.strokeRect(cor1.x, cor1.y, cor2.x - cor1.x, cor2.y - cor1.y);
    } else {
      context.strokeStyle = color;
      context.lineWidth = 2;
      context.strokeRect(cor1.x, cor1.y, cor2.x - cor1.x, cor2.y - cor1.y);
  }
  };

  /*
   * set edges as not active.
   * active means that they are in the active edge table in the scanline
   */
  function setEdgesAsNotActive() {
    for (i = 0; i < points.length; i++) {
      if (points[i].isActive) {
        points[i].isActive = false;
      }
    }
  }


  /*
   * extend the edge given by the two points p1,p2 
   * used for better  visualization of the drawed distances 
   */
  this.extendLine = function (p1, p2) { // vector orientation 
    context_pineda.beginPath();
    context_pineda.strokeStyle = "Black";
    context_pineda.lineWidth = 1;
    context_pineda.setLineDash([5, 3]);
    var m = (p2.y - p1.y) / (p2.x - p1.x);
    if (isFinite(m)) { // check if the edge is not vertical 
      var b = p1.y - m * p1.x;
      var y1 = -0.5 * m + b;
      var y2 = ((main_canvas.width / zoomfactor) - 0.5) * m + b;
      var coord = transformFromGridToCanvas(-0.5, y1);
      var coord2 = transformFromGridToCanvas(((main_canvas.width / zoomfactor) - 0.5), y2);
      context_pineda.moveTo(coord.x, coord.y);
      context_pineda.lineTo(coord2.x, coord2.y);
    } else {
      var coord_vert = transformFromGridToCanvas(p1.x, 0);
      context_pineda.moveTo(coord_vert.x, 0);
      context_pineda.lineTo(coord_vert.x, main_canvas.height);
    }
    context_pineda.stroke();
  };

  /*
   * draw the head arrow in the middle point of the edge 
   */
  this.drawArrowHead = function (p1, p2) {
    // calculate the angle of the line 
    var angle = Math.PI / 8;
    var lineangle = Math.atan2(p2.y - p1.y, p2.x - p1.x); // h is the line length of a side of the arrow head
    var h = zoomfactor;
    context_pineda.beginPath();
    context_pineda.fillStyle = "#3E3E3E";
    context_pineda.lineWidth = 1;
    context_pineda.strokeStyle = "#3E3E3E";
    var angle1 = lineangle + Math.PI + angle;
    var angle2 = lineangle + Math.PI - angle;
    var coord = transformFromGridToCanvas((p2.x + p1.x) / 2, (p2.y + p1.y) / 2);
    context_pineda.moveTo(coord.x, coord.y);
    context_pineda.lineTo(coord.x + Math.cos(angle1) * h, coord.y + Math.sin(angle1) * h);
    context_pineda.lineTo(coord.x + Math.cos(angle2) * h, coord.y + Math.sin(angle2) * h);
    context_pineda.lineTo(coord.x, coord.y);
    context_pineda.fill();
    context_pineda.stroke();
  };

  /*
   * draw a distance between the current pixel and a edge 
   */
  this.drawDistance = function (d, pixel, n0) {
    context.beginPath();
    context.lineWidth = 2;
    if (d > 0) {
      context.strokeStyle = "green";
    } else {
      context.strokeStyle = "red";
    }
    var pixel_coord = transformFromGridToCanvas(pixel.x, pixel.y);
    context.moveTo(pixel_coord.x, pixel_coord.y);
    // console.log("distance: "+d*(n0.x/n0.absToOrigin)+", "+d*(n0.y/n0.absToOrigin));
    var coord = transformFromGridToCanvas(pixel.x - d * (n0.x / n0.disToOrigin), pixel.y - d * (n0.y / n0.disToOrigin));
    context.lineTo(coord.x, coord.y);
    context.stroke();
  };

  this.reInit = function (newZoomfactor) {
    if (newZoomfactor !== zoomfactor) {
      cleanFromScanline();
      cleanFromPineda();
      cleanFromEdgeFlag();

      current_point_index = -1;
      template.disablePoint();

      for (i = 0; i < points.length; i++) {
        points[i].radius = newZoomfactor / 2;
        var coord = transformFromGridToCanvas(points[i].x, points[i].y);
        points[i].x = coord.x / newZoomfactor - 0.5;
        points[i].y = coord.y / newZoomfactor - 0.5;
      }
      pointsRounded = false;

      zoomfactor = newZoomfactor;
      drawGrid();
      drawContent();

      // reInit the edges to update the edge table
      for (i = 0; i < polygon.edges.length; i++) {
        polygon.edges[i].Init();
      }
      template.setEdgeTable(polygon.getEdgeTable(), "et");
      template.setTableToEmpty("pt");
      template.resetCounter();
    }


    // ignore the the reunit 
  };

  this.getGridWidth = function () {
    return 800 / zoomfactor;
  };

}
