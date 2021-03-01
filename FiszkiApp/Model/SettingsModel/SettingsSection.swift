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
        case .General: return "General"
        case .Contact: return "Contact"
        }
    }
}

enum GeneralOptions: Int, CaseIterable, CustomStringConvertible {
    
    case data
    
    var description: String {
        switch self {
        case .data: return "Remove data"
        }
    }
}

enum ContactOptions: Int, CaseIterable, CustomStringConvertible {
    
    case reportBug
    case sendMessage
    
    var description: String {
        switch self {
        case .reportBug: return "Report a bug"
        case .sendMessage: return "Contact with us"
        }
    }
}
