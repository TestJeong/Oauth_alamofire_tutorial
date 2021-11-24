
import SwiftUI

struct PresentedViews : View {
    @Environment(\.presentationMode) var presentationMode
    @State var searchText: String = ""
    @State var searching = false
    @EnvironmentObject var userVM : UserVM
    //@State var results = [SchoolInformation]()
    
    @ObservedObject var apple = UserVM()
      
    @State var users : SchoolInformation? = nil
        

    var body: some View {
        Text("asdf")
        List(apple.schoolList){ test in
            RandomUserRowView(test)
        }
          
    }
//    var body: some View {
//        NavigationView {
//                   VStack(alignment: .leading) {
//                       SearchBar(searchText: $searchText, searching: $searching)
//                       List {
//                           ForEach(myFruits.filter({ (fruit: String) -> Bool in
//                               return fruit.hasPrefix(searchText) || searchText == ""
//                           }), id: \.self) { fruit in
//                               Text(fruit)
//                           }
//                       }
//                           .listStyle(GroupedListStyle())
//                           .navigationTitle(searching ? "Searching" : "MyFruits")
//                           .toolbar {
//
//
//                                   Button("Cancel") {
//                                       if self.presentationMode.wrappedValue.isPresented {
//                                           self.presentationMode.wrappedValue.d
//                                       searchText = ""
//                                       withAnimation {
//                                          searching = false
//                                          UIApplication.shared.dismissKeyboard()
//                                       }
//                                    }
//                                   }
//
//                           }
//                           .gesture(DragGesture()
//                                       .onChanged({ _ in
//                               UIApplication.shared.dismissKeyboard()
//                                       })
//                           )
//                   }
//               }
//           }
       }
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
       
        PresentedViews()
            
    }
}
//
//struct SearchBar: View {
//
//    @Binding var searchText: String
//    @Binding var searching: Bool
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .foregroundColor(Color("LightGray"))
//            HStack {
//                Image(systemName: "magnifyingglass")
//                TextField("Search ..", text: $searchText) { startedEditing in
//                    if startedEditing {
//                        withAnimation {
//                            searching = true
//                        }
//                    }
//                } onCommit: {
//                    withAnimation {
//                        searching = false
//                    }
//                }
//            }
//            .foregroundColor(.gray)
//            .padding(.leading, 13)
//        }
//            .frame(height: 40)
//            .cornerRadius(13)
//            .padding()
//    }
//}
//
//
//extension UIApplication {
//     func dismissKeyboard() {
//         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//     }
// }
