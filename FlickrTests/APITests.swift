//
//  APITests.swift
//  FlickrTests
//
//  Created by Erdi Tunçalp on 25.03.2019.
//  Copyright © 2019 Erdi Tunçalp. All rights reserved.
//

import Quick
import Nimble
import RxSwift

@testable import Moya
//@testable import RxMoya


class APITests: QuickSpec {
    
    //var disposeBag: DisposeBag!
    //var provider: MoyaProvider<FlickrAPI>!
    
    override func spec() {
        describe("provider with single") {
            var provider: MoyaProvider<FlickrAPI>!
            
            beforeEach {
                provider = MoyaProvider<FlickrAPI>(endpointClosure: self.customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
            }
            
            it("emits a Response object") {
                var called = false
                
                _ = provider.rx.request(.getRecentPhotos)
                    .subscribe { event in
                        switch event {
                        case .success:
                            called = true
                        case .error(let error):
                            fail("errored: \(error)")
                        }
                    }
                
                expect(called).to(beTrue())
            }
        }
        
    }
    
    func customEndpointClosure(_ target: FlickrAPI) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(400, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    
}

extension FlickrAPI {
    var testSampleData: Data {
        switch self {
        case .getRecentPhotos:
            let url = Bundle(for: APITests.self).url(forResource: "RecentPhotos", withExtension: "json")!
            return try! Data(contentsOf: url)
        }
    }
}
