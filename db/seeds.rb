Comment.destroy_all
Topic.destroy_all
User.destroy_all
puts "_" * 25
puts "resetting.."
puts "_" * 25

famous_names = [
  "Elon Musk", "Jeff Bezos", "Oprah Winfrey", "Serena Williams", "LeBron James",
  "Kanye West", "Cristiano Ronaldo", "Lionel Messi", "Bill Gates", "Mark Zuckerberg",
  "Emma Watson", "Scarlett Johansson", "Tom Holland", "Chris Hemsworth", "Zendaya",
  "Drake", "Ariana Grande", "Beyoncé", "Harry Styles", "Dua Lipa"
]

famous_names.each_with_index do |name, index|
  User.create(
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
  { title: "The rise of mental health awareness", description: "How society is becoming more aware of mental health issues.", category: "Celebrities" },
  { title: "The impact of technology on education", description: "Examining how technology is enhancing learning experiences.", category: "Education" },
  { title: "The role of sports in community building", description: "How sports can foster community engagement and unity.", category: "Sports" },
  { title: "The ethics of data privacy", description: "Discussing the importance of protecting personal information online.", category: "Tech" },
  { title: "The influence of media on public opinion", description: "How media shapes perceptions and opinions in society.", category: "Politics" },
  { title: "The future of celebrity activism", description: "How celebrities are using their platforms for social change.", category: "Celebrities" },
  { title: "The benefits of lifelong learning", description: "Understanding the importance of continuous education throughout life.", category: "Education" },
]

topics.each do |topic|
  Topic.create(
    title: topic[:title],
    description: topic[:description],
    category: topic[:category],
    user_id: User.all.sample.id
  )
end

comments_data = {
  "The rise of virtual reality in gaming" => {
    for: "AI could surpass human control, leading to unintended consequences.",
    against: "AI is a tool that, when used responsibly, enhances human potential.",
    neutral: "AI's impact depends on regulations and safeguards put in place."
  },
  "The role of influencers in modern marketing" => {
    for: "Regulation would reduce harmful content and misinformation.",
    against: "Overregulation could stifle free speech and innovation.",
    neutral: "Some regulation is necessary, but it should be balanced."
  },
  "Electric cars" => {
    for: "EVs drastically reduce carbon emissions and reliance on oil.",
    against: "The environmental cost of producing EV batteries is significant.",
    neutral: "EVs are promising but need cleaner energy sources for production."
  },
  "Soccer referees" => {
    for: "VAR ensures fairness by reducing referee errors.",
    against: "It disrupts the game flow and creates controversy over decisions.",
    neutral: "VAR is helpful but needs consistency in its application."
  },
  "Football safety" => {
    for: "The high risk of CTE makes football unsustainable.",
    against: "Better equipment and rules can make football safer.",
    neutral: "Football is risky, but players choose to participate."
  }
}

Topic.all.each do |topic|
  if comments_data[topic.title]
    comments = comments_data[topic.title]
    %i[for against neutral].each do |status|
      Comment.create(
        content: comments[status],
        votes: rand(0..50),
        status: status.to_s,
        user_id: User.all.sample.id,
        topic_id: topic.id
      )

    end
  end
end
  User.all.each do |user|
    (3..5).to_a.sample.times do
        user.favorite(Topic.all.sample)
    end
  end

puts "Seeding complete!"
