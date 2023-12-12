class AnswersController < ApplicationController
  include Voted
  include Commented

  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[index new show create]
  before_action :load_answer, only: %i[show update destroy star]

  after_action :publish_answer, only: [:create]

  authorize_resource

  def index
    @answers = @question.answers
  end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
    best_answer
  end

  def destroy
    @answer.destroy
    @question = @answer.question
    best_answer
  end

  def star
    @question = @answer.question
    @question.mark_as_best(@answer)
    best_answer
  end

  private

  def publish_answer
    return if @answer.errors.any?

    ActionCable.server.broadcast(
      "questions/#{params[:question_id]}/answers",
      ApplicationController.render(
        partial: 'answers/answer',
        locals: { answer: @answer, current_user: current_user }
      )
    )
  end

  def best_answer
    @best_answer = @question.best_answer
    @other_answers = @question.answers.where.not(id: @question.best_answer_id)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:name, :url])
  end
end
