$(document).ready(function(){
	$(window).load(function(){
    setTimeout(function(){
      $("#alert").fadeOut()
    }, 8000);
    setTimeout(function(){
      $("#notice").fadeOut()
    }, 8000);
  });
});

init.push(function () {
	$('#blog_posts').dataTable();
	$('#blog_posts_wrapper .table-caption').text('Blog Posts');
	$('#blog_posts_wrapper .dataTables_filter input').attr('placeholder', 'Search...');

	$('#users').dataTable();
	$('#users_wrapper .table-caption').text('Users');
	$('#users_wrapper .dataTables_filter input').attr('placeholder', 'Search...');

	$('#admins').dataTable();
	$('#admins_wrapper .table-caption').text('Admins');
	$('#admins_wrapper .dataTables_filter input').attr('placeholder', 'Search...');

	$('#roles').dataTable();
	$('#roles_wrapper .table-caption').text('Roles');
	$('#roles_wrapper .dataTables_filter input').attr('placeholder', 'Search...');


	$('#tags').dataTable();
	$('#tags_wrapper .table-caption').text('Tags');
	$('#tags_wrapper .dataTables_filter input').attr('placeholder', 'Search...');

	$('.allowed_to_show').switcher({
		theme: 'square',
		on_state_content: 'YES',
		off_state_content: 'NO'
	});

	$('.allowed_to_show').on('change',function(){
    $('.allowed_to_show_form').submit();
  });

	$('.allowed_to_post').switcher({
		theme: 'square',
		on_state_content: 'YES',
		off_state_content: 'NO'
	});

	$('.allowed_to_post').on('change',function(){
    $('.allowed_to_post_form').submit();
  });

	$('.allowed_to_comment').switcher({
		theme: 'square',
		on_state_content: 'YES',
		off_state_content: 'NO'
	});

	$('.allowed_to_comment').on('change',function(){
    $('.allowed_to_comment_form').submit();
  });

	$('.allowed_to_post_admin').switcher({
		theme: 'square',
		on_state_content: 'YES',
		off_state_content: 'NO'
	});

	$('.allowed_to_post_admin').on('change',function(){
    $('.allowed_to_post_admin_form').submit();
  });

	$('.allowed_to_comment_admin').switcher({
		theme: 'square',
		on_state_content: 'YES',
		off_state_content: 'NO'
	});

	$('.allowed_to_comment_admin').on('change',function(){
    $('.allowed_to_comment_admin_form').submit();
  });

  // Add role validator
	$.validator.addMethod(
		"role_format",
		function(value, element) {
			var check = false;
			return this.optional(element) || /^[a-z_]*$/.test(value);
		},
		"Name can consists of only lowercase letters and _"
	);
});