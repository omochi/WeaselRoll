#if canImport(GLKit)

import XCTest
import GLKit
import WeaselRoll
import WLMedia

final class GLKitExTests: XCTestCase {
    func testFrustum() {
        let proj = GLKMatrix4.frustum(fovY: 30,
                                      width: 1920,
                                      height: 1080,
                                      near: 0.1,
                                      far: 100)
        let eps: Float = 1.0e-5
        
        
        let nearTop: Float = tan(Angles.toRadian(15)) * 0.1
        let nearHeight: Float = nearTop * 2
        let nearWidth = nearHeight * 1920 / 1080
        let nearLeft = -nearWidth / 2
        
        XCTAssertEqual(proj.transform(GLKVector3(0, 0, -0.1))
            .distance(to: GLKVector3(0, 0, -1)), 0, accuracy: eps)
        XCTAssertEqual(proj.transform(GLKVector3(0, nearTop, -0.1))
            .distance(to: GLKVector3(0, 1, -1)), 0, accuracy: eps)
        XCTAssertEqual(proj.transform(GLKVector3(nearLeft, 0, -0.1))
            .distance(to: GLKVector3(-1, 0, -1)), 0, accuracy: eps)
        
        let farTop: Float = tan(Angles.toRadian(15)) * 100
        let farHeight: Float = farTop * 2
        let farWidth = farHeight * 1920 / 1080
        let farLeft = -farWidth / 2
        
        XCTAssertEqual(proj.transform(GLKVector3(0, 0, -100))
            .distance(to: GLKVector3(0, 0, 1)), 0, accuracy: eps)
        XCTAssertEqual(proj.transform(GLKVector3(0, farTop, -100))
            .distance(to: GLKVector3(0, 1, 1)), 0, accuracy: eps)
        XCTAssertEqual(proj.transform(GLKVector3(farLeft, 0, -100))
            .distance(to: GLKVector3(-1, 0, 1)), 0, accuracy: eps)
    }
}

#endif
