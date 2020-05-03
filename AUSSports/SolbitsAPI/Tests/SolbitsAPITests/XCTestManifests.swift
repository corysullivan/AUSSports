import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(SolbitsAPITests.allTests),
        ]
    }
#endif
