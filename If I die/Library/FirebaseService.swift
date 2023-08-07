

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseService {
    
    static let shared = FirebaseService()
    
    let db = Firestore.firestore()
    let usersCollection = Firestore.firestore().collection("users")
    
    
    func createAccount(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            } else {
                guard let userId = authResult?.user.uid else {
                    completion(.failure(FirebaseError.createUserIdWasntReceived))
                    return
                }
                
                let newUser = User(userId: userId,
                                   name: "Имярек Фамилиев",
                                   email: email,
                                   password: password,
                                   hisConfidantsSendRequest: [],
                                   hisConfidantsActual: [],
                                   askingHimBeConfidant: [],
                                   heAgreedBeConfidantFor: [],
                                   messages: [Message(messageId: 0,
                                                      title: "Пример заголовка",
                                                      text: "Пример текста сообщения",
                                                      whomToSend: [],
                                                      daysAfterDeathToSend: 0,
                                                      lastEditDate: Date())],
                                   isAlive: true,
                                   whoConfirmDeath: [],
                                   dateOfDeath: nil)
                
                self?.addUser(user: newUser)
                
                completion(.success(Void()))
            }
        }
    }
    


    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let authResult = authResult {
                    let userId = authResult.user.uid
                    
                    self?.fetchUser(userId: userId) { result in
                        switch result {
                        case .success(let user):
                            completion(.success(user))
                        case .failure(let error):
                            completion(.failure(error))
                            print("ошибочка выходит")
                        }
                    }
                } else {
                    completion(.failure(FirebaseError.notReceivedUidDuringAuthorization))
                }
            }
    }
    
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Error signing out: \(error)")
        }
    }
    
    

    
//    func updateUserEmail(newEmail: String, completion: @escaping (Error?) -> Void) {
//        if let user = Auth.auth().currentUser {
//            user.updateEmail(to: newEmail) { (error) in
//                completion(error)
//            }
//        } else {
//            completion(NSError(domain: "Firebase", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"]))
//        }
//    }
    

    

    
    private func addUser(user: User) {
      do {
          try db.collection("users").document(user.userId).setData(from: user)
      }
      catch {
        print(error)
      }
    }
    
    
    
    func updateUser(user: User) {
        let docRef = db.collection("users").document(user.userId)
        do {
          try docRef.setData(from: user)
        }
        catch {
          print(error)
        }
    }
    
    
    
    private func fetchUser(userId: String, completion: @escaping (Result<User,Error>) -> Void) {
      let docRef = db.collection("users").document(userId)
        
        docRef.getDocument(as: User.self) { result in
        switch result {
        case .success(let user):
            completion(.success(user))
        case .failure(let error):
            completion(.failure(error))
        }
      }
    }
    
    
    
    func getUserDataBy(email: String, completion: @escaping (Result<User,Error>) -> Void) {
            db.collection("users").whereField("email", isEqualTo: email).getDocuments { querySnapshot, err in
                if let err = err {
                    completion(.failure(FirebaseError.userWithThisEmailDoesNotExist))
                    print(err.localizedDescription)
                    return
                } else {
                    guard let snapshot = querySnapshot else {
                        completion(.failure(FirebaseError.querySnapshotIsNil))
                        return
                    }
                    guard !snapshot.documents.isEmpty else {
                        completion(.failure(FirebaseError.userWithThisEmailDoesNotExist))
                        return
                    }
                    guard snapshot.documents.count == 1 else {
                        completion(.failure(FirebaseError.thereAreSeveralAccountsWithThisEmail))
                        return
                    }
                    guard let user = querySnapshot?.documents[0] as? User else {
                        print("не удается привести querySnapshot?.documents[0] к типу данных User")
                        return
                    }
                    completion(.success(user))
                }
            }
    }
    
    
    
    
}


enum FirebaseError: String, Error {
    case createUserIdWasntReceived = "userId не был получен при регистрации"
    case dontCreateFirstFirestoreDocument = "Хранилище Firestore не было создано при регистрации"
    case notReceivedUidDuringAuthorization = "Не получен uid при авторизации"
    case thereAreSeveralAccountsWithThisEmail = "Существует несколько аккаунтов с заданным email"
    case userWithThisEmailDoesNotExist = "пользователя с таким почтовым адресом не существует"
    case querySnapshotIsNil = "значение полученного querySnapshot - nil"
}
