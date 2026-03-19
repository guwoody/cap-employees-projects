using EmployeesProjectsService as service from '../../srv/service';
annotate service.Employees with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            
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
                    Label : 'Employee Data',
                    ID : 'EmployeeData',
                    Target : '@UI.FieldGroup#EmployeeData',
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
            Label : 'Projects Leading',
            ID : 'ProjectsLeading',
            Target : 'projectsLeading/@UI.LineItem#ProjectsLeading',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Projects Supporting',
            ID : 'ProjectsSupporting',
            Target : 'projectsSupporting/@UI.LineItem#ProjectsSupporting',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : systemUser,
        },
        {
            $Type : 'UI.DataField',
            Value : role,
        },
        {
            $Type : 'UI.DataField',
            Value : location.name,
            Label : 'Location',
        },
    ],
    UI.FieldGroup #EmployeeData : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Value : systemUser,
            },
            {
                $Type : 'UI.DataField',
                Value : dateOfBirth,
            },
            {
                $Type : 'UI.DataField',
                Value : role,
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
                Value : modifiedBy,
            },
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedAt,
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : name,
        },
        TypeName : '',
        TypeNamePlural : '',
    },
);

annotate service.Employees with {
    location @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Locations',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : location_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'country_code',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'timezone_code',
            },
        ],
    }
};

annotate service.Projects with @(
    UI.LineItem #ProjectsLeading : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'Title',
        },
        {
            $Type : 'UI.DataField',
            Value : status.name,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataField',
            Value : plannedDate,
            Label : 'Planned Date',
        },
    ]
);

annotate service.ProjectSupportTeams with @(
    UI.LineItem #ProjectsSupporting : [
        {
            $Type : 'UI.DataField',
            Value : project.name,
            Label : 'Title',
        },
        {
            $Type : 'UI.DataField',
            Value : project.status.name,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataField',
            Value : project.plannedDate,
            Label : 'Planned Date',
        },
    ]
);

