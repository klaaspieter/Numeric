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

let calendarUnits: [NSCalendarUnit] = [
  NSCalendarUnit.CalendarUnitEra,
  NSCalendarUnit.CalendarUnitYear,
  NSCalendarUnit.CalendarUnitMonth,
  NSCalendarUnit.CalendarUnitDay,
  NSCalendarUnit.CalendarUnitHour,
  NSCalendarUnit.CalendarUnitMinute,
  NSCalendarUnit.CalendarUnitSecond,
  NSCalendarUnit.CalendarUnitNanosecond,
  NSCalendarUnit.CalendarUnitWeekday,
  NSCalendarUnit.CalendarUnitWeekdayOrdinal,
  NSCalendarUnit.CalendarUnitQuarter,
  NSCalendarUnit.CalendarUnitWeekOfMonth,
  NSCalendarUnit.CalendarUnitWeekOfYear,
  NSCalendarUnit.CalendarUnitYearForWeekOfYear
]

public func +(left: NSDateComponents, right: NSDateComponents) -> NSDateComponents {
  map(calendarUnits) { unit -> () in
    let leftValue = left.valueForComponent(unit)
    let rightValue = right.valueForComponent(unit)
    let value: Int

    if leftValue != Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = leftValue + rightValue
    } else if leftValue == Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = rightValue
    } else {
      value = leftValue
    }

    left.setValue(value, forComponent: unit)
  }
  return left
}

public func +(date: NSDate, components: NSDateComponents) -> NSDate {
  let calendar = components.calendar ?? NSCalendar.autoupdatingCurrentCalendar()
  return calendar.dateByAddingComponents(components, toDate: date, options: .allZeros) ?? date
}

public prefix func +(components: NSDateComponents) -> NSDateComponents {
  map(calendarUnits) { unit -> () in
    let value = components.valueForComponent(unit)
    if value != Int(NSDateComponentUndefined) {
      components.setValue(abs(value), forComponent:unit)
    }
  }
  return components
}

public func -(left: NSDateComponents, right: NSDateComponents) -> NSDateComponents {
  map(calendarUnits) { unit -> () in
    let leftValue = left.valueForComponent(unit)
    let rightValue = right.valueForComponent(unit)
    let value: Int

    if leftValue != Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = leftValue - rightValue
    } else if leftValue == Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = -rightValue
    } else {
      value = leftValue
    }

    left.setValue(value, forComponent: unit)
  }
  return left
}

public func-(date: NSDate, components: NSDateComponents) -> NSDate {
  let calendar = components.calendar ?? NSCalendar.autoupdatingCurrentCalendar()
  return calendar.dateByAddingComponents(-components, toDate: date, options: .allZeros) ?? date
}

public prefix func -(components: NSDateComponents) -> NSDateComponents {
  map(calendarUnits) { unit -> () in
    let value = components.valueForComponent(unit)
    if value != Int(NSDateComponentUndefined) {
      components.setValue(abs(value) * -1, forComponent:unit)
    }
  }
  return components
}