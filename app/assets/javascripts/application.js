// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.placeholder
//= require jquery.jcrop
//= require bootstrap
//= require app
//= require coaches

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}

function addToFavorite(url, title) {
  var ctrl = (navigator.userAgent.toLowerCase()).indexOf('mac') !=-1 ? 'Command/Cmd' : 'CTRL';
  if(document.all){
    window.external.addFavorite(url, title);
  } else if (window.sidebar) {
     window.sidebar.addPanel(title, utl, "");
  } else{ 
    alert('您可以通过快捷键' + ctrl + ' + D 加入到收藏夹');
  }
  return false;
}