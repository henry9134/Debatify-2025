# Reset the database
Comment.destroy_all
Topic.destroy_all
User.destroy_all
puts "-" * 25
puts "Resetting database..."
puts "-" * 25

# Create users
require 'open-uri'
require 'faker'

image_urls = [
  "https://randomuser.me/api/portraits/men/86.jpg",
  "https://randomuser.me/api/portraits/men/19.jpg",
  "https://tr.rbxcdn.com/180DAY-d5f59643c2050b82be112fe297d4ea19/420/420/Hat/Webp/noFilter",
  "https://pikshunt.com/wp-content/uploads/2024/05/100000003914_Goofy_Ahh_Pictures.jpg.webp",
  "https://static.planetminecraft.com/files/image/minecraft/texture-pack/2023/088/16414626-pack_m.jpg",
  "https://p16-va.lemon8cdn.com/tos-maliva-v-ac5634-us/oQtOJFDHt1Be1QAHWFEIGOCDpAGQwsAgImfoQB~tplv-tej9nj120t-origin.webp",
  "https://randomuser.me/api/portraits/lego/1.jpg",
  "https://i.pinimg.com/originals/ec/e5/37/ece537399b0e7cb065d1364a5617edd9.jpg",
  "https://randomuser.me/api/portraits/women/28.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYvJWwRKSEHODxrPLDbe_BO8Fry_S0Kxr6Bg&s",
  "https://wallpapers-clan.com/wp-content/uploads/2022/02/fortnite-pfp-5.jpg",
  "https://i.natgeofe.com/n/4f5aaece-3300-41a4-b2a8-ed2708a0a27c/domestic-dog_thumb_square.jpg",
  "https://preview.redd.it/goofy-blue-pfp-v0-3e9elnursklb1.png?auto=webp&s=a01be1c9b7e706db23709c090c8a8089f5446934",
  "https://us-tuna-sounds-images.voicemod.net/b8e29bee-bd5d-4574-be79-171c2f82f3fe-1664477220626.jpg",
  "https://preview.redd.it/the-best-wallpaper-ever-v0-azooeafy2uaa1.jpeg?width=623&format=pjpg&auto=webp&s=47e739cae2e91cd199db03683c2a34fba5f6a27f",
  "https://photosly.net/wp-content/uploads/2024/02/goofy-ahh-memes-photos-images-pfp1.jpg",
  "https://pbs.twimg.com/media/FmTlu40WQAAQbf0.jpg",
  "https://dogsinc.org/wp-content/uploads/2021/08/extraordinary-dog.png",
  "https://pics.craiyon.com/2024-09-10/oH_33jLPQuiU649sEVF-DA.webp",
  "https://cdn3.emoji.gg/emojis/5263-goffycatmeme.png",
  "https://i.redd.it/ijt6xs0wz4ea1.jpg",
  "https://us-tuna-sounds-images.voicemod.net/067a2006-5ad8-40c3-9f94-e6e82c582f7d-1661219753344.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnaE0CplSnQWaLtNGJPlbCAn74ci-1wCnkAA&s",
  "https://media.tenor.com/E70TMSI7rsUAAAAe/memes-goofy-ahh-pictures-meme.png",
  "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/640px-Cat03.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMcAJN2cpzClyBZxTX_Og70DqiDznvrCuWFg&s",
  "https://i.pinimg.com/236x/f9/f5/07/f9f50757afb22d4d3df5ee9bde0c91ac.jpg",
  "https://cdn3.iconfinder.com/data/icons/avatars-9/145/Avatar_Penguin-512.png",
  "https://i.pinimg.com/474x/46/5f/a7/465fa792bac7b94c1d229d43edeaa20d.jpg"
]

famous_users = image_urls.shuffle.each_with_index.map do |image_url, index|
  { name: Faker::Name.name, image_url: image_url }
end

famous_users.each_with_index do |user_data, index|
  image_url = URI.open(user_data[:image_url])
  photo_blob = ActiveStorage::Blob.create_and_upload!(
    io: image_url,
    filename: "#{user_data[:name].parameterize}.jpg",
    content_type: 'image/jpeg'
  )

  User.create!(
    name: user_data[:name],
    email: "user#{index + 1}@example.com",
    password: "password123",
    password_confirmation: "password123",
    photo: photo_blob
  )
end

puts "Users created: #{User.count}"

# Define topics
topics = [
  { title: "The rise of virtual reality in gaming", description: "Virtual reality makes gaming so immersive. I felt like I was in another world playing VR Skyrim!", category: "Tech" },
  { title: "The impact of sports on mental health", description: "Playing sports helps me relieve stress and stay focused.", category: "Sports" },
  { title: "The future of space exploration", description: "I believe the next steps in humanity's journey into space will involve Mars colonization.", category: "Tech" },
  { title: "The benefits of meditation", description: "Meditation has significantly improved my mental health and focus.", category: "Health" },
  { title: "The role of technology in education", description: "Technology is transforming the learning experience by making it more interactive.", category: "Education" },
  { title: "Climate change and its impact", description: "Climate change is affecting our planet in ways we are just beginning to understand.", category: "Environment" },
  { title: "The evolution of social media", description: "Social media has changed the way we communicate, making it instant and global.", category: "Society" },
  { title: "The importance of mental health awareness", description: "Raising awareness about mental health issues is crucial for societal well-being.", category: "Health" },
  { title: "The impact of climate change on wildlife", description: "Climate change is threatening biodiversity and ecosystems around the world.", category: "Environment" },
  { title: "The role of art in society", description: "Art influences culture and community engagement in profound ways.", category: "Society" },
  { title: "The influence of technology on relationships", description: "Technology shapes personal connections, sometimes enhancing and sometimes hindering them.", category: "Tech" },
  { title: "The future of renewable energy", description: "Advancements in renewable energy sources are essential for a sustainable future.", category: "Environment" },
  { title: "The significance of cultural diversity", description: "Cultural diversity enriches society and fosters understanding among different communities.", category: "Society" },
  { title: "Life after death", description: "I believe there is life after death, how can there not be? there are so many accounts of people dying, seeing the afterlife and coming back to life to tell the tale.", category: "Education" }
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

# Add realistic comments and replies specific to topics
Topic.all.each do |topic|
  users = User.all.shuffle

  sides = case topic.title
          when "The rise of virtual reality in gaming"
            {
              "for" => [
                ["Virtual reality makes gaming so immersive. I felt like I was in another world playing VR Skyrim!", "Exactly! It feels like the future of entertainment."],
                ["It's great for connecting with friends in virtual spaces. VR chat is so much fun!", "Totally agree. It's like having a hangout spot without leaving home."],
                ["VR can enhance learning experiences in educational games.", "Absolutely! It opens up new ways to engage with content."]
              ],
              "neutral" => [
                ["The technology is impressive, but it's still so expensive.", "True, but prices are slowly coming down over time."],
                ["Some people might prefer traditional gaming over VR.", "That's understandable; everyone has their preferences."]
              ],
              "against" => [
                ["VR can cause motion sickness for many people.", "Yeah, I tried it once, and I couldn't last more than 10 minutes."],
                ["It's isolating. Spending hours in VR might disconnect people from real life.", "Absolutely. Social interaction in VR isn't the same as face-to-face."],
                ["The technology can be overwhelming for new users.", "I agree, it takes time to get used to the controls."],
                ["Some users may feel disoriented after using VR for extended periods.", "That's a common issue; it can take time to adjust back to reality."]
              ]
            }
          when "The impact of sports on mental health"
            {
              "for" => [
                ["Playing sports helps me relieve stress and stay focused.", "Absolutely! Exercise is amazing for mental clarity."],
                ["Team sports are great for building relationships and boosting confidence.", "Couldn't agree more. The camaraderie is unmatched."],
                ["Sports can provide a sense of achievement and purpose.", "Exactly! Setting and reaching goals is fulfilling."]
              ],
              "neutral" => [
                ["Not everyone enjoys sports, though. Some might find it stressful.", "That's fair. It depends on personality and interests."],
                ["Sports are great, but injuries can really take a mental toll.", "Very true. Recovery is tough physically and mentally."],
                ["Some people might feel pressured to perform.", "That's a valid concern; it can lead to anxiety."],
                ["Participating in sports can sometimes lead to burnout if not managed well.", "Absolutely, balance is key to enjoying sports."],
                ["Some individuals may feel excluded if they don't fit the typical athlete mold.", "That's a valid point; inclusivity in sports is important."]
              ],
              "against" => [
                ["Competitive sports can sometimes create too much pressure.", "Exactly. That pressure can lead to anxiety or burnout."]
              ]
            }
          when "The future of space exploration"
            {
              "for" => [
                ["Space exploration is key to humanity's survival in the long term.", "Absolutely. Colonizing other planets is essential."],
                ["It inspires the next generation to pursue science and innovation.", "Yes! Programs like NASA motivate young minds everywhere."]
              ],
              "neutral" => [
                ["It's exciting, but we need to balance funding with problems on Earth.", "True, but solving space challenges often benefits Earth too."],
                ["Space travel is still so risky. Look at the number of failed missions.", "That's a fair concern, but technology keeps improving."],
                ["Some people might not see the value in space exploration.", "That's understandable; it's a matter of perspective."],
                ["The focus on space can divert attention from pressing Earth issues.", "That's a valid concern; we need to find a balance."]
              ],
              "against" => [
                ["Why invest billions in space when people on Earth are starving?", "Exactly. Those resources could help so many right now."],
                ["Space debris is becoming a huge issue. More exploration could make it worse.", "Good point. Cleaning up space should be a priority too."]
              ]
            }
          when "The benefits of meditation"
            {
              "for" => [
                ["Meditation has helped me reduce anxiety and improve focus.", "Absolutely! It's a game changer for mental clarity."]
              ],
              "neutral" => [
                ["Not everyone finds meditation effective; it can be challenging.", "That's true; it requires practice and patience."]
              ],
              "against" => [
                ["Meditation might not work for everyone; some may find it frustrating.", "Exactly, it can be difficult to quiet the mind."],
                ["It can be seen as a trend rather than a genuine practice.", "That's a fair concern; authenticity matters."]
              ]
            }
          when "The role of technology in education"
            {
              "for" => [
                ["Technology makes learning more accessible and engaging.", "Absolutely! Online resources are invaluable."],
                ["It allows for personalized learning experiences.", "Yes! Tailoring education to individual needs is crucial."],
                ["Technology can connect students with global perspectives.", "Exactly! It broadens horizons and fosters collaboration."],
                ["It can provide interactive and immersive learning experiences.", "Absolutely, it makes learning more engaging."]
              ],
              "neutral" => [
                ["Not all students have equal access to technology.", "That's true; the digital divide is a significant issue."]
              ],
              "against" => [
              ]
            }
          when "Climate change and its impact"
            {
              "for" => [
                ["Addressing climate change is crucial for future generations.", "Absolutely! We owe it to them to take action."],
                ["Renewable energy sources can significantly reduce our carbon footprint.", "Yes! Transitioning to renewables is essential."],
              ],
              "neutral" => [
                ["Some people may not believe in climate change despite the evidence.", "That's true; misinformation is a challenge."],
                ["The effects of climate change can be hard to see immediately.", "Absolutely, it often requires long-term observation."],
                ["Balancing economic growth with environmental protection is complex.", "That's a valid concern; it requires careful planning."],
                ["Not everyone agrees on the best solutions to combat climate change.", "Absolutely, it's a complex issue with many perspectives."],
                ["The focus on climate change can overshadow other important issues.", "That's a valid concern; we need to find a balance."]
              ],
              "against" => [
                ["Some argue that climate change is exaggerated for political gain.", "That's a fair point; skepticism exists."],
                ["The costs of implementing green technologies can be high.", "Exactly, funding is a significant barrier."],
                ["Not everyone agrees on the best solutions to combat climate change.", "Absolutely, it's a complex issue with many perspectives."]
              ]
            }
          when "The evolution of social media"
            {
              "for" => [
                ["Social media has revolutionized communication and connection.", "Absolutely! It brings people together."],
                ["It provides a platform for marginalized voices.", "Yes! It amplifies voices that need to be heard."],
                ["Social media can foster community and support networks.", "Exactly! It helps people find their tribe."],
                ["It can provide a platform for activism and social change.", "Absolutely, it has the power to mobilize people."]
              ],
              "neutral" => [
                ["Not everyone enjoys using social media; some prefer face-to-face interactions.", "That's true; personal preferences vary."],
                ["Social media can sometimes lead to misinformation.", "Absolutely, critical thinking is essential."],
                ["The impact of social media on mental health is still being studied.", "That's a valid point; research is ongoing."]
              ],
              "against" => [
                ["Social media can contribute to feelings of isolation and anxiety.", "Exactly! It can be a double-edged sword."],
                ["It often promotes unrealistic standards and comparisons.", "That's a fair concern; it can affect self-esteem."]
              ]
            }
          when "The importance of mental health awareness"
            {
              "for" => [
                ["Raising awareness about mental health can reduce stigma.", "Absolutely! Open conversations are essential."],
                ["Education on mental health can help people recognize symptoms.", "Yes! Early intervention is crucial."],
                ["Support systems can be strengthened through awareness.", "Exactly! Community support is vital."],
                ["It can lead to early intervention and better outcomes.", "Absolutely, awareness can save lives."],
                ["Mental health awareness can lead to more compassionate communities.", "Exactly! It fosters empathy and understanding."]
              ],
              "neutral" => [
                ["Some people may not understand mental health issues.", "That's true; education is key."],
                ["Mental health awareness campaigns can sometimes be misunderstood.", "Absolutely, clarity in messaging is important."],
                ["Not everyone feels comfortable discussing mental health.", "That's a valid point; it can be a sensitive topic."]
              ],
              "against" => [
                ["Some argue that mental health awareness can lead to over-diagnosis.", "That's a fair concern; balance is needed."]
              ]
            }
          when "The impact of climate change on wildlife"
            {
              "for" => [
                ["Climate change poses a significant threat to biodiversity.", "Absolutely! Many species are at risk."],
                ["Conservation efforts are crucial to protect endangered species.", "Yes! We must act to preserve our planet's wildlife."],
                ["Raising awareness can lead to more support for conservation.", "Exactly! Education is key to driving change."],
                ["Conservation efforts can lead to healthier ecosystems.", "Absolutely, it supports the balance of nature."]
              ],
              "neutral" => [
                ["Some people may not see the immediate effects of climate change on wildlife.", "That's true; it often requires long-term observation."],
              ],
              "against" => [
                ["Some argue that climate change is exaggerated for political gain.", "That's a fair point; skepticism exists."],
                ["The costs of implementing conservation measures can be high.", "Exactly, funding is a significant barrier."],
                ["Not everyone agrees on the best solutions to protect wildlife.", "Absolutely, it's a complex issue with many perspectives."],
                ["The focus on climate change can overshadow other important issues.", "That's a valid concern; we need to find a balance."]
              ]
            }
          when "The role of art in society"
            {
              "for" => [
                ["Art can inspire social change and raise awareness.", "Absolutely! It has the power to move people."],
                ["Creative expression is essential for mental well-being.", "Yes! It allows individuals to process emotions."],
                ["Art fosters community and connection among people.", "Exactly! It brings people together."],
                ["It can provide a platform for activism and social change.", "Absolutely, it has the power to mobilize people."],
                ["Art can promote empathy and understanding among diverse groups.", "Exactly! It bridges gaps and fosters unity."]
              ],
              "neutral" => [
                ["Not everyone appreciates art in the same way.", "That's true; personal preferences vary."],
                ["The value of art can be subjective.", "Absolutely, it often depends on individual interpretation."],
                ["Art can sometimes be seen as elitist.", "That's a valid concern; accessibility is important."],
                ["The focus on art can overshadow other important issues.", "That's a valid concern; we need to find a balance."]
              ],
              "against" => [
                ["Some argue that art funding should be redirected to essential services.", "That's a fair point; priorities matter."],
                ["Art can be seen as a luxury rather than a necessity.", "Exactly, basic needs should come first."],
                ["Not all art is universally appreciated.", "Absolutely, taste is subjective."],
                ["The focus on art can overshadow other important issues.", "That's a valid concern; we need to find a balance."],
                ["Not everyone agrees on the best ways to promote art.", "Absolutely, it's a complex issue with many perspectives."]
              ]
            }
          when "The influence of technology on relationships"
            {
              "for" => [
                ["Technology can help maintain long-distance relationships.", "Absolutely! It bridges the gap."],
                ["Social media allows us to connect with friends and family easily.", "Yes! It keeps us in touch."]
              ],
              "neutral" => [
                ["Some people may feel overwhelmed by constant connectivity.", "That's true; balance is key."]
              ],
              "against" => [
                ["Over-reliance on technology can weaken face-to-face interactions.", "Exactly! Personal connection is vital."],
                ["Social media can contribute to feelings of isolation.", "That's a fair concern; moderation is key."]
              ]
            }
          when "The future of renewable energy"
            {
              "for" => [
                ["Investing in renewable energy is crucial for sustainability.", "Absolutely! It's essential for our planet's future."],
                ["Renewable energy can reduce our dependence on fossil fuels.", "Yes! Transitioning is vital."]
              ],
              "neutral" => [
                ["Some people may be skeptical about the feasibility of renewable energy.", "That's true; it requires significant investment."],
                ["The transition to renewable energy can be slow.", "Absolutely, it takes time to implement changes."],
                ["Not all regions have equal access to renewable energy resources.", "That's a valid concern; infrastructure is key."]
              ],
              "against" => [
                ["Some argue that renewable energy sources can be unreliable.", "That's a fair point; consistency is important."],
                ["The costs of implementing renewable energy can be high.", "Exactly, funding is a significant barrier."],
                ["Not everyone agrees on the best solutions for renewable energy.", "Absolutely, it's a complex issue with many perspectives."]
              ]
            }
          when "The significance of cultural diversity"
            {
              "for" => [
                ["Cultural diversity enriches our communities.", "Absolutely! It brings different perspectives."],
                ["Embracing diversity can lead to innovation and creativity.", "Yes! It fosters new ideas."],
                ["Cultural exchange promotes understanding and tolerance.", "Exactly! It helps bridge gaps between people."]
              ],
              "neutral" => [
                ["Some people may not appreciate cultural diversity.", "That's true; education is key."]
              ],
              "against" => [
                ["Some argue that cultural diversity can lead to division.", "That's a fair point; balance is needed."],
                ["The focus on diversity can overshadow other important issues.", "Exactly, all aspects of society matter."],
                ["Not everyone agrees on the best ways to promote cultural diversity.", "Absolutely, it's a complex issue with many perspectives."]
              ]
            }
          when "Life after death"
            {
              "for" => [
                ["I’ve read so many stories about near-death experiences, and they all sound so similar—bright lights, peace, and seeing loved ones. How can that just be coincidence?",
                 "Exactly! There’s too much consistency in these stories for it to be random imagination."],
                ["Even ancient cultures believed in some form of an afterlife. It’s like humanity has always had this instinctive belief that there’s something more beyond this life.",
                 "Totally agree. The fact that this belief spans across time and cultures says a lot."],
                ["There’s just no way this life is all there is. The soul feels too powerful to just vanish into nothing after death.",
                 "Yes! The idea of our consciousness just disappearing doesn’t make sense to me either."],
                ["The experiences people describe during near-death events often include knowledge or visions they couldn’t have known otherwise.",
                  "Absolutely. Some accounts involve details that can’t be easily explained by science."],
                ["Quantum physics suggests the possibility of parallel dimensions or alternate realities. Couldn’t the afterlife exist in one of those?",
                "Exactly! Modern science opens the door to possibilities we’re just beginning to understand."],
                ["The idea of energy conservation aligns with the belief in an afterlife. Energy doesn’t disappear; it transforms.",
                "Yes! If our consciousness is a form of energy, it makes sense it would continue in some way."],
                ["Many spiritual traditions emphasize that death is not the end but a transition. This belief resonates across countless cultures.",
                "Totally agree. Shared beliefs like these often stem from deep truths."]
              ],
              "neutral" => [
                ["I’m open to the idea, but it’s hard to say for sure. Near-death experiences could just be the brain reacting to trauma.",
                 "That’s true, but even then, the vividness and common themes are hard to ignore."],
                ["It’s fascinating to think about, but without solid evidence, it’s just speculation at this point.",
                 "I agree. It’s a mystery that might never be solved, but it’s fun to explore the possibilities."]
              ],
              "against" => [
                ["I think it’s all wishful thinking. People just don’t want to accept that death is the end, so they create these comforting stories.",
                 "Totally. The idea of an afterlife feels more like a coping mechanism than anything else."],
                ["Science hasn’t proven anything about life after death, and until it does, I don’t see a reason to believe in it.",
                 "Yeah, without evidence, it’s hard to take these stories seriously."],
                ["Near-death experiences can be explained by brain activity during trauma—it’s not evidence of an afterlife.",
                 "Exactly. It’s just the brain doing weird things under stress, nothing more."],
                ["Belief in an afterlife is often rooted in cultural or religious upbringing, not in objective reality.",
                 "Exactly. It’s hard to separate these beliefs from societal conditioning."],
                ["If there really were life after death, we’d have more concrete evidence by now—something that couldn’t be dismissed as anecdotal.",
                 "Totally agree. All we have are stories, not proof."]
              ]
            }

          end

  sides.each do |status, comments_with_replies|
    comments_with_replies.each do |comment, reply|
      # Create the top-level comment
      parent_user = users.pop
      if parent_user
        parent_comment = Comment.create!(
          content: comment,
          status: status,
          user: parent_user,
          topic: topic
        )

        # Create the reply
        reply_user = users.pop
        if reply_user
          Comment.create!(
            content: reply,
            status: status,
            user: reply_user,
            topic: topic,
            parent_id: parent_comment.id
          )
        else
          puts "Warning: No available user for reply to comment: '#{comment}'"
        end
      else
        puts "Warning: No available user for comment: '#{comment}'"
      end
    end
  end
end

puts "Comments and replies created successfully!"
puts "Seeding complete!"

# Add random votes to comments
puts "-" * 25
puts "Adding random votes to comments..."
puts "-" * 25

users = User.all
comments = Comment.all

comments.each do |comment|
  # Generate a random number of votes (1 to 10)
  rand(1..10).times do
    voter = users.sample

    # Ensure no duplicate votes from the same user on the same comment
    unless Vote.exists?(user_id: voter.id, comment_id: comment.id)
      Vote.create!(
        user: voter,
        comment: comment
      )
    end
  end
end

puts "Votes added successfully! Total votes: #{Vote.count}"
