//
//  TimeViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 03/02/2025.
//

import Foundation
import UserNotifications
import Observation

@MainActor
@Observable
class TimeViewModel: ObservableObject {
    // MARK: - PROPERTIES
    private let webService = WebService()
    var timeApi: TimeAPIResponse?
    var randomDailyNumber: Int = 0
    
    private let lastOpenKey = "lastAppOpenDate"
    private let randomNumberKey = "randomNumber"
    
    // MARK: - FUNCTIONS
    init(timeApi: TimeAPIResponse? = nil) {
        self.timeApi = timeApi
        self.randomDailyNumber = UserDefaults.standard.integer(forKey: randomNumberKey)
        
        //First time only
        if self.randomDailyNumber == 0 {
            self.generateRandomNumber()
            saveCurrentTimeAsLastOpen()
        }
        requestNotificationPermission()
        scheduleMidnightNotification()
        checkLastOpenTime()
    }
    
    func saveCurrentTimeAsLastOpen() {
        let now = Date()
        UserDefaults.standard.set(now, forKey: lastOpenKey)
    }
    
    func checkLastOpenTime() {
        guard let lastOpen = UserDefaults.standard.object(forKey: lastOpenKey) as? Date else { return }
        webService.getTokyoHour { result in
            switch result {
            case .success(let data):
                if let lastOpenTokyo = self.convertToTokyoTime(date: lastOpen),
                   let currentTokyo = self.convertToTokyoTimeFromString(data.dateTime) {
                    
                    if lastOpenTokyo.day != currentTokyo.day {
                        self.generateRandomNumber()
                    }//: if =/= day
                    self.saveCurrentTimeAsLastOpen()
                }
            case .failure(let error):
                print("❌ Error getting Tokyo time: \(error.localizedDescription)")
                
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
        content.title = "¡New day on Tokio!"
        content.body = "A new Pokémon is waiting for you 🕛🌟"
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
