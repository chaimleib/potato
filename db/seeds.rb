CodeFreeze.delete_all
ResourceUpdate.delete_all
User.delete_all
User.create(
  fname: "Admin", 
  lname: "Root", 
  email: Rails.application.secrets.root_user, 
  password_digest: "$2a$10$fbajvb4YUwXO8rdwH9O6hepZ6mLwCqbrPB2Y3Ke2JBPjTlzAulPdC"
)
