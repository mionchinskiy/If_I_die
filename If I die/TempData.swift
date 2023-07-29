

import Foundation


struct Confidant {
    var name: String
    var email: String
    var isRegisterd: Bool
    var isConfirmedParticipationForYou: Bool
    var isOnForYou: Bool
}

var confidants: [Confidant] = [Confidant(name: "Иван Васильевич", email: "1234567@gmail.com", isRegisterd: true, isConfirmedParticipationForYou: true, isOnForYou: true),
                               Confidant(name: "Людмила Петровна", email: "1234567@gmail.com", isRegisterd: false, isConfirmedParticipationForYou: true, isOnForYou: true),
                               Confidant(name: "Валерия Ильинична", email: "1234567@gmail.com", isRegisterd: true, isConfirmedParticipationForYou: false, isOnForYou: true),
                               Confidant(name: "Константин Сергеевич", email: "1234567@gmail.com", isRegisterd: true, isConfirmedParticipationForYou: true, isOnForYou: false),
                               Confidant(name: "Ксения Александровна", email: "1234567@gmail.com", isRegisterd: false, isConfirmedParticipationForYou: false, isOnForYou: false)]


struct Will {
    var title: String
    var text: String
    var dataForSend: Data
    var recipients: [Confidant]
    var isOn: Bool
}

var wills: [Will] = [Will(title: "Первое сообщение",
                          text: "На столе стоял стул стол и пишущая машинка. На улице стояла ночь.",
                          dataForSend: Data(),
                          recipients: [confidants[0], confidants[3]],
                          isOn: true),
                     Will(title: "Второе сообщение",
                          text: "Эх рано встает охрана. Такие вот дела. Да да да да. Кавабанга.",
                          dataForSend: Data(),
                          recipients: [confidants[0], confidants[3], confidants[1]],
                          isOn: false),
                     Will(title: "Третье сообщение",
                          text: "Мама мыла раму. Рама мыла маму. Корабли лавировали лавировали да не вылавировали.",
                          dataForSend: Data(),
                          recipients: [confidants[2], confidants[4]],
                          isOn: false)]
