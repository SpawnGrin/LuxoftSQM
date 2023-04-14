//
//  Signal.swift
//  Technical-test
//
//  Created by Andrew on 13.04.2023.
//

import Foundation

final class Signal<Value> {
    
    private struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }
    
    private var observers = [Observer<Value>]()
    
    public func observe(
        on observer: AnyObject,
        observerBlock: @escaping (Value) -> Void
    ) {
        if !observers.contains(where: { $0.observer === observer }) {
            observers.append(Observer(observer: observer, block: observerBlock))
        }
    }
    
    public func accept(_ newValue: Value) {
        notifyObservers(newValue)
    }
    
    private func notifyObservers(_ newValue: Value) {
        DispatchQueue.main.async {
            self.observers.forEach { $0.block(newValue) }
        }
    }
}

extension Signal where Value == Void {
    func sendSignal() {
        notifyObservers(())
    }
}
