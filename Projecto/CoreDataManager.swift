//
//  CoreDataManager.swift
//  Projecto
//
//  Created by CCDM09 on 29/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "Projecto")
        persistentContainer.loadPersistentStores(completionHandler:{
            (description, error) in
            if let error = error{
                fatalError("Core data failed\(error.localizedDescription)")
            }
            
        })
    }
    func guardarEmpleado(activo_opc:String, domicilio:String, empApeMat:String, empApePat:String, empNombre:String, id:String, puesto:String, telefono:String ){
        let emp = Projecto(context: persistentContainer.viewContext)
            emp.activo_opc = activo_opc
            emp.domicilio = domicilio
            emp.empApeMat = empApeMat
            emp.empApePat = empApePat
            emp.empNombre = empNombre
            emp.empID = empId
            emp.puesto = puesto
            emp.telefono = telefono
        do{
            try persistentContainer.viewContext.save()
            print("Empleado guardada")
        }
        catch{
            print ("falla")
        }
    }
    
    func leerProjecto() -> [Projecto] {
        let fetchRequest : NSFetchRequest<Projecto> = Projecto.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    
    func leerProjecto(clv_viga:String) -> Projecto?{
        let fetchRequest : NSFetchRequest<Projecto> = Viga.fetchRequest()
        let predicate = NSPredicate(format: "empId = %@", empId)
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
            }
        catch{
            print("No se puede leer ese dato")
        }
        return nil
    }
    
    func actualizarViga(Projecto: Projecto){
        let fetchRequest : NSFetchRequest<Projecto> = Viga.fetchRequest()
        let predicate = NSPredicate(format: "empId = %@", Projecto.empId ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let v = datos.first
            v?.activo_opc = Projecto.activo_opc
            v?.longitud = Projecto.longitud
            v?.material = Projecto.material
            v?.peso = Projecto.peso
            try persistentContainer.viewContext.save()
            print("Empleado actualizada")
        }catch{
            print("no se pudo actualizar")
        }
    }
    
    func borraViga(Projecto:Projecto){
        persistentContainer.viewContext.delete(Projecto)
    }
}
