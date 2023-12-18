//
//  UIViewController+.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import UIKit

/**
 
 - Description:
 
 요청하는(OK,취소)버튼만 있는 UIAlertController를 간편하게 만들기 위한 extension입니다.
 
 - parameters:
 - title: 알림창에 뜨는 타이틀 부분입니다.
 - message: 타이틀 밑에 뜨는 메세지 부분입니다.
 - okAction: 확인버튼을 눌렀을 때 동작하는 부분입니다.
 - cancelAction: 취소버튼을 눌렀을 때 동작하는 부분입니다.
 - completion: 해당 UIAlertController가 띄워졌을 때, 동작하는 부분입니다.
 
 
 */
extension UIViewController {
    func makeAlert(title: String,
                   message: String,
                   okAction: ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: completion)
    }
}

extension UIViewController {
    func goToSettingPage() {
        let alertController = UIAlertController(title: "알림을 설정하시겠어요?",
                                                message: "설정에서 알림을 허용해주세요",
                                                preferredStyle: .alert)
        
        let goToSettings = UIAlertAction(title: "설정으로가기", style: .default) {_ in
            guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingURL) {
                UIApplication.shared.open(settingURL)
            }
        }
        alertController.addAction(goToSettings)
        alertController.addAction(UIAlertAction(title: "취소", style: .default))
        self.present(alertController, animated: true)
    }
}
