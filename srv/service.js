const cds = require('@sap/cds');
const { json } = require('@sap/cds/lib/compile/parse');

module.exports = cds.service.impl(async function () {

    const { Projects, Employees, ProjectSupportTeams } = this.entities;

    this.on('assignLead', 'Projects.drafts', async (req) => {
        const { employeeID } = req.data;
        const { ID } = req.params[0];

        if (!employeeID) {
            return req.error(400, 'Please select an employee to assign as project lead.');
        }

        // Verify the employee exists   
        const employee = await SELECT.one.from('EmployeesProjectsService.Employees')
            .where({ ID: employeeID });

        if (!employee) {
            return req.error(404, `Employee with ID ${employeeID} not found.`);
        }

        // Update the draft with the new lead
        await UPDATE('EmployeesProjectsService.Projects.drafts')
            .set({ projectLead_ID: employeeID })
            .where({ ID: ID });

        return req.reply(null);
    });

    this.before('READ', 'EmployeesValueHelp', async (req) => {
        const { where } = req.query.SELECT;
        let project_ID = null;
        const projectRefIndex = where.findIndex(item => item.ref && item.ref[0] === 'project');

        if (where) {
            if (projectRefIndex !== -1 && where[projectRefIndex + 2]) {
                project_ID = where[projectRefIndex + 2].val;
            }

            if (project_ID) {

            const projectLeadDrafts = await SELECT.one('projectLead_ID').from(Projects.drafts)
                .where({ ID: project_ID });
        
            const projectSupportTeamMembersDrafts = await SELECT('employee_ID').from(ProjectSupportTeams.drafts)
                .where({ project_ID: project_ID });
        
            const employeeIDs = [
                projectLeadDrafts?.projectLead_ID,
                ...projectSupportTeamMembersDrafts?.map(member => member.employee_ID)
            ].filter(Boolean).map(id => ({ val: id }));

            if (employeeIDs.length > 0) {
                req.query.SELECT.where.splice(projectRefIndex, 3);
                req.query.SELECT.where.push({ ref: ['ID']}, 'not in', { list: employeeIDs });      
            }else {
                req.query.SELECT.where = [];
            }
        }
        }            
    });

});