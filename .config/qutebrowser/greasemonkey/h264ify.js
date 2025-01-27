// ==UserScript==
// @name         YouTube h264ify
// @namespace    nikisby
// @version      1.0
// @description  Force H.264 playback on all YouTube videos (instead of VP8/VP9)
// @author       nikisby
// @match        http://youtube.com/*
// @match        https://youtube.com/*
// @match        http://www.youtube.com/*
// @match        https://www.youtube.com/*
// @run-at       document-start
// @require      https://raw.githubusercontent.com/erkserkserks/h264ify/master/src/inject/inject.js
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    localStorage['h264ify-enable'] = true;
    localStorage['h264ify-block_60fps'] = false;

    inject();
})();
