import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}

console.log("hello world =======================")

$(document).ready(function() {
  $('#pills-aside-tab').on('click', function() {
    // Show MCX-related data when MCX button is clicked
    $('#pills-symbol').show();
    $('#pills-profile').show();
    $('#pills-low').show();
    $('#pills-high').show();
  });
});
