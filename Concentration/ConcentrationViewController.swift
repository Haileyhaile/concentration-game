//
//  ViewController.swift
//  Concentration
//
//  Created by Hailey Le on 6/17/20.
//  Copyright © 2020 Hailey Le. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        } // if it is read only property like this one, we don't need get {}, only return
    }
    
    
    private(set) var flipCount = 0 //or var flipCount: Int = 0. flipCount = 0 suggests that flipCount is an int
    {
        didSet{
            //updateFlipCountLabel()
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    private(set) var score = 0
    
    
   
    //action creates a method
    //outlet creates an instant variable
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            //updateFlipCountLabel()
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        newGame()
    }
    
    
    
    private func newGame() {
        flipCount = 0
        score = 0
        updateViewFromModel()
        
    }
    
    
    @IBOutlet private var cardButtons: [UIButton]! //[UIButton] an array of UIButton
    //To rename: Control click
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) //use let if something is a constant, not var
        {
            
            game.chooseCard(at: cardNumber)
            if game.gameOver()
            {
                //updateViewFromModel()
                //sleep(1)
                if flipCount < 35
                {
                    score += 10
                }
                self.navigationController?.popToRootViewController(animated: true)
                newGame()
            }
            updateViewFromModel()
        }
        else
        {
            print("Card is not in cardButtons")
        }
        
    }
    
    
    private func updateViewFromModel()
    {
        if cardButtons != nil {
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                score -= 1
            }
            else
            {
                let matched = card.isMatched ? "🤍" : ""
                button.setTitle(matched, for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9803921569, green: 0.7320581317, blue: 0.709067235, alpha: 0) : #colorLiteral(red: 0.9803921569, green: 0.7320581317, blue: 0.709067235, alpha: 1)
                score += 3
            }
        }
        }
    }
    
    // _ means there is no external name
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
}

//private var emojiChoices = ["🌸", "🌼", "🌻", "🌺", "🌷", "🌹", "🍀", "🍁", "🌿", "🌱"]
private var emojiChoices = "🌸🌼🍄🌺🌷🌹🍀🍁🌿🌱🌾💐🌴🌳🌵🌻"

private var emoji = [Card:String]()

private func emoji(for card: Card) -> String
{
    if emoji[card] == nil
    {
        if emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
    }
    return emoji[card] ?? "?"
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}
/*
extension UIViewController {
    func performSegueToReturnBack ()
    {
        if let nav = self.navigationController
        {
            nav.popViewController(animated: true)
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
*/
