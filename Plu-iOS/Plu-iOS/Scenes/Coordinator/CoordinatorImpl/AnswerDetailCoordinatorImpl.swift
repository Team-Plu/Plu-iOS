//
//  AnswerDetailCoordinatorImpl.swift
//  Plu-iOS
//
//  Created by 김민재 on 12/12/23.
//

import UIKit


final class AnswerDetailCoordinatorImpl: AnswerDetailCoordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func showAnswerDetailViewController(id: Int) {
        //TODO: ViewModel의 init에 id값 넣기
        // 이후 Factory생긴다면 ViewModelPresentable 프로토콜에 setId() 같은 메서드 넣고 여기서 호출하면 됨.
        print("id: \(id) 눌림")
        let manager = AnswerDetailStub()
        let viewModel = AnswerDetailViewModelImpl(manager: manager)
        viewModel.delegate = self
        let answerDetailViewController = AnswerDetailViewController(
            viewModel: viewModel
        )
        self.navigationController?.pushViewController(answerDetailViewController, animated: true)
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AnswerDetailCoordinatorImpl: AnswerDetailNavigation {
    func backButtonTapped() {
        self.pop()
    }
}
