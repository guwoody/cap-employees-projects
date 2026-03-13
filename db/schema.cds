namespace hr.employee.projects;

using { cuid, managed, Country, Timezone, sap.common.CodeList } from '@sap/cds/common';

entity Projects : cuid, managed {

    name: String;
    description: String;
    @flow.status
    @readonly status : Association to ProjectStatus default 'I';
    plannedDate: Date;
    projectLead: Association to Employees;
    projectSupportTeam: Composition of many ProjectSupportTeams on projectSupportTeam.project = $self;

}

entity ProjectStatus: CodeList {
    key code: String @Common.Label:'Status Code' enum {
        INITIALIZED = 'I';
        INPROGRESS = 'P';
        DONE = 'D';
    };
}

entity Employees: cuid, managed {

    name: String(100) @Common.Label:'Name';
    dateOfBirth: Date @Common.Label:'Date of Birth';
    role: String @Common.Label:'Role';
    systemUser: String(5) @Common.Label:'System User';
    location: Association to Locations @Common.Label:'Location';
    projectsLeading: Association to many Projects on projectsLeading.projectLead = $self;
    projectsSupporting: Association to many ProjectSupportTeams on projectsSupporting.employee = $self;
    
}

entity ProjectSupportTeams: cuid, managed {
    project: association to Projects;
    employee: association to Employees;
}

entity Locations: cuid, managed {
    name: String;
    country: Country;
    timezone: Timezone;
}