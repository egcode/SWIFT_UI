//
//  ListDemo.swift
//  SWUI1
//
//  Created by Eugene G on 5/4/22.
//

import SwiftUI

struct ListDemo: View {
    
    @State var fruits: [String] = ["apple", "orange", "banana", "peach", "mango"]
    @State var veggies: [String] = ["potato", "tomato", "carrot"]
    @State var selectedFruit: String? = nil
    
    var body: some View {

        NavigationView {
            List {
                // Section 1
                Section(header:
                            HStack {
                                Text("Fruits")
                                Image(systemName: "flame.fill")
                            }
                            .font(.headline)
                            .foregroundColor(.orange)
                ) {
                    ForEach(fruits, id: \.self) { fruit in
                        Text(fruit.capitalized)
                            .font(.body)
                            .foregroundColor(.yellow)
                            .padding(.vertical)
                            .onTapGesture {
                                self.selectedFruit = fruit
                                print("Selected: \(fruit)")
                            }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    .listRowBackground(Color.green)
                }
                
                // Section 2
                Section(header: Text("Veggies")) {
                    ForEach(veggies, id: \.self) { veggie in
                        Text(veggie.capitalized)
                    }
                }
                
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Grocery List")
            .navigationBarItems(leading: EditButton(),
                                trailing: addButton)
            
        }
    }
    
    var addButton: some View {
        Button("Add") {
            add()
        }
    }
    
    func delete(indexSet: IndexSet) {
        fruits.remove(atOffsets: indexSet)
    }
    
    func move(indeces: IndexSet, newOffset: Int) {
        fruits.move(fromOffsets: indeces, toOffset: newOffset)
    }
    
    func add() {
        fruits.append("Super Fruit")
    }
    
}

struct ListDemo_Previews: PreviewProvider {
    static var previews: some View {
        ListDemo()
    }
}
