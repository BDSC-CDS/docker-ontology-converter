The documentation for the configuration files is available at https://github.com/CHUV-DS/RDF-i2b2-converter#readme .

To run the data converter, you should
- Have docker installed
- Have cloned this repository
- Create a ontology directory (composed of a "main_ontologies" and a "external_terminologies" directory), an output directory, a debug directory for logs and verbose tables.
- Place yourself in the current repository
- Change the variables in the Makefile to reflect your directories absolute paths
- run
   $ make build
- Perform a debug run if you are about to load data afterwards and want to be able to validate it:  
	- change the "DEBUG" variable in config/i2b2_rdf_config.json to "True" (with quotes)
	- run   $ make debug
- To perform a normal, i2b2-loadable run:
	- change the "DEBUG" variable in config/i2b2_rdf_config.json back to "False" (with quotes)
   	- run   $ make up-d

- You can switch to data conversion if necessary, or simply collect your ontology tables.


