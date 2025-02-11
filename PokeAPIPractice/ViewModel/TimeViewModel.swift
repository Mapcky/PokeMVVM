//
//  TimeViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 03/02/2025.
//

import Foundation
import UserNotifications

class TimeViewModel: ObservableObject {
    
    private let webService = WebService()
    @Published var timeApi: TimeAPIResponse?
    @Published var isMidnight: Bool = false
    @Published var randomDailyNumber: Int = 0

    private let lastOpenKey = "lastAppOpenDate"
    private let randomNumberKey = "randomNumber"
    
    init(timeApi: TimeAPIResponse? = nil) {
        self.timeApi = timeApi
        self.randomDailyNumber = UserDefaults.standard.integer(forKey: randomNumberKey)
        
        if self.randomDailyNumber == 0 {
            self.generateRandomNumber()
        }
        
        requestNotificationPermission()
        getTime()
        checkLastOpenTime()
        scheduleMidnightNotification()
    }
    
    func getTime() {
        webService.getTokyoHour { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.timeApi = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func saveCurrentTimeAsLastOpen() {
        let now = Date()
        UserDefaults.standard.set(now, forKey: lastOpenKey)
    }

    func checkLastOpenTime() {
        guard let lastOpen = UserDefaults.standard.object(forKey: lastOpenKey) as? Date else { return }
        webService.getTokyoHour { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let lastOpenTokyo = self.convertToTokyoTime(date: lastOpen),
                       let currentTokyo = self.convertToTokyoTimeFromString(data.dateTime) {
                        
                        let lastGeneratedDate = UserDefaults.standard.object(forKey: "lastGeneratedDate") as? Date
                        
                        if lastGeneratedDate == nil || !Calendar.current.isDate(lastGeneratedDate!, inSameDayAs: currentTokyo.date!) {
                            
                            if lastOpenTokyo.day != currentTokyo.day {
                                self.sendNotification()
                                self.generateRandomNumber()
                                self.isMidnight = true
                                
                                UserDefaults.standard.set(currentTokyo.date!, forKey: "lastGeneratedDate")
                            }
                            else {
                                self.isMidnight = false
                            }
                        }
                    }
                    
                case .failure(let error):
                    print("❌ Error al obtener la hora de Tokio: \(error.localizedDescription)")
                }
            }
        }
    }

    
    
    
    func convertToTokyoTime(date: Date) -> DateComponents? {
        let tokyoTimeZone = TimeZone(identifier: "Asia/Tokyo")!
        let calendar = Calendar.current
        return calendar.dateComponents(in: tokyoTimeZone, from: date)
    }
    
    func convertToTokyoTimeFromString(_ dateTime: String) -> DateComponents? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"  // Fracciones de segundo
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")  // Zona horaria de Tokio
        
        guard let date = formatter.date(from: dateTime) else {
            return nil
        }
        
        return convertToTokyoTime(date: date)
    }

    func scheduleMidnightNotification() {
        let content = UNMutableNotificationContent()
        content.title = "¡Nuevo Día en Tokio!"
        content.body = "Un nuevo Pokémon te espera 🕛🌟"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateComponents.hour = 0
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "tokyoMidnight", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "¡Nuevo Día en Tokio!"
        content.body = "Un nuevo Pokémon te espera 🕛🌟"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "tokyoMidnight", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func generateRandomNumber() {
        randomDailyNumber = Int.random(in: 1...1025)
        UserDefaults.standard.set(randomDailyNumber, forKey: randomNumberKey)
    }
    
}
