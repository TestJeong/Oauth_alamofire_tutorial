
import SwiftUI


//MARK:- Single Radio Button Field
struct RadioButtonField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.black,
        textSize: CGFloat = 14,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}

//MARK:- Group of Radio Buttons
enum Gender: String {
    case one = "1학년"
    case two = "2학년"
    case three = "3학년"
}

struct RadioButtonGroups: View {
    let callback: (String) -> ()
    
    @State var selectedId: String = ""
    
    var body: some View {
        HStack {
            radioOneMajority
            radioTwoMajority
            radioThreeMajority
        }
    }
    
    var radioOneMajority: some View {
        RadioButtonField(
            id: Gender.one.rawValue,
            label: Gender.one.rawValue,
            isMarked: selectedId == Gender.one.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioTwoMajority: some View {
        RadioButtonField(
            id: Gender.two.rawValue,
            label: Gender.two.rawValue,
            isMarked: selectedId == Gender.two.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioThreeMajority: some View {
        RadioButtonField(
            id: Gender.three.rawValue,
            label: Gender.three.rawValue,
            isMarked: selectedId == Gender.three.rawValue ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}
