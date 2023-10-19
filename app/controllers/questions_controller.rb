class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all
    @question = Question.new
    @question.links.build
  end

  def show
    @answer = @question.answers.new
    @answer.links.build
    @best_answer = @question.best_answer
    @other_answers = @question.answers.where.not(id: @question.best_answer_id)
  end

  def new; end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.save
  end

  def edit; end

  def update
    @question.update(question_params)
    @questions = Question.all
  end

  def destroy
    @question.destroy if current_user.author?(@question)
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:name, :url])
  end
end
