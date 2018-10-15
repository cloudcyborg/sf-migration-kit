# SF Migration Kit

> Note: This is is for Windows users only. This has been tested in Win 7 and Win 10.

With the introduction of the [SFDX](https://www.salesforce.com/products/platform/products/salesforce-dx/) lifecycle, 
this will be rendered obsolete in a while. 
But if you are currently using **Eclipse**, or the **ANT migration tool** for retrival/deployment, and you face issues using them 
(you know, like manually updating org details in the build.properties file, or others), this tool might just help you out.

![SF Menu](/../media/Images/sf-menu.jpg?raw=true)

---

### What it does?

This tool introduces an **inner menu** on the context menu (**right-click menu**), which will contain options to **retrieve**, 
**deploy**, and **migrate** (an entire retrieval and deployment operation performed in one go). 

### Features:

* Retrieve a package from any org. 
* Deploy a package to any org or orgs (in one go)
* Manage your orgs efficiently. No need to keep updating the build.properties file. 
* Choose to validate, or deploy in target org. 
* Opt to run specific tests (during validation/deployment)
* Migrate metadata from a source org to destination org

		
I developed a basic version of this tool a while ago and have been refining it over time, till today, when I decide to release it 
to the community. Ever since I started using this tool in my projects, because of the smooth deployments I ensured, I've been in 
charge of deployments/migration in almost all of them. Hopefully with this latest version, you will be benefitted as well. 	
	
There is a tutorial video describing the installation and usage of the tool. Checkout here
	
	[VIDEO LINK]

For a detailed documentation on installation and usage, head over to the [wiki](https://github.com/cloudcyborg/sf-migration-kit/wiki)	