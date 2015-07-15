CodeFreeze.delete_all
ResourceUpdate.delete_all
User.delete_all
User.create(
  fname: "Admin", 
  lname: "Master", 
  email: ENV["ROOT_USER", 
  password_digest: "$2a$10$fbajvb4YUwXO8rdwH9O6hepZ6mLwCqbrPB2Y3Ke2JBPjTlzAulPdC"
)
