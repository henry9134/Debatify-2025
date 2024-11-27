if current_user.voted_on?(@comment)
  json.form render(partial: "topics/form", formats: :html, locals: {comment: @comment})
  json.button render(partial: "topics/button", formats: :html, locals: {comment: @comment})
  json.voteCount @comment.votes.count
else
  json.form render(partial: "topics/form", formats: :html, locals: {comment: @comment})
  json.button render(partial: "topics/button", formats: :html, locals: {comment: @comment})
  json.voteCount @comment.votes.count
end
