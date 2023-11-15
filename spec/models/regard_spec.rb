require 'rails_helper'

RSpec.describe Regard, type: :model do
  it { should belong_to(:question) }
  it { should have_one_attached(:pic) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:pic) }
end
