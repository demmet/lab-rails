// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require popper
//= require bootstrap-sprockets
//= require moip-sdk-js
//= require_tree .

createCreditCardHash = () => {
  let public_key = $("#textbox_public_key").val()
  let card_number = $("#card_number").val()
  let card_verification_code = $("#card_security_code").val()
  let card_expiration_date = $("#card_expiration_date").val().split("/")
  
  MoipSdkJs.MoipCreditCard
    .setPubKey(public_key)
    .setCreditCard({
        number: card_number,
        cvc: card_verification_code,
        expirationMonth: card_expiration_date[0],
        expirationYear: card_expiration_date[1]
    })
    .hash()
    .then(hash => $("#card_hash").val(hash))
}
