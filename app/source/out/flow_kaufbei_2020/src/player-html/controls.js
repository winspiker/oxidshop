/**
 * @license
 * Copyright 2016 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



/**
 * A container for custom video controls.
 * @constructor
 * @suppress {missingProvide}
 */
function ShakaControls() {

  /** @private {?function(!shaka.util.Error)} */
  this.onError_ = null;

  /** @private {HTMLMediaElement} */
  this.video_ = null;

  /** @private {shaka.Player} */
  this.player_ = null;

  /** @private {Element} */
  this.videoContainer_ = document.getElementById('videoContainer');

  /** @private {Element} */
  this.controls_ = document.getElementById('controls');

  /** @private {Element} */
  this.playPauseButton_ = document.getElementById('playPauseButton');

  /** @private {Element} */
  this.muteButton_ = document.getElementById('muteButton');

  /** @private {Element} */
  this.volumeBar_ = document.getElementById('volumeBar');

  /** @private {Element} */
  this.fullscreenButton_ = document.getElementById('fullscreenButton');

  /** @private {Element} */
  this.bufferingSpinner_ = document.getElementById('bufferingSpinner');

  /** @private {Element} */
  this.giantPlayButtonContainer_ =
      document.getElementById('giantPlayButtonContainer');

  /** @private {number} */
  this.trickPlayRate_ = 1;

  /** @private {?number} */
  this.seekTimeoutId_ = null;

  /** @private {?number} */
  this.mouseStillTimeoutId_ = null;
}


/**
 * Initializes the player controls.
 */
ShakaControls.prototype.init = function(video, player) {
  this.initMinimal(video, player);

  // IE11 doesn't treat the 'input' event correctly.
  // https://connect.microsoft.com/IE/Feedback/Details/856998
  // If you know a better way than a userAgent check to handle this, please
  // send a patch.
  var sliderInputEvent = 'input';
  // This matches IE11, but not Edge.  Edge does not have this problem.
  if (navigator.userAgent.indexOf('Trident/') >= 0) {
    sliderInputEvent = 'change';
  }

  this.playPauseButton_.addEventListener(
      'click', this.onPlayPauseClick_.bind(this));
  this.video_.addEventListener(
      'play', this.onPlayStateChange_.bind(this));
  this.video_.addEventListener(
      'pause', this.onPlayStateChange_.bind(this));
  this.video_.addEventListener(
      'stop', this.onPlayStateChange_.bind(this));

  this.muteButton_.addEventListener(
      'click', this.onMuteClick_.bind(this));

  this.volumeBar_.addEventListener(
      sliderInputEvent, this.onVolumeInput_.bind(this));
  this.video_.addEventListener(
      'volumechange', this.onVolumeStateChange_.bind(this));
  // initialize volume display with a fake event
  this.onVolumeStateChange_();

  this.fullscreenButton_.addEventListener(
      'click', this.onFullscreenClick_.bind(this));

  this.videoContainer_.addEventListener(
      'touchstart', this.onContainerTouch_.bind(this));
  this.videoContainer_.addEventListener(
      'click', this.onPlayPauseClick_.bind(this));

  // Clicks in the controls should not propagate up to the video container.
  this.controls_.addEventListener(
      'click', function(event) { event.stopPropagation(); });

  this.videoContainer_.addEventListener(
      'mousemove', this.onMouseMove_.bind(this));
  this.videoContainer_.addEventListener(
      'mouseout', this.onMouseOut_.bind(this));
};


/**
 * Initializes minimal player controls.  Used on both sender (indirectly) and
 * receiver (directly).
 * @param {HTMLMediaElement} video
 * @param {shaka.Player} player
 */
ShakaControls.prototype.initMinimal = function(video, player) {
  this.video_ = video;
  this.player_ = player;
  if(player) {
    this.player_.addEventListener(
        'buffering', this.onBufferingStateChange_.bind(this));
  }
};


/**
 * Used by the application to notify the controls that a load operation is
 * complete.  This allows the controls to recalculate play/paused state, which
 * is important for platforms like Android where autoplay is disabled.
 */
ShakaControls.prototype.loadComplete = function() {
  // If we are on Android or if autoplay is false, video.paused should be true.
  // Otherwise, video.paused is false and the content is autoplaying.
  this.onPlayStateChange_();
};


/**
 * Hiding the cursor when the mouse stops moving seems to be the only decent UX
 * in fullscreen mode.  Since we can't use pure CSS for that, we use events both
 * in and out of fullscreen mode.
 * @private
 */
ShakaControls.prototype.onMouseMove_ = function() {
  // Use the cursor specified in the CSS file.
  this.videoContainer_.style.cursor = '';
  // Show the controls.
  this.controls_.style.opacity = 1;

  // Hide the cursor when the mouse stops moving.
  // Only applies while the cursor is over the video container.
  if (this.mouseStillTimeoutId_) {
    // Reset the timer.
    window.clearTimeout(this.mouseStillTimeoutId_);
  }
  this.mouseStillTimeoutId_ = window.setTimeout(
      this.onMouseStill_.bind(this), 3000);
};


/** @private */
ShakaControls.prototype.onMouseOut_ = function() {
  // Expire the timer early.
  if (this.mouseStillTimeoutId_) {
    window.clearTimeout(this.mouseStillTimeoutId_);
  }
  // Run the timeout callback to hide the controls.
  // If we don't, the opacity style we set in onMouseMove_ will continue to
  // override the opacity in CSS and force the controls to stay visible.
  this.onMouseStill_();
};


/** @private */
ShakaControls.prototype.onMouseStill_ = function() {
  // The mouse has stopped moving.
  this.mouseStillTimeoutId_ = null;
  // Hide the cursor.  (NOTE: not supported on IE)
  this.videoContainer_.style.cursor = 'none';
  // Revert opacity control to CSS.  Hovering directly over the controls will
  // keep them showing, even in fullscreen mode.
  this.controls_.style.opacity = '';
};


/**
 * @param {!Event} event
 * @private
 */
ShakaControls.prototype.onContainerTouch_ = function(event) {
  if (!this.video_.duration && this.player_) {
    // Can't play yet.  Ignore.
    return;
  }

  this.onMouseMove_();

  if (this.controls_.style.opacity == 1) {
    // The controls are showing.
    // Let this event continue and become a click.
  } else {
    // The controls are hidden, so show them.
    // Stop this event from becoming a click event.
    event.preventDefault();
  }
};


/** @private */
ShakaControls.prototype.onPlayPauseClick_ = function() {
/*  if (!this.video_.duration && this.player_) {
    // Can't play yet.  Ignore.
    return;
  } */

//  this.player_.cancelTrickPlay();
//  this.trickPlayRate_ = 1;

  if (this.video_.paused) {
    console.log(dashUri);
    if(this.player_) {
      this.player_.load(dashUri).then(function() {
        console.log('The video has now been loaded!');
      }).catch(onError);
      this.onPlayStateChange_();
    }
    this.video_.play();
  } else {
    this.video_.pause();
    if(this.player_) {
      this.player_.unload();
      this.onPlayStateChange_();
    }
    //this.video_.currentTime = 0;
  }
};


/** @private */
ShakaControls.prototype.onPlayStateChange_ = function() {
  // Video is paused during seek, so don't show the play arrow while seeking:
  if (this.video_.paused && !this.isSeeking_) {
    this.playPauseButton_.textContent = 'play_arrow';
    this.giantPlayButtonContainer_.style.display = 'inline';
  } else {
    this.playPauseButton_.textContent = 'pause';
    this.giantPlayButtonContainer_.style.display = 'none';
  }
};


/** @private */
ShakaControls.prototype.onMuteClick_ = function() {
  this.video_.muted = !this.video_.muted;
};


/**
 * Updates the controls to reflect volume changes.
 * @private
 */
ShakaControls.prototype.onVolumeStateChange_ = function() {
  if (this.video_.muted) {
    this.muteButton_.textContent = 'volume_off';
    this.volumeBar_.value = 0;
  } else {
    this.muteButton_.textContent = 'volume_up';
    this.volumeBar_.value = this.video_.volume;
  }

  var gradient = ['to right'];
  gradient.push('#ccc ' + (this.volumeBar_.value * 100) + '%');
  gradient.push('#000 ' + (this.volumeBar_.value * 100) + '%');
  gradient.push('#000 100%');
  this.volumeBar_.style.background =
      'linear-gradient(' + gradient.join(',') + ')';
};


/** @private */
ShakaControls.prototype.onVolumeInput_ = function() {
  this.video_.volume = parseFloat(this.volumeBar_.value);
  this.video_.muted = false;
};


/** @private */
ShakaControls.prototype.onFullscreenClick_ = function() {
  if (document.fullscreenElement) {
    if (document.exitFullscreen) {
        document.exitFullscreen();
    } else if (document.mozExitFullscreen) {
        document.mozExitFullscreen();
    } else if (document.webkitExitFullscreen) {
        document.webkitExitFullscreen();
    } else if (document.cancelFullScreen) {
        document.cancelFullScreen()
    } else if (document.mozCancelFullScreen) {
        document.mozCancelFullScreen()
    } else if (document.webkitCancelFullScreen) {
        document.webkitCancelFullScreen()
    }
    //screen.orientation.unlock();
  } else {
    if (this.videoContainer_.requestFullScreen) {
      this.videoContainer_.requestFullScreen();
    } else if (this.videoContainer_.mozRequestFullScreen) {
      this.videoContainer_.mozRequestFullScreen();
    } else if (this.videoContainer_.webkitRequestFullScreen) {
      this.videoContainer_.webkitRequestFullScreen();
    } else if (this.videoContainer_.webkitEnterFullscreen){
      this.videoContainer_.webkitEnterFullscreen();
    } else if (this.video_.webkitRequestFullScreen) {
      this.video_.webkitRequestFullScreen();
    } else if (this.video_.webkitEnterFullScreen) {
      this.video_.webkitEnterFullScreen();
    } else {
    }
    //screen.orientation.lock('landscape');
  }
};


/**
 * @param {Event} event
 * @private
 */
ShakaControls.prototype.onBufferingStateChange_ = function(event) {
//  console.log(event);
//  console.log(this.player_);
  this.bufferingSpinner_.style.display =
      event.buffering ? 'inherit' : 'none';
};


