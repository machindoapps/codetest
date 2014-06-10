#iOS Test Task

##Brief notes on implementation

	* Initial spec read through

	* Quick 5 min sketch on paper of required master/detail views, to make sure all requirements are captured visually and create initial design.
	
	* Online json formatter used to format itunes json into readable form: http://jsonformatter.curiousconcept.com/
	
	* XCode project creation
	
	* Initial thoughts would have been to use AFNetworking for network requests, but no 3rd party libraries permitted. Also, as app is iOS 7 only, the more modern NSURLSession APIs can be used, which fill a lot of the gaps AFNetworking used make up for pre-iOS 7.

	* Given more time and project scope, a TDD approach would have been taken. Given the time available, and the minimal nature of the project, TDD was not used for this project.

	* Placeholder image created for table cell image

	* Making HTTP request using NSURLSession when search button tapped

	* Initial data object creation - the Track object was created with the bare minimum of properties, representing fields from the json that were going to be used. Given more time, a complete object equivalent would have been created.

	* Track object creation is handled using a class method on the Track class.
	
	* Given more time, a core data relational model would have been created also, with associates NSManagedObjects to allow for potential offline storage of data, for e.g. saving the last search when app terminates.

	* JSON is parsed in the response translator class, which creates Track objects and returns an array, which we use in our master view controller.

	* Images are downloaded asynchronously, with UI updates being passed back to the main thread when they complete.

	Other features to implement given more time:
	    * Seperate class for iTunes rest API requests
		* Currency locale conversion
		* Better display of dates on detail view
		* Image sizing bug in the master view cell
		* Proper autolayout setup
		* Better handling of different resolution images when downloading from iTunes.
