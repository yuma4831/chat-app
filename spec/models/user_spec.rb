require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
      expect(@user).to be_valid
    end

    it "nameが空では登録できないこと" do
      @user.name = ""
      @user.valid?
      expect(@user.errors.full_messages)
    end

    it "emailが空では登録できないこと" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages)
    end

    it "passwordが空では登録できないこと" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages)
    end
    it "passwordが6文字以上であれば登録できること" do
      @user.password = "000000000"
      @user.password_confirmation = "000000000"
      expect(@user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
      @user.password = "00000"
      @user.valid?
      expect(@user.errors.full_messages)
    end

    it "passwordとpassword_confirmationが不一致では登録できないこと" do
      @user.password = "0000000"
      @user.password_confirmation = "oooooo"
      @user.valid?
      expect(@user.errors.full_messages)
    end
    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages)
    end
  end
end
