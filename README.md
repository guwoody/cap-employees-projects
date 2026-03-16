# Employees Projects Management

A SAP Cloud Application Programming (CAP) solution for managing departmental projects, including project details configuration, team assignment, project lead designation, and support team management.

## Overview

This application enables department managers to:
- **Create and manage projects** with detailed information including descriptions, planned dates, and status tracking
- **Assign project leads** from the employee roster to oversee individual projects
- **Build support teams** by adding multiple employees as support team members for each project
- **Track project status** throughout the project lifecycle (Initialized, In Progress, Done)
- **Manage employee information** including roles, locations, and time zones

## Database Modeling

The data model is defined in [db/schema.cds](db/schema.cds) and consists of the following entities:

### **Projects**
Core entity for project management with the following fields:
- `ID` (UUID): Unique identifier
- `name` (String): Project name
- `description` (String): Detailed description of the project
- `status` (Association to ProjectStatus): Current project status (Initialized, In Progress, Done)
- `plannedDate` (Date): Planned completion date
- `projectLead` (Association): Reference to the employee assigned as project lead
- `projectSupportTeam` (Composition): Collection of team members supporting the project

### **Employees**
Represents department employees with the following fields:
- `ID` (UUID): Unique identifier
- `name` (String): Employee name
- `dateOfBirth` (Date): Employee's date of birth
- `role` (String): Job role/position
- `systemUser` (String): System user identifier
- `location` (Association): Reference to employee's work location
- `projectsLeading` (Association): Projects where this employee is the lead
- `projectsSupporting` (Association): Projects where this employee is a support team member

### **ProjectSupportTeams**
Link entity connecting projects with their support team members:
- `ID` (UUID): Unique identifier
- `project` (Association): Reference to the project
- `employee` (Association): Reference to the team member

### **ProjectStatus**
Code list entity defining project status values:
- `PENDING` ('P'): Project created but not yet started
- `INPROGRESS` ('I'): Project is currently active
- `DONE` ('D'): Project completed

### **Locations**
Stores location information for employees:
- `ID` (UUID): Unique identifier
- `name` (String): Location name
- `country` (Country): Country code
- `timezone` (Timezone): Time zone information

## Service Definition

The OData service is defined in [srv/service.cds](srv/service.cds) and exposes the following resources:

### **EmployeesProjectsService**

**Entities:**
- `Employees`: Projection of employee data with redirect capability for navigation
- `EmployeesValueHelp`: Enhanced employee view with a virtual `project` field, used for value list scenarios
- `Projects`: Project data with custom actions for project lifecycle management
- `ProjectSupportTeams`: Support team member assignments
- `ProjectStatus`: Project status codes

**Custom Actions:**
- `assignLead`: Assigns an employee as the project lead for a draft project
  - Parameter: `employeeID` (String) - The ID of the employee to assign as lead
  - Validation: Ensures the employee exists and prevents duplicate assignments
- `startImplementation`: Transitions project status from PENDING to INPROGRESS
- `completeProject`: Transitions project status from INPROGRESS to DONE

**Features:**
- Draft enablement for both Employees and Projects entities allowing offline edits
- Status flow handling with controlled state transitions via actions
- Value list annotations with side effects for dynamic employee filtering
- Association-based filtering to prevent duplicate team assignments

## Service Implementation

The business logic is implemented in [srv/service.js](srv/service.js) and [srv/projects-flows.cds](srv/projects-flows.cds) and includes:

### **Status Flow Handling**
Defined in [srv/projects-flows.cds](srv/projects-flows.cds), provides controlled project lifecycle transitions:
- `startImplementation`: Allows transition from PENDING ('P') to INPROGRESS ('I')
- `completeProject`: Allows transition from INPROGRESS ('I') to DONE ('D')

Status transitions are restricted and only valid from specified source states, preventing invalid state changes.

### **assignLead Action Implementation**
Handles the assignment of project leads with the following logic:
1. Validates that an `employeeID` is provided (returns error if missing)
2. Verifies the employee exists in the system (returns 404 if not found)
3. Updates the draft project with the new project lead assignment
4. Returns success confirmation

### **EmployeesValueHelp Filtering**
Implements intelligent filtering for employee value lists to prevent double-assignment:
1. Extracts the project ID from the value list query
2. Retrieves all employees already assigned to the project draft (as lead or support team member)
3. Filters out already-assigned employees from the value list results
4. Returns only available employees for team assignment

This ensures users can only select unassigned employees when building the support team. The filtering operates on draft data only, supporting the draft paradigm for project modifications.

## Key Features

- **Draft Management**: All changes are saved as drafts before activation, ensuring data consistency
- **Smart Employee Filtering**: Automatically filters out already-assigned employees when selecting new team members
- **Project Lead Assignment**: Custom action to assign and change project leads with validation
- **Relationship Management**: Maintains proper associations between projects, employees, and team assignments
- **Localization Support**: UI applications include i18n properties for multi-language support

## Technology Stack

- **Framework**: SAP Cloud Application Programming Model (CAP) 9
- **Backend**: Node.js with Express
- **Database**: SQLite (development)
- **UI**: SAP UI5 Fiori Elements
- **OData**: OData v4
