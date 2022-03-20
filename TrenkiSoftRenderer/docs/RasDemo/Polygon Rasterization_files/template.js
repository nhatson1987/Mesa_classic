// This software is written for educational (non-commercial) purpose. 
// There is no warranty or other guarantee of fitness for this software, 
// it is provided solely "as is". 

// Created by Bellafkir Hicham, August 2017
// http://creativecommons.org/licenses/by/4.0/

function Template() {
  var canvas;
  var that = this;


  this.init = function () {
    canvas = new CanvasImage();
    canvas.init(this);
    addListeners();
  };


  function addListeners() {
    $("#removePoint").click(function () {
      canvas.removePoint();
    });

    $("#scanline").click(function () {
      canvas.scanlineStep();
    });


    $("#pineda").click(function () {
      var selectedMode = $('#pinedaMode').find("option:selected").text();

      switch (selectedMode) {
        case "simple":
          canvas.pinedaStep(true);  // false for fill all, true for a simple iteration over the polygon. 
          break;
        case "smart":
          canvas.pinedaStep(false); // is default is also "simple=false" 
          break;

        default:
      }


    });

    $("#scanline_back").click(function () {
      canvas.scanlineBack();
    });


    $("#scanline_all").click(function () {
      canvas.scanline_all();
    });

    $("#pineda_all").click(function () {
      var simple = $('#pinedaMode').find("option:selected").text() === "simple";
      canvas.pinedaAll(simple); // 
      that.setEmptyDistance();
    });

    $("#pineda_back").click(function () {
      canvas.pinedaBack();
    });

    $(function () {
      $('#pinedaMode').on('change', function () {
        canvas.selectpicker_changed();
      });

    });

    $(function () {
      $('#resolution_select').on('change', function () {
        var selectedMode = $('#resolution_select').find("option:selected").text();

        switch (selectedMode.substring(0,2)) {
          case "25":
            canvas.reInit(20);
            break;
          case "50":
            canvas.reInit(10);
            break;
          default:
        }
      });
      
      $('#approach_select').on('change', function () {
        var selectedMode = $('#approach_select').find("option:selected").text();
        if (selectedMode === "Scanline") {
          $('#scanline_panel').removeClass("hidden");
          $('#pineda_panel').addClass("hidden");
          $('#edgeflag_panel').addClass("hidden");
        }
        if (selectedMode === "Pineda") {
          $('#scanline_panel').addClass("hidden");
          $('#pineda_panel').removeClass("hidden");
          $('#edgeflag_panel').addClass("hidden");
        }
        if (selectedMode === "EdgeFlag") {
          $('#scanline_panel').addClass("hidden");
          $('#pineda_panel').addClass("hidden");
          $('#edgeflag_panel').removeClass("hidden");
        }
        if (selectedMode === "All") {
          $('#scanline_panel').removeClass("hidden");
          $('#pineda_panel').removeClass("hidden");
          $('#edgeflag_panel').removeClass("hidden");
        }
      });
      
      
    });

    $("#edgeflag_step").click(function () {
      //canvas.boundaryFill_step();
      canvas.edgeFlagStep();
    });


    $("#edgeflag_back").click(function () {
      //canvas.boundaryFill_step();
      canvas.edgeFlag_back();
    });

    $("#edgeflag_all").click(function () {
      //canvas.boundaryFill_step();
      canvas.edgeFlag_all();
    });

  }




  this.addEdgeTotable = function (edge, id) {
    var mInv = parseFloat(edge.mInv).toFixed(3);
    $('#' + id).append("<tr>\n\
                                      <th scope='row'>" + edge.idName + "</t>\n\
                                      <td>" + edge.yMin + "</td>\n\
                                      <td>" + edge.xHit.toFixed(2) + "</td><td>" + edge.yMax + "</td><td>" + mInv + "</td></tr>");
  };


  this.setEdgeTable = function (sorted_edges, id) {
    $('#' + id).empty();
    for (i = 0; i < sorted_edges.length; i++) {
      this.addEdgeTotable(sorted_edges[i], id);
    }
  };


  this.setPoint = function (point) {
    $('#removePoint').prop("disabled", false);
    $('#currentP').html("<h5 id='pointText'><strong>" + point.name + "</strong>" + ": (" + point.x.toFixed(2) + ", " + point.y.toFixed(2) + ")</h5>");
  };
  this.disablePoint = function () {
    $('#pointText').html(""); // not working fine 
    $('#removePoint').prop("disabled", true);
  };


  this.setTableToEmpty = function (id) {
    $('#' + id).empty();
  };

  this.displayElement = function (id) {
    if (!$('#' + id).is(":visible")) {
      $('#' + id).show();
    }
  };


  this.setCurrentScanline = function (y) {
    $('#current_scanline_pixel').html("Scanline: " + y);
  };

  this.resetCounter = function () {
    $('#current_scanline_pixel').empty();
  };


  this.setConvexMessage = function (message, isWarning) {
    var class_name = "alert alert-danger alert-dismissable";
    if (!isWarning) {
      class_name = "alert alert-success alert-dismissable hidden";
    }
    $('#isConvex').html("<div class='" + class_name + "'>\n\
                                 <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>\n" + message + "</div>");
    $('#isConvex').show();
  };



  this.setMousePosition = function (x, y) {
    var relativ_cor = document.getElementById('mouse_position');
    relativ_cor.innerHTML = "Pos: (<strong>X</strong>: " + parseFloat(x).toFixed(2) + ",\n\
                            <strong>Y</strong>:" + parseFloat(y).toFixed(2) + ")";


  };

  this.isSimplePinedaMode = function () {
    return   $('#pinedaMode').find("option:selected").text() === "simple";
  };

  this.setItemToPinedaTable = function (p1, p2, n) {
    // var vectorname =  "<mover><mi>"+p1.name+p2.name+"</mi><mo>&rarr;</mo></mover>";
    // var v_html="<mo>(</mo><mfrac linethickness='0'><mi>"+(p2.x-p1.x)+"</mi><mi>"+(p2.y-p1.y)+"</mi></mfrac><mo>)</mo>";
    var dirVec = "(" + (p2.x - p1.x) + "," + (p2.y - p1.y) + ")<sup>T</sup>";
    var n_vec = "(" + n.x + "," + n.y + ")<sup>T</sup>";
    //var p = "<math><mo>(</mo><mfrac linethickness='0'><mi>"+p1.x+"</mi><mi>"+p1.y+"</mi></mfrac><mo>)</mo></math>";


    $('#pt').append("<tr>\n\
                                      <th scope='row'>" + p1.name + p2.name + "</t>\n\
                                      <td>" + dirVec + "</td>\n\
                                      <td>" + n_vec + "</td>\n\
                                      <td id=" + p1.name + p2.name + " class='distance'>-</td></tr>");
  };



  this.setDistanceToTableItem = function (id, d) {
    if (d > 0) {
      $('#' + id).html("<p style='color:green;'>" + d.toFixed(2) + "</p>");
    } else {
      $('#' + id).html("<p style='color:red;'>" + d.toFixed(2) + "</p>");
    }


  };

  this.setEmptyDistance = function () {
    $('.distance').empty();
  };

  this.setCurrentPixel = function (x, y) {
    $('#current_scanline_pixel').html("Pixel: (" + x + ", " + y + ")");
  };


  this.setFlagValue = function (isSet) {
    if (isSet) {
      $('#flag_value').html("1");
    } else {
      $('#flag_value').html("0");
    }
  };

  this.setFlagToEmpty = function () {
    $('#flag_value').empty();
  };

}