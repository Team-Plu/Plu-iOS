//
//  GesturePublisher.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/22/23.
//

import UIKit
import Combine

struct GesturePublisher: Publisher {
    
    typealias Output = GestureType
    typealias Failure = Never
    
    private let view: UIView
    
    private let gestureType: GestureType
    
    init(view: UIView, gestureType: GestureType) {
        self.view = view
        self.gestureType = gestureType
    }
    
    func receive<S: Subscriber>(subscriber: S) where Self.Failure == S.Failure, Self.Output == S.Input  {
        let subscription = GestureSubscription(
            subscriber: subscriber,
            gestureType: gestureType,
            view: view
        )
        subscriber.receive(subscription: subscription)
    }
}

final class GestureSubscription<S: Subscriber>: Subscription where S.Input == GestureType, S.Failure == Never {
    private var subscriber: S?
    private var gestureType: GestureType
    private var view: UIView
    
    init(subscriber: S, gestureType: GestureType, view: UIView) {
        self.subscriber = subscriber
        self.gestureType = gestureType
        self.view = view
        setGesture(type: gestureType)
    }
    
    private func setGesture(type: GestureType) {
        let gesture = type.get()
        gesture.addTarget(self, action: #selector(handler))
        view.addGestureRecognizer(gesture)
    }
    
    func request(_ demand: Subscribers.Demand) {}
    
    func cancel() {
        subscriber = nil
    }
    
    @objc
    func handler() {
        _ = self.subscriber?.receive(self.gestureType)
    }
}

enum GestureType {
    case tap(UITapGestureRecognizer = .init())
    case swipe(UISwipeGestureRecognizer = .init())
    case longPress(UILongPressGestureRecognizer = .init())
    case pan(UIPanGestureRecognizer = .init())
    case pinch(UIPinchGestureRecognizer = .init())
    case edge(UIScreenEdgePanGestureRecognizer = .init())
    func get() -> UIGestureRecognizer {
        switch self {
        case let .tap(tapGesture):
            return tapGesture
        case let .swipe(swipeGesture):
            return swipeGesture
        case let .longPress(longPressGesture):
            return longPressGesture
        case let .pan(panGesture):
            return panGesture
        case let .pinch(pinchGesture):
            return pinchGesture
        case let .edge(edgePanGesture):
            return edgePanGesture
       }
    }
}

