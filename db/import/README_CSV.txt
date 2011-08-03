Data columns for the following CSV files are indicated below. All files have fields separated by tabs (\t),
have field values enclosed by nothing, field data escaped by \, and lines terminated by Unix new line
characters (\n).

Nationalities: id, name
Occupations: id, name
Politics: id, grouping, name
Religions: id, grouping, name
Author_Works: author_id, work_id
Authors: id, name, gender, date_of_birth, date_of_death, occupation_id, religion_id, politic_id, nation_id, notes
NOTE: Record 1400 has a \n in the data that causes 883 records exported instead of 882. Manually edit this to remove


The following files are exported as XML since there are embedded new line characters for formatting reasons. Works 
are sorted by title before exporting to facilitate removing duplicates during the import of the data. Metaphors are
sorted by metaphor and text fields before exporting to facilitate removing any duplicates during the import of the data. 

Works
NOTE: Work 6374 contains an invalid char (Unicode 0xb) in the title element. This looks something like a blank. It
was removed prior to parsing with Ruby to import data since parsing was failing.

Metaphors
NOTE: Metaphor 16880 has invalid char (same as work above) in text element. Metaphor 16831 has invalid char in text 
element.

Recommended order for running the import scripts:
	nationality_import.rb
	occupation_import.rb
	politic_import.rb
	religion_import.rb
	author_import.rb
	author_work_import.rb
	work_import.rb (requires prior script to be executes so it can delete records if needed in author_works)
	metaphor_import.rb

	
Execute these scripts from the command line in the application environment using 

ruby script/runner db/import/NAME OF SCRIPT.rb