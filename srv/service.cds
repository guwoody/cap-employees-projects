using hr.employee.projects as db from '../db/schema';

service EmployeesProjectsService {
    @cds.redirection.target
    entity Employees as projection on db.Employees;

    entity EmployeesValueHelp as projection on db.Employees {
        *,
        virtual project : UUID
    };

    entity Projects as projection on db.Projects actions{
        @( 
            cds.odata.bindingparameter.name: '_it', 
            Common.SideEffects: { 
                TargetEntities: ['_it/projectLead'] 
            }, 
            Common.SideEffects #employeeChanged : {
                SourceProperties : ['employeeID'],
                TargetEntities   : ['/EmployeesProjectsService.EntityContainer/EmployeesValueHelp']
            },
            Core.OperationAvailable : { $edmJson: { $Not: { $Path: 'IsActiveEntity' } } } 
        )
        action assignLead (
            @(
                Common.Label : 'Employee',
                Common.ValueList : {
                    $Type          : 'Common.ValueListType',
                    CollectionPath : 'EmployeesValueHelp',
                    Parameters     : [
                        {
                            $Type             : 'Common.ValueListParameterIn',
                            LocalDataProperty : '_it/ID',
                            ValueListProperty : 'project'
                        },
                        {
                            $Type             : 'Common.ValueListParameterOut',
                            LocalDataProperty : 'employeeID',
                            ValueListProperty : 'ID'
                        },
                        {
                            $Type             : 'Common.ValueListParameterDisplayOnly',
                            ValueListProperty : 'name'
                        },
                        {
                            $Type             : 'Common.ValueListParameterDisplayOnly',
                            ValueListProperty : 'systemUser'
                        },
                        {
                            $Type             : 'Common.ValueListParameterDisplayOnly',
                            ValueListProperty : 'role'
                        }
                    ]
                }
            )
            employeeID : String
        );
        @(
            cds.odata.bindingparameter.name: '_it',
            Common.SideEffects : {
                TargetEntities   : ['_it']
            }
        )
        action startImplementation();
         @(
            cds.odata.bindingparameter.name: '_it',
            Common.SideEffects : {
                TargetEntities   : ['_it']
            }
        )
        action completeProject();
    };

    entity ProjectSupportTeams as projection on db.ProjectSupportTeams;

    entity ProjectStatus as projection on db.ProjectStatus;

    entity Locations as projection on db.Locations;
}

annotate EmployeesProjectsService.ProjectSupportTeams with @(
    Common.SideEffects #employeeChanged : {
        SourceProperties : ['employee_ID'],
        TargetEntities   : [
            'employee',
            '/EmployeesProjectsService.EntityContainer/EmployeesValueHelp'
            ]
    }
){
    employee @(
        //Common.ValueListWithFixedValues: true,
        Common.Label: 'Employee',
        Common.ValueList: {
            $Type          : 'Common.ValueListType',
            CollectionPath : 'EmployeesValueHelp',
            useCache       : false,
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterIn',
                    LocalDataProperty : 'project_ID',
                    ValueListProperty : 'project'
                },                
                {
                    $Type             : 'Common.ValueListParameterOut',
                    LocalDataProperty : 'employee_ID',
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'systemUser'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'role'
                }
            ]
        }
    );
};

annotate EmployeesProjectsService.Employees with @odata.draft.enabled;
annotate EmployeesProjectsService.Projects with @(
    odata.draft.enabled,
    UI.UpdateHidden : { $edmJson: { $Eq: [ { $Path: 'status/code' }, 'D' ] } },
    );
