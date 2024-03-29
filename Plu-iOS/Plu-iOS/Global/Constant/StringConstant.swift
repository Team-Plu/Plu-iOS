//
//  StringConstant.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/04.
//

import Foundation

enum StringConstant {
    
    enum Login {
        static let page1Title = "매일 오후 10시 전달되는\n오늘의 질문을 확인해 보세요"
        static let page2Title = "나의 답변을 작성하면\n모두의 답변을 볼 수 있어요"
        static let page3Title = "꾸준히 작성한 일기는\n기록 탭에서 모아볼 수 있어요"
    }
    
    enum MyPage {
        case alarm, faq, openSource, privacy, appVersion, logOut, resign, nickName
        
        var description: String {
            switch self {
            case .alarm: return "알림 설정"
            case .appVersion: return "앱버전"
            case .faq: return "FAQ"
            case .logOut: return "로그아웃"
            case .resign: return "탈퇴하기"
            case .openSource: return "오픈소스 라이브러리"
            case .privacy: return "개인정보 보호 및 약관"
            case .nickName: return "닉네임"
            }
        }
    }
    
    enum Resign {
        static let resignDescriptionText = "• 나의 답변에 작성한 일기가 영구적으로 삭제됩니다.\n• 회원 정보가 영구적으로 삭제됩니다.\n• 모두의 답변에 공개된 일기와 회원이 누른 공감은 회원 탈퇴와 무관하게 유지됩니다."
        static let resignTitleText = "Plu님과 이별인가요?\n너무 아쉬워요."
        static let resignText = "탈퇴하기"
    }
  
    enum Onboarding {
        case buttonTitle, title, subTitle
        var description: String? {
            switch self {
            case .buttonTitle: return "가입 완료"
            case .title: return "닉네임을 입력해주세요"
            case .subTitle: return "닉네임을 입력하면 가입이 완료됩니다."
            }
        }
    }
    
    enum Nickname {
        case placeHolder, textFieldEmpty, textFieldOver, textFieldError, nickNameNonValid, nickNameValid, none
        var description: String? {
            switch self {
            case .placeHolder: return "닉네임"
            case .textFieldEmpty: return "입력된 내용이 없습니다."
            case .textFieldOver: return "8자 이내로 입력해주세요."
            case .textFieldError: return "다시 시도해주세요."
            case .nickNameNonValid: return "이미 사용 중인 닉네임입니다."
            /// 추후 삭제될 description입니다
            case .nickNameValid: return "사용 가능한 닉네임입니다."
            case .none: return nil
            }
        }
    }
    
    enum TodayQuestion {
        case myAnswer, everyAnswer, explanation
        
        var text: String {
            switch self {
            case .myAnswer: return "나의 답변 작성하기"
            case .everyAnswer: return "모두의 답변 보러 가기"
            case .explanation: return "모두의 답변은 나의 답변을 작성한 후에 확인할 수 있어요"
            }
        }
    }
    
    enum MyAnswer {
        case placeholder, titleCaution, cautionPoint, firstCaution, secondCaution, bottomView
        
        var text: String {
            switch self {
            case .placeholder: return "나만의 답을 적어보세요."
            case .titleCaution: return "주의 사항"
            case .cautionPoint: return " •  "
            case .firstCaution: return "답변 전체 공개 시 Plu를 이용하는 모든 유저에게 답변이 공개됩니다."
            case .secondCaution: return "질문과 전혀 관련없는 답변, 비방 • 욕설 • 음란한 내용이 담긴 답변, 기타 Plu의 이용 약관을 준수하지 않는 답변을 남길 시, 경고없이 답변 삭제 및 계정 영구 정지 조치를 취할 수 있습니다."
            case .bottomView: return "나의 답변 공개하기"
            }
        }
    }
    
    enum PopUp {
        enum YearAndMonth {
            static let checkButtonTitle = "확인"
        }
        
        enum Resign {
            static let title = "Plu를 탈퇴할까요?"
            static let subTitle = "여태껏 내가 작성한\n소중한 일기 기록이 영구적으로 사라져요!"
            static let resignButtonTitle = "탈퇴하기"
            static let cancelButtonTitle = "취소하기"
        }
        
        enum Register {
            static let title = "이대로 글을 등록할까요?"
            static let subTitle = "한번 글을 등록하고 나면\n글의 내용과 공개여부 수정이 불가능해요."
            static let registerButtonTitle = "등록하기"
            static let checkButtonTitle = "다시 확인하기"
        }
        
        enum TodayQuestionAlarm {
            static let title = "매일 저녁 10시\n알림을 드려도 될까요?"
            static let subTitle = "오늘의 질문을 놓치지 않을 수 있어요.\n필요 없는 알림은 보내지 않을게요!"
            static let acceptButtonTitle = "알림을 받을래요"
            static let rejectButtonTitle = "괜찮아요"
        }
        
        enum MypageAlarm {
            static let title = "매일 저녁 10시\n오늘의 질문 알림을 보내드려요!"
            static let subTitle = "알림 설정을 해제하면\n더이상 오늘의 질문 알림이 오지 않아요."
            static let acceptButtonTitle = "계속 알림을 받을래요"
            static let rejectButtonTitle = "알림을 해제할래요"
        }
    }
    
    enum Navibar {
        enum title {
            static let signUp = "회원가입"
            static let myAnswer = "나의 답변"
            static let everyAnswer = "모두의 답변"
            static let diaryRecord = "일기 기록"
            static let myPage = "마이페이지"
            static let resign = "탈퇴하기"
            static let profileEdit = "프로필수정"
            static let completeRightButton = "완료"
        }
    }
}
