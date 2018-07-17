user = User.new(email: "anshul.c26@gmail.com", password: "password", password_confirmation: "password", fullname: "Anshul Kumar", username: "anshul.c26", allowed_to_post: true)
user.add_role :super_admin
user.add_role :admin
user.add_role :blogger
user.skip_confirmation!
user.save!

user = User.new(email: "admin@gmail.com", password: "password", password_confirmation: "password", fullname: "Admin", username: "admin.c26", allowed_to_post: true)
user.add_role :admin
user.add_role :blogger
user.skip_confirmation!
user.save!

user = User.new(email: "blogger@gmail.com", password: "password", password_confirmation: "password", fullname: "Blogger", username: "blogger.c26", allowed_to_post: true)
user.add_role :blogger
user.skip_confirmation!
user.save!