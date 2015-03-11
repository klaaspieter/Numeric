import Foundation

extension NSDateComponents {
  public var ago: NSDate {
    let units = [NSCalendarUnit.CalendarUnitYear,
      .CalendarUnitMonth,
      .CalendarUnitWeekOfYear,
      .CalendarUnitDay,
      .CalendarUnitHour,
      .CalendarUnitMinute,
      .CalendarUnitSecond]

      for unit in units {
        let value = self.valueForComponent(unit)

        if (value != Int.max) {
          self.setValue(-value, forComponent: unit)
        }
      }
      return self.advance();
  }
  public var fromNow: NSDate { return self.advance() }

  private func advance() -> NSDate {
    var calendar : NSCalendar
    if let c = self.calendar {
      calendar = c
    } else {
      calendar = NSCalendar.currentCalendar()
    }

    let date = calendar.dateByAddingComponents(self, toDate: NSDate(), options: NSCalendarOptions.allZeros)
    return date!
  }
}

extension Int {
  public var second: NSDateComponents { return self.seconds }
  public var seconds: NSDateComponents {
    return toDateComponent(NSCalendarUnit.CalendarUnitSecond)
  }

  public var minute: NSDateComponents { return self.minutes }
  public var minutes: NSDateComponents {
    return toDateComponent(NSCalendarUnit.CalendarUnitMinute)
  }

  public var hour: NSDateComponents { return self.hours }
  public var hours: NSDateComponents {
    return toDateComponent(NSCalendarUnit.CalendarUnitHour)
  }

  public var day: NSDateComponents { return self.days }
  public var days: NSDateComponents {
    return toDateComponent(NSCalendarUnit.CalendarUnitDay)
  }

  public var week: NSDateComponents { return self.weeks }
  public var weeks: NSDateComponents {
    return toDateComponent(NSCalendarUnit.CalendarUnitWeekOfYear)
  }

  public var month: NSDateComponents { return self.months }
  public var months: NSDateComponents {
    return toDateComponent(NSCalendarUnit.CalendarUnitMonth)
  }

  public var year: NSDateComponents { return self.years }
  public var years: NSDateComponents {
    return toDateComponent(NSCalendarUnit.CalendarUnitYear)
  }

  private func toDateComponent(unit: NSCalendarUnit) -> NSDateComponents {
    let components = NSDateComponents()
    components.setValue(self, forComponent: unit)
    return components
  }
}

extension NSDate {
  public class func create(era: Int = 1, year: Int = 2001, month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0, nanosecond: Int = 0) -> NSDate {
    return NSDateComponents.create(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nanosecond).date!
  }
}

extension NSDateComponents {
  public class func create(era: Int = 1, year: Int = 2001, month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0, nanosecond: Int = 0, calendar: NSCalendar? = nil) -> NSDateComponents {
    let components = NSDateComponents()
    components.era = era
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.second = second
    components.nanosecond = nanosecond
    components.calendar = calendar ?? NSCalendar.autoupdatingCurrentCalendar()
    return components
  }

}
