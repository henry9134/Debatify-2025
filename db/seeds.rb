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


categories = ["Sports", "Technology", "Politics", "Entertainment", "Health"]
topics = [
  { title: "AI is dangerous", description: "Artificial intelligence poses a threat to humanity as it may surpass human control, leading to unintended catastrophic outcomes.", category: "Technology" },
  { title: "Social media regulation", description: "Social media companies should be regulated like utilities to reduce misinformation and protect public safety.", category: "Technology" },
  { title: "Electric cars", description: "Electric vehicles are the only viable solution for a sustainable future, reducing reliance on fossil fuels.", category: "Technology" },
  { title: "Soccer referees", description: "Video referees have improved fairness in soccer by ensuring critical decisions are reviewed.", category: "Sports" },
  { title: "Football safety", description: "American football is too dangerous due to the high risk of CTE and severe injuries among players.", category: "Sports" },
  { title: "eSports recognition", description: "eSports should be respected as legitimate sports, given the level of skill, strategy, and teamwork required.", category: "Sports" },
  { title: "Mandatory voting", description: "Voting should be mandatory to ensure all citizens participate in the democratic process.", category: "Politics" },
  { title: "Universal healthcare", description: "Universal healthcare systems provide the best outcomes for society, ensuring everyone has access to essential medical care.", category: "Politics" },
  { title: "Gun control", description: "Stricter gun control laws are necessary to reduce gun violence and protect public safety.", category: "Politics" },
  { title: "Superhero movies", description: "The superhero movie genre has become oversaturated, leading to declining creativity and repetitive storytelling.", category: "Entertainment" },
  { title: "Streaming platforms", description: "Streaming platforms are killing traditional movie theaters by making it easier and cheaper to watch movies at home.", category: "Entertainment" },
  { title: "Reality TV", description: "Reality TV shows are harmful, exploiting participants for profit and promoting unhealthy social norms.", category: "Entertainment" },
  { title: "Plant-based diets", description: "Plant-based diets are the healthiest choice for most people, reducing disease risk and benefiting the environment.", category: "Health" },
  { title: "Mental health days", description: "Mandatory mental health days in schools can help students manage stress and improve overall well-being.", category: "Health" },
  { title: "Fitness trackers", description: "Fitness trackers are not always reliable, as they often provide inaccurate data that could mislead users.", category: "Health" }
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
  "AI is dangerous" => {
    for: "AI could surpass human control, leading to unintended consequences.",
    against: "AI is a tool that, when used responsibly, enhances human potential.",
    neutral: "AI's impact depends on regulations and safeguards put in place."
  },
  "Social media regulation" => {
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
