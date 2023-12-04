import consumer from "channels/consumer"

consumer.subscriptions.create({channel: 'CommentsChannel', question_id: gon.question_id}, {
  received(data) {

    let id = data.commentable_id;
    
    if (data.commentable_type === 'Question') {
      $('.question_comments').append(data['partial']);
    } else {
      $(`[answer-id=${id}]`).append(data['partial']);
    }
  }
})
