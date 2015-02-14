// function hotPush(){

  var pusher = new Pusher('451746bcbc1805eb6993');
  var channel = pusher.subscribe('hot_channel');
  var s = document.createElement("style");
  channel.bind('css', function(data) {
    css = data.css;
    s.innerHTML = css;
    document.getElementsByTagName("head")[0].appendChild(s);
  });

// }
