

import Foundation
import FirebaseFirestoreSwift


struct User: Codable {
    var userId: String
    var name: String
    var email: String
    var password: String
    
    //юзер просит их стать его ДЛ
    var hisConfidantsSendRequest: [String]
    //актуальные ДЛ юзера
    var hisConfidantsActual: [String]
    
    //просят юзера стать их ДЛ
    var askingHimBeConfidant: [String]
    //юзер согласился стать их ДЛ
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
