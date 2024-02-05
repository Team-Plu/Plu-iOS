//
//  MyPageCarbonViewController.swift
//  Plu-iOS
//
//  Created by uiskim on 2/5/24.
//  Copyright (c) 2024 MyPageCarbon. All rights reserved.
//

import UIKit

import SnapKit
import Carbon

final class MyPageCarbonViewController: UIViewController {
    
    let myPageTableView = UITableView(frame: .zero, style: .grouped)
    let renderer = Renderer(adapter: UITableViewAdapter(), updater: UITableViewUpdater())

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setDelegate()
        setTableView()
        render()
    }
    enum MypageType {
        case profile, alarm, info, version, user
    }
    func render() {
        renderer.render {
            
            Section(id: MypageType.profile) {
                ProfileItem(nickname: "Plu님") {
                    print("프로필눌림")
                }
            }
            
            Section(id: MypageType.alarm) {
                RoundHeadItem()
                
                AlarmSettingItem(isOn: true) { type in
                    print(type)
                }
            }
            
            Section(id: MypageType.info) {
                SpaceItem(16)
                MyPageItem(title: "FAQ") {
                    print("FAQ가 눌림")
                }
                
                MyPageItem(title: "오픈소스 라이브러리") {
                    print("오픈소스 라이브러리가 눌림")
                }
                
                MyPageItem(title: "개인정보 보호 및 약관") {
                    print("개인정보 보호 및 약관이 눌림")
                }
            }
            
            Section(id: MypageType.version) {
                SpaceItem(16)
                
                AppversionItem(version: "1.0.0")
            }
            
            Section(id: MypageType.user) {
                SpaceItem(16)
                
                MyPageItem(title: "로그아웃") {
                    print("로그아웃이 눌림")
                }
                
                MyPageItem(title: "탈퇴하기") {
                    print("탈퇴하기가 눌림")
                }
            }
        }
    }
}

private extension MyPageCarbonViewController {
    func setUI() {
        self.view.backgroundColor = .designSystem(.background)
    }
    
    func setHierarchy() {
        self.view.addSubview(myPageTableView)
    }
    
    func setLayout() {
        myPageTableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setAddTarget() {
        
    }
    
    func setDelegate() {
        
    }
    
    func setTableView() {
        myPageTableView.separatorStyle = .none
        renderer.target = myPageTableView
    }
}
