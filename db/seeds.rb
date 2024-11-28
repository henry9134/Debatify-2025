# Reset the database
Comment.destroy_all
Topic.destroy_all
User.destroy_all
puts "_" * 25
puts "resetting..."
puts "_" * 25

# Create users
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

puts "Users created: #{User.count}"

# Define topics
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

# Create topics
topics.each do |topic_data|
  Topic.create!(
    title: topic_data[:title],
    description: topic_data[:description],
    category: topic_data[:category],
    user_id: User.all.sample.id
  )
end

puts "Topics created: #{Topic.count}"

# Define generic comments
comment_templates = {
  for: [
    "This is a positive point in favor of the topic.",
    "Another supportive comment on the topic.",
    "People generally agree on this point.",
    "This highlights the benefits of the topic.",
    "More reasons why this is a good idea."
  ],
  against: [
    "A critique of the topic's drawbacks.",
    "This highlights potential downsides.",
    "People have some concerns about this.",
    "This might not work out as intended.",
    "More reasons why this might not be a great idea."
  ],
  neutral: [
    "This is a balanced observation on the topic.",
    "Another neutral point to consider.",
    "This could go either way, depending on context.",
    "Balanced feedback about the topic.",
    "Neutral commentary reflecting various perspectives."
  ]
}

# Add comments to topics
Topic.all.each do |topic|
  comment_templates.each do |status, comments|
    comments.each_with_index do |content, index|
      Comment.create!(
        content: content,
        status: status.to_s,
        user_id: User.all[index % User.count].id, # Rotate users
        topic_id: topic.id
      )
    end
  end
end

puts "Comments created: #{Comment.count}"

puts "Seeding complete!"
