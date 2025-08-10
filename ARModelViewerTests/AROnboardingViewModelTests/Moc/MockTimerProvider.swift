//
//  MockTimerProvider.swift
//  ARModelViewerTests
//
//  Created by Dmitriy Eliseev on 10.08.2025.
//

import Foundation
import Combine
@testable import ARModelViewer

final class MockTimerProvider: ITimerProvider {
    func start(every interval: TimeInterval) -> AnyPublisher<Date, Never> {
        // Используем таймер с небольшими интервалами для имитации
        return Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .prefix(4)
            .eraseToAnyPublisher()
    }
}
