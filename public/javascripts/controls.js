$(document).ready(function() {
  bind_control('.uncover-button',function(box) { box.uncoverAll(); });
  bind_control('.shuffle-button',function(box) { box.shuffle(); });

  // TODO: can be done smarter - check again when online
  $('.browse-button').click(function() { 
      $(this).parent().next().object().pack_unpack();
   });
  bind_control('.close-button',function(box) { box.pack_unpack(this); });
});


function bind_control(name, action) {
 $(name).click(function(event) {
    action($(this).closest('.box').object());
    event.preventDefault();
    event.stopPropagation();
  });
}