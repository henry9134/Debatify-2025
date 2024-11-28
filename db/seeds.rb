# Reset the database
Comment.destroy_all
Topic.destroy_all
User.destroy_all
puts "-" * 25
puts "resetting..."
puts "-" * 25

# Create users
require 'open-uri'

famous_users = [
  { name: "Elon Musk", image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXBTFPI00GKK3GvnZ-S3Mxa7Ae_xmJ2KbkoA&s" },
  { name: "Jeff Bezos", image_url: "https://imageio.forbes.com/specials-images/imageserve/5bb22ae84bbe6f67d2e82e05/0x0.jpg?format=jpg&crop=1012,1013,x627,y129,safe&height=416&width=416&fit=bounds" },
  { name: "Travis Scott", image_url: "https://i.scdn.co/image/ab6761610000e5eb19c2790744c792d05570bb71" },
  { name: "Serena Williams", image_url: "https://hips.hearstapps.com/hmg-prod/images/gettyimages-1155421342.jpg?crop=1xw:1.0xh;center,top&resize=1200:*" },
  { name: "LeBron James", image_url: "https://i1.sndcdn.com/artworks-JHaetN7jbSBk3txE-6RuPnQ-t500x500.jpg" },
  { name: "Kanye West", image_url: "https://ih1.redbubble.net/image.5424095087.9680/raf,360x360,075,t,fafafa:ca443f4786.jpg" },
  { name: "Cristiano Ronaldo", image_url: "https://i.pinimg.com/236x/e5/fd/4a/e5fd4acc0b65a0340d9997a51a4262b9.jpg" },
  { name: "Lionel Messi", image_url: "https://img.a.transfermarkt.technology/portrait/big/28003-1710080339.jpg?lm=1" },
  { name: "Bill Gates", image_url: "https://yt3.googleusercontent.com/WuPodYLA22bumFSAnf654wJ8cE7n2Zb8M2KEF5B3RiyziqLTXQpp6JXBYOSH8zifY_jihWVq=s900-c-k-c0x00ffffff-no-rj" },
  { name: "Mark Zuckerberg", image_url: "https://i.pinimg.com/736x/06/63/d4/0663d4d85dcd4f789e42f4d3724c5796.jpg" },
  { name: "Madison Beer", image_url: "https://hips.hearstapps.com/hmg-prod/images/madison-beer-chi-e-cantante-1604674343.jpg?crop=0.46875xw:1xh;center,top&resize=640:*" },
  { name: "Madelyn Cline", image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEsNVo_njMffYnfItzzIqa06U9EkfUE09w4g&s" },
  { name: "Tom Holland", image_url: "https://hips.hearstapps.com/hmg-prod/images/tom-holland-attends-the-los-angeles-premiere-of-sony-news-photo-1683915930.jpg?crop=0.596xw:0.894xh;0.226xw,0.106xh&resize=1200:*" },
  { name: "Max Verstappen", image_url: "https://www.formula1points.com/images/driver/max-verstappen.webp" },
  { name: "Zendaya", image_url: "https://media.allure.com/photos/588f71bb42d9480a3f8e96a0/1:1/w_1629,h_1629,c_limit/Zendaya.jpg" },
  { name: "Drake", image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXyBgzi2PshKyxZ8QNwq1f0BMmRY3DgbQEmA&s " },
  { name: "Corinna Kopf", image_url: "https://i.ebayimg.com/images/g/nSYAAOSw7IplI9pw/s-l400.jpg" },
  { name: "Dylan Mayoral", image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnqic0t_pBKwvTc6NKNwiL1M9ZK9EWFn0GeQ&s" },
  { name: "Playboi Carti", image_url: "https://i1.sndcdn.com/artworks-LpiOTjAE7XnkdCsk-3dHwxA-t500x500.jpg" },
  { name: "Dua Lipa", image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKQsgzuA-9M8irNmMaHr-Jy3-QsBhiZipOWw&s" }
]

famous_users.each_with_index do |user_data, index|
  p user_data[:image_url]
  image_url = URI.open(user_data[:image_url]) # Open the image URL
  # Create a blob from the image data
  photo_blob = ActiveStorage::Blob.create_and_upload!(
    io: image_url,
    filename: "#{user_data[:name].parameterize}.jpg", # Use a parameterized name for the file
    content_type: 'image/jpeg' # Set the content type
  )

  User.create!(
    name: user_data[:name],
    email: "user#{index + 1}@example.com",
    password: "password123",
    password_confirmation: "password123",
    photo: photo_blob # Store the blob instead of the image URL
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

# Add comments to topics with nested comments
Topic.all.each do |topic|
  comment_templates.each do |status, comments|
    comments.each_with_index do |content, index|
      # Create a top-level comment
      parent_comment = Comment.create!(
        content: content,
        status: status.to_s,
        user_id: User.all[index % User.count].id, # Rotate users
        topic_id: topic.id
      )

      # Create a nested comment under the top-level comment
      Comment.create!(
        content: "Reply to: #{content}",
        status: status.to_s,
        user_id: User.all[(index + 1) % User.count].id, # Use a different user
        topic_id: topic.id,
        parent_id: parent_comment.id
      )
    end
  end
end

puts "Comments created: #{Comment.count}"

puts "Seeding complete!"
