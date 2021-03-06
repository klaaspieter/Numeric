import Foundation
import XCTest
import Quick
import Nimble
import Numeric

class TimeSpec : QuickSpec {
  override func spec() {
    describe("extensions") {
      it("provides the applicable date component") {
        let components = [1.second: NSCalendarUnit.Second,
          1.minute: .Minute,
          1.hour: .Hour,
          1.day: .Day,
          1.week: .WeekOfYear,
          1.month: .Month,
          1.year: .Year]

        for (component, unit) in components {
          expect(component.valueForComponent(unit)) == 1
        }
      }
    }

    it("calculates dates in the future") {
      let calendar = NSCalendar.currentCalendar()
      let components = NSDateComponents()
      components.month = 1
      let date = calendar.dateByAddingComponents(components, toDate: NSDate(), options: NSCalendarOptions())!
      expect(1.month.fromNow.timeIntervalSinceNow) ≈ date.timeIntervalSinceNow ± 1
    }

    it("calculates dates in the past") {
      let calendar = NSCalendar.currentCalendar()
      let components = NSDateComponents()
      components.year = -2
      let date = calendar.dateByAddingComponents(components, toDate: NSDate(), options: NSCalendarOptions())!
      expect(2.years.ago.timeIntervalSinceNow) ≈ date.timeIntervalSinceNow ± 1
    }

    context("instantiation") {
      it("can create dates using date components") {
        let components = NSDateComponents()
        components.era = 1
        components.year = 1986
        components.month = 6
        components.day = 18
        components.hour = 2
        components.minute = 2
        components.second = 2
        components.nanosecond = 2
        components.calendar = NSCalendar.autoupdatingCurrentCalendar()
        expect(components.date!) == NSDate.create(era: 1, year: 1986, month: 6, day: 18, hour: 2, minute: 2, second: 2, nanosecond: 2)
      }

      it("uses default values for components that aren't specified") {
        let components = NSDateComponents()
        components.era = 1
        components.year = 2001
        components.month = 1
        components.day = 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        components.nanosecond = 0
        components.calendar = NSCalendar.autoupdatingCurrentCalendar()
        expect(components.date!) == NSDate.create()
      }
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

      it("can add date components to a date") {
        let calendar = NSCalendar.currentCalendar()
        let components1 = NSDateComponents()
        components1.hour = 1
        let date1 = calendar.dateByAddingComponents(components1, toDate: NSDate(), options: NSCalendarOptions())!

        let components2 = NSDateComponents()
        components2.hour = 2
        let date2 = calendar.dateByAddingComponents(components2, toDate: date1, options: NSCalendarOptions())!

        expect((1.hour.fromNow + 2.hours).timeIntervalSinceNow) ≈ date2.timeIntervalSinceNow ± 1
      }

      it("supports the + prefix operator") {
        let expected = NSDateComponents()
        expected.month = 2

        let actual = NSDateComponents()
        actual.month = -2
        expect(+actual) == expected
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

      it("can subtract date components from a date") {
        let calendar = NSCalendar.currentCalendar()
        let components1 = NSDateComponents()
        components1.hour = 1
        let date1 = calendar.dateByAddingComponents(components1, toDate: NSDate(), options: NSCalendarOptions())!

        let components2 = NSDateComponents()
        components2.hour = -2
        let date2 = calendar.dateByAddingComponents(components2, toDate: date1, options: NSCalendarOptions())!

        expect((1.hour.fromNow - 2.hours).timeIntervalSinceNow) ≈ date2.timeIntervalSinceNow ± 1
      }

      it("supports the - prefix operator") {
        let expected = NSDateComponents()
        expected.month = -2

        let actual = NSDateComponents()
        actual.month = 2
        expect(-actual) == expected
      }
    }

    it("can add and subtract") {
      let components = NSDateComponents()
      components.day = 1
      components.hour = 1
      components.minute = -40
      expect(1.day + 1.hour - 40.minutes) == components
    }

    context("comparing") {
      it("can compare dates") {
        let date = 1.day.ago
        expect(date) == date
        expect(2.hours.fromNow) > 1.hour.ago
        expect(1.month.fromNow) < 2.months.fromNow
      }
    }
  }
}
