require "rails_helper"

RSpec.describe User, type: :model do
  describe "encryption" do
    let(:account_name) { "account_name" }
    let(:session) { "session" }
    let(:user) { User.new(account_name: account_name, session: session) }

    it "encrypts account_name" do
      expect(user.encrypted_account_name).not_to be_empty
      expect(user.encrypted_account_name).not_to eq(session)
    end

    it "encrypts session" do
      expect(user.encrypted_session).not_to be_empty
      expect(user.encrypted_session).not_to eq(account_name)
    end

    it "decrypts values correctly" do
      expect(user.account_name).to eq(account_name)
      expect(user.session).to eq(session)
    end
  end

  describe "check_credentials" do
    context "when valid session" do
      let(:user) { create(:user) }

      it "returns as valid" do
        VCR.use_cassette "check credentials" do
          expect(user).to be_valid
        end
      end

      it "assigns valid_credentials to true" do
        VCR.use_cassette "check credentials" do
          expect(user.valid_credentials).to be_truthy
        end
      end

      it "assigns chars" do
        VCR.use_cassette "check credentials" do
          expect(user.chars).not_to be_empty
        end
      end

      it "assigns account_name" do
        VCR.use_cassette "check credentials" do
          expect(user.account_name).to eq("fladsongomes")
        end
      end
    end

    context "when invalid session" do
      let(:user) { build(:user, session: "invalid_session") }

      it "returns as invalid" do
        VCR.use_cassette "check credentials invalid" do
          expect(user).not_to be_valid
        end
      end

      it "does not assigns valid_credentials to true" do
        VCR.use_cassette "check credentials invalid" do
          expect(user.valid_credentials).to be_falsey
        end
      end

      it "does not assigns chars" do
        VCR.use_cassette "check credentials invalid" do
          expect(user.chars).to be_empty
        end
      end

      it "does not assigns account_name" do
        VCR.use_cassette "check credentials invalid" do
          expect(user.account_name).to be_empty
        end
      end
    end
  end

  describe "current_leagues" do
    context "when different leagues" do
      it "returns the correct legues" do
        chars = [
          {"name"=>"tianne_", "class"=>"Ranger", "level"=>22, "league"=>"SSF Standard", "classId"=>2, "ascendancyClass"=>0},
          {"name"=>"Maeggi", "class"=>"Ascendant", "level"=>94, "league"=>"Standard", "classId"=>0, "ascendancyClass"=>1},
          {"name"=>"Ngamason", "class"=>"Berserker", "level"=>90, "league"=>"Hardcore", "classId"=>1, "ascendancyClass"=>2},
          {"name"=>"Lunna_", "class"=>"Raider", "level"=>88, "league"=>"Abyss", "classId"=>2, "ascendancyClass"=>1}
        ]
        user = build(:user, chars: chars)

        expect(user.current_leagues).to eq(["SSF Standard", "Standard", "Hardcore", "Abyss"])
      end
    end

    context "when some different leagues" do
      it "returns the correct legues as uniq" do
        chars = [
          {"name"=>"tianne_", "class"=>"Ranger", "level"=>22, "league"=>"Standard", "classId"=>2, "ascendancyClass"=>0},
          {"name"=>"Maeggi", "class"=>"Ascendant", "level"=>94, "league"=>"Standard", "classId"=>0, "ascendancyClass"=>1},
          {"name"=>"Ngamason", "class"=>"Berserker", "level"=>90, "league"=>"Abyss", "classId"=>1, "ascendancyClass"=>2},
          {"name"=>"Lunna_", "class"=>"Raider", "level"=>88, "league"=>"Abyss", "classId"=>2, "ascendancyClass"=>1}
        ]
        user = build(:user, chars: chars)

        expect(user.current_leagues).to eq(["Standard", "Abyss"])
      end
    end
  end

  describe "temp_leagues" do
    it "returns the correct legues" do
      chars = [
        {"name"=>"tianne_", "class"=>"Ranger", "level"=>22, "league"=>"SSF Standard", "classId"=>2, "ascendancyClass"=>0},
        {"name"=>"Maeggi", "class"=>"Ascendant", "level"=>94, "league"=>"Standard", "classId"=>0, "ascendancyClass"=>1},
        {"name"=>"Ngamason", "class"=>"Berserker", "level"=>90, "league"=>"Hardcore", "classId"=>1, "ascendancyClass"=>2},
        {"name"=>"Lunna_", "class"=>"Raider", "level"=>88, "league"=>"Abyss", "classId"=>2, "ascendancyClass"=>1},
        {"name"=>"Lunna_", "class"=>"Raider", "level"=>88, "league"=>"Abyss Hardcore", "classId"=>2, "ascendancyClass"=>1}
      ]
      user = build(:user, chars: chars)

      expect(user.temp_leagues).to eq(["Abyss", "Abyss Hardcore"])
    end
  end
end
