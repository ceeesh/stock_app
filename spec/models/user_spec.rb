require 'rails_helper'

RSpec.describe User, type: :model do

    it "should have many transactions" do
      t = User.reflect_on_association(:transactions)
      expect(t.macro).to eq(:has_many)
    end

    it "should have many user stocks" do
      u = User.reflect_on_association(:user_stocks)
      expect(u.macro).to eq(:has_many)
    end


  it 'creates new user' do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it 'password must be greater than or equal to 8' do
    u = FactoryBot.create(:user)
    expect(u.password.length).to be >= 8
  end

  
end
