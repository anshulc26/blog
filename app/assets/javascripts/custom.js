// Search box toggle
// =================
$('#search-btn').on('click', function() {
	$("#search-icon").toggleClass('fa-search fa-times margin-2');
	$("#search-box").toggleClass('show hidden animated fadeInUp');
	return false;
});

// Smooth scrolling for UI elements page
// =====================================
$(document).ready(function(){
   $('a[href*=#buttons],a[href*=#panels], a[href*=#info-boards], a[href*=#navs], a[href*=#alerts], a[href*=#thumbnails], a[href*=#social], a[href*=#section-header],a[href*=#page-tip], a[href*=#block-header], a[href*=#tags]').bind("click", function(e){
	  var anchor = $(this);
	  $('html, body').stop().animate({
		 scrollTop: $(anchor.attr('href')).offset().top
	  }, 1000);
	  e.preventDefault();
   });
   return false;
});

// 404 error page smile
// ====================
$('#search-404').on('focus', function() {
	$("#smile").removeClass("fa-meh-o flipInX");
	$("#smile").addClass("fa-smile-o flipInY");
});

$('#search-404').on('blur', function() {
	$("#smile").removeClass("fa-smile-o flipInY");
	$("#smile").addClass("fa-meh-o flipInX");
});
// Sign up popovers
// ================
$(function(){
	$('#user_fullname').popover();
});

$(function(){
	$('#user_username').popover();
});

$(function(){
	$('#user_email').popover();
});

$(function(){
	$('#user_password').popover();
});

$(function(){
	$('#user_password_confirmation').popover();
});

// Profile - Status Update 
// =======================

$('#update-status').on('click', function() {
	$(".user-status > p").toggleClass("show hidden");
	$(".user-status > form").toggleClass("hidden show");
	return false;
});

$('.user-status > form > button').on('click', function() {
	$(".user-status > p").toggleClass("show hidden");
	$(".user-status > form").toggleClass("hidden show");
	return false;
});

// Lost password form
//===================

$('.pwd-lost > .pwd-lost-q > a').on('click', function() {
	$(".pwd-lost > .pwd-lost-q").toggleClass("show hidden");
	$(".pwd-lost > .pwd-lost-f").toggleClass("hidden show animated fadeIn");
	return false;
});

function previewImage(input) {
  var preview = document.getElementById('preview');
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      var img = new Image();
      img.src = e.target.result;
      img.onload = function() {
        var canvas = document.createElement('canvas');
        canvas.width = img.width - (img.width/8);
        canvas.height = img.height - (img.height/8);
        var context = canvas.getContext('2d');
        context.drawImage(img, -img.width/16, -img.height/18, img.width, img.height);
        var dataURL = canvas.toDataURL('image/jpeg');
        preview.setAttribute('src', dataURL);
      }
    }
    reader.readAsDataURL(input.files[0]);
    $("#image_error").html("");
  } else {
    preview.setAttribute('src', '/assets/face1.jpg');
  }
  return false;
}

function previewName(input) {
  if (input.files && input.files[0]) {
  	$("#add_file_name").html(input.files[0].name);
  }
}

$(document).ready(function(){
	$(".js-example-basic-multiple").select2({
		placeholder: "Select tag",
		tags: true,
		tokenSeparators: [',', ' ']
	});

	$('.user-image-open').click(function(){
    $('#user-image-file').click();
  });

  $("#add_file").click(function(){
    $("#blog_post_image").click();
  });

  $("#new_password").on("submit", function() {
    $("#reset_message").hide();
    $("#send_reset").css('cursor', 'wait');
    $("#send_reset").attr('disabled', 'disabled');
  });

  $("#new_password").on("ajax:success", function(e, data, status, xhr) {
    json_data = $.parseJSON(xhr.responseText);
    var id = json_data.id;
    if (!id) {
      $("#reset_message").show();
      $("#reset_message").removeClass("message-success");
      $("#reset_message").addClass("message-error");
      $("#reset_message").html("Email not found");
      $("#send_reset").css('cursor', 'pointer');
      $('#send_reset').removeAttr('disabled');
    } else {
      $("#reset_message").show();
      $("#reset_message").removeClass("message-error");
      $("#reset_message").addClass("message-success");
      $("#user_email_reset").val("");
      $("#reset_message").html("You will receive an email with instructions on how to reset your password in a few minutes");
      $("#send_reset").css('cursor', 'pointer');
      $('#send_reset').removeAttr('disabled');
    }
  }).on("ajax:error", function(e, xhr, status, error) {
    $("#reset_message").show();
    $("#reset_message").removeClass("message-success");
    $("#reset_message").addClass("message-error");
    $("#reset_message").html("Error");
    $("#send_reset").css('cursor', 'pointer');
    $('#send_reset').removeAttr('disabled');
  });

  $.validator.addMethod("lettersonly", function(value, element) { 
    return this.optional(element) || /^[a-zA-Z\s]*$/.test(value);
	},"Please enter only letters");

	$.validator.addMethod("numberletters", function(value, element) { 
    return this.optional(element) || /^[a-zA-Z0-9.]*$/.test(value);
	},"Username can consists of only numbers, letters and .");

  // Finishup form validation
	//-----------------------------------------------		
  if($("#finish_signup_user").length>0) {
		$("#finish_signup_user").validate({
			submitHandler: function(form) {

				var submitButton = $(this.submitButton);
				submitButton.button("loading");

				$("#finish_signup_user").submit();
			},
			// debug: true,
			errorPlacement: function(error, element) {
				error.insertAfter( element );
			},
			onkeyup: false,
			onclick: false,
			rules: {
				"user[email]": {
					required: true,
					email: true
				}
			},
			messages: {
				"user[email]": {
					required: "Please enter your email",
					email: "Please enter a valid email address e.g. name@domain.com"
				}
			},
			highlight: function (element) {
				$(element).parent().removeClass("has-success").addClass("has-error");
				// $(element).siblings("label").addClass("hide"); 
			},
			success: function (element) {
				$(element).parent().removeClass("has-error").addClass("has-success");
				$(element).removeClass("error");
				$(element).addClass("display-table margin-bottom-0");
				// $(element).siblings("label").removeClass("hide"); 
			}
		});
	};

  // Signin form validation
	//-----------------------------------------------		
	if($("#signin_user").length>0) {
		$("#signin_user").validate({
			submitHandler: function(form) {

				var submitButton = $(this.submitButton);
				submitButton.button("loading");

				$("#signin_user").submit();
			},
			// debug: true,
			errorPlacement: function(error, element) {
				error.insertAfter( element );
			},
			onkeyup: false,
			onclick: false,
			rules: {
				"user[login]": {
					required: true
				},
				"user[password]": {
					required: true,
					minlength: 8
				}
			},
			messages: {
				"user[login]": {
					required: "Please specify your username or email"
				},
				"user[password]": {
					required: "Please specify your password",
					minlength: "Your password must be of minimum 8 characters"
				}
			},
			highlight: function (element) {
				$(element).parent().removeClass("has-success").addClass("has-error");
			},
			success: function (element) {
				$(element).parent().removeClass("has-error").addClass("has-success");
				$(element).removeClass("error");
				$(element).addClass("display-table margin-bottom-0");
			}
		});
	};

  // Signup form validation
	//-----------------------------------------------		
	if($("#signup_user").length>0) {
		$("#signup_user").validate({
			submitHandler: function(form) {

				var submitButton = $(this.submitButton);
				submitButton.button("loading");

				$("#signup_user").submit();
			},
			// debug: true,
			errorPlacement: function(error, element) {
				if(element.attr("name") == "profile_image") {
			    error.appendTo( "#image_error" );
			  } else {
			    error.insertAfter(element);
			  }
			},
			onkeyup: false,
			onclick: false,
			rules: {
				"profile_image": {
					required: true,
					accept: "image/*"
				},
				"user[fullname]": {
					required: true,
					minlength: 2,
					maxlength: 30,
					lettersonly: true
				},
				"user[username]": {
					required: true,
					minlength: 2,
					maxlength: 30,
					numberletters: true
				},
				"user[email]": {
					required: true,
					email: true
				},
				"user[password]": {
					required: true,
					minlength: 8
				},
				"user[password_confirmation]": {
					required: true,
					minlength: 8,
					equalTo: "#user_password"
				}
			},
			messages: {
				"profile_image": {
					required: "Please select your profile image",
					accept: "Please select only image"
				},
				"user[fullname]": {
					required: "Please specify your full name",
					minlength: "Your full name must be of minimum 2 characters",
					maxlength: "Your full name must be of maximum 30 characters"
				},
				"user[username]": {
					required: "Please specify your username",
					minlength: "Your username must be of minimum 2 characters",
					maxlength: "Your username must be of maximum 30 characters"
				},
				"user[email]": {
					required: "Please specify your email",
					email: "Please enter a valid email address e.g. name@domain.com"
				},
				"user[password]": {
					required: "Please specify your password",
					minlength: "Your password must be of minimum 8 characters"
				},
				"user[password_confirmation]": {
					required: "Please confirm your password",
					minlength: "Your confirm password must be of minimum 8 characters",
					equalTo: "Your confirm password must be equal to password"
				}
			},
			highlight: function (element) {
				$(element).parent().removeClass("has-success").addClass("has-error");
			},
			success: function (element) {
				$(element).parent().removeClass("has-error").addClass("has-success");
				$(element).removeClass("error");
				$(element).addClass("display-table margin-bottom-0");
			}
		});
	};

	// Contact form validation
	//-----------------------------------------------		
	if($("#new_contact").length>0) {
		$("#new_contact").validate({
			submitHandler: function(form) {

				var submitButton = $(this.submitButton);
				submitButton.button("loading");

				$.ajax({
					type: "POST",
					url: "/contact",
					data: $("#new_contact").serializeArray(),
					success: function (data) {
						if (data.responseText == "success") {

							$("#alert_notice").removeClass("hide");
							$("#alert_error").addClass("hide");

							// Reset Form
							$("#new_contact .form-control")
								.val("")
								.blur()
								.parent()
								.removeClass("has-success")
								.removeClass("has-error")
								.find("label")
								.removeClass("hide")
								.parent()
								.find("span.error")
								.remove();

							if(($("#alert_notice").position().top - 80) < $(window).scrollTop()){
								$("html, body").animate({
									 scrollTop: $("#alert_notice").offset().top - 80
								}, 300);
							}

						} else {

							$("#alert_error").removeClass("hide");
							$("#alert_notice").addClass("hide");

							if(($("#alert_error").position().top - 80) < $(window).scrollTop()){
								$("html, body").animate({
									 scrollTop: $("#alert_error").offset().top - 80
								}, 300);
							}

						}
					},
					error: function (data) {
						if (data.responseText == "success") {

							$("#alert_notice").removeClass("hide");
							$("#alert_error").addClass("hide");

							// Reset Form
							$("#new_contact .form-control")
								.val("")
								.blur()
								.parent()
								.removeClass("has-success")
								.removeClass("has-error")
								.find("label")
								.removeClass("hide")
								.parent()
								.find("label.error")
								.remove();

							if(($("#alert_notice").position().top - 80) < $(window).scrollTop()){
								$("html, body").animate({
									 scrollTop: $("#alert_notice").offset().top - 80
								}, 300);
							}

						} else {

							$("#alert_error").removeClass("hide");
							$("#alert_notice").addClass("hide");

							if(($("#alert_error").position().top - 80) < $(window).scrollTop()){
								$("html, body").animate({
									 scrollTop: $("#alert_error").offset().top - 80
								}, 300);
							}

						}
					},
					complete: function () {
						submitButton.button("reset");
					}
				});
			},
			// debug: true,
			errorPlacement: function(error, element) {
				error.insertAfter( element );
			},
			onkeyup: false,
			onclick: false,
			rules: {
				"contact[name]": {
					required: true,
					minlength: 2,
					maxlength: 30
				},
				"contact[email]": {
					required: true,
					email: true
				},
				"contact[number]": {
					number: true,
					minlength: 10,
					maxlength: 15
				},
				"contact[message]": {
					required: true,
					minlength: 10
				}
			},
			messages: {
				"contact[name]": {
					required: "Please specify your name",
					minlength: "Your name must be of minimum 2 characters",
					maxlength: "Your name must be of maximum 30 characters"
				},
				"contact[email]": {
					required: "We need your email address to contact you",
					email: "Please enter a valid email address e.g. name@domain.com"
				},
				"contact[number]": {
					number: "Please enter a valid contact number",
					minlength: "Your number must be of minimum 10 numbers",
					maxlength: "Your number must be of maximum 15 numbers"
				},
				"contact[message]": {
					required: "Please enter a message",
					minlength: "Your message must be of minimum 10 characters"
				}					
			},
			highlight: function (element) {
				$(element).parent().removeClass("has-success").addClass("has-error");
			},
			success: function (element) {
				$(element).parent().removeClass("has-error").addClass("has-success");
				$(element).removeClass("error");
				$(element).addClass("display-table margin-bottom-0");
			}
		});
	};
});