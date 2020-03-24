# Carpentries Curriculum Feed

:warning: :warning: :warning:

** While these feeds are still valid, you may want to use <https://feeds.carpentries.org/lessons.json> instead. **

:warning: :warning: :warning:

Provide data in JSON format about The Carpentries lessons.
The data is stored in Airtable. The script is run on Travis daily through a CRON job. To make is run you need the Airtable API key (set as `AIRTABLE_API_KEY` environment variable) and the key for the airtable base (set as `AIRTABLE_LESSONS_KEY`). Both are set up as secure variables in Travis.

The data is provided at:

- The list of curricula: <https://carpentries.github.io/curriculum-feed/carpentries_curricula.json>
- The full list of our lessons: <https://carpentries.github.io/curriculum-feed/carpentries_lessons.json>
