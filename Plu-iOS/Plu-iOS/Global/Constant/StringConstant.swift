//
//  StringConstant.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import Foundation

enum StringConstant {
    enum Onboarding {}
    enum Login {}
    enum MyPage {
        case alarm, faq, openSource, privacy, appVersion, logOut, resign
        
        var title: String {
            switch self {
            case .alarm: return "알림 설정"
            case .appVersion: return "앱버전"
            case .faq: return "FAQ"
            case .logOut: return "로그아웃"
            case .resign: return "탈퇴하기"
            case .openSource: return "오픈소스 라이브러리"
            case .privacy: return "개인정보 보호 및 약관"
            }
        }
    }
    
    enum PlaceHolder {
        case textView
        
        var text: String {
            switch self {
            case .textView: return "나만의 답을 적어보세요."
            }
        }
    }
    
    enum MyAnswer {
        case titleCaution, cautionPoint, firstCaution, secondCaution, bottomView
        
        var text: String {
            switch self {
            case .titleCaution: return "주의 사항"
            case .cautionPoint: return " •  "
            case .firstCaution: return "답변 전체 공개 시 Plu를 이용하는 모든 유저에게 답변이 공개됩니다."
            case .secondCaution: return "질문과 전혀 관련없는 답변, 비방 • 욕설 • 음란한 내용이 담긴 답변, 기타 Plu의 이용 약관을 준수하지 않는 답변을 남길 시, 경고없이 답변 삭제 및 계정 영구 정지 조치를 취할 수 있습니다."
            case .bottomView: return "나의 답변 공개하기"
            }
        }
    }
}
