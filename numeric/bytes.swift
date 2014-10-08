extension Int {
  public var byte: Int { return self }
  public var bytes: Int { return self }

  public var kilobyte: Int { return self.kilobytes }
  public var kilobytes: Int { return self.byte * 1024 }

  public var megabyte: Int { return self.megabytes }
  public var megabytes: Int { return self.kilobyte * 1024 }

  public var gigabyte: Int { return self.gigabytes }
  public var gigabytes: Int { return self.megabyte * 1024 }

  public var terabyte: Int { return self.terabytes }
  public var terabytes: Int { return self.gigabyte * 1024 }

  public var petabyte: Int { return self.petabytes }
  public var petabytes: Int { return self.gigabyte * 1024 }

  public var exabyte: Int { return self.exabytes }
  public var exabytes: Int { return self.petabyte * 1024 }
}