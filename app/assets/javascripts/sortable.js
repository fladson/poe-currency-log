document.addEventListener("turbolinks:load", function(){
  var el = document.getElementById('sortable');
  if(el) {
    var sortable = Sortable.create(el, {
      handle: '.feather-move',
      animation: 150,

      onUpdate: function (evt) {
        [].forEach.call(evt.from.getElementsByClassName('sort'), function (el, index) {
          el.setAttribute("value", index);
        });
      },
    });
  }
});
