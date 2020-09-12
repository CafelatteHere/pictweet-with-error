require 'rails_helper'
describe User, type: :model do
  before do
    @user = FactoryBot.build(:user) #Userのインスタンス生成
  end

  describe 'ユーザー新規登録' do
    it "nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる" do
      expect(@user).to be_valid
    end
    it "nicknameが6文字以下で登録できる" do
      @user.nickname = "aaaaaa"
      expect(@user).to be_valid
    end
    it "passwordが6文字以上であれば登録できる" do
      @user.password = "000000"
      @user.password_confirmation = "000000"
      expect(@user).to be_valid
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "nicknameが7文字以上であれば登録できない" do
       @user.nickname = "aaaaaaa"
       @user.valid?
       expect(@user.errors.full_messages).to include("Nickname is too long (maximum is 6 characters)")
      end

      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "重複したemailが存在する場合登録できない" do 
        @user.email = "kkk@gmail.com"
        @user.save
        user2 = User.new(nickname: "aaaa", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000")
        user2.valid?
        expect(user2.errors.full_messages).to include("Email has already been taken")
        # @user.save
        # another_user = FactoryBot.build(:user)
        # another_user.email = @user.email
        # another_user.valid?
        # expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      
      it "passwordが空では登録できない" do
        @user.password = ""
        # @user.password_confirmation = "" можно, но не обязательно
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが5文字以下であれば登録できない" do 
      @user.password = "aaaaa"
      @user.password_confirmation = "aaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
      @user.password = "000000"
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
