(function() {
  $(function() {
    var getThrobber, throbber;
    getThrobber = function(id) {
      var img, img_div;
      img = document.createElement('img');
      img.setAttribute('src', '/assets/throbber.gif');
      img.setAttribute('alt', 'loading...');
      img_div = document.createElement('div');
      img_div.setAttribute('id', id);
      img_div.setAttribute('class', 'icon-container');
      img_div.innerHTML = img.outerHTML;
      return img_div;
    };
    throbber = getThrobber;
    return $('#wiki-btn').click(function() {
      return $('#wiki-btn').replaceWith(throbber);
    });
  });

}).call(this);
