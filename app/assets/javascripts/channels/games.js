//= require cable
//= require_self
//= require_tree .

/* Defines client-side instance of our WebSocket*/
this.App = {};

App.cable = ActionCable.createConsumer(); 