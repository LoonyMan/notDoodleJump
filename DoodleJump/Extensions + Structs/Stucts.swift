struct BitMaskCategory {
    static let player : UInt32 = 0x1 << 0
    static let floor : UInt32 = 0x1 << 1
    static let redFloor : UInt32 = 0x1 << 2
    static let none : UInt32 = 0x0
}

enum Way {
    case left
    case right
}
