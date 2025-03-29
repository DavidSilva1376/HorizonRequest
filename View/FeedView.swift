import SwiftUI

struct FeedView: View {
    @StateObject var viewModel: FeedViewModel
    var municipio: Municipio
    @State private var mostrarCrearPost = false
    @EnvironmentObject var currentUser: CurrentUser
    @Environment(\.dismiss) var dismiss
    
    init(municipio: Municipio, viewModel: FeedViewModel) {
        self.municipio = municipio
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            // Fondo
            Color(red: 0.19, green: 0.19, blue: 0.19)
                .edgesIgnoringSafeArea(.all)
            
            // Contenido principal
            VStack(spacing: 20) {
                // Header
                HStack {
                    // Botón Back funcional
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                                .font(Font.custom("Inria Sans", size: 20).weight(.bold))
                        }
                        .foregroundColor(Color(red: 1, green: 0.74, blue: 0.35))
                    }
                    
                    Spacer()
                    
                    Text("Comunidad")
                        .font(Font.custom("Inria Sans", size: 40).weight(.bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Botón de agregar post
                    Button(action: {
                        mostrarCrearPost = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(Color(red: 1, green: 0.74, blue: 0.35))
                    }
                }
                .padding(.horizontal)
                .navigationBarBackButtonHidden(true)
                
                // Nombre del municipio
                Text(municipio.nombre)
                    .font(Font.custom("Inria Sans", size: 32).weight(.bold))
                    .foregroundColor(.white)
                
                // Barra de búsqueda
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.35))
                        .frame(height: 50)
                        .cornerRadius(10)
                    
                    HStack {
                        Text("Search")
                            .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                            .foregroundColor(.white)
                            .padding(.leading, 20)
                        
                        TextField("", text: $viewModel.searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }
                }
                .padding(.horizontal)
                
                // Lista de posts
                ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.obtenerPostsParaMunicipio(municipio)) { post in
                                NavigationLink(
                                    destination: DetallePostView(post: post, municipio: municipio)
                                        .environmentObject(viewModel)
                                        .environmentObject(currentUser)
                                ) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.35))
                                            .frame(height: post.imagenData != nil ? 200 : 105) // Ajusta altura si hay imagen
                                            .cornerRadius(20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(.white, lineWidth: 0.5)
                                            )
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            // Mostrar imagen si existe
                                            if let imageData = post.imagenData, let uiImage = UIImage(data: imageData) {
                                                Image(uiImage: uiImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(height: 80)
                                                    .clipped()
                                                    .cornerRadius(10)
                                                    .padding(.bottom, 5)
                                            }
                                            
                                            HStack {
                                                Text(post.title)
                                                    .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                                                    .foregroundColor(.white)
                                                
                                                Spacer()
                                                
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.white)
                                            }
                                            
                                            Text("Created by: \(post.autor)")
                                                .font(Font.custom("Inria Sans", size: 16))
                                                .foregroundColor(.white)
                                        }
                                        .padding(.horizontal, 20)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                
                
                
                Spacer()
            }
            .padding(.top, 20)
        }
        .sheet(isPresented: $mostrarCrearPost) {
            CrearPostView(usuario: currentUser.nombre) { nuevoPost in
                viewModel.agregarPost(nuevoPost, en: municipio)
            }
        }
    }
}

#Preview {
    FeedView(municipio: Municipio(nombre: "Monterrey"), viewModel: FeedViewModel())
        .environmentObject(CurrentUser())
}
