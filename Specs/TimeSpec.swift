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
          expect(component.valueForComponent(unit)) == 1
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

    context("adding") {
      it("can add date components with the same units") {
        expect(1.day + 1.day) == 2.days
      }

      it("can add date components with different units") {
        let components = NSDateComponents()
        components.day = 1
        components.hour = 1
        components.minute = 40
        expect(1.day + 1.hour + 40.minutes) == components
      }
    }

    context("subtracting") {
      it("can subtract date components with the same units") {
        expect(1.day - 2.day) == (-1).days
      }

      it("can subtract date components with different units") {
        let components = NSDateComponents()
        components.day = 1
        components.hour = -1
        components.minute = -40
        expect(1.day - 1.hour - 40.minutes) == components
      }
    }

    it("can add and subtract") {
      let components = NSDateComponents()
      components.day = 1
      components.hour = 1
      components.minute = -40
      expect(1.day + 1.hour - 40.minutes) == components
    }
  }
}