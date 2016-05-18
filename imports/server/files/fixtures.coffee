exports.FilesFixtures =
	NpmSpirehqBackendSwf:
		name: "backend-swf"
		url: "https://github.com/spirehq/backend-swf"
		manager: "npm"
	NpmMeteorNano:
		name: "meteor-nano"
		url: "https://github.com/test/meteor-nano"
		manager: "npm"
		packages: ["backend-swf", "bug-guider"]
	NpmParafilter:
		name: "parafilter"
		url: "https://github.com/test/parafilter"
		manager: "npm"
		packages: ["bug-guider"]
	NpmBugGuider:
		name: "bug-guider"
		url: "https://github.com/test/bug-guider"
		manager: "npm"
		packages: ["backend-swf"]
	NpmRoachFS:
		name: "roach-fs"
		url: "https://github.com/test/roach-fs"
		manager: "npm"
		packages: ["meteor-nano", "parafilter", "bug-guider", "backend-swf", "roach-fs"]
