User.create!(
  name: "DanRay Rollan",
  mobile: "09560635541",
  email: "danray@admin.com",
  password: "password",
  password_confirmation: "password",
  role: "admin"
)

User.create!(
  name: "Xavier Dray",
  mobile: "09560635541",
  email: "xav@user.com",
  password: "password",
  password_confirmation: "password",
  role: "user"
)

Payment.create!(name: "Bank")
Payment.create!(name: "GCash")
Payment.create!(name: "COD")
Payment.create!(name: "Pay at the Store")