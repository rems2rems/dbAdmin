// Generated by CoffeeScript 1.9.2
(function() {
  module.exports = {
    _id: '_design/beehouses',
    views: {
      all: {
        map: (function(doc) {
          if (doc.type === "beehouse") {
            return emit(doc._id, doc);
          }
        }).toString()
      },
      by_name: {
        map: (function(doc) {
          if (doc.type === "beehouse") {
            return emit(doc.name, doc);
          }
        }).toString()
      },
      by_apiary: {
        map: (function(doc) {
          if (doc.type === "beehouse" && (doc.apiary_id != null)) {
            return emit(doc.apiary_id, doc);
          }
        }).toString()
      },
      by_location: {
        map: (function(doc) {
          if (doc.type === "beehouse" && (doc.location_id != null)) {
            return emit(doc.location_id, doc);
          }
        }).toString()
      }
    }
  };

}).call(this);
