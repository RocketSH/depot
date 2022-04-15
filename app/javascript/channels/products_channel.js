//  All channels you create will import this file and use 'consumer' to create a subscription to the server.
import consumer from "./consumer";

consumer.subscriptions.create("ProductsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const storeElement = document.querySelector("main.store");
    if (storeElement) {
      storeElement.innerHTML = data.html;
      const new_product = document.querySelector("ul.catalog>li");
      new_product.classList.add("line-item-highlight");
    }
  },
});
