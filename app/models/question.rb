class Question < ActiveRecord::Base
  validates :text, presence: true
  validates :poll_id, presence: true


  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    results = {}

    answer_choices.includes(:responses).each do |choice|
      results[choice.text] = choice.responses.length
    end

    results
  end

end
