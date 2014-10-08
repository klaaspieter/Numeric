import Foundation

extension Int {
  public var byte: Int { return self }
  public var bytes: Int { return self }

  public var kilobyte: Int { return self.kilobytes }
  public var kilobytes: Int { return Int(Double(self).kilobytes) }

  public var megabyte: Int { return self.megabytes }
  public var megabytes: Int { return Int(Double(self).megabytes) }

  public var gigabyte: Int { return self.gigabytes }
  public var gigabytes: Int { return Int(Double(self).gigabytes) }

  public var terabyte: Int { return self.terabytes }
  public var terabytes: Int { return Int(Double(self).terabytes) }

  public var petabyte: Int { return self.petabytes }
  public var petabytes: Int { return Int(Double(self).petabytes) }

  public var exabyte: Int { return self.exabytes }
  public var exabytes: Int { return Int(Double(self).exabytes) }
}

extension Double {
  public var byte: Double { return self }
  public var bytes: Double { return self }

  public var kilobyte: Double { return self.kilobytes }
  public var kilobytes: Double { return self.byte * 1024 }

  public var megabyte: Double { return self.megabytes }
  public var megabytes: Double { return self.kilobyte * 1024 }

  public var gigabyte: Double { return self.gigabytes }
  public var gigabytes: Double { return self.megabyte * 1024 }

  public var terabyte: Double { return self.terabytes }
  public var terabytes: Double { return self.gigabyte * 1024 }

  public var petabyte: Double { return self.petabytes }
  public var petabytes: Double { return self.terabyte * 1024 }

  public var exabyte: Double { return self.exabytes }
  public var exabytes: Double { return self.petabyte * 1024 }
}