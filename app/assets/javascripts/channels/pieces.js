/* Define the subscription to the channel (pieces) for the client/consumer.
When subscribed, can stream data that is broadcasted to the channel(piece controller #update)*/

App.pieces = App.cable.subscriptions.create('PiecesChannel', {
  received: function(data) {
    return console.log(this.renderMessage(data));
    /*return window.location.reload(true); can refresh windows through, only pass data and use jquery to append DOM */
  },

  renderMessage: function(data) {
    return data.type + " " + data.color + "  row: " + data.row + " column: " + data.column;
  }
});