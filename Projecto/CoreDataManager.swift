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
    func guardarEmpleado(activo_opc:String, domicilio:String, empApeMat:String, empApePat:String, empId:String, puesto:String, telefono:String ){
        let emp = Projecto(context: persistentContainer.viewContext)
            emp.activo_opc = activo_opc
            emp.domicilio = domicilio
            emp.empApeMat = empApeMat
            emp.empApePat = empApePat
            emp.empId = empId
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
    
    func leerProjecto(empId:String) -> Projecto?{
        let fetchRequest : NSFetchRequest<Projecto> = Projecto.fetchRequest()
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
    
    func actualizarProjecto(Projecto: Projecto){
        let fetchRequest : NSFetchRequest<Projecto> = Viga.fetchRequest()
        let predicate = NSPredicate(format: "empId = %@", Projecto.empId ?? "")
        fetchRequest.predicate = predicate
        
        do{
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let v = datos.first
            v?.activo_opc = Projecto.activo_opc
            v?.domicilio = Projecto.domicilio
            v?.empApeMat = Projecto.empApeMat
            v?.empApePat = Projecto.empApePat
            v?.empId = Projecto.empId 
            v?.puesto = Projecto.activo_opc
            v?.telefono = Projecto.activo_opc
            try persistentContainer.viewContext.save()
            print("Empleado actualizada")
        }catch{
            print("no se pudo actualizar")
        }
    }
    
    func borraProjecto(Projecto:Projecto){
        persistentContainer.viewContext.delete(Projecto)
    }
}
