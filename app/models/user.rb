class User < ApplicationRecord
    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}, uniqueness: true
    # validates :password, presence: true, length: { in: 6..20 }

    has_many :transactions, dependent: :delete_all
    has_many :user_stocks, dependent: :delete_all

    include BCrypt

    has_secure_password
    
    after_create :generate_token

    # this is for registering a new user
    def self.signup(user_params)
        password_hash = Password.create(user_params[:password])

        # User.new(...)
        create(email: user_params[:email], password: password_hash)
    end

    # def self.signin(user_params)
    #     # User.find_by(...)
    #    user ||= find_by(email: user_params[:email])

    #    if user.present?
    #     return user if Password.new(user.password) == user_params[:password]
    #    end
    # end

    def generate_token
        # after creating, self is now the user object...
        # self.token = ...
        self.token = (0...50).map{ ('a'..'z').to_a[rand(26)]}.join

        # self.save
        self.save
    end
end
