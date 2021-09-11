var CurrentVehicle = {};
var CurrentVehicle_ = {};
var VehicleArr = []
var garage_id = undefined
var currentcar
var chopper = false
var inGarageVehicle = {}
var backdata = []
var backdata2 = []
var totalcost = 0
var lvladd = 0
var modindex = -1
var modcosts = []
var upgraded = []
var multi = {}

function playsound(table) {
    var file = table['file']
    var volume = table['volume']
    var audioPlayer = null;
    if (audioPlayer != null) {
        audioPlayer.pause();
    }
    if (volume == undefined) {
        volume = 0.2
    }
    audioPlayer = new Audio("./audio/" + file + ".ogg");
    audioPlayer.volume = volume;
    audioPlayer.play();
}

colorPicker = document.querySelector("#color");
var colortype = undefined
function addbill(name,bill,total,index) {
    if (document.getElementById(index+'_div')) {
        document.getElementById(index+'_div').remove()
    }
    var str = `<figure id="`+index+`_div">
    <span style="font-size: 10px;color: #bbb7b7;">
    <strong style="font-size: 10px;color: #fefe;">`+name+`</strong>  </span>
    <span style="color: #fff;">`+bill+`</span>
</figure>`
    $('#invoicelist').append(str)
    document.getElementById("totalcost2").innerHTML = total;
}

function removebill(name,totalcost,index) {
    document.getElementById('totalcost2').innerHTML = totalcost
    if (document.getElementById(index+'_div')) {
        document.getElementById(index+'_div').remove()
    }
}

function ShowSubmenu(data) {
    backdata2 = data
    $.post("https://renzu_customs/Reset", JSON.stringify({}));
    document.getElementById("custom").innerHTML = '';
    setTimeout(function(){
        var color = false
        for (const i in data) {
            if (data[i] && data[i].label !== undefined) {
                if (i == 23) {
                    var index = i
                    for (const ind in data[index].list) {
                        if (ind == 'WheelType') {
                            $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/`+ind+`.svg"><div class="mod_title"><span>`+ind+` Wheel</span></div></button>`)
                            $("#"+ind+"").click(function(){
                                ShowWheelOption(data[i],data[i].max,data[index].list[ind])
                            });
                        } else if (ind == 'WheelColor') {
                            $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/`+ind+`.svg"><div class="mod_title"><span>`+ind+` Wheel</span></div></button>`)
                            $("#"+ind+"").click(function(){
                                ShowWheelColorOption(data[i],data[i].max,data[index].list[ind])
                            });
                        } else if (ind == 'Accessories') {
                            $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/`+ind+`.svg"><div class="mod_title"><span>`+ind+` Wheel</span></div></button>`)
                            $("#"+ind+"").click(function(){
                                ShowWheelAcceOption(data[i],data[i].max,data[index].list[ind])
                            });
                        }
                    }
                } else if (i == 18) {
                    var index = i
                    $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/18.svg"><div class="mod_title"><span>`+data[i].label+`</span></div></button>`)
                    $("#"+i+"").click(function() {
                        //$.post("https://renzu_customs/ToggleTurbo", JSON.stringify({ index: data[index].list[ind]}));
                        ShowTurboMenu(data[i])
                    });
                } else if (i == 105) {
                    var index = i
                    for (const ind in data[index].list) {
                        $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/18.svg"><div class="mod_title"><span>`+i+`</span></div></button>`)
                        $("#"+i+"").click(function() {
                            if(ind == 0 && upgraded[index] !== undefined) {
                                totalcost = totalcost - data[index].cost
                                removebill(ind,totalcost,ind)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = undefined
                            } else {
                                totalcost = totalcost + data[index].cost
                                addbill(ind,data[index].cost,totalcost,index)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = ind
                            }
                            $.post("https://renzu_customs/SetExtra", JSON.stringify({ index: data[index].list[ind]}));
                            //ShowTurboMenu(data[i])
                        });
                    }
                } else if (i == 106) {
                    var index = i
                    var lastcost = 0
                    for (const ind in data[index].list) {
                        $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/custom_engine.svg"><div class="mod_title"><span>`+ind+`</span></div></button>`)
                        $("#"+ind+"").click(function() {
                            if(upgraded[index] !== undefined) {
                                totalcost = totalcost - lastcost
                                removebill(ind,totalcost,ind)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = undefined
                            } 
                            if(ind !== 'Default') {
                                totalcost = totalcost + data[index].list[ind].value
                                addbill(ind,data[index].list[ind].value,totalcost,index)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = ind
                                lastcost = data[index].list[ind].value
                            }
                            $.post("https://renzu_customs/SetCustomEngine", JSON.stringify({ engine: data[index].list[ind].model}));
                            //ShowTurboMenu(data[i])
                        });
                    }
                } else if (i == 107) {
                    var index = i
                    var lastcost = 0
                    for (const ind in data[index].list) {
                        $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/18.svg"><div class="mod_title"><span>`+ind+`</span></div></button>`)
                        $("#"+ind+"").click(function() {
                            if(upgraded[index] !== undefined || ind == 'Default') {
                                totalcost = totalcost - lastcost
                                removebill(ind,totalcost,ind)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = undefined
                            } 
                            if(ind !== 'Default') {
                                totalcost = totalcost + data[index].list[ind].value
                                addbill(ind,data[index].list[ind].value,totalcost,index)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = ind
                                lastcost = data[index].list[ind].value
                            }
                            $.post("https://renzu_customs/SetCustomTurbo", JSON.stringify({ turbo: ind}));
                            //ShowTurboMenu(data[i])
                        });
                    }
                } else if (i == 108) {
                    var index = i
                    var lastcost = 0
                    for (const ind in data[index].list) {
                        $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/custom_tires.svg"><div class="mod_title"><span>`+ind+`</span></div></button>`)
                        $("#"+ind+"").click(function() {
                            if(upgraded[index] !== undefined || ind == 'Default') {
                                totalcost = totalcost - lastcost
                                removebill(ind,totalcost,ind)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = undefined
                            } 
                            if(ind !== 'Default') {
                                totalcost = totalcost + data[index].list[ind].value
                                addbill(ind,data[index].list[ind].value,totalcost,index)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = ind
                                lastcost = data[index].list[ind].value
                            }
                            $.post("https://renzu_customs/SetCustomTireType", JSON.stringify({ tire: ind}));
                            //ShowTurboMenu(data[i])
                        });
                    }
                } else if (i == 99 || i == 100) {
                    var index = i
                    color = true
                    for (const ind in data[index].list) {
                        $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/28.svg"><div class="mod_title"><span>`+ind+`</span></div></button>`)
                        $("#"+ind+"").click(function(){
                            ShowPaintOption(data[i],data[index].list[ind])
                        });
                    }
                    colortype = data[i].type
                } else if (i == 101) {
                    var index = i
                    $.post("https://renzu_customs/SelectModIndex", JSON.stringify({ index: 'headlight'}));
                    for (const ind in data[index].list) {
                        if(ind == 'XenonLights') {
                            $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/22.svg"><div class="mod_title"><span>`+ind+`</span></div></button>`)
                            $("#"+ind+"").click(function() {
                                totalcost = totalcost + data[index].cost
                                addbill(ind,data[index].cost,totalcost,index)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = 1
                                $.post("https://renzu_customs/XenonMod", JSON.stringify({ index: data[index].list[ind]}));
                            });
                        } else if(ind == 'Default') {
                            $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/22.svg"><div class="mod_title"><span>`+ind+`</span></div></button>`)
                            $("#"+ind+"").click(function() {
                                if (upgraded[index] == 1) {
                                    upgraded[index] = 0
                                    totalcost = totalcost - data[index].cost
                                    removebill('XenonLights',totalcost,'XenonLights')
                                }
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                $.post("https://renzu_customs/XenonMod", JSON.stringify({ index: data[index].list[ind]}));
                            });
                        } else if(ind == 'XenonColor') {
                            $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/28.svg"><div class="mod_title"><span>`+data[i].label+`</span></div></button>`)
                            $("#"+i+"").click(function(){
                                ShowXenonMenu(data[index].list[ind])
                            });
                        }
                    }
                } else if (i == 102) {
                    var index = i
                    $.post("https://renzu_customs/SelectModIndex", JSON.stringify({ index: 4}));
                    for (const ind in data[index].list) {
                        $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/26.svg"><div class="mod_title"><span>#`+ind+`</span></div></button>`)
                        $("#"+ind+"").click(function() {
                            var lvl = data[index].list[ind]
                            if (modindex !== index && upgraded[index] == undefined && lvl > 0 || upgraded[index] == undefined) {
                                totalcost = totalcost + data[index].cost
                                modindex = index
                                upgraded[index] = lvl
                                addbill(data[index].name,data[index].cost,totalcost,index)
                            }
                            if (lvl == 0 && lvladd > 0) {
                                modindex = -1
                                upgraded[index] = undefined
                                totalcost = totalcost - data[index].cost
                                removebill(data[index].name,totalcost,index)
                            }
                            lvladd = lvl
                            document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                            $.post("https://renzu_customs/ChangePlate", JSON.stringify({ index: data[index].list[ind]}));
                        });
                    }
                } else if (i == 103) {
                    var index = i
                    $.post("https://renzu_customs/SelectModIndex", JSON.stringify({ index: 'neon'}));
                    var haveneon = false;
                    $.post("https://renzu_customs/isNeonLights", JSON.stringify({}), function(data) {
                        haveneon = data[0]
                    });
                    for (const ind in data[index].list) {
                        if(ind == 'Default') {
                            $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/neon.svg"><div class="mod_title"><span>`+ind+`</span></div></button>`)
                            $("#"+ind+"").click(function() {
                                if (upgraded[index] == 1) {
                                    totalcost = totalcost - data[index].cost
                                    upgraded[index] = undefined
                                    removebill(data[index].name,totalcost,index)
                                    document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                }
                                $.post("https://renzu_customs/SetNeonState", JSON.stringify({ index: false}));
                            });
                        } else if(ind == 'NeonKit') {
                            $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/neon.svg"><div class="mod_title"><span>`+ind+`</span></div></button>`)
                            $("#"+ind+"").click(function() {
                                if (upgraded[index] == undefined) {
                                    totalcost = totalcost + data[index].cost
                                    upgraded[index] = 1
                                    addbill(data[index].name,data[index].cost,totalcost,index)
                                    document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                }
                                $.post("https://renzu_customs/SetNeonState", JSON.stringify({ index: true}));
                            });
                        } else if(ind == 'NeonColor') {
                            $('#custom').prepend(`<button id="colordiv" class="modclass"><input type="color" id="neon" value="#ff0000"><div class="mod_title"><span>Neon Color</span></div></button>`)
                            colorPicker = document.querySelector("#neon");
                            colorPicker.addEventListener("input", SetNeonColor, false);
                            colorPicker.addEventListener("change", SetNeonColor, false);
                        }
                    }
                } else if (i == 104) {
                    var index = i
                    $.post("https://renzu_customs/SelectModIndex", JSON.stringify({ index: 'window'}));
                    for (const ind in data[index].list) {
                        $('#custom').append(`<button id="`+ind+`" class="modclass"><img src="img/window.svg"><div class="mod_title"><span>`+ind+`</span></div></button>`)
                        $("#"+ind+"").click(function() {
                            if(upgraded[index] !== undefined && ind == 'None') {
                                totalcost = totalcost - data[index].cost
                                removebill(ind,totalcost,ind)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = undefined
                            } 
                            if(ind !== 'None' && upgraded[index] == undefined) {
                                totalcost = totalcost + data[index].cost
                                addbill(ind,data[index].cost,totalcost,index)
                                document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                                upgraded[index] = ind
                            }
                            $.post("https://renzu_customs/SetWindowTint", JSON.stringify({ index: data[index].list[ind]}));
                        });
                    }
                } else {
                    $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/`+data[i].index+`.svg"><div class="mod_title"><span>`+data[i].label+`</span></div></button>`)
                    $("#"+i+"").click(function(){
                        ShowIndexMenu(data[i],data[i].max)
                    });
                }
            }
        }
        if (color) {
            $('#custom').prepend(`<button id="colordiv" class="modclass"><input type="color" id="color" value="#ff0000"><div class="mod_title"><span>Custom Color</span></div></button>`)
            colorPicker = document.querySelector("#color");
            colorPicker.addEventListener("input", SetCustomColor, false);
            colorPicker.addEventListener("change", SetCustomColor, false);
        }
        $('#custom').prepend(`<button id="close" class="modclass"><img src="img/b.svg"><div class="mod_title"><span>Back</span></div></button>`)
        $("#close").click(function(){
            document.getElementById("custom").innerHTML = '';
            setTimeout(function(){
                ShowMod(backdata)
            }, 500);
        });
    }, 500);
}


function hexToRgb(hex) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result ? {
      r: parseInt(result[1], 16),
      g: parseInt(result[2], 16),
      b: parseInt(result[3], 16)
    } : null;
}

function SetCustomColor(event) {
    $.post("https://renzu_customs/SetCustomColor", JSON.stringify({ r: hexToRgb(event.target.value).r, g:hexToRgb(event.target.value).g, b:hexToRgb(event.target.value).b, type:colortype}));
}

function SetNeonColor(event) {
    $.post("https://renzu_customs/SetNeonColor", JSON.stringify({ r: hexToRgb(event.target.value).r, g:hexToRgb(event.target.value).g, b:hexToRgb(event.target.value).b}));
}

function ShowXenonMenu(data) {
    //backdata2 = {data,max}
    lvladd = 0
    document.getElementById("custom").innerHTML = '';
    $.post("https://renzu_customs/SelectModIndex", JSON.stringify({ index: data.index}));
    setTimeout(function(){
        for (const i in data) {
            $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/28.svg"><div class="mod_title"><span>`+i+`</span></div></button>`)
            $("#"+i+"").click(function() {
                $.post("https://renzu_customs/SetXenonColor", JSON.stringify({ index: data[i]}));
            });
        }
        $('#custom').prepend(`<button id="close2" class="modclass"><img src="img/b.svg"><div class="mod_title"><span>Back</span></div></button>`)
        $("#close2").click(function(){
            document.getElementById("custom").innerHTML = '';
            setTimeout(function(){
                ShowSubmenu(backdata2)
            }, 500);
        });
    }, 500);
}

function ShowWheelOption(data,max,list) {
    document.getElementById("custom").innerHTML = '';
    setTimeout(function(){
        for (const i in list) {
            $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/`+i+`.svg"><div class="mod_title"><span>`+i+`</span></div></button>`)
                $("#"+i+"").click(function() {
                    ShowIndexMenu(data,data.max,list[i])
            });
            // if (i == 'WheelType') {
            //     $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/`+i+`.svg"><div class="mod_title"><span>`+i+`</span></div></button>`)
            //     $("#"+i+"").click(function() {
            //         ShowIndexMenu(data,data.max,list[i])
            //     });
            // } else if (i == 'WheelColor') {
            //     $("#"+i+"").click(function() {
            //         WheelColor(data,data.max,list[i])
            //     });
            // } else if (i == 'Accessories') {
            //     $("#"+i+"").click(function() {
            //         WheelAccessories(data,data.max,list[i])
            //     });
            // }
        }
        $('#custom').prepend(`<button id="close2" class="modclass"><img src="img/b.svg"><div class="mod_title"><span>Back</span></div></button>`)
        $("#close2").click(function(){
            document.getElementById("custom").innerHTML = '';
            setTimeout(function(){
                ShowSubmenu(backdata2)
            }, 500);
        });
    }, 500);
}

function ShowWheelColorOption(data,max,list) {
    document.getElementById("custom").innerHTML = '';
    setTimeout(function(){
        for (const i in list) {
            $('#custom').append(`<button id="`+list[i]+`" class="modclass"><img src="img/28.svg"><div class="mod_title"><span>`+i+`</span></div></button>`)
            $("#"+list[i]+"").click(function() {
                SetWheelColor(list[i])
            });
        }
        $('#custom').prepend(`<button id="close2" class="modclass"><img src="img/b.svg"><div class="mod_title"><span>Back</span></div></button>`)
        $("#close2").click(function(){
            document.getElementById("custom").innerHTML = '';
            setTimeout(function(){
                ShowSubmenu(backdata2)
            }, 500);
        });
    }, 500);
}

function ShowWheelAcceOption(data,max,list) {
    document.getElementById("custom").innerHTML = '';
    setTimeout(function(){
        for (const i in list) {
            if (i == 'CustomTire') {
                $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/28.svg"><div class="mod_title"><span>`+i+`</span></div></button>`)
                $("#"+i+"").click(function() {
                    if (upgraded['CustomTire'] == 1 && upgraded['CustomTire'] !== undefined) {
                        upgraded['CustomTire'] = 0
                        totalcost = totalcost - data.cost
                        removebill('CustomTire',totalcost,'CustomTire')
                        document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                    } else {
                        totalcost = totalcost + data.cost
                        addbill('CustomTire',data.cost,totalcost,i)
                        document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                        upgraded['CustomTire'] = 1
                    }
                    $.post("https://renzu_customs/SetCustomTire", JSON.stringify({ }));
                });
            } else if (i == 'SmokeColor') {
                $('#custom').prepend(`<button id="colordiv" class="modclass"><input type="color" id="color" value="#ff0000"><div class="mod_title"><span>Smoke Color</span></div></button>`)
                colorPicker = document.querySelector("#color");
                colorPicker.addEventListener("input", SetSmokeColor, false);
                colorPicker.addEventListener("change", SetSmokeColor, false);
            } else if (i == 'BulletProof') {
                $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/28.svg"><div class="mod_title"><span>`+i+`</span></div></button>`)
                $("#"+i+"").click(function() {
                    $.post("https://renzu_customs/SetBulletProofTires", JSON.stringify({ }));
                });
            } else if (i == 'DriftTires') {
                $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/28.svg"><div class="mod_title"><span>`+i+`</span></div></button>`)
                $("#"+i+"").click(function() {
                    if (upgraded['DriftTire'] == 1 && upgraded['DriftTire'] !== undefined) {
                        upgraded['DriftTire'] = 0
                        totalcost = totalcost - data.cost
                        removebill('DriftTire',totalcost,'DriftTire')
                        document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                    } else {
                        totalcost = totalcost + data.cost
                        addbill('DriftTire',data.cost,totalcost,i)
                        document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                        upgraded['DriftTire'] = 1
                    }
                    $.post("https://renzu_customs/SetDrift", JSON.stringify({ }));
                });
            }
        }
        $('#custom').prepend(`<button id="close2" class="modclass"><img src="img/b.svg"><div class="mod_title"><span>Back</span></div></button>`)
        $("#close2").click(function(){
            document.getElementById("custom").innerHTML = '';
            setTimeout(function(){
                ShowSubmenu(backdata2)
            }, 500);
        });
    }, 500);
}

function SetSmokeColor(event) {
    $.post("https://renzu_customs/SetSmokeColor", JSON.stringify({ r: hexToRgb(event.target.value).r, g:hexToRgb(event.target.value).g, b:hexToRgb(event.target.value).b, type:colortype}));
}

function ShowPaintOption(data,list) {
    document.getElementById("custom").innerHTML = '';
    setTimeout(function(){
        for (const i in list) {
            $('#custom').append(`<button id="`+list[i]+`" class="modclass"><img src="img/28.svg"><div class="mod_title"><span>#`+i+`</span></div></button>`)
            $("#"+list[i]+"").click(function() {
                SetPaint(data.type,list[i],data.cost)
            });
        }
        $('#custom').prepend(`<button id="close2" class="modclass"><img src="img/b.svg"><div class="mod_title"><span>Back</span></div></button>`)
        $("#close2").click(function(){
            document.getElementById("custom").innerHTML = '';
            setTimeout(function(){
                ShowSubmenu(backdata2)
            }, 500);
        });
    }, 500);
}

function ShowXenonOption(data,list) {
    document.getElementById("custom").innerHTML = '';
    setTimeout(function(){
        for (const i in list) {
            $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/22.svg"><div class="mod_title"><span>#`+i+`</span></div></button>`)
            $("#"+i+"").click(function() {
                $.post("https://renzu_customs/XenonMod", JSON.stringify({ index: list[i]}));
            });
        }
        $('#custom').prepend(`<button id="close2" class="modclass"><img src="img/b.svg"><div class="mod_title"><span>Back</span></div></button>`)
        $("#close2").click(function(){
            document.getElementById("custom").innerHTML = '';
            setTimeout(function(){
                ShowSubmenu(backdata2)
            }, 500);
        });
    }, 500);
}

function ShowTurboMenu(data) {
    lvladd = 0
    document.getElementById("custom").innerHTML = '';
    $.post("https://renzu_customs/SelectModIndex", JSON.stringify({ index: data.index}));
    setTimeout(function(){
        for (const i in data.list) {
            $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/18.svg"><div class="mod_title"><span>`+i+`</span></div></button>`)
            $("#"+i+"").click(function() {
            var index = data.index
            var lvl = data.list[i]
            var cost = data.cost
            if (modindex !== index && upgraded[index] == undefined && lvl > 0 || upgraded[index] == undefined) {
                totalcost = totalcost + cost
                modindex = index
                upgraded[index] = lvl
                addbill(data.name,data.cost,totalcost,index)
            }
            if (lvl == 0 && lvladd > 0) {
                modindex = -1
                upgraded[index] = undefined
                totalcost = totalcost - cost
                removebill(data.name,totalcost,index)
            }
            lvladd = lvl
            document.getElementById("cost").innerHTML = totalcost.toFixed(1);
                $.post("https://renzu_customs/ToggleTurbo", JSON.stringify({ index: data.list[i]}));
                //SetMod(data.index,i,data.cost,wheeltype)
            });
        }
        $('#custom').prepend(`<button id="close2" class="modclass"><img src="img/b.svg"><div class="mod_title"><span>Back</span></div></button>`)
        $("#close2").click(function(){
            document.getElementById("custom").innerHTML = '';
            setTimeout(function(){
                ShowSubmenu(backdata2)
            }, 500);
        });
    }, 500);
}

function ShowIndexMenu(data,max,wheeltype) {
    //backdata2 = {data,max}
    lvladd = 0
    document.getElementById("custom").innerHTML = '';
    var oldinstalled = -1
    var max = max
    $.post("https://renzu_customs/SelectModIndex", JSON.stringify({ index: data.index}), function(ind,m) {
        setTimeout(function(){
            const mods = function() {
                var installed = ind + 1
                $.post("https://renzu_customs/GetModData", JSON.stringify({ index: data.index,wheeltype:wheeltype}), function(d) {
                    for (let i = 0; i < d.max; i++) {
                        var label = d.mod[i]
                        if (label == '') { label = i+' Lvl' }
                        const index = i
                        var bg = '#f5ebeb'
                        var color = '#353b3e'
                        $('#custom').append(`<button id="`+i+`" class="modclass"><img src="img/`+data.index+`.svg"><div id="`+index+`_installed" class="mod_title" style="background:`+bg+`;color:`+color+`;"><span>`+label+`</span></div></button>`)
                        if (installed == i) {
                            label = 'Installed'
                            $("#"+installed+"_installed").toggleClass("installed")
                            oldinstalled = installed
                        }
                        $("#"+i+"").click(function() {
                            //document.getElementById("custom").innerHTML = '';
                            SetMod(data.index,index,data.cost,wheeltype,label,data.multicostperlvl)
                            setTimeout(function(){
                                $("#"+oldinstalled+"_installed").removeClass("installed")
                                oldinstalled = index
                                $("#"+index+"_installed").toggleClass("installed")
                            }, 100);
                        });
                    }
                });
            }
            mods()
            $('#custom').prepend(`<button id="close2" class="modclass"><img src="img/b.svg"><div class="mod_title"><span>Back</span></div></button>`)
            $("#close2").click(function(){
                document.getElementById("custom").innerHTML = '';
                setTimeout(function(){
                    ShowSubmenu(backdata2)
                    $.post("https://renzu_customs/closedoor", JSON.stringify({ }), function(d) {})
                }, 100);
            });
        }, 100);
    });
}

function GetMod(index) {
    $.post("https://renzu_customs/GetMod", JSON.stringify({ index: index}), function(data) {
        return data 
    });
}

function SetWheelColor(index) {
    //document.getElementById("cost").innerHTML = totalcost;
    $.post("https://renzu_customs/SetWheelColor", JSON.stringify({ index: index}));
}

var lastcost = {}
function multicost(i,cost,lvl) {
    multi[i] = cost * lvl
    if (lastcost[i] == undefined) {
        lastcost[i] = lvl
    }
    return multi[i]
}

function SetMod(index,lvl,cost,wheeltype,label,multi) {
    if (modindex !== index && upgraded[index] == undefined && lvl > 0 || upgraded[index] == undefined && lvl > 0 ) {
        if (!multi) {
            totalcost = totalcost + cost
        }
        modindex = index
        upgraded[index] = lvl
    }
    if (multi && lvl > 0) {
        if (lastcost[index]) {
            totalcost = totalcost - cost * lastcost[index]
            lastcost[index] = undefined
        }
        totalcost = totalcost + multicost(index,cost,lvl)
    }
    addbill(label,cost,totalcost,index)
    if (lvl == 0 && lvladd > 0) {
        modindex = -1
        upgraded[index] = undefined
        if(!multi) {
            totalcost = totalcost - cost
        } else if (lastcost[index]) {
            totalcost = totalcost - cost * lastcost[index]
            lastcost[index] = undefined
        }
        removebill(label,totalcost,index)
    }
    lvladd = lvl
    document.getElementById("cost").innerHTML = totalcost.toFixed(1);
    $.post("https://renzu_customs/SetMod", JSON.stringify({ index: index, lvl: lvl, wheeltype: wheeltype}));
}

var oldpaint = undefined
function SetPaint(type,i,cost) {
    if (upgraded[type] == undefined) {
        totalcost = totalcost + cost
        upgraded[type] = i
        addbill('Paint',cost,totalcost,1,'Paint')
        $.post("https://renzu_customs/GetPaint", JSON.stringify({}), function(data) {
            if (type == 'Primary Color') {
                oldpaint = data[0]
            } else {
                oldpaint = data[1]
            }
        });
    }
    if (oldpaint == i) {
        upgraded[type] = undefined
        totalcost = totalcost - cost
        removebill('Paint',totalcost,'Paint')
    }
    document.getElementById("cost").innerHTML = totalcost.toFixed(1);
    $.post("https://renzu_customs/SetPaint", JSON.stringify({ index: i, type: type}));
}

function close() {
    ShowSubmenu(backdata)
}

function close2() {
    ShowIndexMenu(backdata2[0],backdata2[1])
}

function ShowMod(data) {
    backdata = data
    var datas = []
    $.post("https://renzu_customs/Reset", JSON.stringify({}));
    for(const [k,v] of Object.entries(data)) {
        datas[k] = v
        $('#custom').append(`<button id="`+k.replace(/[^a-z0-9]/gi,'')+`" class="modclass"><img src="img/`+v.index+`.svg"><div class="mod_title"><span>`+k+`</span></div></button>`)
        $("#"+k.replace(/[^a-z0-9]/gi,'')+"").click(function(){
            ShowSubmenu(datas[k])
        });
    }
}

function pay() {
    document.getElementById("custom").innerHTML = '';
    document.getElementById("money").innerHTML = '';
    document.getElementById('invoice').style.display = 'none';
    document.getElementById('perf').style.display = 'none';
    document.getElementById("invoicelist").innerHTML = '';
    document.getElementById("cost").innerHTML = '';
    document.getElementById("totalcost2").innerHTML = '';
    $.post('https://renzu_customs/pay', JSON.stringify({cost:totalcost}), function(data) {
        window.location.reload(false)
    }) 
}

function invoice() {
    document.getElementById("invoice").style.display = 'block';
}

var modcache = {}
window.addEventListener('message', function(event) {
    var data = event.data;
    if (event.data.type == "stats") {
        if (event.data.show) {
            totalcost = 0
            document.getElementById("perf").style.display = 'block';
        } else {
            totalcost = 0
            document.getElementById("perf").style.display = 'none';
            document.getElementById("money").innerHTML = '';
            document.getElementById("invoicelist").innerHTML = '';
            document.getElementById("totalcost2").innerHTML = '';
            document.getElementById("cost").innerHTML = '';
            document.getElementById("totalcost2").innerHTML = '';
            window.location.reload(false)
        }
    }
    if (event.data.type == 'playsound') {
        playsound(event.data.content)
    }
    if (event.data.type == "custom") {
        if (event.data.show) {
            if (event.data.vehicle_health < 1000) {
                modcache = event.data.custom
                document.getElementById("repair").style.display = 'block';
                document.getElementById("money").innerHTML = event.data.money;
            } else {
                document.getElementById("perf").style.display = 'block';
                document.getElementById("money").innerHTML = event.data.money;
                ShowMod(event.data.custom)
            }
            console.log(event.data.shop)
            document.getElementById("shopname").innerHTML = event.data.shop;
        } else {
            document.getElementById("perf").style.display = 'none';
            totalcost = 0
            document.getElementById("perf").style.display = 'none';
            document.getElementById("money").innerHTML = '';
            document.getElementById("invoicelist").innerHTML = '';
            document.getElementById("totalcost2").innerHTML = '';
            document.getElementById("cost").innerHTML = '';
            document.getElementById("totalcost2").innerHTML = '';
            window.location.reload(false)
        }
    }

    if (event.data.custompaint) {
        document.getElementById("custompaint").style.display = 'block';
        custompaint = document.querySelector("#custompaint");
        custompaint.addEventListener("input", SetCustomPaint, false);
        custompaint.addEventListener("change", SetCustomPaint, false);
    }

});

function Repair() {
    $.post('https://renzu_customs/repair', JSON.stringify({}), function(bool) {
        if (bool) {
            document.getElementById("repair").style.display = 'none';
            document.getElementById("perf").style.display = 'block';
            ShowMod(modcache)
        } else {
            document.getElementById("repair").style.display = 'none';
            document.getElementById("perf").style.display = 'none';
            window.location.reload(false)
        }
    }) 
}

function custompaintdone() {
    document.getElementById("custompaint").style.display = 'none';
    $.post("https://renzu_customs/CustomPaintDone", JSON.stringify({ }));
}

function SetCustomPaint(event) {
    $.post("https://renzu_customs/CustomPaint", JSON.stringify({ r: hexToRgb(event.target.value).r, g:hexToRgb(event.target.value).g, b:hexToRgb(event.target.value).b}));
}

var scrollAmount = 0

$(document).on('keydown', function(event) {
    switch(event.keyCode) {
        case 27: // ESC
            document.getElementById("custom").innerHTML = '';
            $.post('https://renzu_customs/Close');
            break;
        case 9: // TAB
            break;
        case 17: // TAB
            break;
    }
});