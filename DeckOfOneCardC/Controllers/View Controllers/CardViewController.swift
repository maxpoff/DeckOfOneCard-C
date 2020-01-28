//
//  CardViewController.swift
//  DeckOfOneCardC
//
//  Created by Maxwell Poffenbarger on 1/28/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var drawCardButton: UIButton!
    @IBOutlet weak var cardImage: UIImageView!
    
    //MARK: - Properties
//    var card: MOPCard? {
//        didSet {
//            updateViews()
//        }
//    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCards()
    }
    
    //MARK: - Private Methods
    func updateViews(card: MOPCard, image: UIImage) {
        self.cardImage.image = image
        self.suitLabel.text = card.suit
    }
    
    func fetchCards() {
        MOPCardController.drawNewCard(1) { (cards) in
            if let cards = cards {
                MOPCardController.fetchCardImage(cards[0]) { (cardImage) in
                    DispatchQueue.main.async {
                        if let cardImage = cardImage {
                            self.updateViews(card: cards[0], image: cardImage)
                        }
                    }
                }
            }
        }
    }

    
    //MARK: - Actions
    @IBAction func drawCardTapped(_ sender: Any) {
        self.fetchCards()
    }
    

}//End of class
