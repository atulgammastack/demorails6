var ready = function () {
  $(".start-conversation").on('click', function(event) {
    var sender_id = $(this).data('sid');
    var recipient_id = $(this).data('rip');
     $.post("/conversations", { sender_id: sender_id, recipient_id: recipient_id });
    
  });
}
$(document).ready(ready);
$(document).on("page:load", ready);
