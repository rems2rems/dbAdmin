// Generated by CoffeeScript 1.10.0
(function() {
  var Promise;

  Promise = require('promise');

  module.exports = function(db, apiary, model, name) {
    var beeProm, beehouse, modelProm;
    modelProm = db.save(model);
    beehouse = {
      _id: "beehouse:" + name,
      name: name,
      type: "beehouse",
      apiary_id: apiary != null ? apiary._id : void 0,
      model_id: model._id,
      number_of_extra_boxes: 0
    };
    beeProm = db.save(beehouse);
    return Promise.all([modelProm, beeProm]).then(function() {
      return [db, apiary, beehouse];
    });
  };

}).call(this);
