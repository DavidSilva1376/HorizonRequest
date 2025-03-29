import SwiftUI

struct SeleccionMunicipioView: View {
    @StateObject var viewModel = MunicipiosViewModel()
    @EnvironmentObject var currentUser: CurrentUser
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                // Fondo general (todo tu diseño existente igual)
                Color(red: 0.19, green: 0.19, blue: 0.19)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Título
                    Text("Select\nLocation:")
                        .font(Font.custom("Inria Sans", size: 40).weight(.bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 40)
                        .padding(.bottom, 30)
                    
                    // Grid de municipios
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(viewModel.municipios) { municipio in
                                Button(action: {
                                    navigationPath.append(municipio)
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color(red: 0.50, green: 0.23, blue: 0.27).opacity(0.5))
                                            .frame(width: 160, height: 160)
                                            .cornerRadius(20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(.white, lineWidth: 0.5)
                                            )
                                        
                                        Text(municipio.nombre)
                                            .font(Font.custom("Inria Sans", size: 20).weight(.bold))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                    }
                                    .padding(5)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: Municipio.self) { municipio in
                FeedView(municipio: municipio, viewModel: FeedViewModel())
                    .environmentObject(currentUser)
            }
        }
    }
}

// Extensión para hacer Municipio identificable para NavigationPath
extension Municipio: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Municipio, rhs: Municipio) -> Bool {
        lhs.id == rhs.id
    }
}

