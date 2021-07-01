//
//  Task.swift
//  TahDoodle
//
//  Created by Andrei Korikov on 29.06.2021.
//

import Foundation

struct Task: Equatable, Identifiable, Codable {
    let title: String
    let id: UUID
    
    init(title: String) {
        self.title = title
        id = UUID()
    }
}
