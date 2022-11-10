#COPY YOUR ABSOLUTE PATH TO THE ONTOLOGY FOLDER HERE. IT SHOULD CONTAIN A "main_ontologies" SUBFOLDER AND A "external_terminologies" SUBFOLDER.
ONTOLOGY_LOCATION = /home/${USER}/ontology

#COPY YOUR DEBUG (DESTINATION FOR ONTOLOGY WITH CLEARTEXT BASECODES) TABLES LOCATION HERE
DEBUG_TABLES_LOCATION = /home/${USER}/debug_tables

#COPY YOUR ABSOLUTE PATH TO THE OUTPUT TABLES FOLDER HERE.
OUTPUT_TABLES_LOCATION = /home/${USER}/output_tables


CONFIG_FOLDER = /home/${USER}/docker-ontology-converter/config


build:
	docker build . -t ontology-converter:latest   
up:
	sed -i 's/"DEBUG":"True"/"DEBUG":"False"/g' $(CONFIG_FOLDER)/i2b2_rdf_config.json
	docker run -it --name ontology_converter -v $(ONTOLOGY_LOCATION):/ontology  -v  $(OUTPUT_TABLES_LOCATION):/output_tables -v $(CONFIG_FOLDER):/config ontology-converter:latest

up-d:
	sed -i 's/"DEBUG":"True"/"DEBUG":"False"/g' $(CONFIG_FOLDER)/i2b2_rdf_config.json
	docker run -it -d --name ontology_converter -v $(ONTOLOGY_LOCATION):/ontology -v $(OUTPUT_TABLES_LOCATION):/output_tables -v $(CONFIG_FOLDER):/config ontology-converter:latest

follow:
	docker logs --follow ontology_converter

stop:
	docker stop ontology_converter
down:
	make stop
	docker rm ontology_converter

wipe:
	make down
	docker image rm ontology-converter:latest
bash:
	docker exec -it ontology_converter bash
	
verbose: 
	sed -i 's/"DEBUG":"False"/"DEBUG":"True"/g' $(CONFIG_FOLDER)/i2b2_rdf_config.json
	docker run -it -d --name ontology_converter -v $(ONTOLOGY_LOCATION):/ontology -v $(DEBUG_TABLES_LOCATION):/output_tables -v $(CONFIG_FOLDER):/config ontology-converter:latest
