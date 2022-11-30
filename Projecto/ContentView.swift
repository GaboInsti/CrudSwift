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
    @State var ProjectoArray = [Projecto]()
    
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
                    coreDM.actualizarEmpleado(Projecto: seleccionado!)
                }else{
                    coreDM.guardarEmpleado(activo_opc:activo_opc,domicilio:domicilio,empApeMat:empApeMat,empApePat:empApePat,empId:empId,puesto:puesto,telefono:telefono)
                }
                mostrarEmpleado()
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
                ForEach(ProjectoArray, id: \.self){
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
                    seleccionado = pro
                    activo_opc = pro.activo_opc ?? ""
                    domicilio = pro.domicilio ?? ""
                    empApeMat = pro.empApeMat ?? ""
                    empApePat = pro.empApePat ?? ""
                    empId = pro.empId ?? ""
                    puesto = pro.puesto ?? ""
                    telefono = pro.telefono ?? ""
                }
            }
            .onDelete(perform: {
                indexSet in
                indexSet.forEach({index in
                    let Projecto = ProjectoArray[index]
                    coreDM.borraProjecto(Projecto: Projecto)
                    mostrarProjecto()
                })
            })
        }
        Spacer()
    }.padding()
        .onAppear(perform: {
            mostrarProjecto()
        })
        
    }

    func mostrarProjecto(){
        ProjectoArray = coreDM.leerProjecto()
    }
}


struct ContentView_preViews: PreviewProvider{
    static var previews: some View{
        ContentView(coreDM: CoreDataManager())
    }
}



    
