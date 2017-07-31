/* Define the subscription to the channel (pieces) for the client/consumer.
When subscribed, can stream data that is broadcasted to the channel(piece controller #update)*/

App.pieces = App.cable.subscriptions.create('PiecesChannel', {
  received: function(data) {
    //console.log(this.renderMessage(data)); //check console of other player to see that data did pass through
    alert("Other Player has made a move. Page will now reload");
   //return window.location.reload(true);  //can refresh windows for now, possibly later use jquery to append DOM 
  },

  /*renderMessage: function(data) {
    return data.type + " " + data.color + "  row: " + data.row + " column: " + data.column;
  }*/
});