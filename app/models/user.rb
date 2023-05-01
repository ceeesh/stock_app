class User < ApplicationRecord
    include BCrypt

    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}, uniqueness: true
    validates :password, presence: true

    has_many :transactions, dependent: :delete_all
    has_many :user_stocks, dependent: :delete_all
    
    after_create :generate_token

    # For registering a new user
    def self.signup(signup_params)
        password_hash = Password.create(signup_params[:password])

        # User.new(...)
        create(email: signup_params[:email], password: password_hash)
    end

    # For user login
    def self.signin(user_params)
        # User.find_by(...) checks t
       user ||= find_by(email: user_params[:email])

       if user.present?
            if user.admin?
                return user
            else
                return user if Password.new(user.password) == user_params[:password]
            end
        end
    end

    # For creating new token every new user
    def generate_token
        # after creating, self is now the user object...
        # self.token = ...
        self.token = (0...50).map{ ('a'..'z').to_a[rand(26)]}.join

        # self.save
        self.save
    end
end
