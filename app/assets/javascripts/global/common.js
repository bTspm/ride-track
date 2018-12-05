var common = {
  get: function(url, data, callback){
      $.get({
          url: url,
          data: data,
          success: callback
      })
  }
};
