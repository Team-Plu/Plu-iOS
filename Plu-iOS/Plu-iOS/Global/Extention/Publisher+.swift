//
//  Publisher+.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/22.
//

import Foundation
import Combine

extension Publisher {
    func requestAPI<Output>(failure: Output,
                            handler: @escaping (Self.Output) async throws -> (Output),
                            errorHandler: @escaping ((NetworkError) -> ())) -> AnyPublisher<Output, Never> where Self.Failure == Never {
        
        return self.flatMap { input -> AnyPublisher<Output, Never> in
                return Future<Output, NetworkError> { promise in
                    Task {
                        do {
                            let output = try await handler(input)
                            promise(.success(output))
                        } catch {
                            let networkError = error as! NetworkError
                            errorHandler(networkError)
                            promise(.failure(networkError))
                        }
                    }
                }
                .catch { _ in
                    Just(failure)
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
