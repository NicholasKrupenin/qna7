import consumer from "channels/consumer"

consumer.subscriptions.create("QuestionsChannel", {
  received(data) {
    $('.questions').append(data)
  }
});
