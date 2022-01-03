//
//  MonthView.swift
//  Taro
//
//  Created by DevMountain on 5/13/21.
//

import SwiftUI


struct MonthView<DateView: View>: View {
    
    @Environment(\.calendar) var calendar
    
    let month: DateComponents
    let viewProvider: (Date) -> DateView
    
    private let titleFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    private var monthDate: Date {
        calendar.date(from: month)!
    }
    
    private var dates: [Date] {
        return calendar.calendarSetOfDays(for: month)
    }
    
    private var title: String {
        titleFormatter.string(from: monthDate)
    }
    
    var body: some View {
        VStack {
            header
            EagerVGrid(models: dates, columns: 7) { date in
                if self.calendar.isDate(monthDate,
                                        equalTo: date,
                                        toGranularity: .month) {
                    viewProvider(date)
                } else {
                    Circle()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .hidden()
                }
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text(title)
                .font(.title3)
                .bold()
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        let month = DateComponents(year: 2020, month: 4)
        return MonthView(month: month) { date in
            PieChart(totalAngle: 360, sections: [0.3, 0.4, 0.6])
                .aspectRatio(1, contentMode: .fit)
        }
    }
}
