//
//  ContentView.swift
//  emp
//
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let coreDM: CoreDataManager
    @State var activo_opc = ""
    @State var domicilio = ""
    @State var empApeMat = ""
    @State var empApePat = ""
    @State var empId = ""
    @State var puesto = ""
    @State var telefono = ""
    @State var seleccionado:Projecto?
    @State var vigaArray = [Projecto]()
    
    var body: some View{
        VStack{
            TextField("Clave de empleado", text: $activo_opc)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Domicilio", text: $domicilio)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("apellido materno", text: $empApeMat)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("apellido paterno", text: $empApePat)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("clave de empleado", text: $empId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Puesto", text: $puesto)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("telefono", text: $telefono)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("SAVE"){
                
                if (seleccionado != nil){
                    seleccionado?.activo_opc = activo_opc
                    seleccionado?.domicilio = domicilio
                    seleccionado?.empApeMat = empApeMat
                    seleccionado?.empApePat = empApePat
                    seleccionado?.empId = empId
                    seleccionado?.puesto = puesto
                    seleccionado?.telefono = telefono
                    coreDM.actualizarViga(<#T##Projecto#>: seleccionado!)
                }else{
                    coreDM.guardarViga(clv_obra: clv_obra, clv_viga: clv_viga, longitud: longitud, material: material, peso: peso)
                }
                mostrarVigas()
                activo_opc = ""
                domicilio = ""
                empApeMat = ""
                empApePat = ""
                empId = ""
                puesto = ""
                telefono = ""
                seleccionado = nil
            }
            List{
                ForEach(vigaArray, id: \.self){
                pro in
                VStack{
                    Text(pro.activo_opc ?? "")
                    Text(pro.domicilio ?? "")
                    Text(pro.empApeMat ?? "")
                    Text(pro.empApePat ?? "")
                    Text(pro.empId ?? "")
                    Text(pro.puesto ?? "")
                    Text(pro.telefono ?? "")
                }
                .onTapGesture {
                    seleccionado = vig
                    clv_viga = vig.clv_viga ?? ""
                    clv_obra = vig.clv_obra ?? ""
                    longitud = vig.longitud ?? ""
                    material = vig.material ?? ""
                    peso = vig.peso ?? ""
                }
            }
            .onDelete(perform: {
                indexSet in
                indexSet.forEach({index in
                    let viga = vigaArray[index]
                    coreDM.borraViga(viga: viga)
                    mostrarVigas()
                })
            })
        }
        Spacer()
    }.padding()
        .onAppear(perform: {
            mostrarVigas()
        })
        
    }

    func mostrarVigas(){
        vigaArray = coreDM.leerVigas()
    }
}


struct ContentView_preViews: PreviewProvider{
    static var previews: some View{
        ContentView(coreDM: CoreDataManager())
    }
}



    
