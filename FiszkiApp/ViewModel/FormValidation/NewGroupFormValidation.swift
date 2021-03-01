//
//  NewGroupFormValidation.swift
//  fiszki
//
//  Created by Leopold on 18/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol FormViewModel {
    func updateForm()
}

struct NewGroupViewModel {
    
    var groupTitleTextField: String?
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    var buttonBackgroundColor: UIColor {
        let enabledColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        let disabledColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledColor : disabledColor
    }
    
    private var formIsValid: Bool {
        groupTitleTextField?.isEmpty == false
    }
    
    var shouldEnableButton: Bool {
        return formIsValid
    }
}

class NewFlashCardViewModel {
    
    var termTextField: String?
    var definitionTextField: String?
    
    let termTextFieldPublishSubject = PublishSubject<String>()
    let definitionTextFieldPublishSubject = PublishSubject<String>()
    
    func formIsValid() -> Observable<Bool> {
        
        Observable.combineLatest(termTextFieldPublishSubject.asObservable().startWith(""),
                                 definitionTextFieldPublishSubject.asObservable().startWith("")).map { (term, definition) in
            return term.count > 0 && definition.count > 0
        }.startWith(false)
    } 
}

struct EditFlashCardViewModel {
    
    var termTextField: String?
    var definitionTextField: String?
    
    var formIsValid: Bool {
        termTextField?.isEmpty == false
        && definitionTextField?.isEmpty == false
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    var buttonBackgroundColor: UIColor {
        let enabledColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        let disabledColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledColor : disabledColor
    }
      
    var shouldEnableButton: Bool {
        return formIsValid
    }
}

struct SwipeFlashCardViewModel {
    
    var cardViewsArray: Int?
    
    var formIsValid: Bool {
        cardViewsArray == 0
    }
    
    var shouldHideDeckView: Bool {
        return formIsValid ? true : false
    }
    
    var shouldEnableButton: Bool {
        return formIsValid
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    var buttonBackgroundColor: UIColor {
        let enabledColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1)
        let disabledColor = #colorLiteral(red: 0.05098039216, green: 0.4392156863, blue: 0.9960784314, alpha: 1).withAlphaComponent(0.5)
        return formIsValid ? enabledColor : disabledColor
    }
}
