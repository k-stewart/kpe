# Kai's Pterosaur Emporium

This is a little project about caring for pterosaurs.

* Ruby version: 3.4.11
* Database initialization:
* How to run the test suite: `bundle exec rspec`


## Data structure
### Pterosaurs
There are many pterosaurs. They have names, species, owners, play dates, and vaccination records.

### Owners
There are many owners. They have names and pterosaurs.

### Vaccination records
Vax records are a shallow data structure. They have vaccination names and due dates. They belong to a pterosaur, and they are indexed on pterosaur id.

### Play Dates
Play dates have start times, stop times, and participants. Participants are pterosaurs.
They are indexed on participant id.

## Services

### The vax checker
The vax checker pull vaccination records for the pterosaur and saves them to the db. There are many state integrations. The vax checker records vax name, due date, and pterosaur id. Info is pretty minimal; this is one way we protect patient privacy and prevent HIPAA violations!

### The play checker
Can a pterosaur play? If not, why not? Burning questions.
- `can_play?(start_date, end_date)` returns true if the pterosaur can play that day.
- `cant_play_reason(start_date, end_date)` returns nil if the pterosaur can play that day, and a string if they can't.

### The happiness alerter
Pterosaurs need two play dates per week to be happy! Once a week, the happiness alerter checks that each pterosaur has at least two play dates scheduled that week. For each happy pterosaur, the happiness alerter increments the happy_pterosaur metric. For each unhappy pterosaur, the happiness alerter increments the unhappy_pterosaur metric with tags cant_play_reason. This will help us triage the most impactful reasons pterosaurs can't play, and address them.

## Future work
### Species requirements
- Some species need different numbers of play dates per week for happiness.
- Species need different vaccinations.

### Front end
Make one.
- Homepage
- Each pterosaur's schedule of play dates by week
- Each pterosaur's vax records, visible only to the owner
- Request a play date between two pterosaurs
