import Foundation
import XCTest
import Quick
import Nimble
import Numeric

class TimeSpec : QuickSpec {
  override func spec() {
    describe("extensions") {
      it("provides the applicable date component") {
        let components = [1.second: NSCalendarUnit.CalendarUnitSecond,
          1.minute: .CalendarUnitMinute,
          1.hour: .CalendarUnitHour,
          1.day: .CalendarUnitDay,
          1.week: .CalendarUnitWeekOfYear,
          1.month: .CalendarUnitMonth,
          1.year: .CalendarUnitYear]

        for (component, unit) in components {
          expect(component.valueForComponent(unit)).to(equal(1))
        }
      }
    }

    it("calculates dates in the future") {
      let calendar = NSCalendar.currentCalendar()
      let components = NSDateComponents()
      components.month = 1
      let date = calendar.dateByAddingComponents(components, toDate: NSDate(), options:NSCalendarOptions.allZeros)!
      expect(1.month.fromNow.timeIntervalSinceNow).to(beCloseTo(date.timeIntervalSinceNow, within: 1))
    }

    it("calculates dates in the past") {
      let calendar = NSCalendar.currentCalendar()
      let components = NSDateComponents()
      components.year = -2
      let date = calendar.dateByAddingComponents(components, toDate: NSDate(), options: NSCalendarOptions.allZeros)!
      expect(2.years.ago.timeIntervalSinceNow).to(beCloseTo(date.timeIntervalSinceNow, within: 1))
    }
  }
}