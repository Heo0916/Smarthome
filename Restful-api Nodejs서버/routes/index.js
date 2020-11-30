var async = require("async");
var mysql = require("mysql");
var fs = require("fs");

module.exports = function(app, pool) {

// 공기청정기
    app.post("/air", function(req, res) {
        	var result = {};
        	var dust1 = null;
	var dust2 = null;
	var temp = null;
	var hum = null;
	var speed = null;
	var co = null;
        async.waterfall([
        function(callback) {
            	dust1 = mysql.escape(req.body.dust1);
	    dust2 = mysql.escape(req.body.dust2);
	    temp = mysql.escape(req.body.temp);
	    hum = mysql.escape(req.body.hum);
	    speed = mysql.escape(req.body.speed);
	    co = mysql.escape(req.body.co);

            callback();
        },
        function(callback) {
            if (dust1 == undefined) {
                callback(new Error("Dust1 is empty."));
	    } else if (dust2 == undefined) {
		callback(new Error("Dust2 is empty."));
            } else if (temp == undefined) {
		callback(new Error("Temp is empty."));
	    } else if (hum == undefined) {
		callback(new Error("Hum is empty."));
	    } else if (speed == undefined) {
		callback(new Error("Speed is empty."));
	    }else if (co == undefined) {
		callback(new Error("Co is empty."));
	    } else {
                // db에 연결하여 sql 수행
                pool.getConnection(function(err, conn) {
                    // title 정보를 DB에 넣기 위한 SQL문 준비
                    var sql = "INSERT INTO air (dust1, dust2, temp, hum, speed) VALUES (" + dust1 + "," + dust2 + "," + temp + "," + hum + "," + speed + "," + co +");";
                    console.log("SQL: " + sql);
                    conn.query(sql, function(err) {
                        if (err) {
                            // err가 떠도 conn은 release() 꼭 해주어야한다.
                            conn.release();
                            callback(err);
                        } else {
                            conn.release();
                            callback();
                        }
                    });
                });
            }
        }],
        function(err) {
            result = returnResult(err, res)
            result.status = res.statusCode;
            res.send(result);
        });
    });

    app.get("/getair", function(req, res) {
        var result = {};

        // db에 연결하여 sql 수행
        pool.getConnection(function(err, conn) {
            var sql = "SELECT dust1, dust2, temp, hum, speed, co, date_format(date, '%Y-%m-%d %H:%m:%s') as date from air order by num desc limit 1;";
	    //console.log("SQL: " + sql);
            conn.query(sql, function(err, rows) {
                var result = returnResult(err, res);
                if (rows) {
                    result = rows;
                }
                conn.release();
                //result.status = res.statusCode;
                res.send(result);
            });
        });
    });

    app.get("/getairspeed", function(req, res) {
        var result = {};

        // db에 연결하여 sql 수행
        pool.getConnection(function(err, conn) {
            var sql = "SELECT speed from air order by num desc limit 1;";
            conn.query(sql, function(err, rows) {
                var result = returnResult(err, res);
                if (rows) {
                    result = rows;
                }
                conn.release();
                res.send(result);
            });
        });
    });

    app.put("/control/:id", function(req, res) {
        var result = {};
	var id = req.params.id;
	var speed = null;
        async.waterfall([
        function(callback) {
	    speed = mysql.escape(req.body.speed);
            callback();
        },
        function(callback) {
	    if (speed == undefined) {
                callback(new Error("speed is empty."));
            } else {
                // db에 연결하여 sql 수행
                pool.getConnection(function(err, conn) {
                    // title 정보를 업데이트 하기 위한 SQL
                    var sql = "UPDATE board" +id+ " SET speed=" + speed +" order by num desc limit 1;";
                    console.log("SQL: " + sql);
                    conn.query(sql, function(err) {
                        if (err) {
                            // err가 떠도 conn은 release() 꼭 해주어야한다.
                            conn.release();
                            callback(err);
                        } else {
                            conn.release();
                            callback();
                        }
                    });
                });
            }
        }],
        function(err) {
            result = returnResult(err, res)
            res.send(result);
        });
    });
    app.put("/controlairspeed/:speed", function(req, res) {
        var result = {};
	var speed = req.params.speed;
        async.waterfall([
        function(callback) {
	    //speed = mysql.escape(req.body.speed);
            callback();
        },
        function(callback) {
                // db에 연결하여 sql 수행
                pool.getConnection(function(err, conn) {
                    // title 정보를 업데이트 하기 위한 SQL
                    var sql = "UPDATE air SET speed=" + speed +" order by num desc limit 1;";
                    console.log("SQL: " + sql);
                    conn.query(sql, function(err) {
                        if (err) {
                            // err가 떠도 conn은 release() 꼭 해주어야한다.
                            conn.release();
                            callback(err);
                        } else {
                            conn.release();
                            callback();
                        }
                    });
                });

        }],
        function(err) {
            result = returnResult(err, res)
            res.send(result);
        });
    });

// 선풍기 Restfulapi Setting
app.post("/fan", function(req, res) {
      var result = {};
      var onoff = null;
      var speed = null;
      var timer = null;
    async.waterfall([
    function(callback) {
  onoff = mysql.escape(req.body.onoff);
  speed = mysql.escape(req.body.speed);
  timer = mysql.escape(req.body.timer);
      callback();
    },
    function(callback) {
        if (onoff == undefined) {
            callback(new Error("Onoff is empty."));
  } else if (speed == undefined) {
callback(new Error("Speed is empty."));
} else if (timer == undefined) {
callback(new Error("Timer is empty."));
  } else {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 DB에 넣기 위한 SQL문 준비
                var sql = "INSERT INTO fan (onoff, speed, timer) VALUES (" + onoff + "," + speed + "," + timer +");";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });
        }
    }],
    function(err) {
        result = returnResult(err, res)
        result.status = res.statusCode;
        res.send(result);
    });
});

app.get("/getfan", function(req, res) {
    var result = {};

    // db에 연결하여 sql 수행
    pool.getConnection(function(err, conn) {
        var sql = "SELECT * from fan order by num desc limit 1;";
  //console.log("SQL: " + sql);
        conn.query(sql, function(err, rows) {
            var result = returnResult(err, res);
            if (rows) {
                result = rows;
            }
            conn.release();
            //result.status = res.statusCode;
            res.send(result);
        });
    });
});

app.get("/getfanonoff", function(req, res) {
    var result = {};

    // db에 연결하여 sql 수행
    pool.getConnection(function(err, conn) {
        var sql = "SELECT onoff from fan order by num desc limit 1;";
        conn.query(sql, function(err, rows) {
            var result = returnResult(err, res);
            if (rows) {
                result = rows;
            }
            conn.release();
            res.send(result);
        });
    });
});
app.get("/getfantimer", function(req, res) {
    var result = {};

    // db에 연결하여 sql 수행
    pool.getConnection(function(err, conn) {
        var sql = "SELECT timer from fan order by num desc limit 1;";
        conn.query(sql, function(err, rows) {
            var result = returnResult(err, res);
            if (rows) {
                result = rows;
            }
            conn.release();
            res.send(result);
        });
    });
});
app.put("/controlfantimer/:timer", function(req, res) {
    var result = {};
var timer = req.params.timer;
    async.waterfall([
    function(callback) {
  //speed = mysql.escape(req.body.speed);
        callback();
    },
    function(callback) {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 업데이트 하기 위한 SQL
                var sql = "UPDATE fan SET timer=" + timer +" order by num desc limit 1;";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });

    }],
    function(err) {
        result = returnResult(err, res)
        res.send(result);
    });
});

app.put("/controlfanonoff/:onoff", function(req, res) {
    var result = {};
var onoff = req.params.onoff;
    async.waterfall([
    function(callback) {
  //speed = mysql.escape(req.body.speed);
        callback();
    },
    function(callback) {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 업데이트 하기 위한 SQL
                var sql = "UPDATE fan SET onoff=" + onoff +" order by num desc limit 1;";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });

    }],
    function(err) {
        result = returnResult(err, res)
        res.send(result);
    });
});


app.put("/controlfanspeed/:speed", function(req, res) {
    var result = {};
var speed = req.params.speed;
    async.waterfall([
    function(callback) {
  //speed = mysql.escape(req.body.speed);
        callback();
    },
    function(callback) {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 업데이트 하기 위한 SQL
                var sql = "UPDATE fan SET speed=" + speed +" order by num desc limit 1;";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });

    }],
    function(err) {
        result = returnResult(err, res)
        res.send(result);
    });
});
// 로그인
app.post("/join", function(req, res) {
      var result = {};
      var userID = null;
      var userPassword = null;
      var userName = null;
      var userEmail = null;
    async.waterfall([
    function(callback) {
  userID = mysql.escape(req.body.userID);
  userPassword = mysql.escape(req.body.userPassword);
  userName = mysql.escape(req.body.userName);
  userEmail = mysql.escape(req.body.userEmail);
      callback();
    },
    function(callback) {
        if (userID == undefined) {
            callback(new Error("userID is empty."));
  } else if (userPassword == undefined) {
callback(new Error("userPassword is empty."));
} else if (userName == undefined) {
callback(new Error("userName is empty."));
}else if (userEmail == undefined) {
  callback(new Error("userEmail is empty."));
}else {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 DB에 넣기 위한 SQL문 준비
                var sql = "INSERT INTO user (userID, userPassword, userName, userEmail) VALUES (" + userID + "," + userPassword + "," + userName + "," + userEmail + ");";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });
        }
    }],
    function(err) {
        result = returnResult(err, res)
        result.status = res.statusCode;
        res.send(result);
    });
});
app.get("/login", function(req, res) {
    var result = {};

    // db에 연결하여 sql 수행
    pool.getConnection(function(err, conn) {
        var sql = "SELECT userPassword from user WHERE userID=?";
        conn.query(sql, function(err, rows) {
            var result = returnResult(err, res);
            if (rows) {
                result = rows;
            }
            conn.release();
            res.send(result);
        });
    });
});
// 블라인드
app.post("/blind", function(req, res) {
      var result = {};
      var level = null;
    async.waterfall([
    function(callback) {
          level = mysql.escape(req.body.level);
        callback();
    },
    function(callback) {
        if (level == undefined) {
            callback(new Error("level is empty."));
  } else {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 DB에 넣기 위한 SQL문 준비
                var sql = "INSERT INTO blind (level) VALUES (" + level +");";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });
        }
    }],
    function(err) {
        result = returnResult(err, res)
        result.status = res.statusCode;
        res.send(result);
    });
});
 app.get("/getblind", function(req, res) {
    var result = {};

    // db에 연결하여 sql 수행
    pool.getConnection(function(err, conn) {
        var sql = "SELECT level, open, close from blind order by num desc limit 1;";
  //console.log("SQL: " + sql);
        conn.query(sql, function(err, rows) {
            var result = returnResult(err, res);
            if (rows) {
                result = rows;
            }
            conn.release();
            //result.status = res.statusCode;
            res.send(result);
        });
    });
});
app.put("/controlblind/:level", function(req, res) {
    var result = {};
var level = req.params.level;
    async.waterfall([
    function(callback) {
  //speed = mysql.escape(req.body.speed);
        callback();
    },
    function(callback) {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 업데이트 하기 위한 SQL
                var sql = "UPDATE blind SET level=" + level +" order by num desc limit 1;";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });

    }],
    function(err) {
        result = returnResult(err, res)
        res.send(result);
    });
});
app.put("/controlblind1/:open", function(req, res) {
    var result = {};
var open = req.params.open;
    async.waterfall([
    function(callback) {
  //speed = mysql.escape(req.body.speed);
        callback();
    },
    function(callback) {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 업데이트 하기 위한 SQL
                var sql = "UPDATE blind SET open=" + open +" order by num desc limit 1;";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });

    }],
    function(err) {
        result = returnResult(err, res)
        res.send(result);
    });
});
app.put("/controlblind2/:close", function(req, res) {
    var result = {};
var close = req.params.close;
    async.waterfall([
    function(callback) {
  //speed = mysql.escape(req.body.speed);
        callback();
    },
    function(callback) {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 업데이트 하기 위한 SQL
                var sql = "UPDATE blind SET close=" + close +" order by num desc limit 1;";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });

    }],
    function(err) {
        result = returnResult(err, res)
        res.send(result);
    });
});

// 조명
app.post("/light", function(req, res) {
      var result = {};
      var onoff = null;

    async.waterfall([
    function(callback) {
          onoff = mysql.escape(req.body.onoff);
        callback();
    },
    function(callback) {
        if (onoff == undefined) {
            callback(new Error("onoff is empty."));

  } else {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 DB에 넣기 위한 SQL문 준비
                var sql = "INSERT INTO light (onoff) VALUES (" + onoff +");";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });
        }
    }],
    function(err) {
        result = returnResult(err, res)
        result.status = res.statusCode;
        res.send(result);
    });
});


  app.get("/getonoff", function(req, res) {
    var result = {};

    // db에 연결하여 sql 수행
    pool.getConnection(function(err, conn) {
        var sql = "SELECT onoff from light order by num desc limit 1;";
  //console.log("SQL: " + sql);
        conn.query(sql, function(err, rows) {
            var result = returnResult(err, res);
            if (rows) {
                result = rows;
            }
            conn.release();
            //result.status = res.statusCode;
            res.send(result);
        });
    });
});

app.put("/controllight/:on", function(req, res) {
    var result = {};
var on = req.params.on;
    async.waterfall([
    function(callback) {
  //speed = mysql.escape(req.body.speed);
        callback();
    },
    function(callback) {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 업데이트 하기 위한 SQL
                var sql = "UPDATE light SET onoff=" + on +" order by num desc limit 1;";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });

    }],
    function(err) {
        result = returnResult(err, res)
        res.send(result);
    });
});

app.put("/controllight/:off", function(req, res) {
    var result = {};
var off = req.params.off;
    async.waterfall([
    function(callback) {
  //speed = mysql.escape(req.body.speed);
        callback();
    },
    function(callback) {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 업데이트 하기 위한 SQL
                var sql = "UPDATE light SET off=" + off +" order by num desc limit 1;";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });

    }],
    function(err) {
        result = returnResult(err, res)
        res.send(result);
    });
});
// 스마트 미러 onoff
app.post("/mirror", function(req, res) {
      var result = {};
      var onoff = null;

    async.waterfall([
    function(callback) {
          onoff = mysql.escape(req.body.onoff);
        callback();
    },
    function(callback) {
        if (onoff == undefined) {
            callback(new Error("onoff is empty."));

  } else {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 DB에 넣기 위한 SQL문 준비
                var sql = "INSERT INTO mirror (onoff) VALUES (" + onoff +");";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });
        }
    }],
    function(err) {
        result = returnResult(err, res)
        result.status = res.statusCode;
        res.send(result);
    });
});

app.get("/mirror_onoff", function(req, res) {
  var result = {};

  // db에 연결하여 sql 수행
  pool.getConnection(function(err, conn) {
      var sql = "SELECT onoff from mirror order by num desc limit 1;";
//console.log("SQL: " + sql);
      conn.query(sql, function(err, rows) {
          var result = returnResult(err, res);
          if (rows) {
              result = rows;
          }
          conn.release();
          //result.status = res.statusCode;
          res.send(result);
      });
  });
});

app.put("/controlmirror/:off", function(req, res) {
    var result = {};
var off = req.params.off;
    async.waterfall([
    function(callback) {
  //speed = mysql.escape(req.body.speed);
        callback();
    },
    function(callback) {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 업데이트 하기 위한 SQL
                var sql = "UPDATE mirror SET onoff=" + off +" order by num desc limit 1;";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });

    }],
    function(err) {
        result = returnResult(err, res)
        res.send(result);
    });
});

app.put("/controlmirror/:on", function(req, res) {
    var result = {};
var on = req.params.on;
    async.waterfall([
    function(callback) {
  //speed = mysql.escape(req.body.speed);
        callback();
    },
    function(callback) {
            // db에 연결하여 sql 수행
            pool.getConnection(function(err, conn) {
                // title 정보를 업데이트 하기 위한 SQL
                var sql = "UPDATE mirror SET onoff=" + on +" order by num desc limit 1;";
                console.log("SQL: " + sql);
                conn.query(sql, function(err) {
                    if (err) {
                        // err가 떠도 conn은 release() 꼭 해주어야한다.
                        conn.release();
                        callback(err);
                    } else {
                        conn.release();
                        callback();
                    }
                });
            });

    }],
    function(err) {
        result = returnResult(err, res)
        res.send(result);
    });
});


}



// 결과 마무리 확인
var returnResult = function(err, res) {
    // 결과를 눈으로 보기 쉽게하기 위해 result 객체 생성
    var result = {};
    if (err) {
        res.status(400);
        result.message = err.stack;
    } else {
        res.status(200);
        result.message = "Success";
    }
    return result;
}
