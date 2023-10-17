class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[index new show create]
  before_action :load_answer, only: %i[show update destroy star del_file]

  def index
    @answers = @question.answers
  end

  def new
    @answer = @question.answers.new
  end

  def show; end

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
    best_answer
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
    best_answer
  end

  def destroy
    @answer.destroy if current_user.author?(@answer)
    @question = @answer.question
    best_answer
  end

  def star
    @question = @answer.question
    @question.mark_as_best(@answer)
    best_answer
  end

  private

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
