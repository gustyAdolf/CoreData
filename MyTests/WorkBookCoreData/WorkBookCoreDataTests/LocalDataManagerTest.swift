//
//  LocalDataManagerTest.swift
//  WorkBookCoreDataTests
//
//  Created by Gustavo A Ramírez Franco on 31/1/21.
//

import XCTest
@testable import WorkBookCoreData

class LocalDataManagerTest: XCTestCase {
    
    let localDataManager: LocalDataManager = LocalDataManagerImpl()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - TESTS
    
    func testFetchAllNotebooks() {
        localDataManager.fetchAllNotebooks { result in
            switch result {
                case .success(let notebookResponse):
                    guard let notebooks = notebookResponse?.notebooks else {
                        XCTFail()
                        return
                    }
                    XCTAssertEqual(notebooks.count, 3)
                case .failure:
                    XCTFail()
            }
        }
        
    }
    
}
