// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

import SimpleMDE from "simplemde"

import $ from "jquery"

import "./bootstrap-tagsinput.min.js"

document.addEventListener("DOMContentLoaded", ()=> {
  let simplemde = new SimpleMDE({ element: document.getElementById("markdownEditor") });
});

let input = $('input#post_tags');
input.on('beforeItemAdd', function(event) {
   let csrf_token = $("input[name='_csrf_token']").val();
   $.ajax({
    method: "POST",
    url: "/tags",
    data: JSON.stringify({tag:{ name: event.item}, _csrf_token: csrf_token}),
    contentType:"application/json; charset=utf-8",
    dataType:"json",
    error: function(e){
      input.tagsinput('remove', event.item, {preventPost: true});
    },
    success: function(res){
//      input.tagsinput('add', { id: res.data.id, text: res.data.name }, {preventPost: true});
    }
    })
});

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
