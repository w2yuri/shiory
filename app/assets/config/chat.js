$.ajax({
  type: 'DELETE',
  url: '/admin/chat_groups/' + messageId, // messageIdには削除するコメントのIDが入ります
  success: function(response) {
    if (response.success) {
      // フラッシュメッセージを表示するための処理
      alert(response.message);
    } else {
      // エラーメッセージを表示するための処理
      alert(response.message);
    }
  }
});