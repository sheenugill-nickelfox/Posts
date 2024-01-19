//
//  ContentView.swift
//  Posts
//
//  Created by Nickelfox on 16/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = PostsViewModel()
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack{
                    Spacer()
                    NavigationLink(destination: PostView(vm:vm)){
                        Text("POST HERE")
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.horizontal,16)
                            .padding(.vertical,10)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    .padding(.trailing,40)
                }
                              
                List{
                    ForEach(vm.posts){ post in
                        HStack(spacing:5){
                             Image(systemName:"music.note.list")

                            VStack(alignment: .leading, spacing:5){
                                Text(post.title)
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                Text(post.body)
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                            }//VSTACK
                        }//HSTACK
                        .padding(.vertical,5)
                    }//Loop
                }//List
                .listStyle(.plain)
                .task {
                    try? await vm.fetchPosts()
            }
            }
            .padding(.top,20)
        }//:VSTACK
        
    }//: NavigationView
}

#Preview {
    ContentView()
}
