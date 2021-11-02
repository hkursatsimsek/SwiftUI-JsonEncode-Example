//
//  ContentView.swift
//  JsonEncode-TodoExample
//
//  Created by Kürşat Şimşek on 1.11.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var fetchTodos = FetchedData()
    
    var body: some View {
//        List(fetchTodos.getData()) { todo in
//            Text(todo.title)
//        }
        NavigationView{
                    
            List(fetchTodos.getData()){ todo in

                NavigationLink(
                
                    destination: DetailView(id: todo.id),
                    label: {
                        Text(todo.title)
                    }
                )
                .navigationTitle("ToDo List")
                .navigationBarTitleDisplayMode(.inline)
            
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class FetchedData: ObservableObject {
    
    @Published var todos = [Todo]()
    @Published var todo = Todo(id: 111, title: "test", completed: false)
    
    func getData() -> [Todo] {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos") {
            let urlRequest = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode([Todo].self, from: data)
                        
                        DispatchQueue.main.async {
                            self.todos = decodedData
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
        
        return self.todos
    }
    
    
    func getDataById(id :Int) -> Todo {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos" + String(id)) {
            let task2 = URLSession.shared.dataTask(with: url) { data, res, err in
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode(Todo.self, from: data)
                        
                        DispatchQueue.main.async {
                            self.todo = decodedData
                        }
                    }
                }catch {
                    print(err?.localizedDescription)
                }
            }
            task2.resume()
        }
        
        return self.todo
    }
    
}

struct DetailView : View {
    var id : Int = 123
    
    var body: some View {
        Text(String(id)).padding()
    }
   
    
  
}
