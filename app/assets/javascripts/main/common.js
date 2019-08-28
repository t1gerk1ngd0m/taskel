$(function () {
  $('.alert-list').click(function() {
    $('.alerts').toggleClass("is_closed");
  });
  $(document).on('change', ':file', function() {
    var input = $(this),
    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    input.parent().parent().next(':text').val(label);
  });
});
