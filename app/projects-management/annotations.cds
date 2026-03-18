using EmployeesProjectsService as service from '../../srv/service';
annotate service.Projects with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : projectLead.name,
                Label : 'name',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Information',
            ID : 'GeneralInformation',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Project Details',
                    ID : 'ProjectDetails',
                    Target : '@UI.FieldGroup#ProjectDetails',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Administrative Data',
                    ID : 'AdministrativeData',
                    Target : '@UI.FieldGroup#AdministrativeData',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Project Lead',
            ID : 'ProjectLead',
            Target : '@UI.FieldGroup#ProjectLead',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Support Team',
            ID : 'SupportTeam',
            Target : 'projectSupportTeam/@UI.LineItem#SupportTeam',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Name}',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Description}',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Value : status.name,
            Label : '{i18n>Status}',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>PlannedDate}',
            Value : plannedDate,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'EmployeesProjectsService.startImplementation',
            Label : '{i18n>StartImplementation}',
            @UI.Hidden : true
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'EmployeesProjectsService.completeProject',
            Label : '{i18n>CompleteProject}',
            @UI.Hidden : true
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'EmployeesProjectsService.startImplementation',
            Label : '{i18n>startImplementation}',
            @UI.Hidden : { $edmJson: { $Or: [ { $Ne: [ { $Path: 'status/code' }, 'P' ] }, { $Not: { $Path: 'IsActiveEntity' } } ] } },
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'EmployeesProjectsService.completeProject',
            Label : '{i18n>completeProject}',
            @UI.Hidden : { $edmJson: { $Or: [ { $Ne: [ { $Path: 'status/code' }, 'I' ] }, { $Not: { $Path: 'IsActiveEntity' } } ] } }
        },
    ],
    UI.FieldGroup #ProjectDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
                Label : '{i18n>Title}',
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>Description}',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>PlannedDate}',
                Value : plannedDate,
            },
            {
                $Type : 'UI.DataField',
                Value : status.name,
                Label : '{i18n>Status}',
            },
        ],
    },
    UI.FieldGroup #AdministrativeData : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
                Label : 'ID',
            },
            {
                $Type : 'UI.DataField',
                Value : createdBy,
            },
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedBy,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedAt,
            },
        ],
    },
    UI.FieldGroup #ProjectLead : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : projectLead.name,
                Label : '{i18n>Name}',
            },
            {
                $Type : 'UI.DataField',
                Value : projectLead.systemUser,
                Label : '{i18n>SystemUser}',
            },
            {
                $Type : 'UI.DataField',
                Value : projectLead.role,
                Label : '{i18n>Role}',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'EmployeesProjectsService.assignLead',
                Label : 'Assign Lead',
            },
            {
                $Type : 'UI.DataField',
                Value : projectLead.location.name,
                Label : '{i18n>Location}',
            },
        ],
    },
);

annotate service.Projects with {
    projectLead @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Employees',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : projectLead_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'dateOfBirth',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'role',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'systemUser',
            },
        ],
    }
};

annotate service.ProjectSupportTeams with @(
    UI.LineItem #SupportTeam : [
        {
            $Type : 'UI.DataField',
            Value : employee_ID,
            Label : '{i18n>Employee}',
        },
        {
            $Type : 'UI.DataField',
            Value : employee.name,
            Label : '{i18n>Name}',
        },
        {
            $Type : 'UI.DataField',
            Value : employee.systemUser,
            Label : '{i18n>SystemUser}',
        },
        {
            $Type : 'UI.DataField',
            Value : employee.role,
            Label : '{i18n>Role}',
        },
        {
            $Type : 'UI.DataField',
            Value : employee.location.name,
            Label : '{i18n>Location}',
        },
    ]
);

annotate service.Employees with {
    name @Common.FieldControl : #ReadOnly
};

annotate service.Employees with {
    systemUser @Common.FieldControl : #ReadOnly
};

annotate service.Employees with {
    role @Common.FieldControl : #ReadOnly
};

annotate service.ProjectStatus with {
    name @Common.FieldControl : #ReadOnly
};

annotate service.Employees with {
    location @(
        Common.FieldControl : #ReadOnly,
    )
};

annotate service.Locations with {
    name @Common.FieldControl : #ReadOnly
};

