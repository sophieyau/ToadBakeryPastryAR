//
//  Pastry.swift
//  ToadBakeryARPastryQuiz
//
//  Created by Sophie Yau on 24/04/2023.
//

struct Pastry: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let imageName: String

    static let all: [Pastry] = [
        
        Pastry(id: 0, name: "Cheesy Puff", description: "You are a boring basic bitch. Get a life.", imageName: "cheesypuff"),
        Pastry(id: 1, name: "Soy Sauce Chocolate chip cookie", description: "You're a sophisticated individual who appreciates the finer things in life. You have a sweet tooth, and won't say no to a sweet espresso martini at 2pm in the afternoon...You have an impeccable sense of style and a flair for the dramatic. People are drawn to your elegance, grace, and the air of mystery that surrounds you.", imageName: "soysaucechoco"),
        Pastry(id: 2, name: "Yuzu, Orange & Almond Jaffa Mini Cake", description: "You're a curious soul, always eager to learn and explore new ideas. You love a good challenge and are never content with settling for the ordinary.Friends admire your quick wit and your ability to make even the most mundane situations entertaining.", imageName: "yuzualmond"),
        Pastry(id: 3, name: "Rhubarb and Pandan croissant", description: "You're a nature lover who finds solace in the great outdoors. You're a free spirit with a whimsical charm, and you're not afraid to show your true colors. When you walk into a room, people can't help but be drawn to your vibrant energy.", imageName: "rhubarbpandan"),
        Pastry(id: 4, name: "Mambow Steak Bake w/ pickled Daikon", description: "You're bold, adventurous, and never afraid to try new things. You're a trendsetter, always up-to-date with the latest fads and styles. You appreciate the unexpected and when it comes to life, you're not just along for the ride - you're the one driving!", imageName: "steakbake")
    ]

    static let example: Pastry = all[0]
}
