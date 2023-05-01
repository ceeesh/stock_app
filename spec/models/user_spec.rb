require 'rails_helper'

RSpec.describe User, type: :model do

  # relationship test
  # it { should have_many(:transactions) }
  # it { should have_many(:user_stocks) }


    it "should have many transactions" do
      t = User.reflect_on_association(:transactions)
      expect(t.macro).to eq(:has_many)
    end

  it 'creates new user' do
    expect(User.create({:email => "mail@email.com", :password => "12345678",})).to be_valid
  end

  # it 'creates new user' do
  #   user = FactoryBot.create(:user)

  # end

  it 'password must be greater than or equal to 8' do
    user = FactoryBot.create(:user)
    expect(user.password.length).to be >= 2
  end

  
end
