Comment.destroy_all
Topic.destroy_all
User.destroy_all
puts "_" * 25
puts "resetting..."
puts "_" * 25

famous_names = [
  "Elon Musk", "Jeff Bezos", "Oprah Winfrey", "Serena Williams", "LeBron James",
  "Kanye West", "Cristiano Ronaldo", "Lionel Messi", "Bill Gates", "Mark Zuckerberg",
  "Emma Watson", "Scarlett Johansson", "Tom Holland", "Chris Hemsworth", "Zendaya",
  "Drake", "Ariana Grande", "Beyoncé", "Harry Styles", "Dua Lipa"
]

famous_names.each_with_index do |name, index|
  User.create!(
    name: name,
    email: "user#{index + 1}@example.com",
    password: "password123",
    password_confirmation: "password123"
  )
end

categories = ["Sports", "Tech", "Politics", "Food", "Celebrities", "Education", "Finance"]
topics = [
  { title: "The rise of virtual reality in gaming", description: "Exploring how virtual reality is changing the gaming experience.", category: "Tech" },
  { title: "The impact of sports on mental health", description: "Examining how participation in sports can improve mental well-being.", category: "Sports" },
  { title: "The future of food sustainability", description: "Discussing innovative practices for sustainable food production.", category: "Food" },
  { title: "The role of influencers in modern marketing", description: "How social media influencers are reshaping advertising strategies.", category: "Celebrities" },
  { title: "The evolution of online learning", description: "How digital platforms are transforming traditional education methods.", category: "Education" },
  { title: "The significance of financial planning", description: "Understanding the importance of budgeting and saving for the future.", category: "Finance" },
  { title: "The effects of climate change on agriculture", description: "Analyzing how climate change is affecting farming practices.", category: "Food" },
  { title: "The future of space exploration", description: "Exploring the next steps in humanity's journey into space.", category: "Tech" },
  { title: "The importance of voting in a democracy", description: "Encouraging civic participation and the impact of voting.", category: "Politics" },
  { title: "The rise of mental health awareness", description: "How society is becoming more aware of mental health issues.", category: "Celebrities" }
]

topics.each do |topic|
  Topic.create!(
    title: topic[:title],
    description: topic[:description],
    category: topic[:category],
    user_id: User.all.sample.id
  )
end

comments_data = {
  "The rise of virtual reality in gaming" => {
    for: "VR creates immersive gaming experiences.",
    against: "VR is expensive and inaccessible for many.",
    neutral: "VR has potential, but it is still in early stages."
  },
  "The impact of sports on mental health" => {
    for: "Sports improve mental health by reducing stress.",
    against: "Pressure in sports can negatively impact mental health.",
    neutral: "The impact depends on how sports are managed."
  },
  "The future of food sustainability" => {
    for: "Sustainable practices ensure long-term food security.",
    against: "Sustainability measures can be expensive to implement.",
    neutral: "Both innovation and cost management are key."
  }
}

Topic.all.each do |topic|
  if comments_data.key?(topic.title)
    comments_data[topic.title].each do |status, content|
      Comment.create!(
        content: content,
        votes: rand(0..50),
        status: status.to_s,
        user_id: User.all.sample.id,
        topic_id: topic.id
      )
    end
  end
end

# Add random favorites for users
User.all.each do |user|
  rand(3..5).times do
    user.favorite(Topic.all.sample)
  end
end

puts "Seeding complete!"
