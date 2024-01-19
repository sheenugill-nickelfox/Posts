//
//  PostView.swift
//  Posts
//
//  Created by Nickelfox on 17/01/24.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var vm :PostsViewModel
   
    var body: some View {
        VStack(alignment: .leading, spacing:20){
            Spacer()
            Text("Enter Title")
                .font(.headline)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.leading ,10)
            TextField("Enter Title",text: $vm.title)
                .padding()
                .background(Color.secondary.opacity(0.2).cornerRadius(10))
                .font(.subheadline)
            Text("Enter Body")
                .font(.headline)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.leading ,10)
            TextEditor(text: $vm.postBody)
                .padding()
                .background(Color.secondary.opacity(0.2).cornerRadius(10))
                .font(.subheadline)
                .lineLimit(3)
                .frame(height: 150)
                
                
            HStack{
                Spacer()
                Button(action: {
                    Task{
                        let title = vm.title
                        let body = vm.postBody
                        vm.title = ""
                        vm.postBody = ""
                        try? await vm.writPost(post: PostModel(userId:1, title: title, body: body))
                    }
                }, label: {
                    Text("Submit")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.horizontal,40)
                        .padding(.vertical,16)
                        .background(.blue)
                        .cornerRadius(20)
                })
                Spacer()
            }
            
        HStack{
            Spacer()
            Button(action: {
                Task{
                    let title = vm.title
                    let body = vm.postBody
                    vm.title = ""
                    vm.postBody = ""
//                    try? await vm.updatePost(post: PostModel(userId:1, title: title, body: body))
                    try? await vm.updatePost(newTitle: title,newBody: body)
                }
            }, label: {
                Text("update")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.horizontal,40)
                    .padding(.vertical,16)
                    .background(.blue)
                    .cornerRadius(20)
            })
            Spacer()
        }
            
            HStack{
                Spacer()
                Button(action: {
                    Task{
                        let title = vm.title
                        let body = vm.postBody
                        vm.title = ""
                        vm.postBody = ""
                        try? await vm.DeletePost()
                    }
                }, label: {
                    Text("Delete")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.horizontal,40)
                        .padding(.vertical,16)
                        .background(.blue)
                        .cornerRadius(20)
                })
                Spacer()
            }
            
            
      
          
          
       
            Spacer()
        }//: VSTACK
        .padding()

    }
}

#Preview {
    PostView(vm:PostsViewModel())
}
