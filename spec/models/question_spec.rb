require 'rails_helper'

require_relative './concerns/voteable_spec'

RSpec.describe Question, type: :model do
  it { should have_many(:answers) }
  it { should belong_to(:best_answer).class_name('Answer').optional }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_one(:regard) }
  it { should have_many(:subscriptions).dependent(:destroy) }

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:title) }

  it { should accept_nested_attributes_for :links }
  it { should accept_nested_attributes_for :regard }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  include_examples 'voteable', "Question" do
    let(:object) { question }
  end

  it 'have many attached files' do
    expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  it 'have new Regard object' do
    expect(Question.new.build_regard).to be_an_instance_of(Regard)
  end

  context '#mark_as_best' do
    let!(:best_answer) { create(:answer, reward: true, question: question, user: user) }
    let!(:regard) { create(:regard, question: question) }

    it 'question have best answers' do
      question.mark_as_best(answer)

      expect(answer.reward).to be_truthy
      expect(question.best_answer_id).to eq answer.id
    end

    it 'only one-award responses' do
      question.mark_as_best(answer)
      best_answer.reload

      expect(best_answer.reward).to_not be_truthy
    end
  end

  describe 'reputation' do
    let(:question) { build(:question) }

    it 'calls ReputationJob' do
      expect(ReputationJob).to receive(:perform_later).with(question)
      question.save!
    end
  end
end
