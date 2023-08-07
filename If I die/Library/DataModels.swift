

import Foundation
import FirebaseFirestoreSwift


struct User: Codable {
    var userId: String
    var name: String
    var email: String
    var password: String
    
    var hisConfidantsSendRequest: [String]
    var hisConfidantsActual: [String]
    
    var askingHimBeConfidant: [String]
    var heAgreedBeConfidantFor: [String]
    
    var messages: [Message]
    
    var isAlive: Bool
    var whoConfirmDeath: [String]
    var dateOfDeath: Date?
}

struct Message: Codable {
    var messageId: Int
    
    var title: String
    var text: String
    
    var whomToSend: [String]
    var daysAfterDeathToSend: Int
    var lastEditDate: Date
}
