import SwiftUI
import Foundation

@available(iOS 13.0, *)
struct FixedHeightTextView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.body)
    }
}

@available(iOS 13.0, *)
struct ContentView: View {
    private var width:CGFloat
    private var padding:EdgeInsets
    private var dataArray:[String]
    
    init(width: CGFloat, padding: EdgeInsets, dataArray: [String]) {
        self.width = width
        self.padding = padding
        self.dataArray = dataArray
    }
    
    var body: some View {
//        GeometryReader { geometry in
//                   Text("Hello, SwiftUI!")
//                       .font(.largeTitle)
//                       .padding(EdgeInsets(
//                           top: geometry.size.height * 0.1,    // 上边距为高度的 10%
//                           leading: geometry.size.width * 0.2, // 左边距为宽度的 20%
//                           bottom: geometry.size.height * 0.1, // 下边距为高度的 10%
//                           trailing: geometry.size.width * 0.2 // 右边距为宽度的 20%
//                       ))
//               }
        VStack {
            ForEach(dataArray, id: \.self) { item in
                    Text(item)
//                        .font(.title)
//                    .frame(width: 50, height: 50)
                    .padding(.bottom,0)
//                    .padding(.top,-10)
//                    .background(Color.black)
                    .foregroundColor(.white)
                }
        }
//        .background(Color.red)
        .frame(width: width, height: 50)
        .padding(padding)
    }
    
}

//@available(iOS 13.0, *)
//struct ContentView_Previews: PreviewProvider {
//    static var previews(counter:Int): some View {
//        ContentView(counter)
//    }
//}


@available(iOS 13.0, *)
class ContentViewController: UIViewController {
    
    public var width:CGFloat = 0
    public var padding:EdgeInsets = EdgeInsets()
    public var dataArray:[String] = []
    
    // 实现 required init(coder:)
    func setData(width: CGFloat, padding: EdgeInsets, dataArray: [String]) {
        // 执行其他初始化工作，如果需要的话
        self.width = width
        self.padding = padding
        self.dataArray = dataArray
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a SwiftUI view
        let swiftUIView = ContentView(width: self.width, padding: self.padding, dataArray: self.dataArray)
//        swiftUIView.counter = 10
//        print("@@@@@@@1111222 \(self.counter) \(swiftUIView.counter)")
//        swiftUIView.test()
        // Create a UIHostingController to wrap the SwiftUI view
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        // swiftUIView.test()
   

        // Add the UIHostingController's view as a subview to your UIKit UIView
    }
}
