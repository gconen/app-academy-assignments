SELECT
  answer_choices.*, COUNT(responses.id) AS count
FROM
  answer_choices
LEFT OUTER JOIN
  responses ON responses.answer_choice_id = answer_choices.id
WHERE
  answer_choices.question_id = ?
GROUP BY
  answer_choices.id
