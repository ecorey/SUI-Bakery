# Project Overview:

Welcome to the BAKERY, where to get that BREAD, first you gotta’ make some DOUGH. 

This project uses the SUI Move language to allow a user to create objects with the intention of finally creating the rarest object, Bread. 
Currently each object is defined by a struct and have functions to allow the object to be created and transferred, as well as deconstructed and deleted. 
First the user needs to create a Flour, Salt, and Yeast object to call the create_dough function. When the create_dough function is called the Flour, Salt, and Yeast objects get deconstructed and deleted and the Dough object is created. When the user calls the create_bread function, they must have a Dough object, and they pass their Dough object to the create_bread function which deconstructs and deletes the Dough object and returns a Bread object.
