//
//  AROnboardingViewModelTests.swift
//  ARModelViewerTests
//
//  Created by Dmitriy Eliseev on 10.08.2025.
//

import XCTest
import Combine
@testable import ARModelViewer

final class AROnboardingViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testInitialStateWhenOnboardingNotFinished() {
        let mockStorage = MockStorageService()
        // В моках ключ не установлен => onboarding не завершен
        let viewModel = AROnboardingViewModel(storage: mockStorage, timerProvider: MockTimerProvider(), shouldStartTimer: false)
        
        XCTAssertFalse(viewModel.didFinishOnboarding)
        XCTAssertEqual(viewModel.data, Onboarding.data.first)
    }
    
    func testInitialStateWhenOnboardingFinished() {
        let mockStorage = MockStorageService()
        mockStorage.setKey(key: Onboarding.storageKey)
        
        let viewModel = AROnboardingViewModel(storage: mockStorage, timerProvider: MockTimerProvider(), shouldStartTimer: false)
        
        XCTAssertTrue(viewModel.didFinishOnboarding)
    }
    
    func testTimerCyclesThroughOnboardingSteps() {
            let mockStorage = MockStorageService()
            let mockTimer = MockTimerProvider()

            let viewModel = AROnboardingViewModel(storage: mockStorage, timerProvider: mockTimer)

            let expectation = XCTestExpectation(description: "Onboarding data updates as timer emits")
            expectation.expectedFulfillmentCount = 4

            var receivedSteps = [OnboardingStep]()

            viewModel.$data
                .dropFirst()
                .sink { step in
                    print("Received step:", step.text)
                    receivedSteps.append(step)
                    expectation.fulfill()
                }
                .store(in: &cancellables)

            wait(for: [expectation], timeout: 0.5)

            XCTAssertEqual(receivedSteps.count, 4)
            XCTAssertEqual(receivedSteps[0], Onboarding.data[1])
            XCTAssertEqual(receivedSteps[1], Onboarding.data[2])
            XCTAssertEqual(receivedSteps[2], Onboarding.data[3])
            XCTAssertEqual(receivedSteps[3], Onboarding.data[0])
        }
    
    func testSkipOnboardingSetsFlagAndStopsTimer() {
        // given
        let mockStorage = MockStorageService()
        let mockTimer = MockTimerProvider()
        let viewModel = AROnboardingViewModel(storage: mockStorage, timerProvider: mockTimer)
        
        // when
        viewModel.skipOnboarding()
        
        // then
        XCTAssertTrue(viewModel.didFinishOnboarding)
        XCTAssertTrue(mockStorage.getKey(key: Onboarding.storageKey))
    }
    
}
