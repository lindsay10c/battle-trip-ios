
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

// alert on hit
Parse.Cloud.define('pushhit', function(req, res){
	var bullseyeId = req.params.bullseyeId;
	console.log(bullseyeId);
	console.log(req.params);
	var text = "It's a hit"
	var Bullseye = Parse.Object.extend("Bullseye");
	var query = new Parse.Query(Bullseye);
	query.get(bullseyeId, {
		success: function(bullseye) {
	  	var radius = bullseye.get('radius');
	  	if(radius > 0){
	  		text += ", but it's still sailing!";
	  	} else {
	  		text += ", and the ship's been sunk!";
	  	}

	  	Parse.Push.send({
			channels: ["global"],
			data: {
			  alert: text
			},
			success: function() {
			  // Push was successful
			  console.log('push sent successfully!');
			},
			error: function(error) {
			  throw "Got an error " + error.code + " : " + error.message;
			}
		});
	  },
	  error: function(object, error) {
	    // The object was not retrieved successfully.
	    // error is a Parse.Error with an error code and message.
	    console.log(error);
	    console.log('hit error');
	  }
	});

});





// alert on hit
Parse.Cloud.define('pushmiss', function(req, res){
	var text = "Aw, you missed! Better luck next time!";

	Parse.Push.send({
		channels: ["global"],
		data: {
		  alert: text
		},
		success: function() {
		  // Push was successful
		  console.log('push sent successfully!');
		},
		error: function(error) {
		  throw "Got an error " + error.code + " : " + error.message;
		}
	});
});




