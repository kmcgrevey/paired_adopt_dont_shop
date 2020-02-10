require 'rails_helper'

describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title}
                                     # :rating,
                                     # :content}
  end

  describe 'relationships' do
    it { should belong_to :shelter }
  end
end
