using EmployeesProjectsService from './service';

annotate EmployeesProjectsService.Projects with @flow.status: Status actions {
    startImplementation @(
        from: #PENDING, 
        to: #INPROGRESS,
    );
    completeProject @(
        from: #INPROGRESS, 
        to: #DONE
    );
};
