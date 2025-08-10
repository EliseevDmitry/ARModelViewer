//
//  AROnboardingViewModel.swift
//  ARModelViewer
//
//  Created by Dmitriy Eliseev on 07.08.2025.
//

import Foundation
import Combine

final class AROnboardingViewModel: ObservableObject {
    @Published var data: OnboardingStep
    @Published var didFinishOnboarding: Bool
    private let storageService: IStorageService
    private let timerProvider: ITimerProvider
    private let onboardingData: [OnboardingStep]
    private var currentIndex = 0
    private var timer: AnyCancellable?
    
    // MARK: - Initialization
    /// Initializes the onboarding view model with dependency injection for storage and timer services
    /// This enables easier testing with mock implementations
    /// - Parameters:
    ///   - storage: Storage service for persisting onboarding completion state
    ///   - timerProvider: Timer provider to control step switching timing
    ///   - onboardingData: Array of onboarding steps to display
    ///   - shouldStartTimer: Flag to control whether the auto-advancing timer should start immediately
    init(
        storage: IStorageService = Storage(),
        timerProvider: ITimerProvider = TimerProvider(),
        onboardingData: [OnboardingStep] = Onboarding.data,
        shouldStartTimer: Bool = true
    ) {
        self.storageService = storage
        self.timerProvider = timerProvider
        self.onboardingData = onboardingData
        self.data = onboardingData[currentIndex]
        let onboarding = storage.getKey(key: Onboarding.storageKey)
        self.didFinishOnboarding = onboarding
        if !didFinishOnboarding && shouldStartTimer {
            setTimer()
        }
    }
    
    deinit {
        deleteTimer()
    }
}

// MARK: - Public Functions
extension AROnboardingViewModel {
    /// Marks onboarding as finished, persists this state, and stops the auto-advancing timer
    func skipOnboarding() {
        deleteTimer()
        setOnboarding()
        didFinishOnboarding = true
    }
}

// MARK: - Private Functions
extension AROnboardingViewModel {
    /// Starts a timer that auto-advances onboarding steps every 4 seconds
    private func setTimer() {
        timer = timerProvider.start(every: 4)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.currentIndex = (self.currentIndex + 1) % self.onboardingData.count
                self.data = self.onboardingData[self.currentIndex]
            }
    }
    
    /// Persists onboarding completion state in storage
    private func setOnboarding() {
        storageService.setKey(key: Onboarding.storageKey)
    }
    
    /// Cancels and invalidates the onboarding timer
    private func deleteTimer() {
        timer?.cancel()
    }
}
