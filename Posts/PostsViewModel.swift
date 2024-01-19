//
//  PostsViewModel.swift
//  Posts
//
//  Created by Nickelfox on 16/01/24.
//

import Foundation
class PostsViewModel : ObservableObject{
    
    @Published var posts :[PostModel] = []
    var postId:Int = 0
    @Published var title: String = ""
    @Published var postBody : String = ""
    
    func fetchPosts() async throws {
        do{
            //  guard let  url = URL(string:"https://jsonplaceholder.typicode.com/posts") else { return URLError(.badURL)}
            guard let  url = URL(string:"https://jsonplaceholder.typicode.com/posts") else { throw URLError(.badURL)}
            let(responseData,_ ) = try await URLSession.shared.data(from: url)
        
            let decodedPost = try JSONDecoder().decode([PostModel].self, from: responseData)
            await MainActor.run{
                self.posts = decodedPost
            }
        }catch{
            print("Error in fetching posts \(error)")
        }
        
    }
    
    func writPost(post:PostModel) async throws{
        do{
          
            guard let  url = URL(string:"https://jsonplaceholder.typicode.com/posts") else { throw URLError(.badURL)}
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(post)
            let(responseData,_) = try await URLSession.shared.data(for: request)
            let decodedPost = try JSONDecoder().decode(PostModel.self, from: responseData)
            print("response data : \(decodedPost)")
            postId = decodedPost.id ?? 0
            await MainActor.run{
                title = decodedPost.title
                postBody = decodedPost.body
            }
        }catch{
            print("Error in posting a post \(error) ")
        }
    }
    
//    func updatePost(post:PostModel) async throws{
//        do{
//            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)") else{ throw URLError(.badURL)}
//            var request = URLRequest(url: url)
//            request.httpMethod = "PATCH"
//            request.setValue("application/json", forHTTPHeaderField: "Accept")
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = try JSONEncoder().encode(post)
//            let(responseData,_) = try await URLSession.shared.data(for: request)
//            let decodedPost = try JSONDecoder().decode(PostModel.self, from: responseData)
//            print("response data : \(decodedPost)")
//            await MainActor.run{
//                title = decodedPost.title
//                postBody = decodedPost.body
//            }
//        }catch{
//            print("Error in posting a post \(error) ")
//        }
//    }
    
    func updatePost(newTitle:String? = nil, newBody:String? = nil) async throws{
        do{
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)") else{ throw URLError(.badURL)}
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            var updatedFields = [String: String]()
                  
                  if let newTitle = newTitle {
                      updatedFields["title"] = newTitle
                  }

                  if let newBody = newBody {
                      updatedFields["body"] = newBody
                  }

            request.httpBody = try JSONEncoder().encode(updatedFields)
            let(responseData,_) = try await URLSession.shared.data(for: request)
            let decodedPost = try JSONDecoder().decode(PostModel.self, from: responseData)
            print("response data : \(decodedPost)")
            await MainActor.run{
                title = decodedPost.title
                postBody = decodedPost.body
            }
        }catch{
            print("Error in posting a post \(error) ")
        }
    }
   
    func DeletePost() async throws{
        do{
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postId)") else{ throw URLError(.badURL)}
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
            let(responseData,_) = try await URLSession.shared.data(for: request)
            print(responseData)
            print("item with ID \(postId) deleted successfully")
           
        }catch{
            print("Error in posting a post \(error) ")
        }
    }
   
    
}
