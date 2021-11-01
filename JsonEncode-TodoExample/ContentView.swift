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
        List(fetchTodos.getData()) { todo in
            Text(todo.title)
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
    
}
