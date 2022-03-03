require 'rails_helper'

RSpec.describe SecretLink, type: :model do
  describe 'validations' do
    context 'when valid' do
      let(:valid_secret_link) { Fabricate(:secret_link) }

      it { expect(valid_secret_link).to validate_persence_of(:slug) }
      it { expect(valid_secret_link).to validate_uniqueness_of(:slug) }
      it { expect(valid_secret_link).to validate_length_of(:slug).is_equal_to(16) }
      it { expect(valid_secret_link.slug).to match(/\A[a-zA-Z0-9]{16}\z/) }
      it { expect(valid_secret_link).to validate_presence_of(:validity_period) }
      it { expect(valid_secret_link).to validate_numericality_of(:validity_period) }
      it { expect(valid_secret_link).to validate_presence_of(:visit_count) }
      it { expect(valid_secret_link).to validate_numericality_of(:visit_count) }
      it { expect(valid_secret_link).to validate_presence_of(:calendar_id) }
      it { expect(valid_secret_link).to belong_to(:calendar) }
      it { expect(valid_secret_link).to validate_presence_of(:user_id) }
      it { expect(valid_secret_link).to belong_to(:user) }
    end

    context 'when invalid' do
      let(:invalid_secret_link) { Fabricate(:secret_link, slug: nil, validity_period: nil, visit_count: nil, calendar: nil, user: nil) }

      it { expect(invalid_secret_link).to model_have_error_on_field(:secret_link) }
      it { expect(invalid_secret_link).to model_have_error_on_field(:validity_period) }
      it { expect(invalid_secret_link).to model_have_error_on_field(:visit_count) }
      it { expect(invalid_secret_link).to model_have_error_on_field(:calendar_id) }
      it { expect(invalid_secret_link).to model_have_error_on_field(:user_id) }
    end
  end

  describe 'instance methods' do
    let(:secret_link) { Fabricate(:secret_link) }

    it '#valid?: is valid until the validity period' do
      expect(secret_link.valid?).to be true
    end

    it '#valid?: is invalid after the validity perdiod' do
      link = secret_link.dup.update_attribute(:validity_period, 0)
      expect(link.valid?).to be false
    end

    it '#increase_visit_count' do
      link = secret_link.dup.increase_visit_count
      expect(link.visit_count).to eq(secret_link.visit_count + 1)
    end
  end
end
