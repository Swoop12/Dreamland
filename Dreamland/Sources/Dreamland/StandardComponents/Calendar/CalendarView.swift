//
//  CalendarView.swift
//  Taro
//
//  Created by DevMountain on 5/13/21.
//

import SwiftUI
import FoundationPlus

public struct CalendarView<DateView: View>: View {
    
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval
    let viewProvider: (Date) -> DateView
    private var months: [DateComponents] = []
    
    public init(interval: DateInterval,
         viewProvider: @escaping (Date) -> DateView) {
        self.interval = interval
        self.viewProvider = viewProvider
        let dates = calendar.generateDates(inside: interval,
                                           stride: .month)
        self.months = dates.map { calendar.dateComponents([.year, .month], from: $0)}
    }
    
    public var body: some View {
        VStack(spacing: 0){
            dayHeaders
            ScrollView(.vertical) {
                ScrollViewReader { proxy in
                    LazyVStack(spacing: Spacing.s5,
                               content: {
                                    ForEach(months, id: \.self) { month in
                                        MonthView(month: month, viewProvider: viewProvider)
                                            .if(month == months.last) { $0.id("LastMonth") }
                                    }
                               })
                        .padding()
                        .onAppear(perform: {
                            proxy.scrollTo("LastMonth")
                        })
                }
            }
        }
    }
    
    private var dayHeaders: some View {
        HStack {
            ForEach(calendar.shortWeekdaySymbols,
                    id: \.self) { symbol in
                Text(symbol)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
            }
        }
        .foregroundColor(.secondary)
        .font(.footnote)
        .padding()
        .background(
            Color(.systemBackground)
                .shadow(radius: 1.5, x: 0, y: 3)
        )
    }
}
