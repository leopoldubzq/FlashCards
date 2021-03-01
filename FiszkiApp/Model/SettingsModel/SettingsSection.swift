//
//  SettingsSection.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    
    case General
    case Contact
    
    var description: String {
        switch self {
        case .General: return "Ogólne"
        case .Contact: return "Kontakt"
        }
    }
}

enum GeneralOptions: Int, CaseIterable, CustomStringConvertible {
    
    case data
    
    var description: String {
        switch self {
        case .data: return "Wyzeruj dane"
        }
    }
}

enum ContactOptions: Int, CaseIterable, CustomStringConvertible {
    
    case reportBug
    case sendMessage
    
    var description: String {
        switch self {
        case .reportBug: return "Zgłoś błąd"
        case .sendMessage: return "Skontaktuj się z nami"
        }
    }
}
