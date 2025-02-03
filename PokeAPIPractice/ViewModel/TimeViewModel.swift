//
//  TimeViewModel.swift
//  PokeAPIPractice
//
//  Created by Mateo Andres Perano on 03/02/2025.
//

import Foundation
import UserNotifications

class TimeViewModel: ViewModelBase {
    
    private let webService = WebService()
    @Published var timeApi : TimeAPIResponse?

    
    func getTime() {
        self.loadingState = .loading
        webService.getTokyoHour { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.timeApi = data
                    self.loadingState = .success
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self.loadingState = .failed
                    
                }
            }
        }
    }
}
