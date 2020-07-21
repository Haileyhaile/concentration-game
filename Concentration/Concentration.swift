//
//  Concentration.swift
//  Concentration
//
//  Created by Hailey Le on 6/23/20.
//  Copyright © 2020 Hailey Le. All rights reserved.
//

import Foundation

class Concentration
{
    private(set) var cards = [Card]() //Array<Card>()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    func chooseCard(at index: Int)
    {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index is not in the cards")
        if !cards[index].isMatched
        {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index
            {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    indexOfOneAndOnlyFaceUpCard = nil
                    flipAll()
                }
                else {
                    cards[index].isFaceUp = true
                }
                
            } else
            {
                
                flipAll()
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    func flipAll()
    {
        for cardIndex in cards.indices
        {
            cards[cardIndex].isFaceUp = false
        }
    }
    
    func gameOver() -> Bool
    {
        for thisCard in cards
        {
            if thisCard.isMatched == false
            {
                return false
            }
        }
        indexOfOneAndOnlyFaceUpCard = nil
        flipAll()
        return true
    }
    
    init(numberOfPairsOfCards: Int)
    {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards
        {
            let card = Card()
            //let matchingCard = card
            cards.append(card)
            cards.append(card)
            // same thing: cards += [card, card]
        }
        cards.shuffle()
        
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
