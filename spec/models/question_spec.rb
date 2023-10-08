require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers) }
  it { should belong_to(:best_answer).class_name('Answer').optional }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:title) }
end
