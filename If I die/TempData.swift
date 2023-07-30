

import Foundation


struct Confidant {
    var name: String
    var email: String
    var isRegistred: Bool
    var isConfirmedParticipationForYou: Bool
    var isOnForYou: Bool
}

var confidants: [Confidant] = [Confidant(name: "Иван Караваев", email: "1234567@gmail.com", isRegistred: true, isConfirmedParticipationForYou: true, isOnForYou: true),
                               Confidant(name: "Людмила Миханковская", email: "1234567@gmail.com", isRegistred: false, isConfirmedParticipationForYou: true, isOnForYou: true),
                               Confidant(name: "Валерия Ильинична", email: "1234567@gmail.com", isRegistred: true, isConfirmedParticipationForYou: false, isOnForYou: true),
                               Confidant(name: "Константин Сергеевич", email: "1234567@gmail.com", isRegistred: true, isConfirmedParticipationForYou: true, isOnForYou: false),
                               Confidant(name: "Ксения Александровна", email: "1234567@gmail.com", isRegistred: false, isConfirmedParticipationForYou: false, isOnForYou: false)]


struct Will {
    var title: String
    var text: String
    var dateForSend: Data
    var recipients: [Confidant]
    var isOn: Bool
}

var wills: [Will] = [Will(title: "Первое сообщение",
                          text: "На столе стоял стул стол и пишущая машинка. На улице стояла ночь.",
                          dateForSend: Data(),
                          recipients: [confidants[0], confidants[3]],
                          isOn: true),
                     Will(title: "Второе сообщение",
                          text: "Эх рано встает охрана. Такие вот дела. Да да да да. Кавабанга.",
                          dateForSend: Data(),
                          recipients: [confidants[0], confidants[3], confidants[1]],
                          isOn: false),
                     Will(title: "Третье сообщение",
                          text: "Мама мыла раму. Рама мыла маму. Корабли лавировали лавировали да не вылавировали.",
                          dateForSend: Data(),
                          recipients: [confidants[2], confidants[4]],
                          isOn: false)]
