//
//  Service.swift
//  fiszki
//
//  Created by Leopold on 21/01/2021.
//

import UIKit

struct Service {
    
    static func fetchFlashCards(array: [FlashCardItem], deckView: UIView, completion: ((_ cardViews: [CardView], _ cardView: CardView) -> Void)) {
        
        array.forEach { (flashCards) in
            
            guard let term = flashCards.term else { return }
            guard let definition = flashCards.definition else { return }
            
            let cardView = CardView(term: term, definition: definition)
            deckView.addSubview(cardView)
            cardView.fillSuperview()
            
            var cardViews = [cardView]
            
            cardViews = deckView.subviews.map({ ($0 as? CardView)! })
            
            completion(cardViews, cardView)
        }
    }
}
