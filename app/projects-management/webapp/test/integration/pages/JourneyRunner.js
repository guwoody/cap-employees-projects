sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"projectsmanagement/test/integration/pages/ProjectsList",
	"projectsmanagement/test/integration/pages/ProjectsObjectPage"
], function (JourneyRunner, ProjectsList, ProjectsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('projectsmanagement') + '/test/flp.html#app-preview',
        pages: {
			onTheProjectsList: ProjectsList,
			onTheProjectsObjectPage: ProjectsObjectPage
        },
        async: true
    });

    return runner;
});

