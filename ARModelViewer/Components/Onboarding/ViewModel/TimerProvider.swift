//
//  TimerProvider.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 08.08.2025.
//

import Foundation
import Combine

protocol ITimerProvider {
    func start(every interval: TimeInterval) -> AnyPublisher<Date, Never>
}

/// Timer service for DI and testing
final class TimerProvider: ITimerProvider {
    func start(every interval: TimeInterval) -> AnyPublisher<Date, Never> {
        Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .eraseToAnyPublisher()
    }
}
