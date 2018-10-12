var username = project.getProperty("username");
var password = project.getProperty("password");
var serverurl = project.getProperty("serverurl");

var retrieve = function() {
	var task = tasklib.getRetrieveTask();
	task.execute();
}

var validate = function() {
	var task = tasklib.getDeployTask('sf:validate', true);
	task.execute();
}

var validateWithTests = function() {
	var task = tasklib.getDeployTask('sf:validate_with_tests', true);
	task.setTestLevel("RunSpecifiedTests");
	if(tasklib.addTests(task)) task.execute();
}

var deploy = function() {
	var task = tasklib.getDeployTask('sf:deploy', false);
	task.execute();
}

var deployWithTests = function() {
	var task = tasklib.getDeployTask('sf:deploy_with_tests', false);
	task.setTestLevel("RunSpecifiedTests");
	if(tasklib.addTests(task)) task.execute();
}

var tasklib = {
	
	getDeployTask : function(taskName, validateOnly) {
		var task = this.createTask(taskName, "deploy");
		if(validateOnly === true) task.setCheckonly(true);
			
		var deployrootdir = project.getProperty("deployRootDir");
		task.setDeployRoot(deployrootdir);
		return task;
	},
	getRetrieveTask : function() {
		var task = this.createTask("sf:retrieve", "retrieve");
		
		var retrieveDir = project.getProperty("retrieveDir");
		var pkgPath = project.getProperty("pkgPath");
		task.setRetrieveTarget(retrieveDir);
		task.setUnpackaged(pkgPath + "/package.xml");
		return task;
	},
	
	createTask : function(taskName, type) {
					
		var task;
		switch(type) {
			case "deploy" : task = java.lang.Class.forName("com.salesforce.ant.DeployTask").newInstance(); break;
			case "retrieve" : task = java.lang.Class.forName("com.salesforce.ant.RetrieveTask").newInstance(); break;		
		}	
		task.setTaskName(taskName);
		task.setUsername(username);
		task.setPassword(password);
		task.setServerURL(serverurl);
		task.setProject(project);		
		task.setMaxPoll("10000");	
		return task;
	},
	
	addTests : function(task) {
		var testNames = project.getProperty("tests");
		if(testNames === null || testNames === '') {
			var echo = project.createTask("echo");
			echo.setMessage("There are no tests to execute or the test class names are entered incorrectly.");
			echo.perform();
			return false;
		}
		
		var tests = testNames.split(';');
		for (var i = 0; i < tests.length; i++) {
			
			var runTest = java.lang.Class.forName(
				"com.salesforce.ant.DeployTask$CodeNameElement"
			).newInstance();
			runTest.addText(tests[i]);
			task.addRunTest(runTest);
		}
		return true;
	}	
}





	

