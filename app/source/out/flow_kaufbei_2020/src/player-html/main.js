function initApp() {
  // Install built-in polyfills to patch browser incompatibilities.
  shaka.polyfill.installAll();
  //shaka.log.setLevel(shaka.log.Level.DEBUG);

  console.log(document.createElement('video').canPlayType('application/vnd.apple.mpegURL'));

  if (shaka.Player.isBrowserSupported()) {
    initDash();
  } else
  if (document.createElement('video').canPlayType('application/vnd.apple.mpegURL') == 'maybe') {
    initHLS();
  } else {
    document.getElementById('videoContainer').innerHTML = 'Browser not supported!';
    console.error('Browser not supported!');
  }
}

function initHLS() {
  var video = document.getElementById('video');
  var source = document.createElement('source');

  source.setAttribute('src', hlsUri);

  video.appendChild(source);


  if(/iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream) {
    // IOS
    video.setAttribute("controls","controls");
    document.getElementById('giantPlayButtonContainer').style.display = 'block';
	  document.getElementById('video').style.display = 'none';
    document.getElementById('bufferingSpinner').style.display = 'none';
	  document.getElementById('giantPlayButtonContainer').addEventListener('click', function() {
		  document.getElementById('video').style.display = 'block';
		  document.getElementById('video').play();
		  document.getElementById('giantPlayButtonContainer').style.display = 'none';
	  });
	  
//    document.getElementById('controlsContainer').style.display = 'none';
  } else {
    var controls_ = new ShakaControls();
    controls_.init(video, false);
    controls_.onPlayStateChange_();
  }
  //video.play();
}

function initDash() {
  var video = document.getElementById('video');
  var player = new shaka.Player(video);

  window.player = player;

  player.addEventListener('error', onErrorEvent);

  var controls_ = new ShakaControls();
  controls_.init(video, player);

  player.load(dashUri).then(function() {
    console.log('The video has now been loaded!');
  }).catch(onError);
  controls_.onPlayStateChange_();
}

function onErrorEvent(event) {
  onError(event.detail);
}

function onError(error) {
  console.error('Error code', error.code, 'object', error);
}

document.addEventListener('DOMContentLoaded', initApp);

