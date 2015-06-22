class Response < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def author_cannot_respond_to_own_poll
    if question.poll.author.id == user_id
      errors[:user_id] << "Author cannot respond to own poll"
    end
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.pluck(:user_id).include?(user_id)
      errors[:user_id] << "User has already answered that question"
    end
  end

  def sibling_responses
    question.responses
            .where('responses.id != ? OR ? IS NULL', self.id, self.id)
  end

end
