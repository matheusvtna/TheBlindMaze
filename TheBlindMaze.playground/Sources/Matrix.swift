import Foundation

public class Matrix{
    
    var map: [[Bool]]
    
    public init(){
        self.map = [[]]
    }

    public static func firstLevel() -> [[Bool]]{
        return [[false, false, true, true, true, false, false], [true, false, false, true, true, false, false], [false, false, true, true, true, true,false], [false, true, true, true, false, false, false], [false, false, false, false, false, true, false]]
    }
    
}
