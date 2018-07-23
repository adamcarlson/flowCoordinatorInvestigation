//
//  Entity.swift
//  flowCoordinatorInvestigation
//
//  Created by Adam Carlson on 7/19/18.
//  Copyright © 2018 adam. All rights reserved.
//

import Foundation
import UIKit

struct Entity {
    let name: String
    let description: String

    let id: UUID

    let color: UIColor
}

extension Entity {
    static func generateTestEntities() -> [Entity] {
        return [
            Entity(name: "The Lord of the Rings: The Fellowship of the Ring", description: "A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.", id: UUID(), color: .blue),
            Entity(name: "House of cards", description: "A Congressman works with his equally conniving wife to exact revenge on the people who betrayed him.", id: UUID(), color: .purple),
            Entity(name: "The Incredibles", description: "A family of undercover superheroes, while trying to live the quiet suburban life, are forced into action to save the world.", id: UUID(), color: .red),
            Entity(name: "Shrek", description: "After his swamp is filled with magical creatures, Shrek agrees to rescue Princess Fiona for a villainous lord in order to get his land back.", id: UUID(), color: .green),
            Entity(name: "Ratatouille", description: "A rat who can cook makes an unusual alliance with a young kitchen worker at a famous restaurant.", id: UUID(), color: .gray),
            Entity(name: "Aquaman", description: "Arthur Curry learns that he is the heir to the underwater kingdom of Atlantis, and must step forward to lead his people and to be a hero to the world.", id: UUID(), color: UIColor(red: 0, green: 0.2, blue: 0.6, alpha: 1)),
            Entity(name: "The Lego Movie", description: "An ordinary LEGO construction worker, thought to be the prophesied as 'special', is recruited to join a quest to stop an evil tyrant from gluing the LEGO universe into eternal stasis.", id: UUID(), color: .orange),
            Entity(name: "Big Hero 6", description: "The special bond that develops between plus-sized inflatable robot Baymax, and prodigy Hiro Hamada, who team up with a group of friends to form a band of high-tech heroes.", id: UUID(), color: .lightGray),
            Entity(name: "Gladiator", description: "When a Roman General is betrayed, and his family murdered by an emperor's corrupt son, he comes to Rome as a gladiator to seek revenge.", id: UUID(), color: .brown),
            Entity(name: "Old Yeller", description: "A teenage boy grows to love a stray yellow dog while helping his mother and younger brother run their Texas homestead while their father is away on a cattle drive. First thought to be good-for-nothing mutt, Old Yeller is soon beloved by all.", id: UUID(), color: .yellow),
        ]
    }
}
