require 'random_data'

#Create Posts
50.times do
  Post.create!(
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end
posts = Post.all

#Create comments

100.times do
  Comment.create!(
  post: posts.sample,
  body: RandomData.random_paragraph
  )
end

unique_post = Post.find_or_create_by!(title: "Unique title for a unique post", body: "Uniqu body for a unique post")

unique_post.comments.find_or_create_by(body: "Unique body for a unique comment", post: unique_post)

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
