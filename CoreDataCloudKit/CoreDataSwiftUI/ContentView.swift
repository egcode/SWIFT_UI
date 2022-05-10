//
//  ContentView.swift
//  CoreDataSwiftUI
//
//  Created by Eugene G on 5/5/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(entity: Fruit.entity(),
//                  sortDescriptors: [NSSortDescriptor(keyPath: \Fruit.name, ascending: true)],
//                  predicate: nil,
//                  animation: .default)
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\Fruit.name, order: .reverse)])
//    @FetchRequest(sortDescriptors: [SortDescriptor(\Fruit.name, order: .forward)])

    
    private var fruits: FetchedResults<Fruit>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fruits) { fruit in
                    NavigationLink {
                        Text("\(fruit.name ?? "")")
                    } label: {
                        Text("\(fruit.name ?? "")")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newFruit = Fruit(context: viewContext)
            newFruit.name = "Fruit \(Int64(Date().timeIntervalSince1970))"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {

            guard let index = offsets.first else {
                print("No index"); return
            }
            let fruitEntity = fruits[index]
            viewContext.delete(fruitEntity)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
