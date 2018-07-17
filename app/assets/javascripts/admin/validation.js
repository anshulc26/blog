var Validation = function () {
    return {
        //Validation
        initValidation: function () {

	        // Validation for Service form
        	$("#").validate({
	            rules:
	            {
	                "service[name]":
	                {
	                    required: true
	                },
	                "service[points]":
	                {
	                    required: true,
	                    digits: true
	                }
	            },
	            messages:
	            {
	                "service[name]":
	                {
	                    required: 'Please enter name of the service'
	                },
	                "service[points]":
	                {
	                    required: 'Please enter points of the service',
	                    digits: 'Please enter only digits'
	                }
	            },
	            errorPlacement: function(error, element)
	            {
	                error.insertAfter(element.parent());
	            }
	        });

	        // Validation for Lead Type form
        	$("#").validate({
	            rules:
	            {
	                "lead_type[name]":
	                {
	                    required: true
	                },
	                "lead_type[criteria]":
	                {
	                    required: true,
	                    digits: true
	                },
	                "lead_type[deduct_credits]":
	                {
	                    required: true,
	                    digits: true
	                },
	                "lead_type[number_of_agents]":
	                {
	                    required: true,
	                    number: true
	                }
	            },
	            messages:
	            {
	                "lead_type[name]":
	                {
	                    required: 'Please enter name of the lead type'
	                },
	                "lead_type[criteria]":
	                {
	                    required: 'Please enter criteria points of the lead type',
	                    digits: 'Please enter only digits'
	                },
	                "lead_type[deduct_credits]":
	                {
	                    required: 'Please enter deduct credits points of the lead type',
	                    digits: 'Please enter only digits',
	                    maxlength: 10
	                },
	                "lead_type[number_of_agents]":
	                {
	                    required: 'Please enter points of the service',
	                    number: 'Please enter only number',
	                    maxlength: jQuery.format("At most {0} numbers required")
	                }
	            },
	            errorPlacement: function(error, element)
	            {
	                error.insertAfter(element.parent());
	            }
	        });

			// Validation for Trip Request Response form
        	$("#").validate({
	            rules:
	            {
	                "response":
	                {
	                    required: true
	                }
	            },
	            messages:
	            {
	                "response":
	                {
	                    required: 'Please enter the response'
	                }
	            },
	            errorPlacement: function(error, element)
	            {
	                error.insertAfter(element.parent());
	            }
	        });

	        // Validation for Admin Profile Edit form
        	$("#").validate({
	            rules:
	            {
	                "admin[email]":
	                {
	                    required: true,
	                    email: true
	                },
	                "admin[current_password]":
	                {
	                    required: true,
	                    minlength: 8
	                },
	                "admin[password]":
	                {
	                    minlength: function(element) {
			                if ($('#admin_password').val().trim()) {
			                    return 8;
			                } else {
			                    return 0;
			                }
			            }
	                },
	                "admin[password_confirmation]":
	                {
	                    required: function(element) {
			                if ($('#admin_password').val().trim()) {
			                    return 8;
			                } else {
			                    return 0;
			                }
			            },
	                    minlength: function(element) {
			                if ($('#admin_password').val().trim()) {
			                    return 8;
			                } else {
			                    return 0;
			                }
			            },
			            equalTo: function(element) {
			                if ($('#admin_password').val().trim()) {
			                    return '#admin_password';
			                }
			            }
	                }
	            },
	            messages:
	            {
	                "admin[email]":
	                {
	                    required: 'Please enter your email address',
	                    email: 'Please enter a valid email address'
	                },
	                "admin[current_password]":
	                {
	                    required: 'Please enter your current password',
	                    minlength: jQuery.format("At least {0} characters required")
	                },
	                "admin[password]":
	                {
	                    minlength: jQuery.format("At least {0} characters required")
	                },
	                "admin[password_confirmation]":
	                {
	                    required: 'Please confirm your password',
	                    minlength: jQuery.format("At least {0} characters required"),
	                    equalTo: 'Please enter the same password as above'
	                }
	            },
	            errorPlacement: function(error, element)
	            {
	                error.insertAfter(element.parent());
	            }
	        });

			// Validation for Edit Agent's Profile form
        	$("#manage_agent_profile").validate({
	            rules:
	            {
	                "user[contact_person]":
	                {
	                    required: true
	                },
	                "user[contact_telephone]":
	                {
	                    minlength: function(element) {
			                if ($('#user_contact_telephone').val().trim()) {
			                    return 7;
			                } else {
			                    return 0;
			                }
			            },
	                    number: function(element) {
			                if ($('#user_contact_telephone').val().trim()) {
			                    return true;
			                } else {
			                    return false;
			                }
			            }
	                },
	                "user[email]":
	                {
	                    required: true,
	                    email: true
	                },
	                "user[company_name]":
	                {
	                    required: true
	                },
	                "user[company_address]":
	                {
	                    required: true
	                },
	                "user[company_city]":
	                {
	                    required: true
	                },
	                "user[company_zip]":
	                {
	                    required: true,
	                    minlength: 5,
	                    maxlength: 6,
	                    number: true
	                },
	                "user[company_country]":
	                {
	                    required: true
	                }
	            },
	            messages:
	            {
	                "user[contact_person]":
	                {
	                    required: 'Please enter name of contact person'
	                },
	                "user[contact_telephone]":
	                {
	                    minlength: jQuery.format("At least {0} numbers required"),
	                    number: 'Numbers only'
	                },
	                "user[email]":
	                {
	                    required: 'Please enter your email address',
	                    email: 'Please enter a valid email address'
	                },
	                "user[company_name]":
	                {
	                    required: 'Please enter your company name'
	                },
	                "user[company_address]":
	                {
	                    required: 'Please enter your company address'
	                },
	                "user[company_city]":
	                {
	                    required: 'Please enter your company city'
	                },
	                "user[company_zip]":
	                {
	                    required: 'Please enter your company zip',
	                    minlength: jQuery.format("At least {0} numbers required"),
	                    maxlength: jQuery.format("At most {0} numbers required"),
	                    number: 'Numbers only'
	                },
	                "user[company_country]":
	                {
	                    required: 'Please enter your company country'
	                }
	            },
	            errorPlacement: function(error, element)
	            {
	                error.insertAfter(element.parent());
	            }
	        });
        }
    };
}();