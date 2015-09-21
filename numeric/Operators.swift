import Foundation

let calendarUnits: [NSCalendarUnit] = [
  NSCalendarUnit.Era,
  NSCalendarUnit.Year,
  NSCalendarUnit.Month,
  NSCalendarUnit.Day,
  NSCalendarUnit.Hour,
  NSCalendarUnit.Minute,
  NSCalendarUnit.Second,
  NSCalendarUnit.Nanosecond,
  NSCalendarUnit.Weekday,
  NSCalendarUnit.WeekdayOrdinal,
  NSCalendarUnit.Quarter,
  NSCalendarUnit.WeekOfMonth,
  NSCalendarUnit.WeekOfYear,
  NSCalendarUnit.YearForWeekOfYear
]

public func apply(lhs: NSDateComponents, rhs: NSDateComponents, f: ((Int, Int) -> Int)) -> NSDateComponents {
  calendarUnits.forEach { unit -> () in
    let leftValue = lhs.valueForComponent(unit)
    let rightValue = rhs.valueForComponent(unit)
    var value: Int

    if leftValue != Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = f(leftValue, rightValue)
    } else if leftValue == Int(NSDateComponentUndefined) && rightValue != Int(NSDateComponentUndefined) {
      value = f(0, rightValue)
    } else {
      value = leftValue
    }

    lhs.setValue(value, forComponent: unit)
  }
  return lhs
}

// NSDateComponents
public func +(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
  return apply(lhs, rhs: rhs, f: +)
}

public func -(lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
  return apply(lhs, rhs: rhs, f: -)
}

// Prefix operators
public prefix func +(components: NSDateComponents) -> NSDateComponents {
  calendarUnits.forEach { unit -> () in
    let value = components.valueForComponent(unit)
    if value != Int(NSDateComponentUndefined) {
      components.setValue(abs(value), forComponent:unit)
    }
  }
  return components
}

public prefix func -(components: NSDateComponents) -> NSDateComponents {
  calendarUnits.forEach { unit -> () in
    let value = components.valueForComponent(unit)
    if value != Int(NSDateComponentUndefined) {
      components.setValue(abs(value) * -1, forComponent:unit)
    }
  }
  return components
}

// NSDate and NSDateComponents
public func +(date: NSDate, components: NSDateComponents) -> NSDate {
  let calendar = components.calendar ?? NSCalendar.autoupdatingCurrentCalendar()
  return calendar.dateByAddingComponents(components, toDate: date, options: []) ?? date
}

public func-(date: NSDate, components: NSDateComponents) -> NSDate {
  let calendar = components.calendar ?? NSCalendar.autoupdatingCurrentCalendar()
  return calendar.dateByAddingComponents(-components, toDate: date, options: []) ?? date
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}
public func <(lhs: NSDate, rhs: NSDate) -> Bool {
  return lhs.compare(rhs) == .OrderedAscending
}
extension NSDate: Comparable { }
