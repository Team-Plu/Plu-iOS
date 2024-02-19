//
//  SelectMonthPopUpViewModel.swift
//  Plu-iOS
//
//  Created by uiskim on 2023/12/14.
//

import Foundation
import Combine

protocol SelectMonthPopUpViewModel {
    func transform(input: SelectMonthPopUpInput) -> SelectMonthPopUpOutput
    func numberOfRowsInComponent(component: Int) -> Int
    func titleForRow(component: Int, row: Int) -> String
}

struct SelectMonthPopUpInput {
    let viewWillAppearSubject: PassthroughSubject<Void, Never>
    let selectYearAndMonthSubject: PassthroughSubject<(type: PickerComponentType, row: Int), Never>
    let registerButtonTapSubject: PassthroughSubject<Void, Never>
}

struct SelectMonthPopUpOutput {
    let viewDidLoadPublisher: AnyPublisher<(yearRow: Int, monthRow: Int), Never>
}

protocol SelectYearAndMonthNavigation {
    func confirmButtonTapped(input: FilterDate)
}

final class SelectMonthPopUpViewModelImpl: SelectMonthPopUpViewModel {
    
    var availableYear: [Int] = []
    var allMonth: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var selectedYear = 0
    var selectedMonth = 0
    var todayYear = "0"
    var todayMonth = "0"
    
    var delegate: SelectYearAndMonthNavigation?
    
    var cancelBag = Set<AnyCancellable>()
    
    
    func transform(input: SelectMonthPopUpInput) -> SelectMonthPopUpOutput {
        let viewDidLoadPublisher = input.viewWillAppearSubject
            .map { _ -> (yearRow: Int, monthRow: Int) in
                self.setAvailableDate()
                return (yearRow: self.availableYear.count-1, monthRow: self.selectedMonth-1)
            }
            .eraseToAnyPublisher()

        input.selectYearAndMonthSubject
            .sink { type, row in
                switch type {
                case .month:
                    self.selectedMonth = self.allMonth[row]
                case .year:
                    self.selectedYear = self.availableYear[row]
                }
            }
            .store(in: &cancelBag)
        
        input.registerButtonTapSubject
            .sink { [weak self] _ in
                guard let selectedYear = self?.selectedYear, let selectedMonth = self?.selectedMonth else { return }
                let date = FilterDate(year: selectedYear, month: selectedMonth)
                self?.delegate?.confirmButtonTapped(input: date)
            }
            .store(in: &cancelBag)
        
        return SelectMonthPopUpOutput(viewDidLoadPublisher: viewDidLoadPublisher)
    }
    
    private func setAvailableDate() {
        let formatterYear = DateFormatter()
        formatterYear.dateFormat = "yyyy"
        todayYear = formatterYear.string(from: Date())
            
        for i in 2023...Int(todayYear)! {
            availableYear.append(i)
        }
    
        let formatterMonth = DateFormatter()
        formatterMonth.dateFormat = "MM"
        todayMonth = formatterMonth.string(from: Date())
            
        selectedYear = Int(todayYear)!
        selectedMonth = Int(todayMonth)!
    }
    
    func numberOfRowsInComponent(component: Int) -> Int {
        switch component {
        case 0:
            return self.availableYear.count
        case 1:
            return self.allMonth.count
        default:
            return 0
        }
    }
    
    func titleForRow(component: Int, row: Int) -> String {
        switch component {
        case 0:
            return "\(self.availableYear[row])년"
        case 1:
            return "\(self.allMonth[row])월"
        default:
            return ""
        }
    }
}
